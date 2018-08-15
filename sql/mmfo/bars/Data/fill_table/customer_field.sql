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