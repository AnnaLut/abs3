

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_UPDATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ND_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ND_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ND_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ND_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ND_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ND_UPDATE 
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
	CHGDATE DATE, 
	CHGACTION NUMBER, 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER, 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ND_UPDATE ***
 exec bpa.alter_policies('SKRYNKA_ND_UPDATE');


COMMENT ON TABLE BARS.SKRYNKA_ND_UPDATE IS '������ ��� �������� ������ ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.RNK IS 'RNK';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ND IS '����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.N_SK IS '����� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.SOS IS '������ �������� 15 - ������, 1 - �����������, 0 - ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.FIO IS '���';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOKUM IS '�������� (�������...)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ISSUED IS '��� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ADRES IS '�����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DAT_BEGIN IS '���� ������ ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DAT_END IS '���� ����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.TEL IS '�������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOVER IS '������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NMK IS '������������ ������� (������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOV_DAT1 IS '���� ������ �������� ������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOV_DAT2 IS '���� ����� �������� ������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOV_PASP IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.MFOK IS '��� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NLSK IS '��������� ���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.CUSTTYPE IS '��� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.O_SK IS '��� ����� (������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ISP_DOV IS '��� ����������� - ����������� ���� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NDOV IS '����� �����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NLS IS '���� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.NDOC IS '����� ������� (���������� ��� ������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DOCDATE IS '���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.SDOC IS '����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.TARIFF IS '��� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.FIO2 IS '��� ��� ���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ISSUED2 IS '��� ����� ������� ��� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ADRES2 IS '����� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.PASP2 IS '����� � ����� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.OKPO1 IS '���� ������� (��� ����� ���)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.OKPO2 IS '���� ����������� ���� (��� ����� ���)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.S_ARENDA IS '����� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.S_NDS IS '����� ���';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.SD IS '������� ����� ��� ������� ������ �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.KEYCOUNT IS '���������� ������� ������� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.PRSKIDKA IS '������� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.PENY IS '������� ������ (+ � �������� ������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DATR2 IS '���� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.MR2 IS '����� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.MR IS '����� �������� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DATR IS '���� �������� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.ADDND IS '������� ����� ��� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.AMORT_DATE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.CHGDATE IS '���� ���������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.CHGACTION IS '��� ���������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.DONEBY IS '��� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_UPDATE.IDUPD IS 'Id';




PROMPT *** Create  constraint PK_SKRYNKANDUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_UPDATE ADD CONSTRAINT PK_SKRYNKANDUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_SKRYNKANDUPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_SKRYNKANDUPDATE ON BARS.SKRYNKA_ND_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_SKRYNKANDUPD_CHGDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_SKRYNKANDUPD_CHGDATE ON BARS.SKRYNKA_ND_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKANDUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKANDUPD ON BARS.SKRYNKA_ND_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ND_UPDATE ***
grant SELECT                                                                 on SKRYNKA_ND_UPDATE to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND_UPDATE to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND_UPDATE to START1;
grant SELECT                                                                 on SKRYNKA_ND_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_UPDATE.sql =========*** End
PROMPT ===================================================================================== 
