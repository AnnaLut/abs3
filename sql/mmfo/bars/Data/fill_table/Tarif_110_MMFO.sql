-------------------------------------------------------------------------------------------------------------
--                                     Заявка COBUMMFO-6432  -  вариант для ММФО
--                         
--       Создаем новый тариф 110 "За внесення непосортованої готівки на рах. клієнта" c базовым значением = 0                         
--       Добавляем его во все ПАКЕТЫ, также со значением = 0.
--
--------------------------------------------------------------------------------------------------------------             

BEGIN

  Bc.go('/') ;

  For k in (Select KF from MV_KF)

  Loop
     ----Bc.go(k.KF) ;
     Begin 
       INSERT INTO TARIF 
       ( KOD,
         KV, NAME, TAR, PR, 
         SMIN, SMAX, TIP, NBS, OB22, KF)
       VALUES  
       (110, 
        980,'110 За внесення Непосортованої готівки на рах. клієнта', 0, 0,
        0, NULL, 0, NULL, NULL, k.KF );
     Exception WHEN OTHERS THEN 
       null;
     End;
    
  End Loop;

  Bc.home();

END;
/
commit;

---------------------------------------------------------------------

BEGIN

  Execute immediate 'Alter trigger TIU_SHTARIF_HISTORY  Disable';

  Bc.go('/') ;
  For k in (Select ID from TARIF_SCHEME)
  Loop
     Begin 
        Insert into BARS.SH_TARIF
          (IDS, KOD, TAR, PR, SMIN, SMAX, NBS_OB22)
        Values
          (k.ID, 110, 0, 0, 0, NULL, NULL);
     Exception WHEN OTHERS THEN 
       null;
     End;
  End Loop;

  Execute immediate 'Alter trigger TIU_SHTARIF_HISTORY  Enable';

END;
/
commit;

