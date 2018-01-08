

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OIC_STRANSFERS_DATA.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OIC_STRANSFERS_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OIC_STRANSFERS_DATA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_OIC_STRANSFERS_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_OIC_STRANSFERS_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OIC_STRANSFERS_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OIC_STRANSFERS_DATA 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	SYNTH_SYNTHREFN VARCHAR2(100), 
	SYNTH_SYNTHCODE VARCHAR2(100), 
	SYNTH_TRNDESCR VARCHAR2(254), 
	CREDIT_SYNTACCOUNT VARCHAR2(100), 
	CREDIT_AMOUNT NUMBER(20,2), 
	CREDIT_LOCALAMOUNT NUMBER(20,2), 
	CREDIT_CURRENCY NUMBER(3,0), 
	DEBIT_SYNTACCOUNT VARCHAR2(100), 
	DEBIT_AMOUNT NUMBER(20,2), 
	DEBIT_LOCALAMOUNT NUMBER(20,2), 
	DEBIT_CURRENCY NUMBER(3,0), 
	SYNTH_POSTINGDATE DATE, 
	ERR_TEXT VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_OIC_STRANSFERS_DATA ***
 exec bpa.alter_policies('OW_OIC_STRANSFERS_DATA');


COMMENT ON TABLE BARS.OW_OIC_STRANSFERS_DATA IS 'OpenWay. Імпортовані файли stransfers';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.KF IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.ID IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.IDN IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.SYNTH_SYNTHREFN IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.SYNTH_SYNTHCODE IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.SYNTH_TRNDESCR IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.CREDIT_SYNTACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.CREDIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.CREDIT_LOCALAMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.CREDIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.DEBIT_SYNTACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.DEBIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.DEBIT_LOCALAMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.DEBIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.SYNTH_POSTINGDATE IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_DATA.ERR_TEXT IS '';




PROMPT *** Create  constraint PK_OWOICSTRANSFERSDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA ADD CONSTRAINT PK_OWOICSTRANSFERSDATA PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWOICSTRNDATA_OWFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA ADD CONSTRAINT FK_OWOICSTRNDATA_OWFILES FOREIGN KEY (ID)
	  REFERENCES BARS.OW_FILES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICSTRANSFERSDATA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA MODIFY (KF CONSTRAINT CC_OWOICSTRANSFERSDATA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWOICSTRANSFERSDATA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA ADD CONSTRAINT FK_OWOICSTRANSFERSDATA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICSTRANSFERSDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA MODIFY (ID CONSTRAINT CC_OWOICSTRANSFERSDATA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICSTRANSFERSDATA_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_DATA MODIFY (IDN CONSTRAINT CC_OWOICSTRANSFERSDATA_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICSTRANSFERSDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICSTRANSFERSDATA ON BARS.OW_OIC_STRANSFERS_DATA (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_OIC_STRANSFERS_DATA ***
grant SELECT,UPDATE                                                          on OW_OIC_STRANSFERS_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OIC_STRANSFERS_DATA to BARS_DM;
grant SELECT,UPDATE                                                          on OW_OIC_STRANSFERS_DATA to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OIC_STRANSFERS_DATA.sql =========**
PROMPT ===================================================================================== 
