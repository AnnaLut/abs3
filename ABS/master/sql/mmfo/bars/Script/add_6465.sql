---===============================================================================================
----
----                                    COBUMMFO-6465
----
----   1).  Создаем в OP_FIELD новые доп.реквизиты операций:   S_MIN - "Але не менше",  S_MAX - "Але не більше"                            
----   2).  Создаем шаблон VOB=147 для операций 470,471,472
----
---===============================================================================================
--
--  Создаем новые доп.реквизиты операций:   S_MIN - "Але не менше",  S_MAX - "Але не більше"                            
--
Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'S_MIN', 'Але не менше',  
        NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'S_MAX', 'Але не більше',  
        NULL, NULL, NULL, NULL, NULL, NULL, 'N', 0 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/
COMMIT;

-----------------------------------------------------------------------------------------------

SET DEFINE OFF;
PROMPT  ---- Создание шаблона №147 для операции 470,471,472!!!
exec bc.go('/');
begin
Insert into BARS.VOB
   (VOB, NAME, FLV, REP_PREFIX)
 Values
   (147, 'Заява на пер гот+Мем.орд', 1, 'ORDERN');
   exception when dup_val_on_index then  null;
end;
/
begin
delete from TTS_VOB where tt in('470','471','472') 
   exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'TT_470', 'select tt from oper where ref=:nRecID and tt=''470''', 'Для друкування 470', 'TIC');
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'TT_471', 'select tt from oper where ref=:nRecID and tt=''471''', 'Для друкування 471', 'TIC');
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'TT_472','select tt from oper where ref=:nRecID and tt=''472''', 'Для друкування 472', 'TIC');
   Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'NLS_470','select substr(a.nls,1,14) from opldok o, accounts a where o.ref=:nRecID and o.acc=a.acc and o.tt in(''470'',''471'',''472'') order by a.nls desc', 'Рахунок Б для TT 470,471,472', 'TIC');
   Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, MOD_CODE)
 Values
   ('DEFAULT', 'NAME_K76', 'select trim(substr(a.nms,1,50)) from opldok o, accounts a where o.ref=:nRecID and a.acc=o.acc and a.nls like ''3570%''and o.dk=0 and o.tt in(''K76'',''K70'')', 'TIC');
   exception when dup_val_on_index then  null;
end;
/
begin
Insert into BARS.TTS_VOB
   (TT, VOB, ORD)
 Values
   ('470', 147, 1);
Insert into BARS.TTS_VOB
   (TT, VOB, ORD)
 Values
   ('471', 147, 1);
Insert into BARS.TTS_VOB
   (TT, VOB, ORD)
 Values
   ('472', 147, 1);
   exception when dup_val_on_index then  null;
end;
/
COMMIT;

