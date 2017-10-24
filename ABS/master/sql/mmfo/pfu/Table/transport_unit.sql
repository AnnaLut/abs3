

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TRANSPORT_UNIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table TRANSPORT_UNIT ***
begin 
  execute immediate '
  CREATE TABLE PFU.TRANSPORT_UNIT 
   (	ID NUMBER(38,0), 
	UNIT_TYPE_ID NUMBER(5,0), 
	RECEIVER_URL VARCHAR2(4000), 
	REQUEST_DATA BLOB, 
	RESPONSE_DATA BLOB, 
	STATE_ID NUMBER(5,0), 
	FAILURES_COUNT NUMBER(5,0), 
	UPD_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (REQUEST_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPONSE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TRANSPORT_UNIT IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.UPD_DATE IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.UNIT_TYPE_ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.RECEIVER_URL IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.REQUEST_DATA IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.RESPONSE_DATA IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.STATE_ID IS '';
COMMENT ON COLUMN PFU.TRANSPORT_UNIT.FAILURES_COUNT IS '';




PROMPT *** Create  constraint PK_TRANSPORT_UNIT ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT ADD CONSTRAINT PK_TRANSPORT_UNIT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111517 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111518 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT MODIFY (UNIT_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111522 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT MODIFY (FAILURES_COUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111520 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT MODIFY (REQUEST_DATA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111521 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT MODIFY (STATE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111519 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TRANSPORT_UNIT MODIFY (RECEIVER_URL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANSPORT_UNIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_TRANSPORT_UNIT ON PFU.TRANSPORT_UNIT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** ADD field KF ***
begin   
 execute immediate '
	alter table PFU.TRANSPORT_UNIT add kf VARCHAR2(6)';
exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TRANSPORT_UNIT.sql =========*** End ***
PROMPT ===================================================================================== 
