

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TRANSACTIONS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_TRANSACTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_TRANSACTIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_TRANSACTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_TRANSACTIONS 
   (	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	REF NUMBER(38,0), 
	SOS NUMBER(1,0), 
	STMT NUMBER(38,0), 
	TT CHAR(3), 
	TXT VARCHAR2(70), 
	KV NUMBER(3,0), 
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
	NBUC_CR VARCHAR2(20)
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
 PARTITION P_304665  VALUES (''304665'') SEGMENT CREATION IMMEDIATE 
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
 PARTITION P_322669  VALUES (''322669'') SEGMENT CREATION IMMEDIATE 
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
 PARTITION P_335106  VALUES (''335106'') SEGMENT CREATION IMMEDIATE 
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
 PARTITION P_351823  VALUES (''351823'') SEGMENT CREATION IMMEDIATE 
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
  TABLESPACE BRSBIGD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_TRANSACTIONS ***
 exec bpa.alter_policies('NBUR_DM_TRANSACTIONS');


COMMENT ON TABLE BARS.NBUR_DM_TRANSACTIONS IS 'Financial transactions (opldok)';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.REPORT_DATE IS 'Calculation date';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.KF IS 'Bank code';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.REF IS 'Document identifier';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.SOS IS 'Transaction state';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.STMT IS 'Transaction identifier';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.TT IS 'Transaction type code';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.TXT IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.KV IS 'Currency identifier';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.BAL IS 'Transaction amount';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.BAL_UAH IS 'Transaction amount in UAH';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.CUST_ID_DB IS 'Customer identifier Debit side transaction (sender)';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.ACC_ID_DB IS 'Account identifier Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.ACC_NUM_DB IS 'Account number Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.ACC_TYPE_DB IS 'Account type code  Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.R020_DB IS 'Account code Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.OB22_DB IS 'Account code Debit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.NBUC_DB IS '';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.CUST_ID_CR IS 'Customer identifier Credit side transaction (receiver)';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.ACC_ID_CR IS 'Account identifier Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.ACC_NUM_CR IS 'Account number Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.ACC_TYPE_CR IS 'Account type code Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.R020_CR IS 'Account parameter Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.OB22_CR IS 'Account parameter Credit side transaction';
COMMENT ON COLUMN BARS.NBUR_DM_TRANSACTIONS.NBUC_CR IS '';




PROMPT *** Create  constraint CC_DMTRANSACTIONS_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (REPORT_DATE CONSTRAINT CC_DMTRANSACTIONS_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (KF CONSTRAINT CC_DMTRANSACTIONS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (REF CONSTRAINT CC_DMTRANSACTIONS_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (SOS CONSTRAINT CC_DMTRANSACTIONS_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_STMT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (STMT CONSTRAINT CC_DMTRANSACTIONS_STMT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (TT CONSTRAINT CC_DMTRANSACTIONS_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (KV CONSTRAINT CC_DMTRANSACTIONS_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_BAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (BAL CONSTRAINT CC_DMTRANSACTIONS_BAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_BALUAH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (BAL_UAH CONSTRAINT CC_DMTRANSACTIONS_BALUAH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_CUSTIDDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (CUST_ID_DB CONSTRAINT CC_DMTRANSACTIONS_CUSTIDDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_ACCIDDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (ACC_ID_DB CONSTRAINT CC_DMTRANSACTIONS_ACCIDDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_ACCNUMDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (ACC_NUM_DB CONSTRAINT CC_DMTRANSACTIONS_ACCNUMDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_NBUCDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (NBUC_DB CONSTRAINT CC_DMTRANSACTIONS_NBUCDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_CUSTIDCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (CUST_ID_CR CONSTRAINT CC_DMTRANSACTIONS_CUSTIDCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_ACCIDCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (ACC_ID_CR CONSTRAINT CC_DMTRANSACTIONS_ACCIDCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_ACCNUMCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (ACC_NUM_CR CONSTRAINT CC_DMTRANSACTIONS_ACCNUMCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTRANSACTIONS_NBUCCR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TRANSACTIONS MODIFY (NBUC_CR CONSTRAINT CC_DMTRANSACTIONS_NBUCCR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMTRANSACTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMTRANSACTIONS ON BARS.NBUR_DM_TRANSACTIONS (KF, REF, STMT) 
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




PROMPT *** Create  index IDX_DMTRANSACTIONS_DEBIT_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSACTIONS_DEBIT_SIDE ON BARS.NBUR_DM_TRANSACTIONS (KF, ACC_NUM_DB, KV) 
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




PROMPT *** Create  index IDX_DMTRANSACTIONS_CREDIT_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSACTIONS_CREDIT_SIDE ON BARS.NBUR_DM_TRANSACTIONS (KF, ACC_NUM_CR, KV) 
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




PROMPT *** Create  index IDX_DMTRANSACTIONS_DB_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSACTIONS_DB_SIDE ON BARS.NBUR_DM_TRANSACTIONS (KF, KV, R020_DB, OB22_DB) 
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
  TABLESPACE BRSBIGI ) COMPRESS 4 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DMTRANSACTIONS_CR_SIDE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DMTRANSACTIONS_CR_SIDE ON BARS.NBUR_DM_TRANSACTIONS (KF, KV, R020_CR, OB22_CR) 
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
  TABLESPACE BRSBIGI ) COMPRESS 4 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_TRANSACTIONS ***
grant SELECT                                                                 on NBUR_DM_TRANSACTIONS to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DM_TRANSACTIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TRANSACTIONS.sql =========*** 
PROMPT ===================================================================================== 