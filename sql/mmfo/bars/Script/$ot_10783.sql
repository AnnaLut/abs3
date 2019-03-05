--------------------------------------------------------------------- 
--
--  Создаем новый Доп.Реквизит операции VOVDP:  
--         = 1 - ОВДП в ГРН
--         = 2 - ОВДП в ВАЛ
---------------------------------------------------------------------

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'VOVDP', 'Валюта ОВДП: 1 - Грн, 2 - Вал',  
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

commit;

---------------------------------------------------------------------


