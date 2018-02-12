begin   
 execute immediate 'create sequence S_CP_ZAL_UPDATE
minvalue 0
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 5';

exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
