

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OIC_DOCUMENTS_HIST.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OIC_DOCUMENTS_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OIC_DOCUMENTS_HIST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_OIC_DOCUMENTS_HIST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_OIC_DOCUMENTS_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OIC_DOCUMENTS_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OIC_DOCUMENTS_HIST 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	DOC_LOCALDATE DATE, 
	DOC_DESCR VARCHAR2(254), 
	DOC_DRN NUMBER(18,0), 
	DOC_SOCMNT VARCHAR2(254), 
	CNT_CONTRACTNUMBER VARCHAR2(100), 
	CNT_CLIENTREGNUMBER VARCHAR2(10), 
	CNT_CLIENTNAME VARCHAR2(38), 
	ORG_CBSNUMBER VARCHAR2(100), 
	DEST_INSTITUTION VARCHAR2(6), 
	BILL_PHASEDATE DATE, 
	BILL_AMOUNT NUMBER(20,2), 
	BILL_CURRENCY NUMBER(3,0), 
	DOC_TRDETAILS VARCHAR2(254), 
	DOC_DATA CLOB, 
	WORK_FLAG NUMBER, 
	IS_SIGN_OK VARCHAR2(1), 
	MSGCODES VARCHAR2(100), 
	REPOST_DOC VARCHAR2(100), 
	POSTINGSTATUS VARCHAR2(20), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (DOC_DATA) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_OIC_DOCUMENTS_HIST ***
 exec bpa.alter_policies('OW_OIC_DOCUMENTS_HIST');


COMMENT ON TABLE BARS.OW_OIC_DOCUMENTS_HIST IS 'OpenWay. Імпортовані файли DOCUMENTS';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.KF IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.ID IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.IDN IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.DOC_LOCALDATE IS 'Дата порождения документа в OW';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.DOC_DESCR IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.DOC_DRN IS 'Исходный документ в OW';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.DOC_SOCMNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.CNT_CONTRACTNUMBER IS 'Счет-А';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.CNT_CLIENTREGNUMBER IS 'ОКПО-А';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.CNT_CLIENTNAME IS 'Наименование-А';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.ORG_CBSNUMBER IS 'Счет-Б';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.DEST_INSTITUTION IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.BILL_PHASEDATE IS 'Дата';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.BILL_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.BILL_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.DOC_TRDETAILS IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.DOC_DATA IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.WORK_FLAG IS 'Флаг обработки документво (null-DOCUMENTS, 0 -DOCUMENTS_LOCPAY , 1-DOCUMENTS_FINES)';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.IS_SIGN_OK IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.MSGCODES IS 'Код сообщения WAY4';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.REPOST_DOC IS '';
COMMENT ON COLUMN BARS.OW_OIC_DOCUMENTS_HIST.POSTINGSTATUS IS '';




PROMPT *** Create  constraint PK_OWOICDOCUMENTSHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_DOCUMENTS_HIST ADD CONSTRAINT PK_OWOICDOCUMENTSHIST PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICDOCUMENTSHIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_DOCUMENTS_HIST MODIFY (ID CONSTRAINT CC_OWOICDOCUMENTSHIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICDOCUMENTSHIST_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_DOCUMENTS_HIST MODIFY (IDN CONSTRAINT CC_OWOICDOCUMENTSHIST_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICDOCUMENTSHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICDOCUMENTSHIST ON BARS.OW_OIC_DOCUMENTS_HIST (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_OIC_DOCUMENTS_HIST ***
grant SELECT                                                                 on OW_OIC_DOCUMENTS_HIST to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on OW_OIC_DOCUMENTS_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OIC_DOCUMENTS_HIST to BARS_DM;
grant SELECT,UPDATE                                                          on OW_OIC_DOCUMENTS_HIST to OW;
grant SELECT                                                                 on OW_OIC_DOCUMENTS_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OIC_DOCUMENTS_HIST.sql =========***
PROMPT ===================================================================================== 
