

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TRANSACTIONS_CNSL.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_TRANSACTIONS_CNSL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_TRANSACTIONS_CNSL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_TRANSACTIONS_CNSL ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL 
   (	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	REF NUMBER(38,0), 
	TT CHAR(3), 
	CCY_ID NUMBER(3,0), 
	BAL NUMBER(24,0), 
	BAL_UAH NUMBER(24,0), 
	CUST_ID_DB NUMBER(38,0), 
	ACC_ID_DB NUMBER(38,0), 
	ACC_NUM_DB VARCHAR2(15), 
	ACC_TYPE_DB CHAR(3), 
	R020_DB CHAR(4), 
	OB22_DB CHAR(2), 
	NBUC_DB VARCHAR2(20), 
	CUST_ID_CR NUMBER(38,0), 
	ACC_ID_CR NUMBER(38,0), 
	ACC_NUM_CR VARCHAR2(15), 
	ACC_TYPE_CR CHAR(3), 
	R020_CR CHAR(4), 
	OB22_CR CHAR(2), 
	NBUC_CR VARCHAR2(20), 
	ADJ_IND NUMBER(1,0)
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC  NOLOGGING 
  TABLESPACE BRSBIGD 
  PARTITION BY LIST (KF) 
 (PARTITION P_300465  VALUES (''300465'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_302076  VALUES (''302076'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_303398  VALUES (''303398'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_304665  VALUES (''304665'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_305482  VALUES (''305482'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_311647  VALUES (''311647'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_312356  VALUES (''312356'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_313957  VALUES (''313957'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_315784  VALUES (''315784'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_322669  VALUES (''322669'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_323475  VALUES (''323475'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_324805  VALUES (''324805'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_325796  VALUES (''325796'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_326461  VALUES (''326461'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_328845  VALUES (''328845'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_331467  VALUES (''331467'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_333368  VALUES (''333368'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_335106  VALUES (''335106'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_336503  VALUES (''336503'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_337568  VALUES (''337568'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_338545  VALUES (''338545'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_351823  VALUES (''351823'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_352457  VALUES (''352457'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_353553  VALUES (''353553'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_354507  VALUES (''354507'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_356334  VALUES (''356334'') SEGMENT CREATION DEFERRED 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC NOLOGGING 
  TABLESPACE BRSBIGD ) 
  PARALLEL 16 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_TRANSACTIONS_CNSL ***
 exec bpa.alter_policies('NBUR_DM_TRANSACTIONS_CNSL');


COMMENT ON TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL IS 'Financial transactions (consolidated data for the period)';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.REPORT_DATE IS 'Calculation date';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.KF IS 'Bank code';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.REF IS 'Document identifier';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.TT IS 'Transaction type code';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.CCY_ID IS 'Currency identifier';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.BAL IS 'Transaction amount';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.BAL_UAH IS 'Transaction amount in UAH';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.CUST_ID_DB IS 'Customer identifier Debit side transaction (sender)';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.ACC_ID_DB IS 'Account identifier Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.ACC_NUM_DB IS 'Account number Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.ACC_TYPE_DB IS 'Account type code  Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.R020_DB IS 'Account code Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.OB22_DB IS 'Account code Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.NBUC_DB IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.CUST_ID_CR IS 'Customer identifier Credit side transaction (receiver)';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.ACC_ID_CR IS 'Account identifier Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.ACC_NUM_CR IS 'Account number Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.ACC_TYPE_CR IS 'Account type code Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.R020_CR IS 'Account parameter Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.OB22_CR IS 'Account parameter Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.NBUC_CR IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS_CNSL.ADJ_IND IS 'Adjustment Indicator';




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (REPORT_DATE CONSTRAINT CC_DMTRANSCTNCNSL_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (KF CONSTRAINT CC_DMTRANSCTNCNSL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (REF CONSTRAINT CC_DMTRANSCTNCNSL_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (TT CONSTRAINT CC_DMTRANSCTNCNSL_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_CCYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (CCY_ID CONSTRAINT CC_DMTRANSCTNCNSL_CCYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_BAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (BAL CONSTRAINT CC_DMTRANSCTNCNSL_BAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_BALUAH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (BAL_UAH CONSTRAINT CC_DMTRANSCTNCNSL_BALUAH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_CUSTIDDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (CUST_ID_DB CONSTRAINT CC_DMTRANSCTNCNSL_CUSTIDDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_ACCIDDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (ACC_ID_DB CONSTRAINT CC_DMTRANSCTNCNSL_ACCIDDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_ACCNUMDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (ACC_NUM_DB CONSTRAINT CC_DMTRANSCTNCNSL_ACCNUMDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_CUSTIDCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (CUST_ID_CR CONSTRAINT CC_DMTRANSCTNCNSL_CUSTIDCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_ACCIDCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (ACC_ID_CR CONSTRAINT CC_DMTRANSCTNCNSL_ACCIDCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSCTNCNSL_ACCNUMCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS_CNSL MODIFY (ACC_NUM_CR CONSTRAINT CC_DMTRANSCTNCNSL_ACCNUMCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DMTRANSCTNCNSL_KF_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_KF_REF ON BARS.NBUR_DM_TRANSACTIONS_CNSL (KF, REF) 
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




PROMPT *** Create  index IDX_DMTRANSCTNCNSL_DEBIT_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_DEBIT_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL (KF, ACC_NUM_DB, CCY_ID) 
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




PROMPT *** Create  index IDX_DMTRANSCTNCNSL_CREDIT_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_CREDIT_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL (KF, ACC_NUM_CR, CCY_ID) 
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




PROMPT *** Create  index IDX_DMTRANSCTNCNSL_DB_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_DB_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL (KF, CCY_ID, R020_DB, OB22_DB) 
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
  TABLESPACE BRSBIGI ) COMPRESS 3 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DMTRANSCTNCNSL_CR_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSCTNCNSL_CR_SIDE ON BARS.NBUR_DM_TRANSACTIONS_CNSL (KF, CCY_ID, R020_CR, OB22_CR) 
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
  TABLESPACE BRSBIGI ) COMPRESS 3 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_TRANSACTIONS_CNSL ***
grant SELECT                                                                 on NBUR_DM_TRANSACTIONS_CNSL to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DM_TRANSACTIONS_CNSL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TRANSACTIONS_CNSL.sql ========
PROMPT ===================================================================================== 
