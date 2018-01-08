

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_BALANCES_CLT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_BALANCES_CLT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_BALANCES_CLT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_BALANCES_CLT ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_BALANCES_CLT 
   (	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	CLT_ACC_ID NUMBER(38,0), 
	CLT_BAL NUMBER(24,0), 
	CLT_BAL_UAH NUMBER(24,0), 
	CLT_CUST_ID NUMBER(38,0), 
	AST_ACC_ID NUMBER(38,0), 
	AST_BAL NUMBER(24,0), 
	AST_BAL_UAH NUMBER(24,0), 
	AST_CUST_ID NUMBER(38,0), 
	TOT_AST_BAL_UAH NUMBER(24,0), 
	TOT_CLT_BAL_UAH NUMBER(24,0), 
	CLT_AMNT NUMBER(24,0), 
	CLT_AMNT_UAH NUMBER(24,0), 
	AST_AMNT NUMBER(24,0), 
	AST_AMNT_UAH NUMBER(24,0)
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC  NOLOGGING 
  TABLESPACE BRSMDLD 
  PARTITION BY LIST (KF) 
 (PARTITION P_300465  VALUES (''300465'') SEGMENT CREATION DEFERRED 
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
 PARTITION P_322669  VALUES (''322669'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_323475  VALUES (''323475'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSMDLD , 
 PARTITION P_324805  VALUES (''324805'') SEGMENT CREATION DEFERRED 
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
  PARALLEL ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_BALANCES_CLT ***
 exec bpa.alter_policies('NBUR_DM_BALANCES_CLT');


COMMENT ON TABLE BARS.NBUR_DM_BALANCES_CLT IS '���� ������������ � ����� ������� ������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.KF IS '��� ������ (���)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.CLT_ACC_ID IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.CLT_BAL IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.CLT_BAL_UAH IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.CLT_CUST_ID IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.AST_ACC_ID IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.AST_BAL IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.AST_BAL_UAH IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.AST_CUST_ID IS '';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.TOT_AST_BAL_UAH IS '�������� ���� ������� (���������) �� ���. ������       ��� ���. ������������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.TOT_CLT_BAL_UAH IS '�������� ���� ������� (���������) �� ���. ������������ ��� ���. ������';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.CLT_AMNT IS '���� ������������, �� ������� ���. ������ (����������� �� ��� ������, �� ������������ ��� �������������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.CLT_AMNT_UAH IS '���� ������������, �� ������� ���. ������ (����������� �� ��� ������, �� ������������ ��� �������������)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.AST_AMNT IS '���� ������, �� ����������� ���. ������������ (����������� �� ������ ������������, �� ������� ��� �����)';
COMMENT ON COLUMN BARS.NBUR_DM_BALANCES_CLT.AST_AMNT_UAH IS '���� ������, �� ����������� ���. ������������ (����������� �� ������ ������������, �� ������� ��� �����)';




PROMPT *** Create  constraint CC_DMBALANCESCLT_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_CLT MODIFY (REPORT_DATE CONSTRAINT CC_DMBALANCESCLT_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESCLT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_CLT MODIFY (KF CONSTRAINT CC_DMBALANCESCLT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESCLT_ASTCUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_CLT MODIFY (AST_CUST_ID CONSTRAINT CC_DMBALANCESCLT_ASTCUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESCLT_CLTCUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_CLT MODIFY (CLT_CUST_ID CONSTRAINT CC_DMBALANCESCLT_CLTCUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESCLT_ASTACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_CLT MODIFY (AST_ACC_ID CONSTRAINT CC_DMBALANCESCLT_ASTACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMBALANCESCLT_CLTACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_BALANCES_CLT MODIFY (CLT_ACC_ID CONSTRAINT CC_DMBALANCESCLT_CLTACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMBALANCESCLT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMBALANCESCLT ON BARS.NBUR_DM_BALANCES_CLT (KF, CLT_ACC_ID, AST_ACC_ID) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSMDLI  LOCAL
 (PARTITION P_300465 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_302076 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_303398 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_304665 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_305482 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_311647 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_312356 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_313957 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_315784 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_322669 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_323475 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_324805 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_325796 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_326461 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_328845 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_331467 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_333368 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_335106 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_336503 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_337568 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_338545 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_351823 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_352457 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_353553 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_354507 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI , 
 PARTITION P_356334 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSMDLI ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_BALANCES_CLT ***
grant SELECT                                                                 on NBUR_DM_BALANCES_CLT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_BALANCES_CLT.sql =========*** 
PROMPT ===================================================================================== 
