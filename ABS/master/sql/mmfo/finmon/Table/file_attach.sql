

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/FILE_ATTACH.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table FILE_ATTACH ***
begin 
  execute immediate '
  CREATE TABLE FINMON.FILE_ATTACH 
   (	ID NUMBER(38,0), 
	IDA VARCHAR2(15), 
	RESP_DOD VARCHAR2(256), 
	FILE_ID VARCHAR2(15), 
	TYPE_DOD VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.FILE_ATTACH IS '';
COMMENT ON COLUMN FINMON.FILE_ATTACH.ID IS '';
COMMENT ON COLUMN FINMON.FILE_ATTACH.IDA IS '';
COMMENT ON COLUMN FINMON.FILE_ATTACH.RESP_DOD IS '';
COMMENT ON COLUMN FINMON.FILE_ATTACH.FILE_ID IS '';
COMMENT ON COLUMN FINMON.FILE_ATTACH.TYPE_DOD IS '';




PROMPT *** Create  constraint SYS_C0032146 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_ATTACH MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032147 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_ATTACH MODIFY (IDA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032148 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_ATTACH MODIFY (RESP_DOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032149 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_ATTACH MODIFY (TYPE_DOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FILE_ATTACH_PK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.FILE_ATTACH ADD CONSTRAINT FILE_ATTACH_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_FILEATTACH_IDA ***
begin   
 execute immediate '
  CREATE INDEX FINMON.XIE_FILEATTACH_IDA ON FINMON.FILE_ATTACH (IDA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index FILE_ATTACH_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.FILE_ATTACH_PK ON FINMON.FILE_ATTACH (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/FILE_ATTACH.sql =========*** End ***
PROMPT ===================================================================================== 
