

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PFU_CA_FILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PFU_CA_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PFU_CA_FILES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PFU_CA_FILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PFU_CA_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.PFU_CA_FILES 
   (	ID NUMBER, 
	FILE_TYPE NUMBER, 
	FILE_DATA CLOB, 
	STATE NUMBER(2,0) DEFAULT 0, 
	MESSAGE VARCHAR2(4000), 
	SIGN RAW(128), 
	RESP_DATA CLOB, 
	KF VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESP_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PFU_CA_FILES ***
 exec bpa.alter_policies('PFU_CA_FILES');


COMMENT ON TABLE BARS.PFU_CA_FILES IS 'Файли на реєстрацію пенсійних карток';
COMMENT ON COLUMN BARS.PFU_CA_FILES.KF IS '';
COMMENT ON COLUMN BARS.PFU_CA_FILES.ID IS 'Ідентифікатор файла в ЦА';
COMMENT ON COLUMN BARS.PFU_CA_FILES.FILE_TYPE IS 'Тип файлу';
COMMENT ON COLUMN BARS.PFU_CA_FILES.FILE_DATA IS 'Данні';
COMMENT ON COLUMN BARS.PFU_CA_FILES.STATE IS 'Статус обробки файлу';
COMMENT ON COLUMN BARS.PFU_CA_FILES.MESSAGE IS 'Повідомлення';
COMMENT ON COLUMN BARS.PFU_CA_FILES.SIGN IS 'Ідентифікатор ключа підпису';
COMMENT ON COLUMN BARS.PFU_CA_FILES.RESP_DATA IS 'Файл квитанції';




PROMPT *** Create  constraint SYS_C00109486 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109487 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES MODIFY (FILE_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109488 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES MODIFY (FILE_DATA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109489 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFU_CA_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.PFU_CA_FILES ADD CONSTRAINT PK_PFU_CA_FILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_CA_FILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PFU_CA_FILES ON BARS.PFU_CA_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_CA_FILES ***
grant SELECT                                                                 on PFU_CA_FILES    to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on PFU_CA_FILES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_CA_FILES    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PFU_CA_FILES.sql =========*** End *** 
PROMPT ===================================================================================== 
