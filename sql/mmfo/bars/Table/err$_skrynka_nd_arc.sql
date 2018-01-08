

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_ARC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ERR$_SKRYNKA_ND_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ERR$_SKRYNKA_ND_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ERR$_SKRYNKA_ND_ARC 
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
	MFOK VARCHAR2(4000), 
	NLSK VARCHAR2(4000), 
	CUSTTYPE VARCHAR2(4000), 
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
	PENY VARCHAR2(4000), 
	PRSKIDKA VARCHAR2(4000), 
	DATR2 VARCHAR2(4000), 
	MR2 VARCHAR2(4000), 
	MR VARCHAR2(4000), 
	DATR VARCHAR2(4000), 
	ADDND VARCHAR2(4000), 
	KEYCOUNT VARCHAR2(4000), 
	SD VARCHAR2(4000), 
	BRANCH VARCHAR2(4000), 
	KF VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ERR$_SKRYNKA_ND_ARC ***
 exec bpa.alter_policies('ERR$_SKRYNKA_ND_ARC');


COMMENT ON TABLE BARS.ERR$_SKRYNKA_ND_ARC IS 'DML Error Logging table for "SKRYNKA_ND_ARC"';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.N_SK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.SOS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.FIO IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DOKUM IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ISSUED IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ADRES IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DAT_END IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.TEL IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DOVER IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.NMK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DOV_DAT1 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DOV_DAT2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.MFOK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.NLSK IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ISP_DOV IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.NDOV IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.NLS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.NDOC IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DOCDATE IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.SDOC IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.TARIFF IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.FIO2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ISSUED2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ADRES2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.PASP2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.OKPO1 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.OKPO2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.S_ARENDA IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.S_NDS IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.PENY IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.PRSKIDKA IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DATR2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.MR2 IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.MR IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.DATR IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.ADDND IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.KEYCOUNT IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.SD IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.ERR$_SKRYNKA_ND_ARC.KF IS '';



PROMPT *** Create  grants  ERR$_SKRYNKA_ND_ARC ***
grant SELECT                                                                 on ERR$_SKRYNKA_ND_ARC to BARSREADER_ROLE;
grant SELECT                                                                 on ERR$_SKRYNKA_ND_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ERR$_SKRYNKA_ND_ARC.sql =========*** E
PROMPT ===================================================================================== 
