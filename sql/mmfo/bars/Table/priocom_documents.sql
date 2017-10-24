

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRIOCOM_DOCUMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRIOCOM_DOCUMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRIOCOM_DOCUMENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_DOCUMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_DOCUMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRIOCOM_DOCUMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRIOCOM_DOCUMENTS 
   (	MFO VARCHAR2(6), 
	OPERDATE DATE, 
	FNAME VARCHAR2(12), 
	ODBSTATUS VARCHAR2(1), 
	DOCID NUMBER(*,0), 
	MFO_A VARCHAR2(6), 
	ACCOUNT1 VARCHAR2(14), 
	MFO_B VARCHAR2(6), 
	ACCOUNT2 VARCHAR2(14), 
	CURRENCY NUMBER(*,0), 
	DOCKIND NUMBER(*,0), 
	NDP VARCHAR2(18), 
	PAYDESTINATION VARCHAR2(160), 
	PAYDATE DATE, 
	ROWNUMBER NUMBER(*,0), 
	EPCDOCUM VARCHAR2(512), 
	IKEY VARCHAR2(8), 
	ERRMESSAGE VARCHAR2(4000), 
	REF NUMBER(*,0), 
	OTM NUMBER(*,0) DEFAULT 0, 
	ABS_KEY VARCHAR2(8), 
	ABS_SIGN RAW(128), 
	DOCSUM NUMBER(38,0), 
	NATIONALCURSUM NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRIOCOM_DOCUMENTS ***
 exec bpa.alter_policies('PRIOCOM_DOCUMENTS');


COMMENT ON TABLE BARS.PRIOCOM_DOCUMENTS IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.MFO IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.OPERDATE IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.FNAME IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.ODBSTATUS IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.DOCID IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.MFO_A IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.ACCOUNT1 IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.MFO_B IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.ACCOUNT2 IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.CURRENCY IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.DOCKIND IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.NDP IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.PAYDESTINATION IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.PAYDATE IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.ROWNUMBER IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.EPCDOCUM IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.IKEY IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.ERRMESSAGE IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.REF IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.OTM IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.ABS_KEY IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.ABS_SIGN IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.DOCSUM IS '';
COMMENT ON COLUMN BARS.PRIOCOM_DOCUMENTS.NATIONALCURSUM IS '';




PROMPT *** Create  constraint XPK_PRIOCOM_DOCUMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS ADD CONSTRAINT XPK_PRIOCOM_DOCUMENTS PRIMARY KEY (OPERDATE, FNAME, ROWNUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (MFO CONSTRAINT CC_PRC_DOC_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_NATIONALCURSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (NATIONALCURSUM CONSTRAINT CC_PRC_DOC_NATIONALCURSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_DOCSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (DOCSUM CONSTRAINT CC_PRC_DOC_DOCSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_OTM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (OTM CONSTRAINT CC_PRC_DOC_OTM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_ROWNUMBER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (ROWNUMBER CONSTRAINT CC_PRC_DOC_ROWNUMBER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_PAYDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (PAYDATE CONSTRAINT CC_PRC_DOC_PAYDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_PAYDESTINATION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (PAYDESTINATION CONSTRAINT CC_PRC_DOC_PAYDESTINATION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_NDP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (NDP CONSTRAINT CC_PRC_DOC_NDP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_DOCKIND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (DOCKIND CONSTRAINT CC_PRC_DOC_DOCKIND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_CURRENCY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (CURRENCY CONSTRAINT CC_PRC_DOC_CURRENCY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_ACCOUNT2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (ACCOUNT2 CONSTRAINT CC_PRC_DOC_ACCOUNT2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_MFO_B_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (MFO_B CONSTRAINT CC_PRC_DOC_MFO_B_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_ACCOUNT1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (ACCOUNT1 CONSTRAINT CC_PRC_DOC_ACCOUNT1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_MFO_A_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (MFO_A CONSTRAINT CC_PRC_DOC_MFO_A_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_DOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (DOCID CONSTRAINT CC_PRC_DOC_DOCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_ODBSTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (ODBSTATUS CONSTRAINT CC_PRC_DOC_ODBSTATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_FNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (FNAME CONSTRAINT CC_PRC_DOC_FNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_DOC_OPERDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_DOCUMENTS MODIFY (OPERDATE CONSTRAINT CC_PRC_DOC_OPERDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRIOCOM_DOCUMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRIOCOM_DOCUMENTS ON BARS.PRIOCOM_DOCUMENTS (OPERDATE, FNAME, ROWNUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRIOCOM_DOCUMENTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PRIOCOM_DOCUMENTS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRIOCOM_DOCUMENTS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRIOCOM_DOCUMENTS.sql =========*** End
PROMPT ===================================================================================== 
