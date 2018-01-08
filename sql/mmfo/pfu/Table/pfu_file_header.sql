

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_FILE_HEADER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_FILE_HEADER ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_FILE_HEADER 
   (	FILE_ID NUMBER(10,0), 
	FILE_DATE DATE, 
	LINES_COUNT NUMBER(6,0), 
	PAYER_MFO VARCHAR2(9 CHAR), 
	PAYER_ACCOUNT VARCHAR2(9 CHAR), 
	RECEIVER_MFO VARCHAR2(9 CHAR), 
	RECEIVER_ACCOUNT VARCHAR2(9 CHAR), 
	TOTAL_SUM NUMBER(19,0), 
	PAYER_NAME VARCHAR2(27 CHAR), 
	RECEIVER_NAME VARCHAR2(27 CHAR), 
	PAYMENT_PURPOSE VARCHAR2(160 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_FILE_HEADER IS '';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.FILE_ID IS '';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.FILE_DATE IS 'Дата створення файлу';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.LINES_COUNT IS 'Кількість інформаційних рядків';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.PAYER_MFO IS 'МФО банку-платника';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.PAYER_ACCOUNT IS 'Рахунок платника';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.RECEIVER_MFO IS 'МФО банку-одержувача';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.RECEIVER_ACCOUNT IS 'Рахунок одержувача';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.TOTAL_SUM IS 'Сума (в коп.) платежу';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.PAYER_NAME IS 'Найменування платника';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.RECEIVER_NAME IS 'Найменування одержувача';
COMMENT ON COLUMN PFU.PFU_FILE_HEADER.PAYMENT_PURPOSE IS 'Призначення платежу';




PROMPT *** Create  constraint SYS_C00111468 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_HEADER MODIFY (FILE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FILE_HEADER ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_FILE_HEADER ADD CONSTRAINT PK_FILE_HEADER PRIMARY KEY (FILE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FILE_HEADER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_FILE_HEADER ON PFU.PFU_FILE_HEADER (FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_FILE_HEADER ***
grant SELECT                                                                 on PFU_FILE_HEADER to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_FILE_HEADER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_FILE_HEADER.sql =========*** End **
PROMPT ===================================================================================== 
