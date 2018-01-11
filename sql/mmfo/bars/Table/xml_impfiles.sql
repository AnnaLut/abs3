

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_IMPFILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_IMPFILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_IMPFILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_IMPFILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_IMPFILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_IMPFILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_IMPFILES 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	USERID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DOCS_QTY NUMBER(5,0) DEFAULT 0, 
	DOCS_SUM NUMBER(24,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_IMPFILES ***
 exec bpa.alter_policies('XML_IMPFILES');


COMMENT ON TABLE BARS.XML_IMPFILES IS 'Архiв прийнятих файлiв iмпорту iз зовнiшнiх задач';
COMMENT ON COLUMN BARS.XML_IMPFILES.FN IS 'Iмя файлу iмпорту';
COMMENT ON COLUMN BARS.XML_IMPFILES.DAT IS 'Банкiвська дата обробки';
COMMENT ON COLUMN BARS.XML_IMPFILES.USERID IS 'Ід. користувача';
COMMENT ON COLUMN BARS.XML_IMPFILES.BRANCH IS 'Бранч де проходить обробка';
COMMENT ON COLUMN BARS.XML_IMPFILES.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.XML_IMPFILES.DOCS_QTY IS 'К-ть документів у файлі';
COMMENT ON COLUMN BARS.XML_IMPFILES.DOCS_SUM IS 'Сума документів у файлі';




PROMPT *** Create  constraint CC_XMLIMPFILES_FN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (FN CONSTRAINT CC_XMLIMPFILES_FN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_DT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (DAT CONSTRAINT CC_XMLIMPFILES_DT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_USRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (USERID CONSTRAINT CC_XMLIMPFILES_USRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_DOCSQTY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (DOCS_QTY CONSTRAINT CC_XMLIMPFILES_DOCSQTY_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_DOCSSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (DOCS_SUM CONSTRAINT CC_XMLIMPFILES_DOCSSUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_BR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (BRANCH CONSTRAINT CC_XMLIMPFILES_BR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLIMPFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPFILES MODIFY (KF CONSTRAINT CC_XMLIMPFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_XMLIMPFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_XMLIMPFILES ON BARS.XML_IMPFILES (KF, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_XMLIMPFILES_DATUSER ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_XMLIMPFILES_DATUSER ON BARS.XML_IMPFILES (DAT, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_IMPFILES ***
grant SELECT                                                                 on XML_IMPFILES    to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on XML_IMPFILES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XML_IMPFILES    to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on XML_IMPFILES    to OPER000;
grant SELECT                                                                 on XML_IMPFILES    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_IMPFILES    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_IMPFILES.sql =========*** End *** 
PROMPT ===================================================================================== 
