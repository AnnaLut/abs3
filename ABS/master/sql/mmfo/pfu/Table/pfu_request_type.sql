

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_TYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_REQUEST_TYPE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_REQUEST_TYPE 
   (	ID NUMBER(5,0), 
	REQUEST_TYPE_CODE VARCHAR2(30 CHAR), 
	REQUEST_TYPE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_REQUEST_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TYPE.ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TYPE.REQUEST_TYPE_CODE IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_TYPE.REQUEST_TYPE_NAME IS '';




PROMPT *** Create  constraint SYS_C00111495 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_REQUEST_TYPE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TYPE ADD CONSTRAINT PK_PFU_REQUEST_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111497 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TYPE MODIFY (REQUEST_TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111496 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_TYPE MODIFY (REQUEST_TYPE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_REQUEST_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_REQUEST_TYPE ON PFU.PFU_REQUEST_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_TYPE.sql =========*** End *
PROMPT ===================================================================================== 
