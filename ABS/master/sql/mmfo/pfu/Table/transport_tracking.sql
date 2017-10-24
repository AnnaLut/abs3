

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TRANSPORT_TRACKING.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSPORT_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE PFU.TRANSPORT_TRACKING 
   (	ID NUMBER(38,0), 
	UNIT_ID NUMBER(38,0), 
	STATE_ID NUMBER(5,0), 
	TRACKING_COMMENT VARCHAR2(4000), 
	STACK_TRACE CLOB, 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (STACK_TRACE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TRANSPORT_TRACKING IS '';
COMMENT ON COLUMN PFU.TRANSPORT_TRACKING.ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_TRACKING.UNIT_ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_TRACKING.STATE_ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_TRACKING.TRACKING_COMMENT IS '';
COMMENT ON COLUMN PFU.TRANSPORT_TRACKING.STACK_TRACE IS '';
COMMENT ON COLUMN PFU.TRANSPORT_TRACKING.SYS_TIME IS '';




PROMPT *** Create  constraint PK_TRANSPORT_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_TRACKING ADD CONSTRAINT PK_TRANSPORT_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111525 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_TRACKING MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111524 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_TRACKING MODIFY (UNIT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111523 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSPORT_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_TRANSPORT_TRACKING ON PFU.TRANSPORT_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TRANSPORT_TRACKING.sql =========*** End
PROMPT ===================================================================================== 
