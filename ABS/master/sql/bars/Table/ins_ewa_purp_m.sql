begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_purp_m'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_purp_m'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 

begin 
execute immediate '
create table ins_ewa_purp_m(
id       number(3),
r_id     number(3),
mval_id  number(3),
stat_val varchar2(255),
SPLIT_S  VARCHAR2(1 Byte),
FUNC_USE VARCHAR2(255 Byte)
  )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
COMMENT ON TABLE BARS.ins_ewa_purp_m IS 'Конструктор призначення платежу EWA';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_m.id IS 'ID шаблону';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_m.r_id IS 'ID рядку';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_m.mval_id IS 'ID параметру';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_m.stat_val IS 'Статичне значення';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_m.SPLIT_S IS 'Розділовий знак (;/ \)';
/
COMMENT ON COLUMN BARS.ins_ewa_purp_m.FUNC_USE IS 'Ознака використання функції';
/

begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INS_EWA_PURP_M ON BARS.INS_EWA_PURP_M (ID,R_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate '
ALTER TABLE BARS.INS_EWA_PURP_M ADD (
  CONSTRAINT PK_INS_EWA_PURP_M
  PRIMARY KEY
  (ID,R_ID)
  USING INDEX BARS.PK_INS_EWA_PURP_M
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin   
 execute immediate ' 
ALTER TABLE BARS.ins_ewa_purp_m ADD 
CONSTRAINT fk_ins_ewa_purp_m
 FOREIGN KEY (mval_id)
 REFERENCES BARS.ins_ewa_purp_mval(ID)
 ENABLE
 VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;

/

grant select, insert, update, delete on ins_ewa_purp_m to bars_access_defrole;

/