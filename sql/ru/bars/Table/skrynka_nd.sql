

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_ND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_ND'', ''FILIAL'' , ''Q'', ''Q'', ''Q'', ''Q'');
               bpa.alter_policy_info(''SKRYNKA_ND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_ND 
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
	CUSTTYPE NUMBER DEFAULT 3, 
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
	KEYCOUNT NUMBER DEFAULT 1, 
	PRSKIDKA NUMBER, 
	PENY NUMBER, 
	DATR2 DATE, 
	MR2 VARCHAR2(100), 
	MR VARCHAR2(100), 
	DATR DATE, 
	ADDND NUMBER DEFAULT 0, 
	AMORT_DATE DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DEAL_CREATED DATE, 
	IMPORTED NUMBER(1,0) DEFAULT 0, 
	DAT_CLOSE DATE, 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_ND ***
 exec bpa.alter_policies('SKRYNKA_ND');


COMMENT ON TABLE BARS.SKRYNKA_ND IS '�������� ������ ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND.KF IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DEAL_CREATED IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND.IMPORTED IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DAT_CLOSE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND.RNK IS 'RNK �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.O_SK IS '��� ����� (������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND.ISP_DOV IS '��� ����������� - ����������� ���� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.NDOV IS '����� �����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.NLS IS '���� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.NDOC IS '����� ������� (���������� ��� ������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DOCDATE IS '���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.SDOC IS '����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.TARIFF IS '��� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.FIO2 IS '��� ��� ���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.ISSUED2 IS '��� ����� ������� ��� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.ADRES2 IS '����� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.PASP2 IS '����� � ����� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.OKPO1 IS '���� ������� (��� ����� ���)';
COMMENT ON COLUMN BARS.SKRYNKA_ND.OKPO2 IS '���� ����������� ���� (��� ����� ���)';
COMMENT ON COLUMN BARS.SKRYNKA_ND.S_ARENDA IS '����� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.S_NDS IS '����� ���';
COMMENT ON COLUMN BARS.SKRYNKA_ND.SD IS '������� ����� ��� ������� ������ �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.KEYCOUNT IS '���������� ������� ������� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.PRSKIDKA IS '������� ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.PENY IS '������� ������ (+ � �������� ������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DATR2 IS '���� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.MR2 IS '����� �������� ����������� ����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.MR IS '����� �������� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DATR IS '���� �������� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.ADDND IS '������� ����� ��� ����������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.AMORT_DATE IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND.ND IS '����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.N_SK IS '����� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.SOS IS '������ �������� 15 - ������, 1 - �����������, 0 - ������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.FIO IS '���';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DOKUM IS '�������� (�������...)';
COMMENT ON COLUMN BARS.SKRYNKA_ND.ISSUED IS '��� �����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.ADRES IS '�����';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DAT_BEGIN IS '���� ������ ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DAT_END IS '���� ����� ��������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.TEL IS '�������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DOVER IS '������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.NMK IS '������������ ������� (������)';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DOV_DAT1 IS '���� ������ �������� ������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DOV_DAT2 IS '���� ����� �������� ������������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.DOV_PASP IS '';
COMMENT ON COLUMN BARS.SKRYNKA_ND.MFOK IS '��� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.NLSK IS '��������� ���� �������';
COMMENT ON COLUMN BARS.SKRYNKA_ND.CUSTTYPE IS '��� �������';




PROMPT *** Create  constraint FK_SKRYNKAND_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_ND_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKA_ND_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAND_SKRYNKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_SKRYNKA FOREIGN KEY (KF, N_SK)
	  REFERENCES BARS.SKRYNKA (KF, N_SK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAND_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAND_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CH_SKRYNKA_ND_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT CH_SKRYNKA_ND_SOS CHECK (sos = ''15'' OR sos = ''0'' OR sos = ''1'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SKRYNKAND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT PK_SKRYNKAND PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_TARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (TARIFF CONSTRAINT NN_SKRYNKA_ND_TARIFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (CUSTTYPE CONSTRAINT NN_SKRYNKA_ND_CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_DAT_END ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (DAT_END CONSTRAINT NN_SKRYNKA_ND_DAT_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_DAT_BEGIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (DAT_BEGIN CONSTRAINT NN_SKRYNKA_ND_DAT_BEGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (SOS CONSTRAINT NN_SKRYNKA_ND_SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_SKRYNKA_ND_N_SK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (N_SK CONSTRAINT NN_SKRYNKA_ND_N_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAND_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (ND CONSTRAINT CC_SKRYNKAND_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SKRYNKAND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT UK_SKRYNKAND UNIQUE (KF, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAND_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (KF CONSTRAINT CC_SKRYNKAND_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKAND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND MODIFY (BRANCH CONSTRAINT CC_SKRYNKAND_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SKRYNKAND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SKRYNKAND ON BARS.SKRYNKA_ND (KF, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKAND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKAND ON BARS.SKRYNKA_ND (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_ND ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_ND      to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_ND      to DEP_SKRN;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_ND      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_ND      to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SKRYNKA_ND ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_ND FOR BARS.SKRYNKA_ND;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_ND.sql =========*** End *** ==
PROMPT ===================================================================================== 
