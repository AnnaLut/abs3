

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_PAYMENT_SHD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_PAYMENT_SHD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_PAYMENT_SHD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_PAYMENT_SHD ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_PAYMENT_SHD 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	AGRM_ID NUMBER(38,0), 
	ACC_ID NUMBER(38,0), 
	PYMT_DT DATE, 
	PYMT_AMNT NUMBER(24,0), 
	PYMT_AMNT_UAH NUMBER(24,0), 
	LMT_AMNT NUMBER(24,0), 
	LMT_AMNT_UAH NUMBER(24,0), 
	S240 CHAR(1), 
	DESCRIPTION VARCHAR2(256)
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
  PARALLEL 8 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DM_PAYMENT_SHD ***
 exec bpa.alter_policies('NBUR_DM_PAYMENT_SHD');


COMMENT ON TABLE BARS.NBUR_DM_PAYMENT_SHD IS '��`���� ������� �� ��������';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.KF IS '��� ������ (���)';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.AGRM_ID IS '������������� ��������';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.ACC_ID IS '������������� �������';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.PYMT_DT IS '������� ����';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.PYMT_AMNT IS '���� ������� (������)';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.PYMT_AMNT_UAH IS '���� ������� (���������)';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.LMT_AMNT IS '���� ������ ���� (������)';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.LMT_AMNT_UAH IS '���� ������ ���� (���������)';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.S240 IS '�������� S240';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.DESCRIPTION IS '����';
COMMENT ON COLUMN BARS.NBUR_DM_PAYMENT_SHD.REPORT_DATE IS '����� ����';




PROMPT *** Create  constraint CC_DMPAYMENTSHD_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (REPORT_DATE CONSTRAINT CC_DMPAYMENTSHD_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (KF CONSTRAINT CC_DMPAYMENTSHD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_AGRMID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (AGRM_ID CONSTRAINT CC_DMPAYMENTSHD_AGRMID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (ACC_ID CONSTRAINT CC_DMPAYMENTSHD_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_S240_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (S240 CONSTRAINT CC_DMPAYMENTSHD_S240_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_ASTAMNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (PYMT_AMNT CONSTRAINT CC_DMPAYMENTSHD_ASTAMNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_ASTAMNTUAH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (PYMT_AMNT_UAH CONSTRAINT CC_DMPAYMENTSHD_ASTAMNTUAH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_LMTAMNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (LMT_AMNT CONSTRAINT CC_DMPAYMENTSHD_LMTAMNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_LMTAMNTUAH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (LMT_AMNT_UAH CONSTRAINT CC_DMPAYMENTSHD_LMTAMNTUAH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMPAYMENTSHD_PYMTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_PAYMENT_SHD MODIFY (PYMT_DT CONSTRAINT CC_DMPAYMENTSHD_PYMTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMPAYMENTSHD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMPAYMENTSHD ON BARS.NBUR_DM_PAYMENT_SHD (KF, AGRM_ID, ACC_ID, PYMT_DT) 
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



PROMPT *** Create  grants  NBUR_DM_PAYMENT_SHD ***
grant SELECT                                                                 on NBUR_DM_PAYMENT_SHD to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_PAYMENT_SHD.sql =========*** E
PROMPT ===================================================================================== 
