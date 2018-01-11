

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ND.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA_ND ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA_ND 
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
	DOV_PASP VARCHAR2(100), 
	MFOK VARCHAR2(12), 
	NLSK VARCHAR2(15), 
	CUSTTYPE NUMBER, 
	O_SK NUMBER, 
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
	SD NUMBER, 
	KEYCOUNT NUMBER, 
	PRSKIDKA NUMBER, 
	PENY NUMBER, 
	DATR2 DATE, 
	MR2 VARCHAR2(100), 
	MR VARCHAR2(100), 
	DATR DATE, 
	ADDND NUMBER, 
	AMORT_DATE DATE, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6), 
	DEAL_CREATED DATE, 
	IMPORTED NUMBER(1,0), 
	DAT_CLOSE DATE, 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA_ND ***
 exec bpa.alter_policies('TMP_SKRYNKA_ND');


COMMENT ON TABLE BARS.TMP_SKRYNKA_ND IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.ISP_DOV IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.NDOV IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.NLS IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.NDOC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DOCDATE IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.SDOC IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.TARIFF IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.FIO2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.ISSUED2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.ADRES2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.PASP2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.OKPO1 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.OKPO2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.S_ARENDA IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.S_NDS IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.SD IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.KEYCOUNT IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.PRSKIDKA IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.PENY IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DATR2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.MR2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.MR IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DATR IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.ADDND IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.AMORT_DATE IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.KF IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DEAL_CREATED IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.IMPORTED IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DAT_CLOSE IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.RNK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.ND IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.N_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.SOS IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.FIO IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DOKUM IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.ISSUED IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.ADRES IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DAT_END IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.TEL IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DOVER IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.NMK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DOV_DAT1 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DOV_DAT2 IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.DOV_PASP IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.MFOK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA_ND.O_SK IS '';




PROMPT *** Create  constraint SYS_C00135496 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135497 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (N_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135498 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135499 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (DAT_BEGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135500 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (DAT_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135501 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135502 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (TARIFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135503 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135504 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SKRYNKA_ND MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SKRYNKA_ND ***
grant SELECT                                                                 on TMP_SKRYNKA_ND  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA_ND.sql =========*** End **
PROMPT ===================================================================================== 
