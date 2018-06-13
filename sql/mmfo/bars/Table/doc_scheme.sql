

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_SCHEME.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_SCHEME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOC_SCHEME'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_SCHEME'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DOC_SCHEME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_SCHEME ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_SCHEME 
   (	ID VARCHAR2(35), 
	NAME VARCHAR2(140) DEFAULT ''noname'', 
	PRINT_ON_BLANK NUMBER(1,0) DEFAULT 0, 
	TEMPLATE CLOB, 
	HEADER CLOB, 
	FOOTER CLOB, 
	HEADER_EX CLOB, 
	D_CLOSE DATE, FR_PRINT_FORMAT number(3),
	FR NUMBER(1,0) DEFAULT 0, 
	FILE_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (TEMPLATE) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (HEADER) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (FOOTER) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (HEADER_EX) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_SCHEME ***
 exec bpa.alter_policies('DOC_SCHEME');


COMMENT ON TABLE BARS.DOC_SCHEME IS 'Печатные шаблоны';
COMMENT ON COLUMN BARS.DOC_SCHEME.ID IS 'Идентификатор шаблона';
COMMENT ON COLUMN BARS.DOC_SCHEME.NAME IS 'Название шаблона';
COMMENT ON COLUMN BARS.DOC_SCHEME.PRINT_ON_BLANK IS 'Признак печати договора на бланке';
COMMENT ON COLUMN BARS.DOC_SCHEME.TEMPLATE IS 'Шаблон';
COMMENT ON COLUMN BARS.DOC_SCHEME.HEADER IS 'Верхній колонтитул';
COMMENT ON COLUMN BARS.DOC_SCHEME.FOOTER IS 'Нижній колонтитул';
COMMENT ON COLUMN BARS.DOC_SCHEME.HEADER_EX IS 'Верхній розширений колонтитул';
COMMENT ON COLUMN BARS.DOC_SCHEME.D_CLOSE IS 'Дата закрытия';
COMMENT ON COLUMN BARS.DOC_SCHEME.FR IS '';
COMMENT ON COLUMN BARS.DOC_SCHEME.FILE_NAME IS 'Имя файла шаблона из папки TEMPLATE.RPT';





PROMPT *** Create  constraint CC_DOCSCHEME_FR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_SCHEME ADD CONSTRAINT CC_DOCSCHEME_FR CHECK (fr in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_SCHEME ADD CONSTRAINT PK_DOCSCHEME PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSCHEME_POB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_SCHEME ADD CONSTRAINT CC_DOCSCHEME_POB_NN CHECK (PRINT_ON_BLANK IS NOT NULL) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSCHEME_POB ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_SCHEME ADD CONSTRAINT CC_DOCSCHEME_POB CHECK (print_on_blank in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010227 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_SCHEME MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCSCHEME_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_SCHEME MODIFY (NAME CONSTRAINT CC_DOCSCHEME_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCSCHEME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DOCSCHEME ON BARS.DOC_SCHEME (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** ADD FR_PRINT_FORMAT ***
BEGIN 
     execute immediate  
       'ALTER TABLE BARS.DOC_SCHEME ADD FR_PRINT_FORMAT number(3)';
exception when others then       
  if sqlcode=-955 or sqlcode=-2275 or sqlcode=-1430 then null; else raise; end if; 
end; 
/

COMMENT ON COLUMN BARS.DOC_SCHEME.FR_PRINT_FORMAT IS 'Формат друку';

PROMPT *** Create  constraint FK_DOCSCHEME ***
BEGIN 
     execute immediate  
'ALTER TABLE BARS.DOC_SCHEME ADD 
CONSTRAINT FK_DOCSCHEME
 FOREIGN KEY (FR_PRINT_FORMAT)
 REFERENCES BARS.FR_PRINT_FORMAT (ID)
 ENABLE
 VALIDATE';
exception when others then       
  if sqlcode=-955 or sqlcode=-2275 or sqlcode=-1430 then null; else raise; end if; 
end; 
/


PROMPT *** Create  grants  DOC_SCHEME ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_SCHEME      to ABS_ADMIN;
grant SELECT                                                                 on DOC_SCHEME      to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DOC_SCHEME      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOC_SCHEME      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_SCHEME      to CC_DOC;
grant SELECT                                                                 on DOC_SCHEME      to CUST001;
grant SELECT                                                                 on DOC_SCHEME      to DEP_SKRN;
grant SELECT                                                                 on DOC_SCHEME      to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_SCHEME      to DPT_ADMIN;
grant SELECT                                                                 on DOC_SCHEME      to DPT_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DOC_SCHEME      to FOREX;
grant SELECT                                                                 on DOC_SCHEME      to RCC_DEAL;
grant SELECT                                                                 on DOC_SCHEME      to REPORTER;
grant SELECT                                                                 on DOC_SCHEME      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DOC_SCHEME      to WR_ALL_RIGHTS;
grant SELECT                                                                 on DOC_SCHEME      to WR_CREDIT;
grant SELECT                                                                 on DOC_SCHEME      to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_SCHEME.sql =========*** End *** ==
PROMPT ===================================================================================== 
