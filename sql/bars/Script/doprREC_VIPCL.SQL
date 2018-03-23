--------------------------------------------------------------------- 
--
-- 1). Создаем новый Доп.Реквизит операции:
--          K_VIP  - 'VIP-клієнт (1-Так)'
--
-- 2). Включаем его в операцию САА. 
--
---------------------------------------------------------------------

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'K_VIP', 'VIP-клієнт (1-Так)',  
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/


---  Добавляем Доп.Реквизит K_VIP в операцию CAA:
                     
                                       
begin
  insert into op_rules( TAG   ,  TT  ,  OPT, USED4INPUT, ORD, VAL, NOMODIFY)
             values   ('K_VIP', 'CAA',  'M',     0     ,   0, '0', null    );
exception WHEN OTHERS THEN 
  null;
end;
/

commit;

---------------------------------------------------------------------


