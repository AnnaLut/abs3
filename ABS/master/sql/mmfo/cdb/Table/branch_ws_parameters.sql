

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/CDB/Table/BRANCH_WS_PARAMETERS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table BRANCH_WS_PARAMETERS ***
begin 
  execute immediate '
  CREATE TABLE CDB.BRANCH_WS_PARAMETERS 
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


COMMENT ON TABLE CDB.BRANCH_WS_PARAMETERS IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS.BRANCH_ID IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS.URL IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS.LOGIN IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS.PASSWORD IS '';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS.WALLET_DIR IS 'Параметри wallet для https';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS.WALLET_PASS IS 'Параметри wallet для https';
COMMENT ON COLUMN CDB.BRANCH_WS_PARAMETERS.DEFAULT_NAMESPACE IS '';




PROMPT *** Create  constraint SYS_C00118921 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH_WS_PARAMETERS MODIFY (BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00118922 ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH_WS_PARAMETERS MODIFY (URL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRANCH_WS_PARAMETERS ***
begin   
 execute immediate '
  ALTER TABLE CDB.BRANCH_WS_PARAMETERS ADD CONSTRAINT PK_BRANCH_WS_PARAMETERS PRIMARY KEY (BRANCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCH_WS_PARAMETERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX CDB.PK_BRANCH_WS_PARAMETERS ON CDB.BRANCH_WS_PARAMETERS (BRANCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_WS_PARAMETERS ***
grant SELECT                                                                 on BRANCH_WS_PARAMETERS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/CDB/Table/BRANCH_WS_PARAMETERS.sql =========*** E
PROMPT ===================================================================================== 
