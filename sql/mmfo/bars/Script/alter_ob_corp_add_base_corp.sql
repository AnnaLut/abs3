begin
execute immediate 'alter table ob_corporation add BASE_CORP number';
exception when others then
if sqlcode = -01430 then null; else raise; end if;
end;
/
begin
update OB_CORPORATION o
   set o.BASE_CORP = (select case when parent_id is null 
                                  then -1 else to_number(base_extid) end 
                       from v_org_corporations v where v.id = o.id);
commit;
end;
/
begin   
 execute immediate '
CREATE INDEX BARS.UK_OB_CORPORATION ON BARS.OB_CORPORATION
(EXTERNAL_ID, BASE_CORP)
LOGGING
TABLESPACE BRSSMLI compress 1';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
begin
 execute immediate 'drop index IND_OB_CORP_EXT';
exception when others then
if sqlcode = -01418 then null; else raise; end if;
end;
/

