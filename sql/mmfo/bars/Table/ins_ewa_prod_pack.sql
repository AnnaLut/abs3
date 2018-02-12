begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_prod_pack'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_prod_pack'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 
BEGIN
execute immediate 'create table ins_ewa_prod_pack (
okpo varchar2(20),
ext_code number,
ewa_type_id varchar2(30),
MASK_ID      NUMBER)';
  exception when others then
  if sqlcode = -955 then null;
  else raise;
  end if;
 END;
/
begin
execute immediate 'alter table ins_ewa_prod_pack add MASK_ID NUMBER';
exception when others then
 if sqlcode = -1430 then null; 
 else raise;
 end if;
end;
/
COMMENT ON TABLE BARS.ins_ewa_prod_pack IS 'Довідник типів страхування для прдуктових пакетів';
/
COMMENT ON COLUMN BARS.ins_ewa_prod_pack.okpo IS 'ОКПО';
/
COMMENT ON COLUMN BARS.ins_ewa_prod_pack.ext_code IS 'Тип страхування';
/
COMMENT ON COLUMN BARS.ins_ewa_prod_pack.ewa_type_id IS 'Тип страхування EWA';
/
COMMENT ON COLUMN BARS.ins_ewa_prod_pack.mask_id IS 'Ід маски призначення';
/

begin
  execute immediate 'begin BARS_POLICY_ADM.ALTER_POLICIES(''ins_ewa_prod_pack''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin   
 execute immediate 'ALTER TABLE BARS.ins_ewa_prod_pack ADD 
CONSTRAINT ins_ewa_prod_pack_PK
 PRIMARY KEY (okpo,ext_code)
 ENABLE
 VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
begin   
 execute immediate ' 
ALTER TABLE BARS.ins_ewa_prod_pack ADD 
CONSTRAINT ins_ewa_prod_pack_FK
 FOREIGN KEY (ewa_type_id)
 REFERENCES BARS.ins_ewa_types (id)
  ON DELETE CASCADE
 ENABLE
 VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
grant select, insert, update, delete on ins_ewa_prod_pack to bars_access_defrole;
/