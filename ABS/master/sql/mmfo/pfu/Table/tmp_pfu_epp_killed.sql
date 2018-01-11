

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/TMP_PFU_EPP_KILLED.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_PFU_EPP_KILLED ***
begin 
  execute immediate '
  CREATE TABLE PFU.TMP_PFU_EPP_KILLED 
   (	NAME_RU VARCHAR2(32), 
	EPP_NUMBER VARCHAR2(12), 
	KILL_TYPE NUMBER(1,0), 
	KILL_DATE DATE, 
	STATE NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.TMP_PFU_EPP_KILLED IS '';
COMMENT ON COLUMN PFU.TMP_PFU_EPP_KILLED.NAME_RU IS '';
COMMENT ON COLUMN PFU.TMP_PFU_EPP_KILLED.EPP_NUMBER IS '';
COMMENT ON COLUMN PFU.TMP_PFU_EPP_KILLED.KILL_TYPE IS '';
COMMENT ON COLUMN PFU.TMP_PFU_EPP_KILLED.KILL_DATE IS '';
COMMENT ON COLUMN PFU.TMP_PFU_EPP_KILLED.STATE IS '';




PROMPT *** Create  constraint SYS_C00119345 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TMP_PFU_EPP_KILLED MODIFY (NAME_RU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119346 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TMP_PFU_EPP_KILLED MODIFY (EPP_NUMBER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119347 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TMP_PFU_EPP_KILLED MODIFY (KILL_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119348 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TMP_PFU_EPP_KILLED MODIFY (KILL_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119349 ***
begin   
 execute immediate '
  ALTER TABLE PFU.TMP_PFU_EPP_KILLED MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_PFU_EPP_KILLED ***
grant SELECT                                                                 on TMP_PFU_EPP_KILLED to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_PFU_EPP_KILLED to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_PFU_EPP_KILLED to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/TMP_PFU_EPP_KILLED.sql =========*** End
PROMPT ===================================================================================== 
