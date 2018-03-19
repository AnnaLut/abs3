

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OIC_ATRANSFERS_DATA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OIC_ATRANSFERS_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OIC_ATRANSFERS_DATA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_OIC_ATRANSFERS_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_OIC_ATRANSFERS_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OIC_ATRANSFERS_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OIC_ATRANSFERS_DATA 
   (    ID NUMBER(22,0), 
    IDN NUMBER(22,0), 
    ANL_SYNTHREFN VARCHAR2(100), 
    ANL_SYNTHCODE VARCHAR2(100), 
    ANL_TRNDESCR VARCHAR2(254), 
    ANL_ANALYTICREFN VARCHAR2(100), 
    CREDIT_ANLACCOUNT VARCHAR2(30), 
    CREDIT_SYNTACCOUNT VARCHAR2(30), 
    CREDIT_AMOUNT NUMBER(20,2), 
    CREDIT_CURRENCY NUMBER(3,0), 
    DEBIT_ANLACCOUNT VARCHAR2(30), 
    DEBIT_SYNTACCOUNT VARCHAR2(30), 
    DEBIT_AMOUNT NUMBER(20,2), 
    DEBIT_CURRENCY NUMBER(3,0), 
    ANL_POSTINGDATE DATE, 
    DOC_DRN NUMBER(18,0), 
    DOC_LOCALDATE DATE, 
    DOC_DESCR VARCHAR2(160), 
    DOC_AMOUNT NUMBER(20,2), 
    DOC_CURRENCY NUMBER(3,0), 
    ERR_TEXT VARCHAR2(254), 
    NLSA VARCHAR2(14), 
    NAM_A VARCHAR2(38), 
    ID_A VARCHAR2(14), 
    NLSB VARCHAR2(14), 
    NAM_B VARCHAR2(38), 
    ID_B VARCHAR2(14), 
    BRANCH VARCHAR2(30), 
    DOC_ORN NUMBER(22,0), 
    ACCOUNT_2924_016 VARCHAR2(14), 
    KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_OIC_ATRANSFERS_DATA ***
 exec bpa.alter_policies('OW_OIC_ATRANSFERS_DATA');


COMMENT ON TABLE BARS.OW_OIC_ATRANSFERS_DATA IS 'OpenWay. ≤мпортован≥ файли atransfers';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.KF IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ID IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.IDN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ANL_SYNTHREFN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ANL_SYNTHCODE IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ANL_TRNDESCR IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ANL_ANALYTICREFN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.CREDIT_ANLACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.CREDIT_SYNTACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.CREDIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.CREDIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DEBIT_ANLACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DEBIT_SYNTACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DEBIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DEBIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ANL_POSTINGDATE IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DOC_DRN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DOC_LOCALDATE IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DOC_DESCR IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DOC_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DOC_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ERR_TEXT IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.NLSA IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.NAM_A IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ID_A IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.NLSB IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.NAM_B IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ID_B IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.BRANCH IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.DOC_ORN IS '';
COMMENT ON COLUMN BARS.OW_OIC_ATRANSFERS_DATA.ACCOUNT_2924_016 IS 'рахунок торговц€';




PROMPT *** Create  constraint CC_OWOICATRANSFERSDATA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_DATA MODIFY (KF CONSTRAINT CC_OWOICATRANSFERSDATA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWOICATRNDATA_OWFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_DATA ADD CONSTRAINT FK_OWOICATRNDATA_OWFILES FOREIGN KEY (ID)
      REFERENCES BARS.OW_FILES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICATRANSFERSDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_DATA MODIFY (ID CONSTRAINT CC_OWOICATRANSFERSDATA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICATRANSFERSDATA_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_DATA MODIFY (IDN CONSTRAINT CC_OWOICATRANSFERSDATA_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWOICATRANSFERSDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_ATRANSFERS_DATA ADD CONSTRAINT PK_OWOICATRANSFERSDATA PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICATRANSFERSDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICATRANSFERSDATA ON BARS.OW_OIC_ATRANSFERS_DATA (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWOICATRANSFERSDATA_DOCORN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWOICATRANSFERSDATA_DOCORN ON BARS.OW_OIC_ATRANSFERS_DATA (DOC_ORN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OWOICATRANSFERSDATA_DOCDRN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OWOICATRANSFERSDATA_DOCDRN ON BARS.OW_OIC_ATRANSFERS_DATA (DOC_DRN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

-- Add/modify columns 
begin
    execute immediate 'alter table OW_OIC_ATRANSFERS_DATA add trans_info VARCHAR2(254)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

declare
  l_dl number;
begin 

    select data_length into l_dl from all_tab_columns
    where owner='BARS' 
    and   table_name='OW_OIC_ATRANSFERS_DATA'
    and   column_name='TRANS_INFO';
    
if   l_dl<>4000
 then 
      execute immediate 'alter table OW_OIC_ATRANSFERS_DATA drop column trans_info '; -- на данные колонки не используютс€ 
      execute immediate 'alter table OW_OIC_ATRANSFERS_DATA add trans_info VARCHAR2(4000)';
end if;
 
end; 
/

PROMPT *** Create  grants  OW_OIC_ATRANSFERS_DATA ***
grant SELECT,UPDATE                                                          on OW_OIC_ATRANSFERS_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OIC_ATRANSFERS_DATA to BARS_DM;
grant SELECT,UPDATE                                                          on OW_OIC_ATRANSFERS_DATA to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OIC_ATRANSFERS_DATA.sql =========**
PROMPT ===================================================================================== 
