

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_TRACKING.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_LINE_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_LINE_TRACKING 
   (	ID NUMBER(38,0), 
	LINE_ID NUMBER(38,0), 
	STATE_ID NUMBER(5,0), 
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


COMMENT ON TABLE PFU.PFU_EPP_LINE_TRACKING IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRACKING.STATE_ID IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRACKING.SYS_TIME IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRACKING.TRACKING_COMMENT IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRACKING.ERROR_STACK IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRACKING.ID IS '';
COMMENT ON COLUMN PFU.PFU_EPP_LINE_TRACKING.LINE_ID IS '';




PROMPT *** Create  constraint SYS_C00111528 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111529 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_TRACKING MODIFY (LINE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111530 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_TRACKING MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111531 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_EPP_LINE_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_LINE_TRACKING ADD CONSTRAINT PK_PFU_EPP_LINE_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_EPP_LINE_TRACK_LINE_ID ***
begin   
 execute immediate '
  CREATE INDEX PFU.I_EPP_LINE_TRACK_LINE_ID ON PFU.PFU_EPP_LINE_TRACKING (LINE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_EPP_LINE_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_EPP_LINE_TRACKING ON PFU.PFU_EPP_LINE_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_EPP_LINE_TRACKING ***
grant SELECT                                                                 on PFU_EPP_LINE_TRACKING to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_LINE_TRACKING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_LINE_TRACKING.sql =========*** 
PROMPT ===================================================================================== 
