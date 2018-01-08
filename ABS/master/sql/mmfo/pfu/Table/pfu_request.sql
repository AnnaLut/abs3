

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_REQUEST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_REQUEST 
   (	ID NUMBER(10,0), 
	REQUEST_TYPE VARCHAR2(30), 
	STATE VARCHAR2(30), 
	PFU_REQUEST_ID NUMBER(10,0), 
	PARENT_REQUEST_ID NUMBER(10,0), 
	SYS_TIME DATE, 
	PARTS_CNT NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_REQUEST IS 'Запити адресовані сервісам ПФУ на отримання даних';
COMMENT ON COLUMN PFU.PFU_REQUEST.ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST.REQUEST_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST.STATE IS 'Стан запиту реєстру (0 - запит запланований, 1 - формування реєстру ініційовано, 2 - формування реєстру скасовано ПФУ, 3 - дані реєстру отримані)';
COMMENT ON COLUMN PFU.PFU_REQUEST.PFU_REQUEST_ID IS 'Ідентифікат запиту в системі ПФУ, за яким виконується отримання даних після завершення їх обробки';
COMMENT ON COLUMN PFU.PFU_REQUEST.PARENT_REQUEST_ID IS '';
COMMENT ON COLUMN PFU.PFU_REQUEST.SYS_TIME IS 'Системний час створення запиту';
COMMENT ON COLUMN PFU.PFU_REQUEST.PARTS_CNT IS '';




PROMPT *** Create  constraint SYS_C00111445 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111446 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST MODIFY (REQUEST_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111447 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111448 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_REQUEST ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_REQUEST ADD CONSTRAINT PK_PFU_REQUEST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_REQUEST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_REQUEST ON PFU.PFU_REQUEST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_REQUEST ***
grant SELECT                                                                 on PFU_REQUEST     to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_REQUEST     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_REQUEST.sql =========*** End *** ==
PROMPT ===================================================================================== 
