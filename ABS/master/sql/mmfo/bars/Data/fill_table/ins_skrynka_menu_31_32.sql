prompt ====================================================================================================
prompt == Установка 31 операции по ДС. Дострокове закриття договору оренди індивідуального сейфа через касу
prompt == Установка 32 операции по ДС. Дострокове закриття договору оренди індивідуального сейфа(безнал)
prompt ==================================================================================================== 

DECLARE
  L_ITEM31 SKRYNKA_MENU.ITEM%TYPE := 31;
  L_ITEM32 SKRYNKA_MENU.ITEM%TYPE := 32;
BEGIN
  BC.GO('/');

  FOR CUR IN (SELECT KF FROM BARS.MV_KF) LOOP
    -- kf
    BC.GO(CUR.KF);
    
  delete from skrynka_menu sm
  where SM.ITEM in (L_ITEM31, L_ITEM32)
  AND SM.KF = CUR.KF;

    
      INSERT INTO SKRYNKA_MENU
        (ITEM,
         NAME,
         TYPE,
         DATENAME1,
         DATENAME2,
         TT,
         SK,
         TT2,
         TT3,
         VOB,
         VOB2,
         VOB3,
         NUMPARNAME,
         BRANCH,
         KF,
         STRPARNAME)
      
      VALUES
        (L_ITEM31,
         'Дострокове закриття договору оренди індивідуального сейфа через касу',
         'SKRN',
         NULL,
         NULL,
         'SN1',
         61,
         'SN3',
         'SN3',
         101,
         6,
         6,
         NULL,
         '/' || CUR.KF || '/',
         CUR.KF,
         NULL);

      INSERT INTO SKRYNKA_MENU
        (ITEM,
         NAME,
         TYPE,
         DATENAME1,
         DATENAME2,
         TT,
         SK,
         TT2,
         TT3,
         VOB,
         VOB2,
         VOB3,
         NUMPARNAME,
         BRANCH,
         KF,
         STRPARNAME)
      
      VALUES
        (L_ITEM32,
         'Дострокове закриття договору оренди індивідуального сейфа(безнал)',
         'SKRN',
         NULL,
         NULL,
         'SN1',
         NULL,
         'SN3',
         'SN3',
         6,
         6,
         6,
         NULL,
         '/' || CUR.KF || '/',
         CUR.KF,
         NULL);
  
  END LOOP; --kf
  COMMIT;

  BC.HOME;

EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
