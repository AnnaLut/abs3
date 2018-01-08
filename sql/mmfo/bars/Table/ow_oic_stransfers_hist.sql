

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_OIC_STRANSFERS_HIST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_OIC_STRANSFERS_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_OIC_STRANSFERS_HIST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_OIC_STRANSFERS_HIST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_OIC_STRANSFERS_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_OIC_STRANSFERS_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_OIC_STRANSFERS_HIST 
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
	NLSA VARCHAR2(14), 
	NLSB VARCHAR2(14), 
	NAZN VARCHAR2(160), 
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




PROMPT *** ALTER_POLICIES to OW_OIC_STRANSFERS_HIST ***
 exec bpa.alter_policies('OW_OIC_STRANSFERS_HIST');


COMMENT ON TABLE BARS.OW_OIC_STRANSFERS_HIST IS 'OpenWay. Імпортовані файли stransfers';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.KF IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.ID IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.IDN IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.SYNTH_SYNTHREFN IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.SYNTH_SYNTHCODE IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.SYNTH_TRNDESCR IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.CREDIT_SYNTACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.CREDIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.CREDIT_LOCALAMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.CREDIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.DEBIT_SYNTACCOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.DEBIT_AMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.DEBIT_LOCALAMOUNT IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.DEBIT_CURRENCY IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.SYNTH_POSTINGDATE IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.NLSA IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.NLSB IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.NAZN IS '';
COMMENT ON COLUMN BARS.OW_OIC_STRANSFERS_HIST.ERR_TEXT IS '';




PROMPT *** Create  constraint PK_OWOICSTRANSFERSHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_HIST ADD CONSTRAINT PK_OWOICSTRANSFERSHIST PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICSTRANSFERSHIST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_HIST MODIFY (KF CONSTRAINT CC_OWOICSTRANSFERSHIST_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICSTRANSFERSHIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_HIST MODIFY (ID CONSTRAINT CC_OWOICSTRANSFERSHIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWOICSTRANSFERSHIST_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_OIC_STRANSFERS_HIST MODIFY (IDN CONSTRAINT CC_OWOICSTRANSFERSHIST_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWOICSTRANSFERSHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWOICSTRANSFERSHIST ON BARS.OW_OIC_STRANSFERS_HIST (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_OIC_STRANSFERS_HIST ***
grant SELECT                                                                 on OW_OIC_STRANSFERS_HIST to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on OW_OIC_STRANSFERS_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_OIC_STRANSFERS_HIST to BARS_DM;
grant SELECT,UPDATE                                                          on OW_OIC_STRANSFERS_HIST to OW;
grant SELECT                                                                 on OW_OIC_STRANSFERS_HIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_OIC_STRANSFERS_HIST.sql =========**
PROMPT ===================================================================================== 
