

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/STATUS_RECORD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table STATUS_RECORD ***
begin 
  execute immediate '
  CREATE TABLE FINMON.STATUS_RECORD 
   (	STATUS_ID NUMBER(3,0), 
	STATUS_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.STATUS_RECORD IS 'Метаописание статусов записей в БД';
COMMENT ON COLUMN FINMON.STATUS_RECORD.STATUS_ID IS 'Идентификатор';
COMMENT ON COLUMN FINMON.STATUS_RECORD.STATUS_NAME IS 'Пояснение';




PROMPT *** Create  constraint XPK_STATUS_RECORD ***
begin   
 execute immediate '
  ALTER TABLE FINMON.STATUS_RECORD ADD CONSTRAINT XPK_STATUS_RECORD PRIMARY KEY (STATUS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_STATUS_RECORD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_STATUS_RECORD ON FINMON.STATUS_RECORD (STATUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/STATUS_RECORD.sql =========*** End *
PROMPT ===================================================================================== 
