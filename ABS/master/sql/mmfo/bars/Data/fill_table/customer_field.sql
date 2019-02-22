prompt add FMPOS reqv
begin
insert into customer_field (TAG, NAME, B, U, F, TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, U_NREZ, F_NREZ, F_SPD)
values ('FMPOS', 'Висн. щодо наявн.у кл-та потенц. та реал. фін.можл.для провед. опер.', 1, 1, 1, 'FM_POSS', null, null, null, 'NAME', null, 'FM', 0, null, null, 0, 1, 1);
commit;
exception
when dup_val_on_index then null;
end;
/

begin
 update customer_field set F=2,F_SPD=2 where tag = 'FMPOS';
commit;
 end;
/

begin 
  execute immediate 
    ' Insert into BARS.CUSTOMER_FIELD (TAG, NAME, U, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)'||
    ' Values (''DEDR '', ''Дата запису в ЄДР'', 2, ''D'', 1, ''GENERAL'', 0, 2, 2, 2) ';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' Insert into BARS.CUSTOMER_FIELD (TAG, NAME, U, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)'||
    ' Values (''NEDR '', ''Номер запису в ЄДР'', 2, ''N'', 1, ''GENERAL'', 0, 2, 2, 2) ';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' Insert into BARS.CUSTOMER_FIELD (TAG, NAME, U, TYPE, OPT, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD)'||
    ' Values (''VVORG'', ''Відомості про виконавчий орган'', 2, ''U'', 1, ''FM'', 0, 2, 2, 2) ';
exception when dup_val_on_index then 
  null;
end;
/

COMMIT;	
