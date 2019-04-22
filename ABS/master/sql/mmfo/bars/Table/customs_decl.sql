

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMS_DECL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMS_DECL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMS_DECL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMS_DECL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMS_DECL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMS_DECL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMS_DECL 
   (	FN VARCHAR2(12), 
	DAT DATE, 
	N NUMBER, 
	LEN NUMBER, 
	CDAT DATE, 
	ISNULL NUMBER(1,0), 
	NDAT DATE, 
	MDAT DATE, 
	CTYPE VARCHAR2(2), 
	CNUM_CST VARCHAR2(9), 
	CNUM_YEAR VARCHAR2(4), 
	CNUM_NUM VARCHAR2(6), 
	MVM_FEAT VARCHAR2(3), 
	S_OKPO VARCHAR2(10), 
	S_NAME VARCHAR2(200), 
	S_ADRES VARCHAR2(200), 
	S_TYPE NUMBER(3,0), 
	S_TAXID VARCHAR2(12), 
	R_OKPO VARCHAR2(10), 
	R_NAME VARCHAR2(200), 
	R_ADRES VARCHAR2(200), 
	R_TYPE NUMBER(3,0), 
	R_TAXID VARCHAR2(12), 
	F_OKPO VARCHAR2(10), 
	F_NAME VARCHAR2(200), 
	F_ADRES VARCHAR2(200), 
	F_TYPE NUMBER(3,0), 
	F_TAXID VARCHAR2(12), 
	F_COUNTRY VARCHAR2(3), 
	UAH_NLS VARCHAR2(35), 
	UAH_MFO VARCHAR2(6), 
	CCY_NLS VARCHAR2(35), 
	CCY_MFO VARCHAR2(6), 
	KV NUMBER(3,0), 
	KURS NUMBER(38,0), 
	S NUMBER(38,0), 
	ALLOW_DAT DATE, 
	CMODE_CODE NUMBER(2,0), 
	RESERV VARCHAR2(10), 
	DOC VARCHAR2(50), 
	SDATE DATE, 
	FDATE DATE, 
	SIGN_KEY VARCHAR2(6), 
	SIGN RAW(128), 
	CHARACTER NUMBER, 
	RESERVE2 VARCHAR2(8), 
	FL_EIK NUMBER(1,0) DEFAULT 0, 
	IDT NUMBER, 
	DATJ DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	CIM_ID NUMBER, 
	CIM_BRANCH VARCHAR2(30), 
	CIM_DATE DATE, 
	CIM_BOUNDSUM NUMBER, 
	CIM_ORIGINAL NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMS_DECL ***
 exec bpa.alter_policies('CUSTOMS_DECL');


COMMENT ON TABLE BARS.CUSTOMS_DECL IS '���������� ����������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.FN IS '��� �����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.DAT IS '���� �������� �����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.N IS '����� �������������� ������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.LEN IS '����� �������������� ������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CDAT IS '���� �������� ���������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.ISNULL IS '������� ���������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.NDAT IS '���� ���������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.MDAT IS '���� �����������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CTYPE IS '��� ����������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CNUM_CST IS '����� ����������: �������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CNUM_YEAR IS '����� ����������: ���';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CNUM_NUM IS '����� ���������: �����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.MVM_FEAT IS '����������� ������������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.S_OKPO IS '�����������: ��� ���� ��� ����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.S_NAME IS '�����������: ������������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.S_ADRES IS '�����������: �����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.S_TYPE IS '�����������: ���';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.S_TAXID IS '�����������: ��� ����������������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.R_OKPO IS '����������: ��� ���� ��� ����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.R_NAME IS '����������: ������������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.R_ADRES IS '����������: �����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.R_TYPE IS '����������: ���';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.R_TAXID IS '����������: ��� �����������������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.F_OKPO IS '���������������: ��� ���� ��� ����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.F_NAME IS '���������������: ������������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.F_ADRES IS '���������������: �����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.F_TYPE IS '���������������: ���';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.F_TAXID IS '���������������: ��� �����������������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.F_COUNTRY IS '���������������: ��� ������ �����������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.UAH_NLS IS '�/� ���� �� ������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.UAH_MFO IS '��� ����������� ����� (������)';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CCY_NLS IS '�/� ���� �� ������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CCY_MFO IS '��� ����������� ����� (������)';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.KV IS '��� ������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.KURS IS '���� ������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.S IS '�����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.ALLOW_DAT IS '���� ����������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CMODE_CODE IS '��� ������ ����������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.RESERV IS '������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.DOC IS '�������� (��������)';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.SDATE IS '���� ������ ��������� (���������)';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.FDATE IS '���� ��������� ��������� (���������)';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.SIGN_KEY IS '�� ����� �������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.SIGN IS '���';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CHARACTER IS '';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.RESERVE2 IS '';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.FL_EIK IS '������� ��������� �� ������� "�������� ��������"';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.IDT IS '��� �� �� ������ "�������� ��������"';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.DATJ IS '���� �������� �� �� ����� "�������� ��������"';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.KF IS '';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CIM_ID IS '��� �� � WEB-����� "�������� ��������"';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CIM_BRANCH IS '����� ��������';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CIM_DATE IS '���� ���������� ����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CIM_BOUNDSUM IS '����`����� ������� ����';
COMMENT ON COLUMN BARS.CUSTOMS_DECL.CIM_ORIGINAL IS '1 - �������� �� (�� �����)';




PROMPT *** Create  constraint CC_CUSTOMSDECL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMS_DECL MODIFY (KF CONSTRAINT CC_CUSTOMSDECL_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMSDECL_CIMID_UK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMS_DECL ADD CONSTRAINT CC_CUSTOMSDECL_CIMID_UK UNIQUE (CIM_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CUSTOMS_DECL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMS_DECL ADD CONSTRAINT XPK_CUSTOMS_DECL PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CUSTOMS_DECL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CUSTOMS_DECL ON BARS.CUSTOMS_DECL (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_CUSTOMSDECL_CIMID_UK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_CUSTOMSDECL_CIMID_UK ON BARS.CUSTOMS_DECL (CIM_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CUSTOMS_DECL_AD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CUSTOMS_DECL_AD ON BARS.CUSTOMS_DECL (TRUNC(ALLOW_DAT)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
PROMPT *** ADD COLUMN OUTDATED***
begin 
  execute immediate 
    ' ALTER TABLE BARS.CUSTOMS_DECL'||
    '  ADD (OUTDATED  NUMBER)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/
PROMPT *** ADD COLUMN MDAT_NEW***
begin 
  execute immediate 
    ' ALTER TABLE BARS.CUSTOMS_DECL'||
    '  ADD (MDAT_NEW  DATE)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/
PROMPT *** ADD COLUMN CCY_MFO_NEW***
begin 
  execute immediate 
    ' ALTER TABLE BARS.CUSTOMS_DECL'||
    '  ADD (CCY_MFO_NEW  VARCHAR2(6))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/
PROMPT *** ADD COLUMN UAH_MFO_NEW***
begin 
  execute immediate 
    ' ALTER TABLE BARS.CUSTOMS_DECL'||
    '  ADD (UAH_MFO_NEW  VARCHAR2(6))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/
PROMPT *** ADD COLUMN FN_MM***
begin 
  execute immediate 
    ' ALTER TABLE BARS.CUSTOMS_DECL'||
    '  ADD (FN_MM  VARCHAR2(12))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/
PROMPT *** ADD COLUMN N_MM***
begin 
  execute immediate 
    ' ALTER TABLE BARS.CUSTOMS_DECL'||
    '  ADD (N_MM  NUMBER)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/
COMMENT ON COLUMN BARS.CUSTOMS_DECL.OUTDATED IS '������ ��������� ������� "����������" ���';

COMMENT ON COLUMN BARS.CUSTOMS_DECL.MDAT_NEW IS '���� ��������� ������� "����������" ���';

COMMENT ON COLUMN BARS.CUSTOMS_DECL.CCY_MFO_NEW IS '��� ������ ��������� ����� (������)';

COMMENT ON COLUMN BARS.CUSTOMS_DECL.UAH_MFO_NEW IS '��� ������ ��������� ����� (������)';

COMMENT ON COLUMN BARS.CUSTOMS_DECL.FN_MM IS '��� MM-�����';

COMMENT ON COLUMN BARS.CUSTOMS_DECL.N_MM IS '����� �������������� ����� � ���� MM';


PROMPT *** Create  grants  CUSTOMS_DECL ***
grant SELECT                                                                 on CUSTOMS_DECL    to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CUSTOMS_DECL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMS_DECL    to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CUSTOMS_DECL    to TOSS;
grant SELECT                                                                 on CUSTOMS_DECL    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMS_DECL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMS_DECL.sql =========*** End *** 
PROMPT ===================================================================================== 
