

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_SESSION_STATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_SESSION_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_SESSION_STATE 
   (	ID NUMBER(10,0), 
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


COMMENT ON TABLE PFU.PFU_SESSION_STATE IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_STATE.ID IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_STATE.STATE_CODE IS '';
COMMENT ON COLUMN PFU.PFU_SESSION_STATE.STATE_NAME IS '';




PROMPT *** Create  constraint SYS_C00111502 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_STATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111503 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_STATE MODIFY (STATE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111504 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_STATE MODIFY (STATE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_SESSION_STATE ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SESSION_STATE ADD CONSTRAINT PK_PFU_SESSION_STATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_SESSION_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_SESSION_STATE ON PFU.PFU_SESSION_STATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_SESSION_STATE ***
grant SELECT                                                                 on PFU_SESSION_STATE to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_SESSION_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_SESSION_STATE.sql =========*** End 
PROMPT ===================================================================================== 
