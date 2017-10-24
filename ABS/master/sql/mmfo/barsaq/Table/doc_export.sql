

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_EXPORT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_EXPORT ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_EXPORT 
   (	DOC_ID NUMBER(*,0), 
	DOC_XML SYS.XMLTYPE , 
	BANK_ID VARCHAR2(11), 
	TYPE_ID VARCHAR2(12), 
	STATUS_ID NUMBER(*,0), 
	STATUS_CHANGE_TIME DATE DEFAULT sysdate, 
	BANK_ACCEPT_DATE DATE, 
	BANK_REF VARCHAR2(40), 
	BANK_BACK_DATE DATE, 
	BANK_BACK_REASON VARCHAR2(4000), 
	BANK_BACK_REASON_AUX VARCHAR2(4000), 
	BANK_SYSERR_DATE DATE, 
	BANK_SYSERR_MSG VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 XMLTYPE COLUMN DOC_XML STORE AS BASICFILE CLOB (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_EXPORT IS 'Документы экспортированные из клиент-банка в АБС';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.DOC_ID IS 'ID документа';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.DOC_XML IS 'XML-представление документа';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_ID IS 'Код банка по счету плательщика';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.TYPE_ID IS 'Тип документа';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.STATUS_ID IS 'Статус документа';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.STATUS_CHANGE_TIME IS 'Дата+время изменения статуса';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_ACCEPT_DATE IS 'Дата+время проведения банком документа';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_REF IS 'Референс документа в банке';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_BACK_DATE IS 'Дата+время отказа банка';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_BACK_REASON IS 'Причина отказа банка';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_BACK_REASON_AUX IS 'Причина отказа банка(расширенная)';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_SYSERR_DATE IS 'Дата+время системной ошибки при импорте в банке';
COMMENT ON COLUMN BARSAQ.DOC_EXPORT.BANK_SYSERR_MSG IS 'Описание системной ошибки при импорте в банке';




PROMPT *** Create  constraint CC_DOCEXPORT_DOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT MODIFY (DOC_ID CONSTRAINT CC_DOCEXPORT_DOCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCEXPORT ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT ADD CONSTRAINT PK_DOCEXPORT PRIMARY KEY (DOC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCEXPORT_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT MODIFY (BANK_ID CONSTRAINT CC_DOCEXPORT_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCEXPORT_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT MODIFY (TYPE_ID CONSTRAINT CC_DOCEXPORT_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCEXPORT_STATUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT MODIFY (STATUS_ID CONSTRAINT CC_DOCEXPORT_STATUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCEXPORT_STATCHTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT MODIFY (STATUS_CHANGE_TIME CONSTRAINT CC_DOCEXPORT_STATCHTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCEXPORT_DOCXML_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_EXPORT MODIFY (DOC_XML CONSTRAINT CC_DOCEXPORT_DOCXML_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DOCEXPORT_TYPEID ***
begin   
 execute immediate '
  CREATE INDEX BARSAQ.I_DOCEXPORT_TYPEID ON BARSAQ.DOC_EXPORT (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCEXPORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCEXPORT ON BARSAQ.DOC_EXPORT (DOC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_EXPORT ***
grant SELECT                                                                 on DOC_EXPORT      to BARS with grant option;
grant SELECT,UPDATE                                                          on DOC_EXPORT      to PUBLIC;
grant SELECT,UPDATE                                                          on DOC_EXPORT      to SYS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_EXPORT.sql =========*** End *** 
PROMPT ===================================================================================== 
