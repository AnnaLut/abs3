begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_refs'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''ins_ewa_refs'', ''FILIAL'', null, null, null , null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin 
execute immediate '
create table ins_ewa_refs(
ewa_id number,
ref number(32)
)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
COMMENT ON TABLE BARS.ins_ewa_refs IS 'Таблиця дла тимчасового зберігання пар референс - договір EWA';
/
COMMENT ON COLUMN BARS.ins_ewa_refs.ewa_id IS 'Номер договору';
/
COMMENT ON COLUMN BARS.ins_ewa_refs.ref IS 'Референс';
/

begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ins_ewa_refs ON BARS.ins_ewa_refs (ewa_id) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate '
ALTER TABLE BARS.ins_ewa_refs ADD (
  CONSTRAINT PK_ins_ewa_refs
  PRIMARY KEY
  (ewa_id)
  USING INDEX BARS.PK_ins_ewa_refs
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

grant select, insert, update, delete on ins_ewa_refs to bars_access_defrole;

/
