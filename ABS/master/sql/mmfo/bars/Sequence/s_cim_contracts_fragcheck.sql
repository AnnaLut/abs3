begin   
 execute immediate '
create sequence s_cim_contracts_fragcheck
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 2';
   exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


grant SELECT    on s_cim_contracts_fragcheck     to bars_access_defrole;
