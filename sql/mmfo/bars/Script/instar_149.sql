
---------------------------------------------------------------
--
--                  Заявка COBUSUPABS-6839
--                                                                 
---------------------------------------------------------------

BEGIN

  Bc.home();

  For k in (Select KF from MV_KF)

  Loop

    INSERT INTO TARIF 
    ( KOD,
      KV, NAME, TAR, PR, 
      SMIN, SMAX, TIP, NBS, OB22, KF)
    VALUES  
    ( 149, 
      980,'Приймання готівкових коштів від бюджетних установ і перерах. їх в ДКСУ', 0, 0.15,
      0, NULL, 0, NULL, NULL, k.KF );
    
  End Loop;

  Bc.home();

EXCEPTION WHEN OTHERS then
   null;
END;
/
commit;

