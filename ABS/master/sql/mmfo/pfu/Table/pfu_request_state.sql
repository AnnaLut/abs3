

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_STATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_REQUEST_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_REQUEST_STATE 
   (	ID NUMBER(5,0), 
	STATE_CODE VARCHAR2(30 CHAR), 
	STATE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_REQUEST_STATE IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_STATE.ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_STATE.STATE_CODE IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST_STATE.STATE_NAME IS '';




PROMPT *** Create  constraint PK_PFU_REQUEST_STATE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_STATE ADD CONSTRAINT PK_PFU_REQUEST_STATE PRIMARY KEY (STATE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111501 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_STATE MODIFY (STATE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111500 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_STATE MODIFY (STATE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111499 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST_STATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_REQUEST_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_REQUEST_STATE ON PFU.PFU_REQUEST_STATE (STATE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST_STATE.sql =========*** End 
PROMPT ===================================================================================== 
