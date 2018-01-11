

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_BALANCES_MONTHLY.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_BALANCES_MONTHLY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_BALANCES_MONTHLY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_BALANCES_MONTHLY ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_BALANCES_MONTHLY 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
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
  PARTITION BY LIST (KF) 
 (PARTITION P_300465  VALUES (''300465'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_302076  VALUES (''302076'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_303398  VALUES (''303398'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_304665  VALUES (''304665'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_305482  VALUES (''305482'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_311647  VALUES (''311647'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_312356  VALUES (''312356'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_313957  VALUES (''313957'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_315784  VALUES (''315784'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_322669  VALUES (''322669'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_323475  VALUES (''323475'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_324805  VALUES (''324805'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_325796  VALUES (''325796'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_326461  VALUES (''326461'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_328845  VALUES (''328845'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_331467  VALUES (''331467'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_333368  VALUES (''333368'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_335106  VALUES (''335106'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_336503  VALUES (''336503'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_337568  VALUES (''337568'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_338545  VALUES (''338545'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_351823  VALUES (''351823'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_352457  VALUES (''352457'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_353553  VALUES (''353553'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_354507  VALUES (''354507'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_356334  VALUES (''356334'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING 
  TABLESPACE BRSBIGD ) 
  PARALLEL ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_BALANCES_MONTHLY ***
 exec bpa.alter_policies('NBUR_DM_BALANCES_MONTHLY');


COMMENT ON TABLE BARS.NBUR_DM_BALANCES_MONTHLY IS '�������� ������ ������� �� �� ����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.ACC_ID IS 'I������i����� �������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CUST_ID IS 'I������i����� �����������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.DOS IS '������ �����, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.KOS IS '������ ������, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.OST IS '���i���� �������, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.DOSQ IS '������ �����, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.KOSQ IS '������ ������, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.OSTQ IS '���i���� �������, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CRDOS IS '��������� ������� �����, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CRKOS IS '��������� ������� ������, ���i���';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CRDOSQ IS '��������� ������� �����, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CRKOSQ IS '��������� ������� ������, ���i������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CUDOS IS '��������� ������� ������������ ���i��� ����� (���i���)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CUKOS IS '��������� ������� ������������ ���i��� ������ (���i���)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CUDOSQ IS '��������� ������� ������������ ���i��� �����  (��������� ���i������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.CUKOSQ IS '��������� ������� ������������ ���i��� ������ (��������� ���i������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.ADJ_BAL IS '���i���� ������� � ����������� �����. ������� (������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_MONTHLY.ADJ_BAL_UAH IS '���i���� ������� � ����������� �����. ������� (��������� ���i������)';




PROMPT *** Create  constraint CC_DMBALANCESMONTH_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY MODIFY (REPORT_DATE CONSTRAINT CC_DMBALANCESMONTH_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESMONTH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY MODIFY (KF CONSTRAINT CC_DMBALANCESMONTH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESMONTH_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY MODIFY (ACC_ID CONSTRAINT CC_DMBALANCESMONTH_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESMONTH_CUSTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY MODIFY (CUST_ID CONSTRAINT CC_DMBALANCESMONTH_CUSTID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESMONTH_ADJBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY MODIFY (ADJ_BAL CONSTRAINT CC_DMBALANCESMONTH_ADJBAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESMONTH_ADJBALUAH ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_MONTHLY MODIFY (ADJ_BAL_UAH CONSTRAINT CC_DMBALANCESMONTH_ADJBALUAH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMBALANCESMONTH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMBALANCESMONTH ON BARS.NBUR_DM_BALANCES_MONTHLY (KF, ACC_ID) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P_300465 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_302076 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_303398 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_304665 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_305482 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_311647 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_312356 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_313957 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_315784 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_322669 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_323475 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_324805 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_325796 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_326461 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_328845 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_331467 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_333368 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_335106 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_336503 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_337568 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_338545 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_351823 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_352457 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_353553 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_354507 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_356334 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_BALANCES_MONTHLY ***
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY to BARS_DM;
grant SELECT                                                                 on NBUR_DM_BALANCES_MONTHLY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_BALANCES_MONTHLY.sql =========
PROMPT ===================================================================================== 
