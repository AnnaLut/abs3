begin
update OB_CORPORATION o
   set o.BASE_CORP = (select case when parent_id is null 
                                  then -1 else to_number(base_extid) end 
                       from v_org_corporations v where v.id = o.id);
commit;
end;
/
begin
 execute immediate 'drop index IND_OB_CORP_EXT';
exception when others then
if sqlcode = -01418 then null; else raise; end if;
end;
/

