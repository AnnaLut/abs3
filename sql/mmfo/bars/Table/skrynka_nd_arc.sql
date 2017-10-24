

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_ARC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ND_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ND_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_ND_ARC'', ''FILIAL'' , ''Q'', ''Q'', ''Q'', ''Q'');
               bpa.alter_policy_info(''SKRYNKA_ND_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ND_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ND_ARC 
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
	CUSTTYPE NUMBER DEFAULT 3, 
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
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ND_ARC ***
 exec bpa.alter_policies('SKRYNKA_ND_ARC');


COMMENT ON TABLE BARS.SKRYNKA_ND_ARC IS '�������� ������ ������ - �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.RNK IS '��� �볺���';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.ND IS '����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.N_SK IS '����� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.SOS IS '������ �������� 15 - ������, 0 - ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.FIO IS '���';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DOKUM IS '�������� (�������...)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.ISSUED IS '��� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.ADRES IS '�����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DAT_BEGIN IS '���� ������ ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DAT_END IS '���� ����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.TEL IS '�������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DOVER IS '������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.NMK IS '������������ ������� (������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DOV_DAT1 IS '���� ������ �������� ������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DOV_DAT2 IS '���� ����� �������� ������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.MFOK IS '��� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.NLSK IS '��������� ���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.CUSTTYPE IS '��� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.ISP_DOV IS '��� ����������� - ����������� ���� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.NDOV IS '����� �����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.NLS IS '���� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.NDOC IS '����� ������� (���������� ��� ������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DOCDATE IS '���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.SDOC IS '����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.TARIFF IS '��� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.FIO2 IS '��� ��� ���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.ISSUED2 IS '��� ����� ������� ��� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.ADRES2 IS '����� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.PASP2 IS '����� � ����� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.OKPO1 IS '���� ������� (��� ����� ���)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.OKPO2 IS '���� ����������� ���� (��� ����� ���)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.S_ARENDA IS '����� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.S_NDS IS '����� ���';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.PENY IS '������� ������ (+ � �������� ������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.PRSKIDKA IS '������� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DATR2 IS '���� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.MR2 IS '����� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.MR IS '����� �������� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.DATR IS '���� �������� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.ADDND IS '������� ����� ��� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.KEYCOUNT IS '���������� ������� ������� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.SD IS '������� ����� ��� ������� ������ �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND_ARC.KF IS '';




PROMPT *** Create  constraint UK_SKRYNKANDARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT UK_SKRYNKANDARC UNIQUE (KF, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKA_ND_ARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT PK_SKRYNKA_ND_ARC PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDARC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDARC_SKRYNKAALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_SKRYNKAALL FOREIGN KEY (KF, N_SK)
	  REFERENCES BARS.SKRYNKA_ALL (KF, N_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDARC_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKANDARC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (KF CONSTRAINT CC_SKRYNKANDARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_ARC_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (SOS CONSTRAINT NN_SKRYNKA_ND_ARC_SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_ARC_DAT_BEGIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (DAT_BEGIN CONSTRAINT NN_SKRYNKA_ND_ARC_DAT_BEGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_ARC_DAT_END ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (DAT_END CONSTRAINT NN_SKRYNKA_ND_ARC_DAT_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_ARC_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (CUSTTYPE CONSTRAINT NN_SKRYNKA_ND_ARC_CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_ARC_TARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (TARIFF CONSTRAINT NN_SKRYNKA_ND_ARC_TARIFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKANDARC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (BRANCH CONSTRAINT CC_SKRYNKANDARC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_ARC_N_SK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC MODIFY (N_SK CONSTRAINT NN_SKRYNKA_ND_ARC_N_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SKRYNKANDARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SKRYNKANDARC ON BARS.SKRYNKA_ND_ARC (KF, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKA_ND_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKA_ND_ARC ON BARS.SKRYNKA_ND_ARC (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ND_ARC ***
grant SELECT                                                                 on SKRYNKA_ND_ARC  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_ND_ARC  to BARS_DM;
grant SELECT                                                                 on SKRYNKA_ND_ARC  to DEP_SKRN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND_ARC  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ND_ARC ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ND_ARC FOR BARS.SKRYNKA_ND_ARC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND_ARC.sql =========*** End **
PROMPT ===================================================================================== 
