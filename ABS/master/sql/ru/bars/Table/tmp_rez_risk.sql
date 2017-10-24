

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_RISK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_RISK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_RISK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_RISK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_RISK 
   (	DAT DATE, 
	ID NUMBER(*,0), 
	S080 CHAR(1), 
	S080_NAME VARCHAR2(35), 
	CUSTTYPE NUMBER(*,0), 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(35), 
	KV NUMBER(*,0), 
	NLS VARCHAR2(15), 
	SK NUMBER, 
	SKQ NUMBER, 
	SOQ NUMBER, 
	SRQ NUMBER, 
	CC_ID VARCHAR2(20), 
	SZQ NUMBER, 
	SZ NUMBER, 
	SZ1 NUMBER, 
	FIN NUMBER(*,0), 
	OBS NUMBER(*,0), 
	IDR NUMBER(*,0), 
	RS080 CHAR(1), 
	COUNTRY NUMBER(*,0), 
	PR_REZ NUMBER, 
	RZ NUMBER DEFAULT 0, 
	ACC NUMBER(*,0), 
	ND NUMBER(*,0), 
	WDATE DATE, 
	KDATE DATE, 
	KPROLOG NUMBER, 
	SG NUMBER, 
	SV NUMBER, 
	PAWN NUMBER, 
	OBESP NUMBER, 
	DAT_PROL DATE, 
	METODIKA NUMBER, 
	ISP NUMBER, 
	OTD NUMBER, 
	FONDID NUMBER, 
	SN NUMBER, 
	TOBO VARCHAR2(22), 
	SKQ2 NUMBER, 
	DISCONT NUMBER, 
	SZQ2 NUMBER DEFAULT 0, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	CORP VARCHAR2(30), 
	PREM NUMBER, 
	ISTVAL VARCHAR2(1), 
	ODNCRE VARCHAR2(1), 
	DNIPR NUMBER, 
	REZOLDQ NUMBER DEFAULT 0, 
	DELREZQ NUMBER DEFAULT 0, 
	POGREZ NUMBER DEFAULT 0, 
	REZOLD NUMBER DEFAULT 0, 
	DELREZ NUMBER DEFAULT 0, 
	DELREZQCURS NUMBER DEFAULT 0, 
	FL_NEWACC VARCHAR2(1), 
	SZN NUMBER, 
	SZNQ NUMBER, 
	ARJK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_RISK ***
 exec bpa.alter_policies('TMP_REZ_RISK');


COMMENT ON TABLE BARS.TMP_REZ_RISK IS '������� �� ������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZN IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZNQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ARJK IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DAT IS '���� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ID IS '��� ������������ ������������ ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.S080 IS '��������� ����� - ���';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.S080_NAME IS '��������� ����� - ������������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.CUSTTYPE IS '��� ������� - ��������� ����� ������, ��� ����� ���� ������ � ����� ����� ���� ��� = 2';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.RNK IS '��� ����� ������� ��������� ����� ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.NMK IS '������������ �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.KV IS '������ ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.NLS IS '������� ���� ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SK IS '������� ������� �� ����� ������ � ������ �� �� �������� ����';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SKQ IS '������� ���������� �� ����� ������ � ������ �� �� �������� ����';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SOQ IS '����������� �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SRQ IS '������ ��������� ���� = ������� �� ����� ������� �������� � ������ - ������� - ����������� �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.CC_ID IS '����� ���������� ��������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZQ IS '������ ����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZ IS '������ �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZ1 IS '���� ��� ����� ������������ ����� ������� �� �����';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.FIN IS '���������� ��������� �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.OBS IS '��������� ������������ �����';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.IDR IS '��� ���� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.RS080 IS '��������� ��������� �����';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.COUNTRY IS '������ �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.PR_REZ IS '������� ��������������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.RZ IS '�������������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ACC IS 'acc ����� ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ND IS '����� ���������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.WDATE IS '��������� ���� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.KDATE IS '�������� ���� ��������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.KPROLOG IS '���������� �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SG IS '��������� ����� ���������� �������� � ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SV IS '��������� ����� ���������� �������� � ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.PAWN IS '��� ����������� ��� ���������� ����� ����������� = 40';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.OBESP IS '����������� ����������� �� ������ ��� ����� �������� �� ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DAT_PROL IS '���� ��������� �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.METODIKA IS '�� ������������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ISP IS '��� ����������� �� �����';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.OTD IS '����� ��� �����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.FONDID IS '�� ������������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SN IS '������� ������ - �����������/�������������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.TOBO IS '����';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SKQ2 IS '������� �� ����� ������� �������� � ������, ��� 9129 = 50% � �.�.';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DISCONT IS '����������� ������� ����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.SZQ2 IS '������ ���������� ��� ����� ��������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.CORP IS '������� �������������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.PREM IS '������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ISTVAL IS '������� ������� ��������� �������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.ODNCRE IS '������� ����������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DNIPR IS '��� ��������� ����������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.REZOLDQ IS '������ ����������� ������� (���������� �� �������� ����)';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DELREZQ IS '���������� ������� ����������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.POGREZ IS '�������� ������ �� ���� ������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.REZOLD IS '���������� ������ � ��������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DELREZ IS '���������� � ������� �������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.DELREZQCURS IS '���������� ������� � ���������� ��������� � ���������� �������� ������';
COMMENT ON COLUMN BARS.TMP_REZ_RISK.FL_NEWACC IS '';




PROMPT *** Create  constraint FK_REZ_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK ADD CONSTRAINT FK_REZ_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMP_REZ_RISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK ADD CONSTRAINT PK_TMP_REZ_RISK PRIMARY KEY (ID, DAT, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZ_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_RISK MODIFY (BRANCH CONSTRAINT CC_REZ_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_SZ1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SZ1 ON BARS.TMP_REZ_RISK (SZ1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_REZ_RISK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_REZ_RISK ON BARS.TMP_REZ_RISK (ID, DAT, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_RISK ***
grant SELECT                                                                 on TMP_REZ_RISK    to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_RISK    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_RISK    to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_RISK    to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_RISK    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_REZ_RISK ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_REZ_RISK FOR BARS.TMP_REZ_RISK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_RISK.sql =========*** End *** 
PROMPT ===================================================================================== 
