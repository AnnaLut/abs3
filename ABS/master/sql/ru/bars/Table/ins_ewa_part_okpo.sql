begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_part_okpo'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_part_okpo'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 

begin 
execute immediate '
create table ins_ewa_part_okpo(
okpo varchar2(255),
name varchar2(255))';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
COMMENT ON TABLE BARS.ins_ewa_part_okpo IS 'Довідник ОКПО страхових компаній';
/
COMMENT ON COLUMN BARS.ins_ewa_part_okpo.okpo IS 'ОКПО';
/
COMMENT ON COLUMN BARS.ins_ewa_part_okpo.name IS 'Назва страхової компанії';
/

begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ins_ewa_part_okpo ON BARS.ins_ewa_part_okpo (okpo) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate '
ALTER TABLE BARS.ins_ewa_part_okpo ADD (
  CONSTRAINT PK_ins_ewa_part_okpo
  PRIMARY KEY
  (okpo)
  USING INDEX BARS.PK_ins_ewa_part_okpo
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
execute immediate('
alter table bars.ins_ewa_part_okpo add 
  CONSTRAINT CC_ins_ewa_part_okpo_name
  CHECK (name IS NOT NULL)
  ENABLE VALIDATE');
exception when others then 
if sqlcode = -02264 or sqlcode=-1442 then null;
else
raise;
end if;
end;
/

grant select, insert, update, delete on ins_ewa_part_okpo to bars_access_defrole;

/