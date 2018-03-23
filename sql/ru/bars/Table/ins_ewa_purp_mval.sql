begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_purp_mval'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_purp_mval'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 

begin 
execute immediate '
create table ins_ewa_purp_mval(
id              number(3),
purp_name       varchar2(255),
purp_val        varchar2(255),
alt_path        varchar2(255),
alt_path_cond   varchar2(255),
def_val         varchar2(50)

)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
COMMENT ON TABLE BARS.ins_ewa_purp_mval IS 'Довідник параметрів призначення платежу EWA';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_mval.id IS 'ID параметру';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_mval.purp_name IS 'Назва параметру';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_mval.purp_val IS 'XPATH параметру';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_mval.alt_path IS 'Альтернативний XPATH';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_mval.alt_path_cond IS 'Умова використання альтернативного XPATH в форматі XPATH параметру|значення';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_mval.def_val IS 'Значення за замовчуванням';
/

begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INS_EWA_PURP_MVAL ON BARS.INS_EWA_PURP_MVAL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate '
ALTER TABLE BARS.INS_EWA_PURP_MVAL ADD (
  CONSTRAINT PK_INS_EWA_PURP_MVAL
  PRIMARY KEY
  (ID)
  USING INDEX BARS.PK_INS_EWA_PURP_MVAL
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
execute immediate('
alter table bars.ins_ewa_purp_mval add 
  CONSTRAINT CC_ins_ewa_purp_mval_name
  CHECK (purp_name IS NOT NULL)
  ENABLE VALIDATE');
exception when others then 
if sqlcode = -02264 or sqlcode=-1442 then null;
else
raise;
end if;
end;
/

begin
execute immediate('
alter table bars.ins_ewa_purp_mval add 
  CONSTRAINT CC_ins_ewa_purp_val
  CHECK (purp_val IS NOT NULL)
  ENABLE VALIDATE');
exception when others then 
if sqlcode = -02264 or sqlcode=-1442 then null;
else
raise;
end if;
end;
/

grant select, insert, update, delete on ins_ewa_purp_mval to bars_access_defrole;

/