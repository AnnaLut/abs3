

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_ACCOUNTS_ARCH.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_ACCOUNTS_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_ACCOUNTS_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_ACCOUNTS_ARCH'', ''FILIAL'' , ''M'', ''M'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_ACCOUNTS_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_ACCOUNTS_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_ACCOUNTS_ARCH 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	VERSION_ID NUMBER(38,0), 
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
	LIMIT NUMBER(24,0), 
	PAP NUMBER(1,0), 
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
	S580 CHAR(1), 
	ACC_PID NUMBER(38,0), 
	VID NUMBER(2,0), 
	BLC_CODE_DB NUMBER(3,0), 
	BLC_CODE_CR NUMBER(3,0)
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC 
  TABLESPACE BRSMDLD 
  PARTITION BY RANGE (REPORT_DATE) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
  SUBPARTITION BY LIST (KF) 
  SUBPARTITION TEMPLATE ( 
    SUBPARTITION SP_300465 VALUES ( ''300465'' ), 
    SUBPARTITION SP_302076 VALUES ( ''302076'' ), 
    SUBPARTITION SP_303398 VALUES ( ''303398'' ), 
    SUBPARTITION SP_304665 VALUES ( ''304665'' ), 
    SUBPARTITION SP_305482 VALUES ( ''305482'' ), 
    SUBPARTITION SP_311647 VALUES ( ''311647'' ), 
    SUBPARTITION SP_312356 VALUES ( ''312356'' ), 
    SUBPARTITION SP_313957 VALUES ( ''313957'' ), 
    SUBPARTITION SP_315784 VALUES ( ''315784'' ), 
    SUBPARTITION SP_322669 VALUES ( ''322669'' ), 
    SUBPARTITION SP_323475 VALUES ( ''323475'' ), 
    SUBPARTITION SP_324805 VALUES ( ''324805'' ), 
    SUBPARTITION SP_325796 VALUES ( ''325796'' ), 
    SUBPARTITION SP_326461 VALUES ( ''326461'' ), 
    SUBPARTITION SP_328845 VALUES ( ''328845'' ), 
    SUBPARTITION SP_331467 VALUES ( ''331467'' ), 
    SUBPARTITION SP_333368 VALUES ( ''333368'' ), 
    SUBPARTITION SP_335106 VALUES ( ''335106'' ), 
    SUBPARTITION SP_336503 VALUES ( ''336503'' ), 
    SUBPARTITION SP_337568 VALUES ( ''337568'' ), 
    SUBPARTITION SP_338545 VALUES ( ''338545'' ), 
    SUBPARTITION SP_351823 VALUES ( ''351823'' ), 
    SUBPARTITION SP_352457 VALUES ( ''352457'' ), 
    SUBPARTITION SP_353553 VALUES ( ''353553'' ), 
    SUBPARTITION SP_354507 VALUES ( ''354507'' ), 
    SUBPARTITION SP_356334 VALUES ( ''356334'' ) ) 
 (PARTITION P_MINVALUE  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) 
PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD 
 COMPRESS BASIC ) 
  PARALLEL ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_ACCOUNTS_ARCH ***
 exec bpa.alter_policies('NBUR_DM_ACCOUNTS_ARCH');


