

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ND_ARC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA_ND_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA_ND_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA_ND_ARC 
   (	ND NUMBER, 
	N_SK NUMBER, 
	SOS NUMBER, 
	FIO VARCHAR2(70), 
	DOKUM VARCHAR2(100), 
	ISSUED VARCHAR2(100), 
	ADRES VARCHAR2(100), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	TEL VARCHAR2(30), 
	DOVER VARCHAR2(100), 
	NMK VARCHAR2(70), 
	DOV_DAT1 DATE, 
	DOV_DAT2 DATE, 
	MFOK VARCHAR2(12), 
	NLSK VARCHAR2(15), 
	CUSTTYPE NUMBER, 
	ISP_DOV NUMBER, 
	NDOV VARCHAR2(30), 
	NLS VARCHAR2(15), 
	NDOC VARCHAR2(30), 
	DOCDATE DATE, 
	SDOC NUMBER, 
	TARIFF NUMBER, 
	FIO2 VARCHAR2(70), 
	ISSUED2 VARCHAR2(100), 
	ADRES2 VARCHAR2(100), 
	PASP2 VARCHAR2(100), 
	OKPO1 VARCHAR2(10), 
	OKPO2 VARCHAR2(10), 
	S_ARENDA NUMBER, 
	S_NDS NUMBER, 
	PENY NUMBER, 
	PRSKIDKA NUMBER, 
	DATR2 DATE, 
	MR2 VARCHAR2(100), 
	MR VARCHAR2(100), 
	DATR DATE, 
	ADDND NUMBER, 
	KEYCOUNT NUMBER, 
	SD NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6), 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA_ND_ARC ***
 exec bpa.alter_policies('TMP_SKRYNKA_ND_ARC');


COMMENT ON TABLE BARS.TMP_SKRYNKA_ND_ARC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.MR IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DATR IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.ADDND IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.KEYCOUNT IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.SD IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.KF IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.RNK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DOV_DAT2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.MFOK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.ISP_DOV IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.NDOV IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.NLS IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.NDOC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DOCDATE IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.SDOC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.TARIFF IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.FIO2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.ISSUED2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.ADRES2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.PASP2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.OKPO1 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.OKPO2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.S_ARENDA IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.S_NDS IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.PENY IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.PRSKIDKA IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DATR2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.MR2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.ND IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.N_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.SOS IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.FIO IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DOKUM IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.ISSUED IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.ADRES IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DAT_END IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.TEL IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DOVER IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.NMK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND_ARC.DOV_DAT1 IS '';




PROMPT *** Create  constraint SYS_C00135506 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135507 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (DAT_BEGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135508 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (DAT_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135509 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135510 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (TARIFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135511 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135512 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135505 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND_ARC MODIFY (N_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SKRYNKA_ND_ARC ***
grant SELECT                                                                 on TMP_SKRYNKA_ND_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ND_ARC.sql =========*** En
PROMPT ===================================================================================== 
