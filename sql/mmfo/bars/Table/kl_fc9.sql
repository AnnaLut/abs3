begin
  bpa.alter_policy_info('KL_FC9', 'FILIAL',  null, null, null, null);
  bpa.alter_policy_info('KL_FC9', 'WHOLE',  null, null, null, null);
  commit;
exception when others then null;   
end;
/

Prompt ALTER Table OTCN_F70_TEMP;
begin
   execute immediate 'alter table OTCN_F70_TEMP add TT VARCHAR2(3)';
exception
	when others then null;
end;
/

Prompt Table KL_FC9;
begin
  execute immediate 
    'create table BARS.KL_FC9
(
  NLSD    VARCHAR2(15 BYTE),
  NLSK    VARCHAR2(15 BYTE),
  TT      VARCHAR2(3 BYTE),
  NAZN    VARCHAR2(160 BYTE),
  COMM    VARCHAR2(60 BYTE),
  PR_DEL  NUMBER
)';
exception 
  when others then
    if (sqlcode = -955) then null;
    else raise;
    end if;
end;
/

COMMENT ON TABLE BARS.KL_FC9 IS 'Довiдник особових(бал.) рах. для вiдбору док-тiв в файл #C9';

COMMENT ON COLUMN BARS.KL_FC9.NLSD IS 'Особовий рах. Дт';

COMMENT ON COLUMN BARS.KL_FC9.NLSK IS 'Особовий рах. Кт';

COMMENT ON COLUMN BARS.KL_FC9.TT IS 'Код операцii';

COMMENT ON COLUMN BARS.KL_FC9.NAZN IS 'Призначення платежу';

COMMENT ON COLUMN BARS.KL_FC9.COMM IS 'Коментар';

COMMENT ON COLUMN BARS.KL_FC9.PR_DEL IS 'Признак обробки (0 - не включати в обробку, 1 - включати)';

begin
    execute immediate 'DROP PUBLIC SYNONYM KL_FС9';
exception
    when others then null;
end;
/    

create public synonym KL_FС9 for bars.KL_FС9;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.KL_FC9 TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.KL_FC9 TO RPBN002;

GRANT DELETE, INSERT, SELECT, UPDATE, FLASHBACK ON BARS.KL_FC9 TO WR_ALL_RIGHTS;

GRANT SELECT, FLASHBACK ON BARS.KL_FC9 TO WR_REFREAD;

BEGIN
   bpa.alter_policies('KL_FC9');
END;
/


