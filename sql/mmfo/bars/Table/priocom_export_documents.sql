

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRIOCOM_EXPORT_DOCUMENTS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRIOCOM_EXPORT_DOCUMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRIOCOM_EXPORT_DOCUMENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_EXPORT_DOCUMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_EXPORT_DOCUMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRIOCOM_EXPORT_DOCUMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS 
   (	UNIQUE_SESSION_ID VARCHAR2(24), 
	ODBID NUMBER(*,0), 
	REF NUMBER, 
	STMT NUMBER, 
	OTM NUMBER(*,0) DEFAULT 0, 
	DOCKIND NUMBER(*,0), 
	DOCSTATUS NUMBER(*,0) DEFAULT 5, 
	CURRENCY NUMBER(*,0), 
	DOCDATE DATE, 
	ACCOUNT1 VARCHAR2(14), 
	ACCOUNT2 VARCHAR2(14), 
	DOCSUM NUMBER, 
	NATIONALCURSUM NUMBER, 
	MFO_A VARCHAR2(6), 
	MFO_B VARCHAR2(6), 
	DOCID VARCHAR2(10), 
	PAYER VARCHAR2(38), 
	RECIPIENT VARCHAR2(38), 
	PAYDESTINATION VARCHAR2(160), 
	PAYDATE DATE, 
	OKPO1 VARCHAR2(14), 
	OKPO2 VARCHAR2(14), 
	ERRMESSAGE VARCHAR2(4000), 
	EPCDOCUM VARCHAR2(512), 
	IKEY VARCHAR2(8)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRIOCOM_EXPORT_DOCUMENTS ***
 exec bpa.alter_policies('PRIOCOM_EXPORT_DOCUMENTS');


COMMENT ON TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.UNIQUE_SESSION_ID IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.ODBID IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.REF IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.STMT IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.OTM IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.DOCKIND IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.DOCSTATUS IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.CURRENCY IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.DOCDATE IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.ACCOUNT1 IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.ACCOUNT2 IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.DOCSUM IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.NATIONALCURSUM IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.MFO_A IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.MFO_B IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.DOCID IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.PAYER IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.RECIPIENT IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.PAYDESTINATION IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.PAYDATE IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.OKPO1 IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.OKPO2 IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.ERRMESSAGE IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.EPCDOCUM IS '';
COMMENT ON COLUMN BARS.PRIOCOM_EXPORT_DOCUMENTS.IKEY IS '';




PROMPT *** Create  constraint XPK_PRIOCOM_EXPORT_DOCUMENTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS ADD CONSTRAINT XPK_PRIOCOM_EXPORT_DOCUMENTS PRIMARY KEY (UNIQUE_SESSION_ID, ODBID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_DOCDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (DOCDATE CONSTRAINT CC_PRC_EXP_DOC_DOCDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_ACCOUNT1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (ACCOUNT1 CONSTRAINT CC_PRC_EXP_DOC_ACCOUNT1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_ACCOUNT2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (ACCOUNT2 CONSTRAINT CC_PRC_EXP_DOC_ACCOUNT2 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_DOCSUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (DOCSUM CONSTRAINT CC_PRC_EXP_DOC_DOCSUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_NATIONALCURSUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (NATIONALCURSUM CONSTRAINT CC_PRC_EXP_DOC_NATIONALCURSUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_MFO_A ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (MFO_A CONSTRAINT CC_PRC_EXP_DOC_MFO_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_MFO_B ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (MFO_B CONSTRAINT CC_PRC_EXP_DOC_MFO_B NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_DOCID ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (DOCID CONSTRAINT CC_PRC_EXP_DOC_DOCID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_PAYER ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (PAYER CONSTRAINT CC_PRC_EXP_DOC_PAYER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_RECIPIENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (RECIPIENT CONSTRAINT CC_PRC_EXP_DOC_RECIPIENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_PAYDEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (PAYDESTINATION CONSTRAINT CC_PRC_EXP_DOC_PAYDEST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_PAYDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (PAYDATE CONSTRAINT CC_PRC_EXP_DOC_PAYDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_OKPO1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (OKPO1 CONSTRAINT CC_PRC_EXP_DOC_OKPO1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_OKPO2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (OKPO2 CONSTRAINT CC_PRC_EXP_DOC_OKPO2 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (REF CONSTRAINT CC_PRC_EXP_DOC_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_STMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (STMT CONSTRAINT CC_PRC_EXP_DOC_STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (OTM CONSTRAINT CC_PRC_EXP_DOC_OTM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_DOCKIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (DOCKIND CONSTRAINT CC_PRC_EXP_DOC_DOCKIND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_DOCSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (DOCSTATUS CONSTRAINT CC_PRC_EXP_DOC_DOCSTATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRC_EXP_DOC_CURRENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_EXPORT_DOCUMENTS MODIFY (CURRENCY CONSTRAINT CC_PRC_EXP_DOC_CURRENCY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRIOCOM_EXPORT_DOCUMENTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRIOCOM_EXPORT_DOCUMENTS ON BARS.PRIOCOM_EXPORT_DOCUMENTS (UNIQUE_SESSION_ID, ODBID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRIOCOM_EXPORT_DOCUMENTS ***
grant SELECT                                                                 on PRIOCOM_EXPORT_DOCUMENTS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRIOCOM_EXPORT_DOCUMENTS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRIOCOM_EXPORT_DOCUMENTS to START1;
grant SELECT                                                                 on PRIOCOM_EXPORT_DOCUMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRIOCOM_EXPORT_DOCUMENTS.sql =========
PROMPT ===================================================================================== 
