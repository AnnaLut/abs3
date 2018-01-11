

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_BALANCES_MONTHLY_ARCH.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_BALANCES_MONTHLY_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_BALANCES_MONTHLY_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_BALANCES_MONTHLY_ARCH'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_DM_BALANCES_MONTHLY_ARCH'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_BALANCES_MONTHLY_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	VERSION_ID NUMBER(38,0), 
	ACC_ID NUMBER(38,0), 
	CUST_ID NUMBER(38,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OST NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	CRDOS NUMBER(24,0), 
	CRKOS NUMBER(24,0), 
	CRDOSQ NUMBER(24,0), 
	CRKOSQ NUMBER(24,0), 
	CUDOS NUMBER(24,0), 
	CUKOS NUMBER(24,0), 
	CUDOSQ NUMBER(24,0), 
	CUKOSQ NUMBER(24,0), 
	ADJ_BAL NUMBER(24,0), 
	ADJ_BAL_UAH NUMBER(24,0)
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC 
  TABLESPACE BRSBIGD 
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
  TABLESPACE BRSBIGD 
 COMPRESS BASIC ) 
  PARALLEL ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_BALANCES_MONTHLY_ARCH ***
 exec bpa.alter_policies('NBUR_DM_BALANCES_MONTHLY_ARCH');


COMMENT ON TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH IS '�������� ������ ������� �� �� ����� ����  (����� �����)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.VERSION_ID IS 'I������i����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.ACC_ID IS 'I������i����� �������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CUST_ID IS 'I������i����� �����������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.DOS IS '������ �����, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.KOS IS '������ ������, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.OST IS '���i���� �������, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.DOSQ IS '������ �����, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.KOSQ IS '������ ������, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.OSTQ IS '���i���� �������, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CRDOS IS '��������� ������� �����, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CRKOS IS '��������� ������� ������, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CRDOSQ IS '��������� ������� �����, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CRKOSQ IS '��������� ������� ������, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CUDOS IS '��������� ������� ������������ ���i��� ����� (���i���)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CUKOS IS '��������� ������� ������������ ���i��� ������ (���i���)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CUDOSQ IS '��������� ������� ������������ ���i��� �����  (��������� ���i������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.CUKOSQ IS '��������� ������� ������������ ���i��� ������ (��������� ���i������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.ADJ_BAL IS '���i���� ������� � ����������� �����. ������� (������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY_ARCH.ADJ_BAL_UAH IS '���i���� ������� � ����������� �����. ������� (��������� ���i������)';




PROMPT *** Create  constraint CC_DMBALSMONTHARCH_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH MODIFY (REPORT_DATE CONSTRAINT CC_DMBALSMONTHARCH_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALSMONTHARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH MODIFY (KF CONSTRAINT CC_DMBALSMONTHARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALSMONTHARCH_VERSION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH MODIFY (VERSION_ID CONSTRAINT CC_DMBALSMONTHARCH_VERSION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALSMONTHARCH_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH MODIFY (ACC_ID CONSTRAINT CC_DMBALSMONTHARCH_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALSMONTHARCH_CUSTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH MODIFY (CUST_ID CONSTRAINT CC_DMBALSMONTHARCH_CUSTID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALSMONTHARCH_ADJBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH MODIFY (ADJ_BAL CONSTRAINT CC_DMBALSMONTHARCH_ADJBAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALSMONTHARCH_ADJBALUAH ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY_ARCH MODIFY (ADJ_BAL_UAH CONSTRAINT CC_DMBALSMONTHARCH_ADJBALUAH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMBALSMONTHARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMBALSMONTHARCH ON BARS.NBUR_DM_BALANCES_MONTHLY_ARCH (REPORT_DATE, KF, VERSION_ID, ACC_ID) 
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
  TABLESPACE BRSBIGI ) ) COMPRESS 3 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_BALANCES_MONTHLY_ARCH ***
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY_ARCH to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY_ARCH to BARSUPL;
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY_ARCH to BARS_DM;
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY_ARCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_BALANCES_MONTHLY_ARCH.sql ====
PROMPT ===================================================================================== 
