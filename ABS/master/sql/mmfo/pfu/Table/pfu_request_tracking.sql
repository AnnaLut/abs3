

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_TRACKING.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_REQUEST_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_REQUEST_TRACKING 
   (	ID NUMBER(10,0), 
	REQUEST_ID NUMBER(10,0), 
	STATE VARCHAR2(30), 
	SYS_TIME DATE, 
	TRACKING_COMMENT VARCHAR2(4000), 
	ERROR_STACK CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (ERROR_STACK) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_REQUEST_TRACKING IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TRACKING.ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TRACKING.REQUEST_ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TRACKING.STATE IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TRACKING.SYS_TIME IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TRACKING.TRACKING_COMMENT IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TRACKING.ERROR_STACK IS '';




PROMPT *** Create  constraint FK_REQ_TRACK_REF_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TRACKING ADD CONSTRAINT FK_REQ_TRACK_REF_REQUEST FOREIGN KEY (REQUEST_ID)
	  REFERENCES PFU.PFU_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111507 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_REQUEST_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TRACKING ADD CONSTRAINT PK_PFU_REQUEST_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111509 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111508 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TRACKING MODIFY (REQUEST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_REQUEST_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_REQUEST_TRACKING ON PFU.PFU_REQUEST_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_TRACKING.sql =========*** E
PROMPT ===================================================================================== 
