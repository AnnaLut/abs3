

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_EPP_KILLED.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_EPP_KILLED ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_EPP_KILLED 
   (	EPP_NUMBER VARCHAR2(12), 
	KILL_TYPE NUMBER(1,0), 
	KILL_DATE DATE, 
	STATE NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_EPP_KILLED IS 'Информация по причинам удаления ЕПП';
COMMENT ON COLUMN PFU.PFU_EPP_KILLED.EPP_NUMBER IS '';
COMMENT ON COLUMN PFU.PFU_EPP_KILLED.KILL_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_EPP_KILLED.KILL_DATE IS '';
COMMENT ON COLUMN PFU.PFU_EPP_KILLED.STATE IS '';




PROMPT *** Create  constraint SYS_C00111477 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILLED MODIFY (EPP_NUMBER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111478 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILLED MODIFY (KILL_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111479 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILLED MODIFY (KILL_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111480 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILLED MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_EPP_KILLED ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_EPP_KILLED ADD CONSTRAINT PK_PFU_EPP_KILLED PRIMARY KEY (EPP_NUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_EPP_KILLED ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_EPP_KILLED ON PFU.PFU_EPP_KILLED (EPP_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_EPP_KILLED ***
grant SELECT                                                                 on PFU_EPP_KILLED  to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_EPP_KILLED  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_EPP_KILLED  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_EPP_KILLED.sql =========*** End ***
PROMPT ===================================================================================== 
