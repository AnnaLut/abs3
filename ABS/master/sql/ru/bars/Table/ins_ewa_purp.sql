begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_purp'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_purp'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 

begin 
execute immediate '
create table ins_ewa_purp(
  INS_OKPO     VARCHAR2(20 BYTE),
  EWA_TYPE_ID  VARCHAR2(255 BYTE),
  MASK_ID      NUMBER)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
COMMENT ON TABLE BARS.ins_ewa_purp IS 'Довідник призначення платежу EWA';
/
COMMENT ON COLUMN BARS.ins_ewa_purp.INS_OKPO IS 'ОКПО страхової';
/
COMMENT ON COLUMN BARS.ins_ewa_purp.EWA_TYPE_ID IS 'Тип страхування EWA';
/
COMMENT ON COLUMN BARS.ins_ewa_purp.MASK_ID IS 'ID маски призначення';
/
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INS_EWA_PURP ON BARS.INS_EWA_PURP (INS_OKPO,EWA_TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate '
ALTER TABLE BARS.INS_EWA_PURP ADD (
  CONSTRAINT PK_INS_EWA_PURP
  PRIMARY KEY
  (INS_OKPO,EWA_TYPE_ID)
  USING INDEX BARS.PK_INS_EWA_PURP
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate ' 
ALTER TABLE BARS.INS_EWA_PURP ADD (
CONSTRAINT FK_INS_EWA_PURP
 FOREIGN KEY (ewa_type_id)
 REFERENCES BARS.ins_ewa_types(id)
 ENABLE
 VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate ' 
ALTER TABLE BARS.INS_EWA_PURP ADD (
CONSTRAINT FK_INS_EWA_PURP_OKPO
 FOREIGN KEY (INS_OKPO)
 REFERENCES BARS.ins_ewa_PART_OKPO(OKPO)
 ENABLE
 VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
execute immediate('
alter table bars.ins_ewa_purp add 
  CONSTRAINT CC_ins_ewa_purp_mask_id
  CHECK (mask_id IS NOT NULL)
  ENABLE VALIDATE');
exception when others then 
if sqlcode = -02264 or sqlcode=-1442 then null;
else
raise;
end if;
end;
/

grant select, insert, update, delete on ins_ewa_purp to bars_access_defrole;

/