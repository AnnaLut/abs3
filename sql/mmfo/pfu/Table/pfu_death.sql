

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_DEATH.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_DEATH ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_DEATH 
   (	ID NUMBER(38,0), 
	REQUEST_ID NUMBER(38,0), 
	COUNT_RES VARCHAR2(4000), 
	DATE_PFU DATE, 
	DATE_CR DATE, 
	STATE VARCHAR2(20), 
	USERID NUMBER(38,0), 
	PFU_FILE_ID VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_DEATH IS 'Скписки, умерших пенсионеров';
COMMENT ON COLUMN PFU.PFU_DEATH.ID IS '';
COMMENT ON COLUMN PFU.PFU_DEATH.REQUEST_ID IS '';
COMMENT ON COLUMN PFU.PFU_DEATH.COUNT_RES IS '';
COMMENT ON COLUMN PFU.PFU_DEATH.DATE_PFU IS '';
COMMENT ON COLUMN PFU.PFU_DEATH.DATE_CR IS '';
COMMENT ON COLUMN PFU.PFU_DEATH.STATE IS '';
COMMENT ON COLUMN PFU.PFU_DEATH.USERID IS '';
COMMENT ON COLUMN PFU.PFU_DEATH.PFU_FILE_ID IS '';




PROMPT *** Create  constraint SYS_C00111469 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_DEATH_LIST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH ADD CONSTRAINT PK_PFU_DEATH_LIST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111470 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_DEATH MODIFY (REQUEST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_DEATH_LIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_DEATH_LIST ON PFU.PFU_DEATH (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_DEATH.sql =========*** End *** ====
PROMPT ===================================================================================== 
