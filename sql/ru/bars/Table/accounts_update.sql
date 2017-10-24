

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTS_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTS_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTS_UPDATE 
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
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
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
	SEND_SMS VARCHAR2(1), 
	OB22 CHAR(2), 
	GLOBALBD DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255  NOLOGGING 
  TABLESPACE BRSBIGD 
  PARTITION BY RANGE (CHGDATE) INTERVAL (NUMTOYMINTERVAL(1,''MONTH'')) 
 (PARTITION SYS_P68612  VALUES LESS THAN (TO_DATE('' 2010-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD ) 
  PARALLEL ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTS_UPDATE ***
 exec bpa.alter_policies('ACCOUNTS_UPDATE');


COMMENT ON TABLE BARS.ACCOUNTS_UPDATE IS '������� ��������� ������ �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.OB22 IS '����i���� ���. ���������� ��.';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.GLOBALBD IS '��������� ��������� ����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.ACC IS '���������� ����� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NLS IS '����� �������� ����� (�������)';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NLSALT IS '�������������� ����� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.KV IS '��� ������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NBS IS '����� ����������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NBS2 IS '����� ���������. ����������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.DAOS IS '���� �������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.ISP IS '��� �����������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.NMS IS '������������ �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.PAP IS '������� �����-�������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.VID IS '��� ���� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.DAZS IS '���� �������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.BLKD IS '��� ���������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.BLKK IS '��� ���������� ������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.CHGDATE IS '����/����� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.CHGACTION IS '��� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.POS IS '������� �������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.TIP IS '��� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.GRP IS '��� ������ �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SECI IS '��� ������� �����������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SECO IS '��� ������� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.DONEBY IS '��� ������������, ������������ ���������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.IDUPD IS '������������� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.LIM IS '�����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.ACCC IS '���������� ����� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.TOBO IS '��� �������������� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.BRANCH IS '��� �������������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.MDATE IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.OSTX IS '������������ ������� �� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SEC IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.RNK IS '��� �������-��������� �����';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.EFFECTDATE IS '���������� ���� ���������';
COMMENT ON COLUMN BARS.ACCOUNTS_UPDATE.SEND_SMS IS '������� �������� ��� �� �������';




PROMPT *** Create  constraint R_ACC_ACCUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT R_ACC_ACCUPDATE FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_VIDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_VIDS FOREIGN KEY (VID)
	  REFERENCES BARS.VIDS (VID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_TOBO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_TOBO FOREIGN KEY (TOBO)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_STAFF2 FOREIGN KEY (DONEBY)
	  REFERENCES BARS.STAFF$BASE (LOGNAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_STAFF FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_RANG2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_RANG2 FOREIGN KEY (BLKK)
	  REFERENCES BARS.RANG (RANG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_RANG FOREIGN KEY (BLKD)
	  REFERENCES BARS.RANG (RANG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_POS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_POS FOREIGN KEY (POS)
	  REFERENCES BARS.POS (POS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_PAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_PAP FOREIGN KEY (PAP)
	  REFERENCES BARS.PAP (PAP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_ACCOUNTS3 FOREIGN KEY (KF, ACCC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOUNTSUPD_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT FK_ACCOUNTSUPD_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCOUNTSUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT PK_ACCOUNTSUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (KF CONSTRAINT CC_ACCOUNTSUPD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (BRANCH CONSTRAINT CC_ACCOUNTSUPD_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (IDUPD CONSTRAINT CC_ACCOUNTSUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (DONEBY CONSTRAINT CC_ACCOUNTSUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (CHGACTION CONSTRAINT CC_ACCOUNTSUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (CHGDATE CONSTRAINT CC_ACCOUNTSUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_NMS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (NMS CONSTRAINT CC_ACCOUNTSUPD_NMS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_DAOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (DAOS CONSTRAINT CC_ACCOUNTSUPD_DAOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (KV CONSTRAINT CC_ACCOUNTSUPD_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (NLS CONSTRAINT CC_ACCOUNTSUPD_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (ACC CONSTRAINT CC_ACCOUNTSUPD_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_CHGACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE ADD CONSTRAINT CC_ACCOUNTSUPD_CHGACTION CHECK (chgaction in (0,1,2,3,4)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOUNTSUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTS_UPDATE MODIFY (GLOBALBD CONSTRAINT CC_ACCOUNTSUPD_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_ACCOUNTSUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_ACCOUNTSUPD ON BARS.ACCOUNTS_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_ACCOUNTSUPD_CHGDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_ACCOUNTSUPD_CHGDATE ON BARS.ACCOUNTS_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION SYS_P68726 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_ACCOUNTSUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_ACCOUNTSUPD_EFFDAT ON BARS.ACCOUNTS_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_ACCOUNTS_UPDATE_DAOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_ACCOUNTS_UPDATE_DAOS ON BARS.ACCOUNTS_UPDATE (DAOS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION SYS_P68783 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOUNTSUPD_GLD_EFFD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOUNTSUPD_GLD_EFFD ON BARS.ACCOUNTS_UPDATE (GLOBALBD, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTSUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTSUPD ON BARS.ACCOUNTS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_ACCOUNTSUPD_UPLDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_ACCOUNTSUPD_UPLDATE ON BARS.ACCOUNTS_UPDATE (CHGDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION SYS_P68669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTS_UPDATE ***
grant REFERENCES,SELECT                                                      on ACCOUNTS_UPDATE to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCOUNTS_UPDATE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCOUNTS_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTS_UPDATE to BARS_DM;
grant SELECT                                                                 on ACCOUNTS_UPDATE to BARS_SUP;
grant DELETE,INSERT,UPDATE                                                   on ACCOUNTS_UPDATE to CUST001;
grant SELECT                                                                 on ACCOUNTS_UPDATE to KLBX;
grant SELECT                                                                 on ACCOUNTS_UPDATE to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACCOUNTS_UPDATE to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACCOUNTS_UPDATE ***

  CREATE OR REPLACE SYNONYM BARSDWH_ACCESS_USER.ACCOUNTS_UPDATE FOR BARS.ACCOUNTS_UPDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTS_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
