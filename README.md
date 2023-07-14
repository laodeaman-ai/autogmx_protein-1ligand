#Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk multi kompleks protein-ligand dimana setiap kompleks berada dalam direktori terpisah, dan setiap direktori berada pada direktori kerja.
#Tempatkan skrip ini bersama ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direkrori kerja
#Pastikan nama ligand memiliki awalan "lig" sehingga terbaca "lig*"
#Pastikan nama resepetor memiliki awalan "protein" sehingga terbaca "protein*"
#Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG
#Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
#Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 1. 
#Untuk simulasi MD kompleks protein-ligan dengan 2 ligan dalam sistem, gunakan skrip lain yang telah kami sediakan.
#Selamat ber_MD :)
