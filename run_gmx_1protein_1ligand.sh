#! /bin/bash
#Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk multi kompleks protein-ligand dimana setiap kompleks berada dalam direktori terpisah, dan setiap direktori berada pada direktori kerja.
#Tempatkan skrip ini bersama ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direkrori kerja
#Pastikan nama ligand memiliki awalan "lig" sehingga terbaca "lig*"
#Pastikan nama resepetor memiliki awalan "protein" sehingga terbaca "protein*"
#Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG
#Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
#Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 1. 
#Untuk simulasi MD kompleks protein-ligan dengan 2 ligan dalam sistem, gunakan skrip lain yang telah kami sediakan.
#Selamat ber_MD :)

for dir in */; do
	a=`basename $dir`
	cd $dir
	cp lig*.pdb LIG.pdb
	acpype -i LIG.pdb -c gas 
	cd ..
	wait
	done
	
for dir in */; do
	a=`basename $dir`
	cd $dir
	cp lig*.pdb LIG.pdb
	gmx pdb2gmx -f protein*.pdb -o protein.pdb -ignh 
	cd ..
	wait
	done
	
for dir in */; do
	a=`basename $dir`
	cd $dir
	grep -h ATOM protein.pdb LIG.acpype/LIG_NEW.pdb >| complex.pdb
	cp LIG.acpype/LIG_GMX.itp LIG.itp
	cat topol.top | sed '/forcefield\.itp\"/a\
#include "LIG.itp"\
\
; Ligand position restraints\
#ifdef POSRES\
#include "LIG-posre.itp"\
#endif
	' >| topol2.top
	echo "LIG   1" >> topol2.top
	mv topol2.top topol.top 
	gmx editconf -f complex.pdb -o box.pdb -bt triclinic -d 1.0 -c
	gmx solvate -cp box.pdb -cs spc216.gro -p topol.top -o solv.pdb 
	cd ..
	wait
	done
	
for dir in */; do
	a=`basename $dir`
	cd $dir
	gmx grompp -f ../ions.mdp -c solv.pdb -p topol.top -o ions.tpr -maxwarn 1 
	gmx genion -s ions.tpr -o ions.pdb -p topol.top -pname NA -nname CL -neutral 
	cd ..
	wait
	done
	
for dir in */; do
	a=`basename $dir`
	cd $dir
	gmx grompp -f ../em.mdp -c ions.pdb -p topol.top -o em.tpr -maxwarn 1 
	gmx mdrun -v -deffnm em
	gmx energy -f em.edr -o potential.xvg
	cd ..
	wait
	done
	
for dir in */; do
	a=`basename $dir`
	cd $dir
	gmx make_ndx -f LIG.acpype/LIG_NEW.pdb -o LIG-index.ndx
	cd ..
	wait
	done
	
for dir in */; do
	a=`basename $dir`
	cd $dir
	gmx genrestr -f LIG.acpype/LIG_NEW.pdb -n LIG-index.ndx -o LIG-posre.itp -fc 1000 1000 1000
	cd ..
	wait
	done

for dir in */; do
	a=`basename $dir`
	cd $dir
	gmx make_ndx -f em.gro -o index.ndx
	cd ..
	done
for dir in */; do
	a=`basename $dir`
	cd $dir
gmx grompp -f ../nvt.mdp -c em.gro -r em.gro -p topol.top -n index.ndx -o nvt.tpr -maxwarn 1 
gmx mdrun -v -s nvt.tpr -deffnm nvt
	cd ..
	wait
	done


for dir in */; do
a=`basename $dir`
cd $dir
gmx grompp -f ../npt.mdp -c nvt.gro -t nvt.cpt -r nvt.gro -p topol.top -n index.ndx -o npt.tpr -maxwarn 1 
gmx mdrun -v -s npt.tpr -deffnm npt
cd ..
wait
done

for dir in */; do
a=`basename $dir`
cd $dir
gmx grompp -f ../md.mdp -c npt.gro -t npt.cpt -p topol.top -n index.ndx -o md.tpr -maxwarn 1 
gmx mdrun -v -s md.tpr -deffnm md
cd ..
done

echo Succesfully
echo This script written by La Ode Aman, laode_aman@ung.ac.id, Universitas Negeri Gorontalo, Indonesia
wait
