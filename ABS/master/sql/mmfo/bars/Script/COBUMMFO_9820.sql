PROMPT *** Create  index UK_WEB_USERMAP ***
delete from BARS.WEB_USERMAP where WEBUSER = 'WEB_OPER';
commit;
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_WEB_USERMAP ON BARS.WEB_USERMAP (LOWER(WEBUSER)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index STAFF_AD_USER_NAME_L_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.STAFF_AD_USER_NAME_L_IDX ON BARS.STAFF_AD_USER (LOWER(ACTIVE_DIRECTORY_NAME)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




