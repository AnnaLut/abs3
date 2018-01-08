

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_STATUS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_SYNCRU_STATUS ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_SYNCRU_STATUS 
   (	SYNC_STATUS VARCHAR2(20), 
	NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_SYNCRU_STATUS IS 'Довідник статусів синхронізації';
COMMENT ON COLUMN PFU.PFU_SYNCRU_STATUS.SYNC_STATUS IS 'Статус синхронізації';
COMMENT ON COLUMN PFU.PFU_SYNCRU_STATUS.NAME IS 'Коментар';




PROMPT *** Create  constraint PK_PFUSYNCRUSTATUS ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_STATUS ADD CONSTRAINT PK_PFUSYNCRUSTATUS PRIMARY KEY (SYNC_STATUS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111490 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_STATUS MODIFY (SYNC_STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUSYNCRUSTATUS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_STATUS ADD CONSTRAINT CC_PFUSYNCRUSTATUS_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFUSYNCRUSTATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFUSYNCRUSTATUS ON PFU.PFU_SYNCRU_STATUS (SYNC_STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_STATUS.sql =========*** End 
PROMPT ===================================================================================== 
