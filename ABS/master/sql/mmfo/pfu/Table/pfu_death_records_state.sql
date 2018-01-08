

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_RECORDS_STATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_DEATH_RECORDS_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_DEATH_RECORDS_STATE 
   (	ID VARCHAR2(30), 
	NAME VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_DEATH_RECORDS_STATE IS 'Описания статусов записей реестра по умершим';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORDS_STATE.ID IS 'Код статуса';
COMMENT ON COLUMN PFU.PFU_DEATH_RECORDS_STATE.NAME IS 'Наименование статуса';




PROMPT *** Create  constraint SYS_C00139074 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_RECORDS_STATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_DEATH_RECORDS ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH_RECORDS_STATE ADD CONSTRAINT PK_PFU_DEATH_RECORDS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_DEATH_RECORDS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_DEATH_RECORDS ON PFU.PFU_DEATH_RECORDS_STATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_DEATH_RECORDS_STATE ***
grant SELECT                                                                 on PFU_DEATH_RECORDS_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_DEATH_RECORDS_STATE.sql =========**
PROMPT ===================================================================================== 
