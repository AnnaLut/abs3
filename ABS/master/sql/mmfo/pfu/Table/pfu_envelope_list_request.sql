

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_ENVELOPE_LIST_REQUEST.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_ENVELOPE_LIST_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_ENVELOPE_LIST_REQUEST 
   (	ID NUMBER(10,0), 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	OPFU_CODE VARCHAR2(20), 
	SET_DATE DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_ENVELOPE_LIST_REQUEST IS 'Запит на отримання списку конвертів з файлами зарахувань пенсій';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_LIST_REQUEST.ID IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_LIST_REQUEST.DATE_FROM IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_LIST_REQUEST.DATE_TO IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_LIST_REQUEST.OPFU_CODE IS '';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_LIST_REQUEST.SET_DATE IS '';




PROMPT *** Create  constraint SYS_C00111465 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_ENVELOPE_LIST_REQUEST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111466 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_ENVELOPE_LIST_REQUEST MODIFY (DATE_FROM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ENV_LIST_REF_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_ENVELOPE_LIST_REQUEST ADD CONSTRAINT FK_ENV_LIST_REF_REQUEST FOREIGN KEY (ID)
	  REFERENCES PFU.PFU_REQUEST (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_ENVELOPE_LIST_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_ENVELOPE_LIST_REQUEST ADD CONSTRAINT PK_PFU_ENVELOPE_LIST_REQUEST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111467 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_ENVELOPE_LIST_REQUEST MODIFY (DATE_TO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_ENVELOPE_LIST_REQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_ENVELOPE_LIST_REQUEST ON PFU.PFU_ENVELOPE_LIST_REQUEST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_ENVELOPE_LIST_REQUEST.sql =========
PROMPT ===================================================================================== 
