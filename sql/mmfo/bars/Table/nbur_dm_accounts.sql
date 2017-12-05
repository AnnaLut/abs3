

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_ACCOUNTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_ACCOUNTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_ACCOUNTS ***
begin
  execute immediate 'CREATE TABLE BARS.NBUR_DM_ACCOUNTS 
(	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	ACC_ID NUMBER(38,0), 
	ACC_NUM VARCHAR2(15), 
	ACC_NUM_ALT VARCHAR2(15), 
	ACC_TYPE CHAR(3), 
	BRANCH VARCHAR2(30), 
	KV NUMBER(3,0), 
	OPEN_DATE DATE, 
	CLOSE_DATE DATE, 
	MATURITY_DATE DATE, 
	CUST_ID NUMBER(38,0), 
	ACC_PID NUMBER(38,0), 
	LIMIT NUMBER(24,0), 
	PAP NUMBER(1,0), 
	VID NUMBER(2,0), 
	BLC_CODE_DB NUMBER(3,0), 
	BLC_CODE_CR NUMBER(3,0), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	NBUC VARCHAR2(20), 
	B040 CHAR(20), 
	R011 CHAR(1), 
	R012 CHAR(1), 
	R013 CHAR(1), 
	R016 CHAR(2), 
	R030 CHAR(3), 
	R031 CHAR(1), 
	R032 CHAR(1), 
	R033 CHAR(1), 
	R034 CHAR(1), 
	S180 CHAR(1), 
	S181 CHAR(1), 
	S183 CHAR(1), 
	S240 CHAR(1), 
	S580 CHAR(1)
, OB22_ALT   CHAR(2)
, ACC_ALT_DT DATE
) TABLESPACE BRSMDLD
COMPRESS BASIC
NOLOGGING
  PARTITION BY LIST (KF) 
 (PARTITION P_300465  VALUES (''300465'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_302076  VALUES (''302076'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_303398  VALUES (''303398'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_304665  VALUES (''304665'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_305482  VALUES (''305482'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_311647  VALUES (''311647'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_312356  VALUES (''312356'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_313957  VALUES (''313957'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_315784  VALUES (''315784'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_322669  VALUES (''322669'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_323475  VALUES (''323475'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_324805  VALUES (''324805'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_325796  VALUES (''325796'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_326461  VALUES (''326461'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_328845  VALUES (''328845'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_331467  VALUES (''331467'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_333368  VALUES (''333368'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_335106  VALUES (''335106'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_336503  VALUES (''336503'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_337568  VALUES (''337568'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_338545  VALUES (''338545'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_351823  VALUES (''351823'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_352457  VALUES (''352457'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_353553  VALUES (''353553'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_354507  VALUES (''354507'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_356334  VALUES (''356334'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD ) 
  PARALLEL 8 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_ACCOUNTS ***
 exec bpa.alter_policies('NBUR_DM_ACCOUNTS');


COMMENT ON TABLE BARS.NBUR_DM_ACCOUNTS IS '������� ��� � �����������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.ACC_ID IS 'I������i����� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.ACC_NUM IS '����� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.ACC_NUM_ALT IS '����� ��������������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.ACC_TYPE IS '��� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.BRANCH   IS '��� �i��i�����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.KV            IS '������ �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.OPEN_DATE     IS '���� �i������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.CLOSE_DATE    IS '���� �������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.MATURITY_DATE IS '���� ��������� (maturity date)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.CUST_ID       IS 'I������i����� �����������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.ACC_PID       IS '������������� ��������� ������� (ACCC)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.LIMIT         IS '�i�i� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.PAP           IS '������ �����/�����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.VID           IS '��� ���� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.BLC_CODE_DB   IS '��� ���������� �����  (BLKD)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.BLC_CODE_CR   IS '��� ���������� ������ (BLKK)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.NBS           IS '���������� ������� (R020)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.OB22          IS '��������� ����i���� ������� OB22';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.NBUC          IS 'NBUC';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.B040          IS '��� �������� �������� �����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R011          IS '�������� R011';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R012          IS '��� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R013          IS '�������� R013';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R016          IS '�������� R016';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R030          IS '�������� R030';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R031          IS '�������� R031';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R032          IS '�������� R032';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R033          IS '�������� R033';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.R034          IS '�������� R034';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.S180          IS '�������� S180';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.S181          IS '�������� S181';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.S183          IS '�������� S183';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.S240          IS '�������� S240';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS.S580          IS '������� ������ ����� �� ������� ������';

PROMPT *** Create  constraint CC_DMACCOUNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (KF CONSTRAINT CC_DMACCOUNTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (REPORT_DATE CONSTRAINT CC_DMACCOUNTS_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_ACNTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (ACC_NUM CONSTRAINT CC_DMACCOUNTS_ACNTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (ACC_TYPE CONSTRAINT CC_DMACCOUNTS_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (BRANCH CONSTRAINT CC_DMACCOUNTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_CURRENCY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (KV CONSTRAINT CC_DMACCOUNTS_CURRENCY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_OPENDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (OPEN_DATE CONSTRAINT CC_DMACCOUNTS_OPENDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (CUST_ID CONSTRAINT CC_DMACCOUNTS_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_LIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (LIMIT CONSTRAINT CC_DMACCOUNTS_LIMIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_PAP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (PAP CONSTRAINT CC_DMACCOUNTS_PAP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_VID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (VID CONSTRAINT CC_DMACCOUNTS_VID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_BLCCODEDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (BLC_CODE_DB CONSTRAINT CC_DMACCOUNTS_BLCCODEDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_BLCCODECR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (BLC_CODE_CR CONSTRAINT CC_DMACCOUNTS_BLCCODECR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (NBS CONSTRAINT CC_DMACCOUNTS_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (OB22 CONSTRAINT CC_DMACCOUNTS_OB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_NBUC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (NBUC CONSTRAINT CC_DMACCOUNTS_NBUC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_B040_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (B040 CONSTRAINT CC_DMACCOUNTS_B040_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R011_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R011 CONSTRAINT CC_DMACCOUNTS_R011_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R012_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R012 CONSTRAINT CC_DMACCOUNTS_R012_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R013_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R013 CONSTRAINT CC_DMACCOUNTS_R013_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R016_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R016 CONSTRAINT CC_DMACCOUNTS_R016_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R030_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R030 CONSTRAINT CC_DMACCOUNTS_R030_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R031_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R031 CONSTRAINT CC_DMACCOUNTS_R031_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R032_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R032 CONSTRAINT CC_DMACCOUNTS_R032_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R033_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R033 CONSTRAINT CC_DMACCOUNTS_R033_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_R034_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (R034 CONSTRAINT CC_DMACCOUNTS_R034_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_S180_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (S180 CONSTRAINT CC_DMACCOUNTS_S180_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_S181_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (S181 CONSTRAINT CC_DMACCOUNTS_S181_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_S183_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (S183 CONSTRAINT CC_DMACCOUNTS_S183_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_S240_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (S240 CONSTRAINT CC_DMACCOUNTS_S240_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_S580_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (S580 CONSTRAINT CC_DMACCOUNTS_S580_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTS_ACNTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS MODIFY (ACC_ID CONSTRAINT CC_DMACCOUNTS_ACNTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX UK_DMACCOUNTS ON NBUR_DM_ACCOUNTS ( KF, ACC_ID )
  TABLESPACE BRSMDLI LOCAL COMPRESS 1';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_DMACCOUNTS_NBS_OB22 ***
begin   
 execute immediate '
  CREATE INDEX IDX_DMACCOUNTS_NBS_OB22 ON BARS.NBUR_DM_ACCOUNTS ( KF, NBS, OB22 )
  TABLESPACE BRSBIGI LOCAL COMPRESS 3';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index IDX_DMACCOUNTS_CUSTID_ACNTID ***
begin   
 execute immediate 'CREATE INDEX IDX_DMACCOUNTS_CUSTID_ACNTID ON BARS.NBUR_DM_ACCOUNTS ( KF, CUST_ID, ACC_ID )
  TABLESPACE BRSBIGI LOCAL COMPRESS 1';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  NBUR_DM_ACCOUNTS ***
grant SELECT                                                                 on NBUR_DM_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_DM_ACCOUNTS to DM;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_ACCOUNTS.sql =========*** End 
PROMPT ===================================================================================== 

begin
  NBUR_UTIL.SET_COL('NBUR_DM_ACCOUNTS','ACC_ALT_DT','DATE',Null,'���� �������� �� ����� ���� ������� ����� ��������� ��� �89 �� 11.09.2017');
  NBUR_UTIL.SET_COL('NBUR_DM_ACCOUNTS','OB22_ALT','CHAR(2)');
end;
/
