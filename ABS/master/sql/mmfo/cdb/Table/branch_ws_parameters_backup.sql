

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BRANCH_WS_PARAMETERS_BACKUP.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  table BRANCH_WS_PARAMETERS_BACKUP ***
begin 
  execute immediate '
  CREATE TABLE CDB.BRANCH_WS_PARAMETERS_BACKUP 
   (	BRANCH_ID NUMBER(5,0), 
	URL VARCHAR2(300 CHAR), 
	LOGIN VARCHAR2(30 CHAR), 
	PASSWORD RAW(1000), 
	WALLET_DIR RAW(2000), 
	WALLET_PASS RAW(1000), 
	DEFAULT_NAMESPACE VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE CDB.BRANCH_WS_PARAMETERS_BACKUP IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS_BACKUP.BRANCH_ID IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS_BACKUP.URL IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS_BACKUP.LOGIN IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS_BACKUP.PASSWORD IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS_BACKUP.WALLET_DIR IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS_BACKUP.WALLET_PASS IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS_BACKUP.DEFAULT_NAMESPACE IS '';




PROMPT *** Create  constraint SYS_C00118903 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH_WS_PARAMETERS_BACKUP MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118904 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH_WS_PARAMETERS_BACKUP MODIFY (URL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_WS_PARAMETERS_BACKUP ***
grant SELECT                                                                 on BRANCH_WS_PARAMETERS_BACKUP to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BRANCH_WS_PARAMETERS_BACKUP.sql =======
PROMPT ===================================================================================== 
