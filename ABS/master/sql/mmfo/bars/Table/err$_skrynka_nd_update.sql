

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_UPDATE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_ND_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_ND_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_ND_UPDATE 
   (	ORA_ERR_NUMBER$ NUMBER, 
	ORA_ERR_MESG$ VARCHAR2(2000), 
	ORA_ERR_ROWID$ UROWID (4000), 
	ORA_ERR_OPTYP$ VARCHAR2(2), 
	ORA_ERR_TAG$ VARCHAR2(2000), 
	ND VARCHAR2(4000), 
	N_SK VARCHAR2(4000), 
	SOS VARCHAR2(4000), 
	FIO VARCHAR2(4000), 
	DOKUM VARCHAR2(4000), 
	ISSUED VARCHAR2(4000), 
	ADRES VARCHAR2(4000), 
	DAT_BEGIN VARCHAR2(4000), 
	DAT_END VARCHAR2(4000), 
	TEL VARCHAR2(4000), 
	DOVER VARCHAR2(4000), 
	NMK VARCHAR2(4000), 
	DOV_DAT1 VARCHAR2(4000), 
	DOV_DAT2 VARCHAR2(4000), 
	DOV_PASP VARCHAR2(4000), 
	MFOK VARCHAR2(4000), 
	NLSK VARCHAR2(4000), 
	CUSTTYPE VARCHAR2(4000), 
	O_SK VARCHAR2(4000), 
	ISP_DOV VARCHAR2(4000), 
	NDOV VARCHAR2(4000), 
	NLS VARCHAR2(4000), 
	NDOC VARCHAR2(4000), 
	DOCDATE VARCHAR2(4000), 
	SDOC VARCHAR2(4000), 
	TARIFF VARCHAR2(4000), 
	FIO2 VARCHAR2(4000), 
	ISSUED2 VARCHAR2(4000), 
	ADRES2 VARCHAR2(4000), 
	PASP2 VARCHAR2(4000), 
	OKPO1 VARCHAR2(4000), 
	OKPO2 VARCHAR2(4000), 
	S_ARENDA VARCHAR2(4000), 
	S_NDS VARCHAR2(4000), 
	SD VARCHAR2(4000), 
	KEYCOUNT VARCHAR2(4000), 
	PRSKIDKA VARCHAR2(4000), 
	PENY VARCHAR2(4000), 
	DATR2 VARCHAR2(4000), 
	MR2 VARCHAR2(4000), 
	MR VARCHAR2(4000), 
	DATR VARCHAR2(4000), 
	ADDND VARCHAR2(4000), 
	AMORT_DATE VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000), 
	CHGDATE VARCHAR2(4000), 
	CHGACTION VARCHAR2(4000), 
	DONEBY VARCHAR2(4000), 
	IDUPD VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_ND_UPDATE ***
 exec bpa.alter_policies('ERR$_SKRYNKA_ND_UPDATE');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_ND_UPDATE IS 'DML Error Logging table for "SKRYNKA_ND_UPDATE"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DOKUM IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ISSUED IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ADRES IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DAT_END IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.TEL IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DOVER IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.NMK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DOV_DAT1 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DOV_DAT2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DOV_PASP IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.MFOK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.NLSK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.O_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ISP_DOV IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.NDOV IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.NDOC IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DOCDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.SDOC IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.TARIFF IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.FIO2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ISSUED2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ADRES2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.PASP2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.OKPO1 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.OKPO2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.S_ARENDA IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.S_NDS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.SD IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.KEYCOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.PRSKIDKA IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.PENY IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DATR2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.MR2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.MR IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DATR IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ADDND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.AMORT_DATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.CHGDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.CHGACTION IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.N_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_UPDATE.FIO IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_UPDATE.sql =========**
PROMPT ===================================================================================== 
