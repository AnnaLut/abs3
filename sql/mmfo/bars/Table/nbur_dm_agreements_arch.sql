

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_AGREEMENTS_ARCH.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_AGREEMENTS_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_AGREEMENTS_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_AGREEMENTS_ARCH'', ''FILIAL'' , ''M'', ''M'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_AGREEMENTS_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_AGREEMENTS_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_AGREEMENTS_ARCH 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	VERSION_ID NUMBER(3,0), 
	AGRM_ID NUMBER(38,0), 
	AGRM_NUM VARCHAR2(50), 
	AGRM_TP NUMBER(38,0), 
	AGRM_STE NUMBER(2,0), 
	BEG_DT DATE, 
	END_DT DATE, 
	INL_AMNT NUMBER(24,0), 
	CRN_AMNT NUMBER(24,0), 
	DBT_FRQ_TP NUMBER(3,0), 
	DBT_INL_DT DATE, 
	DBT_MAT_DAY NUMBER(2,0), 
	INT_FRQ_TP NUMBER(3,0), 
	INT_INL_DT DATE, 
	INT_MAT_DAY NUMBER(2,0), 
	PRTFL_TP CHAR(3), 
	CCY_ID NUMBER(3,0)
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




PROMPT *** ALTER_POLICIES to NBUR_DM_AGREEMENTS_ARCH ***
 exec bpa.alter_policies('NBUR_DM_AGREEMENTS_ARCH');


COMMENT ON TABLE BARS.NBUR_DM_AGREEMENTS_ARCH IS 'Зв`язок рахунків та договорів';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.KF IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.VERSION_ID IS 'Iдентифiкатор версії';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.AGRM_ID IS 'Ідентифікатор договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.AGRM_NUM IS 'Номер договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.AGRM_TP IS 'Вид договору (CC_VIDD.VIDD)';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.AGRM_STE IS 'Стан договору (CC_SOS.SOS)';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.BEG_DT IS 'Дата початку';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.END_DT IS 'Дата закінчення';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.INL_AMNT IS 'Початкова сума по договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.CRN_AMNT IS 'Поточна сума по договору';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.DBT_FRQ_TP IS 'Періодичність погашення основного боргу';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.DBT_INL_DT IS 'Дата початку погашення основного боргу';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.DBT_MAT_DAY IS 'День погашення основного боргу';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.INT_FRQ_TP IS 'Періодичність погашення відсотків';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.INT_INL_DT IS 'Дата початку погашення відсотків ';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.INT_MAT_DAY IS 'День погашення відсотків';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.PRTFL_TP IS 'Тип портфеля договорів';
COMMENT ON COLUMN BARS.NBUR_DM_AGREEMENTS_ARCH.CCY_ID IS 'Валюта рахунку';




PROMPT *** Create  constraint CC_DMAGRMSARCH_RPTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (REPORT_DATE CONSTRAINT CC_DMAGRMSARCH_RPTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (KF CONSTRAINT CC_DMAGRMSARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_VRSN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (VERSION_ID CONSTRAINT CC_DMAGRMSARCH_VRSN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_AGRMID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (AGRM_ID CONSTRAINT CC_DMAGRMSARCH_AGRMID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_AGRMTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (AGRM_TP CONSTRAINT CC_DMAGRMSARCH_AGRMTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_AGRMSTE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (AGRM_STE CONSTRAINT CC_DMAGRMSARCH_AGRMSTE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_BEGDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (BEG_DT CONSTRAINT CC_DMAGRMSARCH_BEGDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_INLAMNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (INL_AMNT CONSTRAINT CC_DMAGRMSARCH_INLAMNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_CRNAMNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (CRN_AMNT CONSTRAINT CC_DMAGRMSARCH_CRNAMNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_DBTFRQTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (DBT_FRQ_TP CONSTRAINT CC_DMAGRMSARCH_DBTFRQTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_DBTINLDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (DBT_INL_DT CONSTRAINT CC_DMAGRMSARCH_DBTINLDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_INTFRQTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (INT_FRQ_TP CONSTRAINT CC_DMAGRMSARCH_INTFRQTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_INTINLDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (INT_INL_DT CONSTRAINT CC_DMAGRMSARCH_INTINLDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_INTMATDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (INT_MAT_DAY CONSTRAINT CC_DMAGRMSARCH_INTMATDAY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_PRTFLTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (PRTFL_TP CONSTRAINT CC_DMAGRMSARCH_PRTFLTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMAGRMSARCH_CCYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_AGREEMENTS_ARCH MODIFY (CCY_ID CONSTRAINT CC_DMAGRMSARCH_CCYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMAGRMSARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMAGRMSARCH ON BARS.NBUR_DM_AGREEMENTS_ARCH (REPORT_DATE, KF, VERSION_ID, AGRM_ID) 
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
  TABLESPACE BRSMDLI ) ) COMPRESS 1 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DM_AGREEMENTS_ARCH ***
grant SELECT                                                                 on NBUR_DM_AGREEMENTS_ARCH to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DM_AGREEMENTS_ARCH to BARSUPL;
grant SELECT                                                                 on NBUR_DM_AGREEMENTS_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_DM_AGREEMENTS_ARCH to BARS_DM;
grant SELECT                                                                 on NBUR_DM_AGREEMENTS_ARCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_AGREEMENTS_ARCH.sql =========*
PROMPT ===================================================================================== 
