begin   
 execute immediate '
create sequence CORP2_REL_CUST_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20';
   exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


grant SELECT    on CORP2_REL_CUST_SEQ     to bars_access_defrole;

