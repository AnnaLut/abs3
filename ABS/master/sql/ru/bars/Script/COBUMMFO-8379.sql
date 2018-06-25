begin
update sw_own c 
 set c.compare_id = 0
where c.compare_id <> 0 and not exists (select * from sw_compare where id=c.compare_id);
end;
/
commit;
/



begin   
 execute immediate 'ALTER TABLE SW_OWN drop CONSTRAINT PK_SW_OWN';
exception when others then
  if  sqlcode in (-2443)  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'drop index PK_SW_OWN';
exception when others then
  if  sqlcode in (-1418,-2429)  then null; else raise; end if;
 end;
/