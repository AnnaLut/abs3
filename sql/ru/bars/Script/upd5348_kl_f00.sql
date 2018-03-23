
--  Змiна "Код одиниці виміру даних"  для #2K

update kl_f00$GLOBAL
   set NN ='02'
 where kodf ='2K';

commit;



