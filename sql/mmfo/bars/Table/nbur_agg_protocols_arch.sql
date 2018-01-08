

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_AGG_PROTOCOLS_ARCH.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_AGG_PROTOCOLS_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_AGG_PROTOCOLS_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_AGG_PROTOCOLS_ARCH'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_AGG_PROTOCOLS_ARCH'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_AGG_PROTOCOLS_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH 
   (	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	VERSION_ID NUMBER(38,0), 
	REPORT_CODE CHAR(3), 
	NBUC VARCHAR2(20), 
	FIELD_CODE VARCHAR2(35), 
	FIELD_VALUE VARCHAR2(256), 
	ERROR_MSG VARCHAR2(1000), 
	ADJ_IND NUMBER(1,0) DEFAULT 0
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
  PARALLEL 8 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_AGG_PROTOCOLS_ARCH ***
 exec bpa.alter_policies('NBUR_AGG_PROTOCOLS_ARCH');


COMMENT ON TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH IS 'Сформованi показники файлiв звiтностi';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.VERSION_ID IS '';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.REPORT_CODE IS 'Код звіту';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.NBUC IS 'Код розрізу даних у звітному файлі (Code section data)';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.FIELD_CODE IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.FIELD_VALUE IS 'Значення показника';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.ERROR_MSG IS 'Текст помилки';
COMMENT ON COLUMN BARS.NBUR_AGG_PROTOCOLS_ARCH.ADJ_IND IS 'Ознака ручного корегування значення показника';




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (REPORT_DATE CONSTRAINT CC_AGGPROTOCOLARCH_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (KF CONSTRAINT CC_AGGPROTOCOLARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_VERSION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (VERSION_ID CONSTRAINT CC_AGGPROTOCOLARCH_VERSION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_REPORTCD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (REPORT_CODE CONSTRAINT CC_AGGPROTOCOLARCH_REPORTCD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_NBUC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (NBUC CONSTRAINT CC_AGGPROTOCOLARCH_NBUC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_FIELDCD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (FIELD_CODE CONSTRAINT CC_AGGPROTOCOLARCH_FIELDCD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_FIELDVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (FIELD_VALUE CONSTRAINT CC_AGGPROTOCOLARCH_FIELDVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_ADJIND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH MODIFY (ADJ_IND CONSTRAINT CC_AGGPROTOCOLARCH_ADJIND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGGPROTOCOLARCH_ADJIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_AGG_PROTOCOLS_ARCH ADD CONSTRAINT CC_AGGPROTOCOLARCH_ADJIND CHECK ( ADJ_IND in (0,1) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_AGGPROTOCOLARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_AGGPROTOCOLARCH ON BARS.NBUR_AGG_PROTOCOLS_ARCH (REPORT_DATE, KF, VERSION_ID, REPORT_CODE, NBUC, FIELD_CODE) 
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
  TABLESPACE BRSBIGI ) ) COMPRESS 5 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_AGG_PROTOCOLS_ARCH ***
grant SELECT                                                                 on NBUR_AGG_PROTOCOLS_ARCH to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_AGG_PROTOCOLS_ARCH to BARSUPL;
grant SELECT                                                                 on NBUR_AGG_PROTOCOLS_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_AGG_PROTOCOLS_ARCH to BARS_DM;
grant SELECT                                                                 on NBUR_AGG_PROTOCOLS_ARCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_AGG_PROTOCOLS_ARCH.sql =========*
PROMPT ===================================================================================== 
