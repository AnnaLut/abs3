

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OIC_ATRANSFERS_HIST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OIC_ATRANSFERS_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OIC_ATRANSFERS_HIST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_OIC_ATRANSFERS_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OIC_ATRANSFERS_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OIC_ATRANSFERS_HIST 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	ANL_SYNTHCODE VARCHAR2(100), 
	ANL_TRNDESCR VARCHAR2(254), 
	ANL_ANALYTICREFN VARCHAR2(100), 
	CREDIT_ANLACCOUNT VARCHAR2(30), 
	CREDIT_AMOUNT NUMBER(20,2), 
	CREDIT_CURRENCY NUMBER(3,0), 
	DEBIT_ANLACCOUNT VARCHAR2(30), 
	DEBIT_AMOUNT NUMBER(20,2), 
	DEBIT_CURRENCY NUMBER(3,0), 
	ANL_POSTINGDATE DATE, 
	DOC_DRN NUMBER(18,0), 
	DOC_LOCALDATE DATE, 
	DOC_DESCR VARCHAR2(160), 
	DOC_AMOUNT NUMBER(20,2), 
	DOC_CURRENCY NUMBER(3,0), 
	REF NUMBER(22,0), 
	DOC_ORN NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'alter table OW_OIC_ATRANSFERS_HIST add trans_info VARCHAR2(4000)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 



PROMPT *** ALTER_POLICIES to OW_OIC_ATRANSFERS_HIST ***
 exec bpa.alter_policies('OW_OIC_ATRANSFERS_HIST');


COMMENT ON TABLE BARS.OW_OIC_ATRANSFERS_HIST IS 'OpenWay. Імпортовані файли atransfers';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DOC_ORN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.KF IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.ID IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.IDN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.ANL_SYNTHCODE IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.ANL_TRNDESCR IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.ANL_ANALYTICREFN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.CREDIT_ANLACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.CREDIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.CREDIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DEBIT_ANLACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DEBIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DEBIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.ANL_POSTINGDATE IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DOC_DRN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DOC_LOCALDATE IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DOC_DESCR IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DOC_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.DOC_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_HIST.REF IS '';




PROMPT *** Create  constraint FK_OWOICATRNHIST_OWFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_HIST ADD CONSTRAINT FK_OWOICATRNHIST_OWFILES FOREIGN KEY (ID)
	  REFERENCES BARS.OW_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWOICATRANSFERSHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_HIST ADD CONSTRAINT PK_OWOICATRANSFERSHIST PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICATRANSFERSHIST_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_HIST MODIFY (IDN CONSTRAINT CC_OWOICATRANSFERSHIST_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICATRANSFERSHIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_HIST MODIFY (ID CONSTRAINT CC_OWOICATRANSFERSHIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWOICATRANSFERSHIST_DOCDRN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWOICATRANSFERSHIST_DOCDRN ON BARS.OW_OIC_ATRANSFERS_HIST (DOC_DRN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICATRANSFERSHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICATRANSFERSHIST ON BARS.OW_OIC_ATRANSFERS_HIST (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWOICATRANSFERSHIST_DOCORN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWOICATRANSFERSHIST_DOCORN ON BARS.OW_OIC_ATRANSFERS_HIST (DOC_ORN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_OIC_ATRANSFERS_HIST ***
grant SELECT,UPDATE                                                          on OW_OIC_ATRANSFERS_HIST to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on OW_OIC_ATRANSFERS_HIST to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OIC_ATRANSFERS_HIST.sql =========**
PROMPT ===================================================================================== 
