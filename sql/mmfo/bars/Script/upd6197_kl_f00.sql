prompt    Змiна "Код одиниці виміру даних"  для #2K

exec bc.home;

update kl_f00$GLOBAL
   set NN ='01'
 where kodf ='2K';

update nbur_ref_files
   set unit_code ='01'
 where file_code ='#2K';

commit;


