Skrip ini berguna untuk automatisasi simulasi MD menggunakan gromacs untuk multi kompleks protein-ligand dimana setiap kompleks terdiri dari resepetor dan 1 ligand.

1. File protein dan ligand dari setiap kompleks berada dalam direktori berbeda, dan setiap direktori kompoleks berada pada direktori kerja.
2. Tempatkan skrip ini bersama file ions.mdp, em.mdp, nvt.mpd, npt.mdp dan md.mdp pada direktori kerja dengan pengaturan pasangan protein_ligand pada file mdp adalah "Protein_LIG".
3. Pastikan nama file dari ligand memiliki awalan "lig" sehingga terbaca "lig*".
4. Pastikan nama resepetor memiliki awalan "rec" sehingga terbaca "rec*"
5. Pastikan ID molekul setiap ligan yang berada di dalam file pdb telah diubah menjadi LIG.
6. Pastikan pada mesin anda telah terinstall gromacs, acpype dan paket-paket dependensinya.
7. Skrip ini hanya mengeksekusi kompleks protein-ligand dengan jumlah molekul ligan = 1. Untuk simulasi MD kompleks protein-ligan dengan 2 ligan dalam satu sistem, gunakan skrip lain yang telah kami sediakan.
8. Selamat ber_MD :)
