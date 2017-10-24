

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTS_UPDATE_O.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCOUNTS_UPDATE_O ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCOUNTS_UPDATE_O ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACCOUNTS_UPDATE_O 
   (	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NLSALT VARCHAR2(15), 
	KV NUMBER(3,0), 
	NBS CHAR(4), 
	NBS2 CHAR(4), 
	DAOS DATE, 
	ISP NUMBER(38,0), 
	NMS VARCHAR2(70), 
	PAP NUMBER(1,0), 
	VID NUMBER(2,0), 
	DAZS DATE, 
	BLKD NUMBER(2,0), 
	BLKK NUMBER(2,0), 
	CHGDATE DATE, 
	CHGACTION NUMBER(1,0), 
	POS NUMBER(38,0), 
	TIP CHAR(3), 
	GRP NUMBER(38,0), 
	SECI NUMBER(38,0), 
	SECO NUMBER(38,0), 
	DONEBY VARCHAR2(64), 
	IDUPD NUMBER(38,0), 
	LIM NUMBER(24,0), 
	ACCC NUMBER(38,0), 
	TOBO VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	MDATE DATE, 
	OSTX NUMBER(24,0), 
	SEC RAW(64), 
	RNK NUMBER(22,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	EFFECTDATE DATE, 
	SEND_SMS VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCOUNTS_UPDATE_O ***
 exec bpa.alter_policies('TMP_ACCOUNTS_UPDATE_O');


COMMENT ON TABLE BARS.TMP_ACCOUNTS_UPDATE_O IS '������� ��������� ������ �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.EFFECTDATE IS '���������� ���� ���������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SEND_SMS IS '������� �������� ��� �� �������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.ACC IS '���������� ����� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NLS IS '����� �������� ����� (�������)';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NLSALT IS '�������������� ����� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.KV IS '��� ������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NBS IS '����� ����������� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NBS2 IS '����� ���������. ����������� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.DAOS IS '���� �������� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.ISP IS '��� �����������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.NMS IS '������������ �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.PAP IS '������� �����-�������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.VID IS '��� ���� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.DAZS IS '���� �������� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.BLKD IS '��� ���������� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.BLKK IS '��� ���������� ������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.CHGDATE IS '����/����� ���������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.CHGACTION IS '��� ���������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.POS IS '������� �������� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.TIP IS '��� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.GRP IS '��� ������ �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SECI IS '��� ������� �����������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SECO IS '��� ������� ���������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.DONEBY IS '��� ������������, ������������ ���������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.IDUPD IS '������������� ���������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.LIM IS '�����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.ACCC IS '���������� ����� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.TOBO IS '��� �������������� ���������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.BRANCH IS '��� �������������';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.MDATE IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.OSTX IS '������������ ������� �� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.SEC IS '';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.RNK IS '��� �������-��������� �����';
COMMENT ON COLUMN BARS.TMP_ACCOUNTS_UPDATE_O.KF IS '';



PROMPT *** Create  grants  TMP_ACCOUNTS_UPDATE_O ***
grant REFERENCES,SELECT                                                      on TMP_ACCOUNTS_UPDATE_O to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ACCOUNTS_UPDATE_O to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to BARS_DM;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to BARS_SUP;
grant DELETE,INSERT,UPDATE                                                   on TMP_ACCOUNTS_UPDATE_O to CUST001;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to KLBX;
grant SELECT                                                                 on TMP_ACCOUNTS_UPDATE_O to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_ACCOUNTS_UPDATE_O to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCOUNTS_UPDATE_O.sql =========***
PROMPT ===================================================================================== 
