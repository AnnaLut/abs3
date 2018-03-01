

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAYAVKA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAYAVKA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAYAVKA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAYAVKA'', ''FILIAL'' , ''M'', ''M'', null, ''M'');
               bpa.alter_policy_info(''ZAYAVKA'', ''WHOLE'' , null, ''E'', null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAYAVKA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAYAVKA 
   (	RNK NUMBER, 
	DK NUMBER, 
	ACC0 NUMBER, 
	ACC1 NUMBER, 
	FDAT DATE, 
	S2 NUMBER, 
	KURS_Z NUMBER(16,8), 
	KURS_F NUMBER(16,8), 
	MFOP VARCHAR2(12), 
	NLSP VARCHAR2(15), 
	SOS NUMBER(2,1), 
	KV2 NUMBER, 
	KOM NUMBER(10,4), 
	SKOM NUMBER(10,2), 
	VDATE DATE, 
	REF NUMBER, 
	MFO0 VARCHAR2(12), 
	NLS0 VARCHAR2(15), 
	OKPOP VARCHAR2(10), 
	OKPO0 VARCHAR2(10), 
	CONTRACT VARCHAR2(50), 
	DAT_VMD DATE, 
	DAT2_VMD DATE, 
	VIZA NUMBER, 
	META NUMBER, 
	DAT5_VMD VARCHAR2(240), 
	RNK_PF VARCHAR2(20), 
	PRIORITY NUMBER DEFAULT 0, 
	COUNTRY NUMBER, 
	BASIS VARCHAR2(512), 
	ID NUMBER, 
	FNAMEKB VARCHAR2(12), 
	IDENTKB VARCHAR2(16), 
	IDBACK NUMBER, 
	PID NUMBER, 
	TIPKB NUMBER(*,0), 
	DATEDOKKB DATE, 
	ND VARCHAR2(10), 
	DATT DATE, 
	OBZ NUMBER DEFAULT 0, 
	DATZ DATE, 
	FL_PF NUMBER, 
	FL_KURSZ NUMBER(1,0), 
	BENEFCOUNTRY NUMBER, 
	BANK_CODE VARCHAR2(10), 
	BANK_NAME VARCHAR2(60), 
	S3 NUMBER, 
	LIM NUMBER, 
	ISP NUMBER, 
	TOBO VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	PRODUCT_GROUP CHAR(2), 
	NUM_VMD VARCHAR2(35), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DETAILS VARCHAR2(254), 
	KURS_KL VARCHAR2(30), 
	COMM VARCHAR2(250), 
	CONTACT_FIO VARCHAR2(70), 
	CONTACT_TEL VARCHAR2(32), 
	CLOSE_TYPE NUMBER(1,0), 
	VERIFY_OPT NUMBER(1,0) DEFAULT 1, 
	AIMS_CODE NUMBER(2,0), 
	KV_CONV NUMBER(3,0), 
	OPERID_NOKK VARCHAR2(30), 
	SOPER NUMBER, 
	REF_SPS NUMBER, 
	S_PF NUMBER, 
	REF_PF NUMBER, 
	ID_PREV NUMBER, 
	REQ_TYPE NUMBER(10,0), 
	VDATE_PLAN DATE, 
	REASON_COMM VARCHAR2(254), 
	REFOPER NUMBER, 
	CODE_2C VARCHAR2(1), 
	P12_2C VARCHAR2(10), 
	SUPPORT_DOCUMENT NUMBER(1,0), 
	ATTACHMENTS_COUNT NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAYAVKA ***
 exec bpa.alter_policies('ZAYAVKA');


COMMENT ON TABLE BARS.ZAYAVKA IS '������ �������� �� �������-������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.ATTACHMENTS_COUNT IS 'ʳ������ ������� ���������';
COMMENT ON COLUMN BARS.ZAYAVKA.RNK IS '��� �������';
COMMENT ON COLUMN BARS.ZAYAVKA.DK IS '1 - �������,  2 - �������, 3 - ������� �� ��.������ (���������)';
COMMENT ON COLUMN BARS.ZAYAVKA.ACC0 IS '��� 1 - ��� ���� ��������, ��� 2 - ��� ���� ����������(��� ���������� �����.��� �� ������� - ���� �������,���� ����������� ���� mfo0, nls0,okpo0), ��� 3 - ��� ���� ��� ��������';
COMMENT ON COLUMN BARS.ZAYAVKA.ACC1 IS '��� 1 - ��� ���� ����������, ��� 2 - ��� ���� ��������, ��� 3 - ��� ���� ����������';
COMMENT ON COLUMN BARS.ZAYAVKA.FDAT IS '���� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.S2 IS '����� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.KURS_Z IS '���� ���������� (�������)';
COMMENT ON COLUMN BARS.ZAYAVKA.KURS_F IS '���� ����������� (������)';
COMMENT ON COLUMN BARS.ZAYAVKA.MFOP IS '��� ��';
COMMENT ON COLUMN BARS.ZAYAVKA.NLSP IS '�����. ���� ������� ��� ���������� � ��';
COMMENT ON COLUMN BARS.ZAYAVKA.SOS IS '���������: 0 - �������, 0.5 - ������������� ������� ��������������, 1 - ������������� ������� ������������,  2 - ��������, -1 - �������';
COMMENT ON COLUMN BARS.ZAYAVKA.KV2 IS '������ ������';
COMMENT ON COLUMN BARS.ZAYAVKA.KOM IS '% ��������';
COMMENT ON COLUMN BARS.ZAYAVKA.SKOM IS '����� ��������';
COMMENT ON COLUMN BARS.ZAYAVKA.VDATE IS '���� �������������';
COMMENT ON COLUMN BARS.ZAYAVKA.REF IS '���.���-��';
COMMENT ON COLUMN BARS.ZAYAVKA.MFO0 IS '��� ��� ���������� ��� �� �/� ��� �������';
COMMENT ON COLUMN BARS.ZAYAVKA.NLS0 IS '���� ��� ���������� ��� �� �/� ��� ������� ';
COMMENT ON COLUMN BARS.ZAYAVKA.OKPOP IS '���� � ��';
COMMENT ON COLUMN BARS.ZAYAVKA.OKPO0 IS '���� ��� ���������� ��� �� �/� ��� �������';
COMMENT ON COLUMN BARS.ZAYAVKA.CONTRACT IS '� ���������';
COMMENT ON COLUMN BARS.ZAYAVKA.DAT_VMD IS '���� ��������� ���';
COMMENT ON COLUMN BARS.ZAYAVKA.DAT2_VMD IS '���� ���������';
COMMENT ON COLUMN BARS.ZAYAVKA.VIZA IS '����: 0 - �������, 1 - ������������ ZAY2, 2 - ������������ ZAY3, -1 - ������������(����� � ����)';
COMMENT ON COLUMN BARS.ZAYAVKA.META IS '���� ������� (���-� zay_aims)';
COMMENT ON COLUMN BARS.ZAYAVKA.DAT5_VMD IS '���� ��������� ���';
COMMENT ON COLUMN BARS.ZAYAVKA.RNK_PF IS '��� ������� - ���.� ������� � �� ��� �������: ��� ��� 27-�� �����';
COMMENT ON COLUMN BARS.ZAYAVKA.PRIORITY IS '��������� ������: 0 - �������, 1 - �����������, 2 - ������������, 9 - ���������������';
COMMENT ON COLUMN BARS.ZAYAVKA.COUNTRY IS '��� ������ ������������ ������';
COMMENT ON COLUMN BARS.ZAYAVKA.BASIS IS '��������� ��� ������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.ID IS '������������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.FNAMEKB IS '��� ����� ������, �������� �� ������-�����';
COMMENT ON COLUMN BARS.ZAYAVKA.IDENTKB IS '������� ������, �������� �� ������-����� (1)';
COMMENT ON COLUMN BARS.ZAYAVKA.IDBACK IS '��� ������� �������� ������ (���-� zay_back)';
COMMENT ON COLUMN BARS.ZAYAVKA.PID IS '�������� ���������';
COMMENT ON COLUMN BARS.ZAYAVKA.TIPKB IS '��� ��������� �� ������-�����';
COMMENT ON COLUMN BARS.ZAYAVKA.DATEDOKKB IS '���� ����������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.ND IS '����� ���������, ������������ �� ��';
COMMENT ON COLUMN BARS.ZAYAVKA.DATT IS '��������� ���� �������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.OBZ IS '������� ������ �� ������������ ������� (1)';
COMMENT ON COLUMN BARS.ZAYAVKA.DATZ IS '���� ���������� ������� ���/���';
COMMENT ON COLUMN BARS.ZAYAVKA.FL_PF IS '������� ������������ ������� � ����.����';
COMMENT ON COLUMN BARS.ZAYAVKA.FL_KURSZ IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.BENEFCOUNTRY IS '��� ������ �������-�����������';
COMMENT ON COLUMN BARS.ZAYAVKA.BANK_CODE IS '��� ������������ �����';
COMMENT ON COLUMN BARS.ZAYAVKA.BANK_NAME IS '������������ ������������ �����';
COMMENT ON COLUMN BARS.ZAYAVKA.S3 IS '����� ��������';
COMMENT ON COLUMN BARS.ZAYAVKA.LIM IS '����� ����������������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.ISP IS '��� ������������, ������� ���� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.TOBO IS '��� �������������, � ������� ������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.PRODUCT_GROUP IS '��� �������� ������ (kod_70_4)';
COMMENT ON COLUMN BARS.ZAYAVKA.NUM_VMD IS '� ���������� ����������';
COMMENT ON COLUMN BARS.ZAYAVKA.BRANCH IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.KF IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.DETAILS IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.KURS_KL IS '�������������� ���������� ����';
COMMENT ON COLUMN BARS.ZAYAVKA.COMM IS '����������';
COMMENT ON COLUMN BARS.ZAYAVKA.CONTACT_FIO IS '��� ����������� ����';
COMMENT ON COLUMN BARS.ZAYAVKA.CONTACT_TEL IS '��� ����������� ����';
COMMENT ON COLUMN BARS.ZAYAVKA.CLOSE_TYPE IS '��� �������� ������ (1-�� �� �����; 2-�� ����; 3-������ ������� �� ������ ������ ������))';
COMMENT ON COLUMN BARS.ZAYAVKA.VERIFY_OPT IS '��������� ����� �������� � ������ �볺��-���� HOKK';
COMMENT ON COLUMN BARS.ZAYAVKA.AIMS_CODE IS '�������� ��� ���� ������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.KV_CONV IS '��� ������(�����������)';
COMMENT ON COLUMN BARS.ZAYAVKA.OPERID_NOKK IS '��������� ����� �������� � ������ �볺��-���� HOKK';
COMMENT ON COLUMN BARS.ZAYAVKA.SOPER IS '����� ����� ��������� ����.��������� �� 2603 ��� ���';
COMMENT ON COLUMN BARS.ZAYAVKA.REF_SPS IS '�������� �������� �� �������� �������';
COMMENT ON COLUMN BARS.ZAYAVKA.S_PF IS '����� ���������� � ��';
COMMENT ON COLUMN BARS.ZAYAVKA.REF_PF IS '�������� ���������� � ��';
COMMENT ON COLUMN BARS.ZAYAVKA.ID_PREV IS '�� ������-�������� (��� ���, ���.���������)';
COMMENT ON COLUMN BARS.ZAYAVKA.REQ_TYPE IS '';
COMMENT ON COLUMN BARS.ZAYAVKA.VDATE_PLAN IS '�������� ���� �������������';
COMMENT ON COLUMN BARS.ZAYAVKA.REASON_COMM IS '������� �������� ������';
COMMENT ON COLUMN BARS.ZAYAVKA.REFOPER IS '�������� ��������� ����.��������� �� 2603 ��� ���';
COMMENT ON COLUMN BARS.ZAYAVKA.CODE_2C IS '��� ����� �� �������� (#2C)';
COMMENT ON COLUMN BARS.ZAYAVKA.P12_2C IS '������ ��������(#2C)';
COMMENT ON COLUMN BARS.ZAYAVKA.SUPPORT_DOCUMENT IS '������� �������������� ����������';




PROMPT *** Create  constraint CC_ZAYAVKA_CODE2C ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_CODE2C CHECK (code_2c in (''0'', ''1'', ''2'', ''4'', ''9'', ''A'', ''B'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_ZAYAVKA_FNAMEKB_IDENTKB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT UK_ZAYAVKA_FNAMEKB_IDENTKB UNIQUE (FNAMEKB, IDENTKB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAYAVKA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT PK_ZAYAVKA_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_DK CHECK (dk in (1, 2, 3, 4)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_SOS CHECK (sos between -1 and 2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_VIZA ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_VIZA CHECK (viza in (-1, 0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_OBZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_OBZ CHECK (obz in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_FLPF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_FLPF CHECK (fl_pf in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_FLKURSZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_FLKURSZ CHECK (fl_kursz in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAYAVKA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA ADD CONSTRAINT CC_ZAYAVKA_CODE2C CHECK (code_2c in (''0'', ''1'', ''2'', ''3'',''4'',''5'',''9'',''A'',''B'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA MODIFY (BRANCH CONSTRAINT CC_ZAYAVKA_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYAVKA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAYAVKA MODIFY (KF CONSTRAINT CC_ZAYAVKA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ZAYAVKA_FNAMEKB_IDENTKB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ZAYAVKA_FNAMEKB_IDENTKB ON BARS.ZAYAVKA (FNAMEKB, IDENTKB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYAVKA_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYAVKA_ID ON BARS.ZAYAVKA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_ZAYAVKA ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_ZAYAVKA ON BARS.ZAYAVKA (KV2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ZAYAVKA_KF_REF_DK ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ZAYAVKA_KF_REF_DK ON BARS.ZAYAVKA (KF, REFOPER, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAYAVKA ***
grant UPDATE                                                                 on ZAYAVKA         to BARSAQ;
grant FLASHBACK,REFERENCES,SELECT                                            on ZAYAVKA         to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on ZAYAVKA         to BARSAQ_ADM with grant option;
grant SELECT                                                                 on ZAYAVKA         to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAYAVKA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAYAVKA         to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on ZAYAVKA         to START1;
grant INSERT                                                                 on ZAYAVKA         to TECH_MOM1;
grant SELECT                                                                 on ZAYAVKA         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAYAVKA         to WR_ALL_RIGHTS;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ZAYAVKA         to ZAY;



PROMPT *** Create SYNONYM  to ZAYAVKA ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAYAVKA FOR BARS.ZAYAVKA;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAYAVKA.sql =========*** End *** =====
PROMPT ===================================================================================== 
