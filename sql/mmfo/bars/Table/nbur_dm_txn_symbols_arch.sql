

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TXN_SYMBOLS_ARCH.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DM_TXN_SYMBOLS_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DM_TXN_SYMBOLS_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_TXN_SYMBOLS_ARCH'', ''FILIAL'' , ''M'', ''M'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_DM_TXN_SYMBOLS_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DM_TXN_SYMBOLS_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH 
   (	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	VERSION_ID NUMBER(38,0), 
	REF NUMBER(38,0), 
	STMT NUMBER(38,0), 
	SYMB_TP NUMBER(1,0), 
	SYMB_VAL CHAR(2)
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




PROMPT *** ALTER_POLICIES to NBUR_DM_TXN_SYMBOLS_ARCH ***
 exec bpa.alter_policies('NBUR_DM_TXN_SYMBOLS_ARCH');


COMMENT ON TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH IS '�������� �������� (�������) ���������';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ARCH.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ARCH.KF IS '��� ������ (���)';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ARCH.VERSION_ID IS 'I������i����� ����';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ARCH.REF IS '������������� ���������';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ARCH.STMT IS '������������� ����������';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ARCH.SYMB_TP IS '��� ������� (1- �������, 2- ��������������)';
COMMENT ON COLUMN BARS.NBUR_DM_TXN_SYMBOLS_ARCH.SYMB_VAL IS '�������� �������';




PROMPT *** Create  constraint CC_DMTXNSYMBOLSARCH_RPTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH MODIFY (REPORT_DATE CONSTRAINT CC_DMTXNSYMBOLSARCH_RPTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTXNSYMBOLSARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH MODIFY (KF CONSTRAINT CC_DMTXNSYMBOLSARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTXNSYMBOLSARCH_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH MODIFY (SYMB_TP CONSTRAINT CC_DMTXNSYMBOLSARCH_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTXNSYMBOLSARCH_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH MODIFY (REF CONSTRAINT CC_DMTXNSYMBOLSARCH_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTXNSYMBOLSARCH_STMT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH MODIFY (STMT CONSTRAINT CC_DMTXNSYMBOLSARCH_STMT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DMTXNSYMBOLSARCH_VRSN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DM_TXN_SYMBOLS_ARCH MODIFY (VERSION_ID CONSTRAINT CC_DMTXNSYMBOLSARCH_VRSN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DMTXNSYMBOLSARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DMTXNSYMBOLSARCH ON BARS.NBUR_DM_TXN_SYMBOLS_ARCH (REPORT_DATE, KF, VERSION_ID, REF, STMT, SYMB_TP) 
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



PROMPT *** Create  grants  NBUR_DM_TXN_SYMBOLS_ARCH ***
grant SELECT                                                                 on NBUR_DM_TXN_SYMBOLS_ARCH to BARSUPL;
grant SELECT                                                                 on NBUR_DM_TXN_SYMBOLS_ARCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_DM_TXN_SYMBOLS_ARCH to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DM_TXN_SYMBOLS_ARCH.sql =========
PROMPT ===================================================================================== 
