

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_PARAMS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_SYNCRU_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_SYNCRU_PARAMS 
   (	KF VARCHAR2(6), 
	NAME VARCHAR2(100), 
	SYNC_SERVICE_URL VARCHAR2(1000), 
	SYNC_LOGIN VARCHAR2(100), 
	SYNC_PASSWORD VARCHAR2(100), 
	LAST_SYNC_DATE DATE, 
	SYNC_ENABLED NUMBER(1,0) DEFAULT 0, 
	LAST_SYNC_STATUS VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_SYNCRU_PARAMS IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.KF IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.NAME IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.SYNC_SERVICE_URL IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.SYNC_LOGIN IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.SYNC_PASSWORD IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.LAST_SYNC_DATE IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.SYNC_ENABLED IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PARAMS.LAST_SYNC_STATUS IS '';




PROMPT *** Create  constraint SYS_C00111438 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PARAMS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111439 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PARAMS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111440 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PARAMS MODIFY (SYNC_SERVICE_URL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111441 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PARAMS MODIFY (SYNC_LOGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111442 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PARAMS MODIFY (SYNC_PASSWORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111443 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PARAMS MODIFY (SYNC_ENABLED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFUSYNCRUPARAMS ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PARAMS ADD CONSTRAINT PK_PFUSYNCRUPARAMS PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFUSYNCRUPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFUSYNCRUPARAMS ON PFU.PFU_SYNCRU_PARAMS (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_SYNCRU_PARAMS ***
grant SELECT                                                                 on PFU_SYNCRU_PARAMS to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_SYNCRU_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_PARAMS.sql =========*** End 
PROMPT ===================================================================================== 
