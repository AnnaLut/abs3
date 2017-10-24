

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS 
   (	ACC NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	NLSALT VARCHAR2(15), 
	NBS CHAR(4), 
	NBS2 CHAR(4), 
	DAOS DATE DEFAULT TRUNC(SYSDATE), 
	DAPP DATE, 
	ISP NUMBER(38,0), 
	NMS VARCHAR2(70), 
	LIM NUMBER(24,0) DEFAULT 0, 
	OSTB NUMBER(24,0) DEFAULT 0, 
	OSTC NUMBER(24,0) DEFAULT 0, 
	OSTF NUMBER(24,0) DEFAULT 0, 
	OSTQ NUMBER(24,0) DEFAULT 0, 
	DOS NUMBER(24,0) DEFAULT 0, 
	KOS NUMBER(24,0) DEFAULT 0, 
	DOSQ NUMBER(24,0) DEFAULT 0, 
	KOSQ NUMBER(24,0) DEFAULT 0, 
	PAP NUMBER(1,0), 
	TIP CHAR(3), 
	VID NUMBER(2,0), 
	TRCN NUMBER(24,0) DEFAULT 0, 
	MDATE DATE, 
	DAZS DATE, 
	SEC RAW(64), 
	ACCC NUMBER(38,0), 
	BLKD NUMBER(3,0) DEFAULT 0, 
	BLKK NUMBER(3,0) DEFAULT 0, 
	POS NUMBER(38,0), 
	SECI NUMBER(38,0), 
	SECO NUMBER(38,0), 
	GRP NUMBER(38,0), 
	OSTX NUMBER(24,0), 
	RNK NUMBER(38,0), 
	NOTIFIER_REF NUMBER(38,0), 
	TOBO VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	BDATE DATE, 
	OPT NUMBER(*,0), 
	OB22 CHAR(2), 
	DAPPQ DATE, 
	SEND_SMS VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS ***
 exec bpa.alter_policies('ACCOUNTS');


COMMENT ON TABLE BARS.ACCOUNTS IS '����� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.SEND_SMS IS '';
COMMENT ON COLUMN BARS.ACCOUNTS.ACC IS '���������� ����� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.KF IS '��� �������';
COMMENT ON COLUMN BARS.ACCOUNTS.NLS IS '����� �������� ����� (�������)';
COMMENT ON COLUMN BARS.ACCOUNTS.KV IS '��� ������';
COMMENT ON COLUMN BARS.ACCOUNTS.BRANCH IS '��� �������������� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS.NLSALT IS '�������������� ����� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.NBS IS '����� ����������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.NBS2 IS '����� ���������. ����������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.DAOS IS '���� �������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.DAPP IS '���� ���������� ��������';
COMMENT ON COLUMN BARS.ACCOUNTS.ISP IS '��� �����������';
COMMENT ON COLUMN BARS.ACCOUNTS.NMS IS '������������ �����';
COMMENT ON COLUMN BARS.ACCOUNTS.LIM IS '�����';
COMMENT ON COLUMN BARS.ACCOUNTS.OSTB IS '������� ��������';
COMMENT ON COLUMN BARS.ACCOUNTS.OSTC IS '������� �����������';
COMMENT ON COLUMN BARS.ACCOUNTS.OSTF IS '������� �������';
COMMENT ON COLUMN BARS.ACCOUNTS.OSTQ IS '���������� OSTF � ���. ������';
COMMENT ON COLUMN BARS.ACCOUNTS.DOS IS '������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.KOS IS '������� ������';
COMMENT ON COLUMN BARS.ACCOUNTS.DOSQ IS '��������� ������� �� ������� ����';
COMMENT ON COLUMN BARS.ACCOUNTS.KOSQ IS '���������� ������� �� ������� ����';
COMMENT ON COLUMN BARS.ACCOUNTS.PAP IS '������� �����-�������';
COMMENT ON COLUMN BARS.ACCOUNTS.TIP IS '��� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.VID IS '��� ���� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.TRCN IS '������� ���������� �� ������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.MDATE IS '���� ��������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.DAZS IS '���� �������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.SEC IS '��� ������� (obsolete)';
COMMENT ON COLUMN BARS.ACCOUNTS.ACCC IS '���������� ����� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.BLKD IS '��� ���������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.BLKK IS '��� ���������� ������';
COMMENT ON COLUMN BARS.ACCOUNTS.POS IS '������� �������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS.SECI IS '��� ������� �����������';
COMMENT ON COLUMN BARS.ACCOUNTS.SECO IS '��� ������� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS.GRP IS '��� ������ �����';
COMMENT ON COLUMN BARS.ACCOUNTS.OSTX IS '������������ ������� �� �����(������� �����)';
COMMENT ON COLUMN BARS.ACCOUNTS.RNK IS '��������������� ����� �������';
COMMENT ON COLUMN BARS.ACCOUNTS.NOTIFIER_REF IS '������ ����������� ������� �� ��������� ���� �������';
COMMENT ON COLUMN BARS.ACCOUNTS.TOBO IS '��� �������������';
COMMENT ON COLUMN BARS.ACCOUNTS.BDATE IS '����';
COMMENT ON COLUMN BARS.ACCOUNTS.OPT IS '1 - ������� �������� ������';
COMMENT ON COLUMN BARS.ACCOUNTS.OB22 IS '����i���� ���. ���������� ��.';
COMMENT ON COLUMN BARS.ACCOUNTS.DAPPQ IS '���� ������� �����������';




PROMPT *** Create  constraint FK_ACCOUNTS_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_ACCOUNTS2 FOREIGN KEY (KF, ACCC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_VIDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_VIDS FOREIGN KEY (VID)
	  REFERENCES BARS.VIDS (VID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_RANG FOREIGN KEY (BLKD)
	  REFERENCES BARS.RANG (RANG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_RANG2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_RANG2 FOREIGN KEY (BLKK)
	  REFERENCES BARS.RANG (RANG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_POS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_POS FOREIGN KEY (POS)
	  REFERENCES BARS.POS (POS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_PAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_PAP FOREIGN KEY (PAP)
	  REFERENCES BARS.PAP (PAP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_NOTIFIERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_NOTIFIERS FOREIGN KEY (NOTIFIER_REF)
	  REFERENCES BARS.NOTIFIERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTS_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT FK_ACCOUNTS_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (RNK CONSTRAINT CC_ACCOUNTS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BRANCH_TOBO_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT CC_ACCOUNTS_BRANCH_TOBO_CC CHECK (branch=tobo) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_SENDSMS_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT CC_ACCOUNTS_SENDSMS_CC CHECK (send_sms=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK3_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT UK3_ACCOUNTS UNIQUE (KF, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BRANCH_CC2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT CC_ACCOUNTS_BRANCH_CC2 CHECK (branch like ''/''||kf||''/%'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BRANCH_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT CC_ACCOUNTS_BRANCH_CC CHECK (branch<>''/'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS ADD CONSTRAINT PK_ACCOUNTS PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_TOBO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (TOBO CONSTRAINT CC_ACCOUNTS_TOBO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_POS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (POS CONSTRAINT CC_ACCOUNTS_POS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BLKK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (BLKK CONSTRAINT CC_ACCOUNTS_BLKK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BLKD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (BLKD CONSTRAINT CC_ACCOUNTS_BLKD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_TRCN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (TRCN CONSTRAINT CC_ACCOUNTS_TRCN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (VID CONSTRAINT CC_ACCOUNTS_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (KOSQ CONSTRAINT CC_ACCOUNTS_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (DOSQ CONSTRAINT CC_ACCOUNTS_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (KOS CONSTRAINT CC_ACCOUNTS_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (DOS CONSTRAINT CC_ACCOUNTS_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (OSTQ CONSTRAINT CC_ACCOUNTS_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_OSTF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (OSTF CONSTRAINT CC_ACCOUNTS_OSTF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_OSTC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (OSTC CONSTRAINT CC_ACCOUNTS_OSTC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_OSTB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (OSTB CONSTRAINT CC_ACCOUNTS_OSTB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_LIM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (LIM CONSTRAINT CC_ACCOUNTS_LIM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_NMS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (NMS CONSTRAINT CC_ACCOUNTS_NMS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_DAOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (DAOS CONSTRAINT CC_ACCOUNTS_DAOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (BRANCH CONSTRAINT CC_ACCOUNTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (KV CONSTRAINT CC_ACCOUNTS_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (NLS CONSTRAINT CC_ACCOUNTS_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (KF CONSTRAINT CC_ACCOUNTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS MODIFY (ACC CONSTRAINT CC_ACCOUNTS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_ACCOUNTS ON BARS.ACCOUNTS (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_ACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_ACCOUNTS ON BARS.ACCOUNTS (KF, NLS, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_ACCOUNTS ON BARS.ACCOUNTS (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTS ON BARS.ACCOUNTS (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_ACCOUNTS ON BARS.ACCOUNTS (ACCC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_ACCOUNTS ON BARS.ACCOUNTS (TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_ACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_ACCOUNTS ON BARS.ACCOUNTS (ACC, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_ACCOUNTS_RNK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_ACCOUNTS_RNK ON BARS.ACCOUNTS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK3_ACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK3_ACCOUNTS ON BARS.ACCOUNTS (KF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I6_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I6_ACCOUNTS ON BARS.ACCOUNTS (CASE  WHEN (TIP=''N00'' OR TIP=''L00'' OR TIP=''L01'' OR TIP=''T00'' OR TIP=''T0D'' OR TIP=''TNB'' OR TIP=''TND'' OR TIP=''L99'' OR TIP=''N99'' OR TIP=''TUR'' OR TIP=''TUD'' OR TIP=''902'' OR TIP=''90D'') THEN TIP ELSE NULL END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I7_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I7_ACCOUNTS ON BARS.ACCOUNTS (TOBO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I8_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I8_ACCOUNTS ON BARS.ACCOUNTS (KF, NLSALT, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I9_ACCOUNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I9_ACCOUNTS ON BARS.ACCOUNTS (UPPER(NMS)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS        to ABS_ADMIN;
grant SELECT                                                                 on ACCOUNTS        to BARS;
grant SELECT,UPDATE                                                          on ACCOUNTS        to BARS009;
grant SELECT                                                                 on ACCOUNTS        to BARS010;
grant SELECT                                                                 on ACCOUNTS        to BARS015;
grant REFERENCES,SELECT                                                      on ACCOUNTS        to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on ACCOUNTS        to BARSAQ_ADM with grant option;
grant SELECT                                                                 on ACCOUNTS        to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCOUNTS        to BARSUPL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ACCOUNTS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS        to BARS_DM;
grant SELECT                                                                 on ACCOUNTS        to BARS_SUP;
grant DELETE,UPDATE                                                          on ACCOUNTS        to CUST001;
grant SELECT,UPDATE                                                          on ACCOUNTS        to DEP_SKRN;
grant SELECT,UPDATE                                                          on ACCOUNTS        to DPT;
grant SELECT                                                                 on ACCOUNTS        to DPT_ADMIN;
grant SELECT                                                                 on ACCOUNTS        to DPT_ROLE;
grant SELECT                                                                 on ACCOUNTS        to FINMON;
grant SELECT,UPDATE                                                          on ACCOUNTS        to FINMON01;
grant SELECT,UPDATE                                                          on ACCOUNTS        to FOREX;
grant SELECT                                                                 on ACCOUNTS        to IBSADM_ROLE;
grant SELECT,SELECT                                                          on ACCOUNTS        to KLBX;
grant INSERT,SELECT,UPDATE                                                   on ACCOUNTS        to NALOG;
grant SELECT,UPDATE                                                          on ACCOUNTS        to OBPC;
grant SELECT                                                                 on ACCOUNTS        to PYOD001;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ACCOUNTS        to RCC_DEAL;
grant SELECT                                                                 on ACCOUNTS        to REF0000;
grant SELECT                                                                 on ACCOUNTS        to RPBN001;
grant SELECT                                                                 on ACCOUNTS        to RPBN002;
grant SELECT,UPDATE                                                          on ACCOUNTS        to SALGL;
grant SELECT,UPDATE                                                          on ACCOUNTS        to SETLIM01;
grant SELECT                                                                 on ACCOUNTS        to START1;
grant UPDATE                                                                 on ACCOUNTS        to TECH001;
grant SELECT                                                                 on ACCOUNTS        to TECH005;
grant SELECT,UPDATE                                                          on ACCOUNTS        to TEST;
grant SELECT                                                                 on ACCOUNTS        to TOSS;
grant SELECT                                                                 on ACCOUNTS        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTS        to WR_ALL_RIGHTS;
grant SELECT,UPDATE                                                          on ACCOUNTS        to WR_CUSTLIST;
grant SELECT,UPDATE                                                          on ACCOUNTS        to WR_DEPOSIT_U;
grant SELECT                                                                 on ACCOUNTS        to WR_DOCHAND;
grant SELECT                                                                 on ACCOUNTS        to WR_DOCVIEW;
grant SELECT                                                                 on ACCOUNTS        to WR_DOC_INPUT;
grant SELECT                                                                 on ACCOUNTS        to WR_KP;
grant SELECT                                                                 on ACCOUNTS        to WR_VIEWACC;



PROMPT *** Create SYNONYM  to ACCOUNTS ***

  CREATE OR REPLACE SYNONYM BARSDWH_ACCESS_USER.ACCOUNTS FOR BARS.ACCOUNTS;


PROMPT *** Create SYNONYM  to ACCOUNTS ***

  CREATE OR REPLACE PUBLIC SYNONYM ACCOUNTS_F FOR BARS.ACCOUNTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS.sql =========*** End *** ====
PROMPT ===================================================================================== 