COMMENT ON TABLE BARS.NBUR_DM_ACCOUNTS_ARCH IS '³����� ������i� ��� � ����������� (����� �����)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.VID IS '��� ���� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.BLC_CODE_DB IS '��� ���������� �����  (BLKD)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.BLC_CODE_CR IS '��� ���������� ������ (BLKK)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.ACC_PID IS '������������� ��������� ������� (ACCC)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R011 IS '�������� R011';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R012 IS '��� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R013 IS '�������� R013';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R016 IS '�������� R016';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R030 IS '';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R031 IS '�������� R031';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R032 IS '�������� R032';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R033 IS '�������� R033';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.R034 IS '�������� R034';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.S180 IS '�������� S180';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.S181 IS '�������� S181';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.S183 IS '�������� S183';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.S240 IS '�������� S240';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.S580 IS '������� ������ ����� �� ������� ������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.VERSION_ID IS 'I������i����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.ACC_ID IS 'I������i����� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.ACC_NUM IS '����� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.ACC_NUM_ALT IS '����� ��������������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.ACC_TYPE IS '��� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.BRANCH IS '��� �i��i�����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.KV IS '������ �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.OPEN_DATE IS '���� �i������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.CLOSE_DATE IS '���� �������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.MATURITY_DATE IS '���� ��������� (maturity date)';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.CUST_ID IS 'I������i����� �����������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.LIMIT IS '�i�i� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.PAP IS '������ �����/�����';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.NBS IS '���������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.OB22 IS '��������� ����i���� ������� OB22';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.NBUC IS 'NBUC';
COMMENT ON COLUMN BARS.NBUR_DM_ACCOUNTS_ARCH.B040 IS '��� �������� �������� �����';




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (REPORT_DATE CONSTRAINT CC_DMACCOUNTSARCH_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_S580_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (S580 CONSTRAINT CC_DMACCOUNTSARCH_S580_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_VERSION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (VERSION_ID CONSTRAINT CC_DMACCOUNTSARCH_VERSION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_ACNTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (ACC_ID CONSTRAINT CC_DMACCOUNTSARCH_ACNTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_ACNTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (ACC_NUM CONSTRAINT CC_DMACCOUNTSARCH_ACNTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (ACC_TYPE CONSTRAINT CC_DMACCOUNTSARCH_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (BRANCH CONSTRAINT CC_DMACCOUNTSARCH_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_CYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (KV CONSTRAINT CC_DMACCOUNTSARCH_CYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_OPENDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (OPEN_DATE CONSTRAINT CC_DMACCOUNTSARCH_OPENDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (CUST_ID CONSTRAINT CC_DMACCOUNTSARCH_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_LIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (LIMIT CONSTRAINT CC_DMACCOUNTSARCH_LIMIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_PAP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (PAP CONSTRAINT CC_DMACCOUNTSARCH_PAP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (NBS CONSTRAINT CC_DMACCOUNTSARCH_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (OB22 CONSTRAINT CC_DMACCOUNTSARCH_OB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_NBUC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (NBUC CONSTRAINT CC_DMACCOUNTSARCH_NBUC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_B040_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (B040 CONSTRAINT CC_DMACCOUNTSARCH_B040_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R011_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R011 CONSTRAINT CC_DMACCOUNTSARCH_R011_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R012_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R012 CONSTRAINT CC_DMACCOUNTSARCH_R012_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R013_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R013 CONSTRAINT CC_DMACCOUNTSARCH_R013_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R016_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R016 CONSTRAINT CC_DMACCOUNTSARCH_R016_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R030_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R030 CONSTRAINT CC_DMACCOUNTSARCH_R030_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R031_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R031 CONSTRAINT CC_DMACCOUNTSARCH_R031_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R032_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R032 CONSTRAINT CC_DMACCOUNTSARCH_R032_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R033_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R033 CONSTRAINT CC_DMACCOUNTSARCH_R033_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_R034_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (R034 CONSTRAINT CC_DMACCOUNTSARCH_R034_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_S180_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (S180 CONSTRAINT CC_DMACCOUNTSARCH_S180_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_S181_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (S181 CONSTRAINT CC_DMACCOUNTSARCH_S181_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_S183_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (S183 CONSTRAINT CC_DMACCOUNTSARCH_S183_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_S240_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (S240 CONSTRAINT CC_DMACCOUNTSARCH_S240_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMACCOUNTSARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_ACCOUNTS_ARCH MODIFY (KF CONSTRAINT CC_DMACCOUNTSARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DMACCOUNTSARCH_NBS_OB22 ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMACCOUNTSARCH_NBS_OB22 ON BARS.NBUR_DM_ACCOUNTS_ARCH (REPORT_DATE, KF, VERSION_ID, NBS, OB22) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P_MINVALUE 
PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI 
 ( SUBPARTITION P_MINVALUE_SP_300465 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_302076 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_303398 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_304665 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_305482 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_311647 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_312356 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_313957 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_315784 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_322669 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_323475 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_324805 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_325796 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_326461 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_328845 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_331467 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_333368 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_335106 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_336503 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_337568 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_338545 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_351823 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_352457 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_353553 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_354507 
  TABLESPACE BRSBIGI , 
  SUBPARTITION P_MINVALUE_SP_356334 
  TABLESPACE BRSBIGI ) ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMACCOUNTSARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMACCOUNTSARCH ON BARS.NBUR_DM_ACCOUNTS_ARCH (REPORT_DATE, KF, VERSION_ID, ACC_ID) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLI  LOCAL
 (PARTITION P_MINVALUE 
PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLI 
 ( SUBPARTITION P_MINVALUE_SP_300465 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_302076 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_303398 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_304665 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_305482 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_311647 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_312356 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_313957 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_315784 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_322669 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_323475 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_324805 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_325796 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_326461 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_328845 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_331467 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_333368 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_335106 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_336503 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_337568 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_338545 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_351823 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_352457 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_353553 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_354507 
  TABLESPACE BRSMDLI , 
  SUBPARTITION P_MINVALUE_SP_356334 
  TABLESPACE BRSMDLI ) ) COMPRESS 3 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_ACCOUNTS_ARCH ***
grant SELECT                                                                 on NBUR_DM_ACCOUNTS_ARCH to BARSUPL;
grant SELECT                                                                 on NBUR_DM_ACCOUNTS_ARCH to BARS_ACCESS_DEFROLE;



PROMPT *** Create SYNONYM  to NBUR_DM_ACCOUNTS_ARCH ***

  CREATE OR REPLACE SYNONYM BARS.DM_ACCOUNTS FOR BARS.NBUR_DM_ACCOUNTS_ARCH;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_ACCOUNTS_ARCH.sql =========***
PROMPT ===================================================================================== 
