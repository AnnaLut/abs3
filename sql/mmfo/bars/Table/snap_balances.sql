

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SNAP_BALANCES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SNAP_BALANCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SNAP_BALANCES'', ''CENTER'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SNAP_BALANCES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''SNAP_BALANCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SNAP_BALANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SNAP_BALANCES 
   (	FDAT DATE, 
	KF VARCHAR2(6), 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CALDT_ID NUMBER(38,0) GENERATED ALWAYS AS (TO_NUMBER(TO_CHAR(FDAT,''j''))-2447892) VIRTUAL VISIBLE 
   ) PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC 
  TABLESPACE BRSACCM 
  PARTITION BY RANGE (FDAT) INTERVAL (NUMTODSINTERVAL(1,''DAY'')) 
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
  TABLESPACE BRSACCM 
 COMPRESS BASIC ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SNAP_BALANCES ***
 exec bpa.alter_policies('SNAP_BALANCES');


COMMENT ON TABLE BARS.SNAP_BALANCES IS 'Знімок балансу за день';
COMMENT ON COLUMN BARS.SNAP_BALANCES.FDAT IS 'Дата балансу';
COMMENT ON COLUMN BARS.SNAP_BALANCES.KF IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.SNAP_BALANCES.ACC IS 'Ід. рахунка';
COMMENT ON COLUMN BARS.SNAP_BALANCES.RNK IS 'Ід. клієнта';
COMMENT ON COLUMN BARS.SNAP_BALANCES.OST IS 'Вихідний залишок по рахунку (номінал)';
COMMENT ON COLUMN BARS.SNAP_BALANCES.DOS IS 'Сума дебетових оборотів (номінал)';
COMMENT ON COLUMN BARS.SNAP_BALANCES.KOS IS 'Сума кредитових оборотів (номінал)';
COMMENT ON COLUMN BARS.SNAP_BALANCES.OSTQ IS 'Вихідний залишок по рахунку (еквівалент)';
COMMENT ON COLUMN BARS.SNAP_BALANCES.DOSQ IS 'Сума дебетових оборотів (еквівалент)';
COMMENT ON COLUMN BARS.SNAP_BALANCES.KOSQ IS 'Сума кредитових оборотів (еквівалент)';
COMMENT ON COLUMN BARS.SNAP_BALANCES.CALDT_ID IS 'Ід. дати балансу';




PROMPT *** Create  constraint CC_SNAP_BALANCES_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (OSTQ CONSTRAINT CC_SNAP_BALANCES_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (DOSQ CONSTRAINT CC_SNAP_BALANCES_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (KOSQ CONSTRAINT CC_SNAP_BALANCES_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (FDAT CONSTRAINT CC_SNAP_BALANCES_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (KF CONSTRAINT CC_SNAP_BALANCES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (ACC CONSTRAINT CC_SNAP_BALANCES_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (RNK CONSTRAINT CC_SNAP_BALANCES_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (OST CONSTRAINT CC_SNAP_BALANCES_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (DOS CONSTRAINT CC_SNAP_BALANCES_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SNAP_BALANCES_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES MODIFY (KOS CONSTRAINT CC_SNAP_BALANCES_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SNAP_BALANCES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SNAP_BALANCES ON BARS.SNAP_BALANCES (FDAT, KF, ACC) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM  LOCAL
 (PARTITION P_MINVALUE 
PCTFREE 0 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSACCM 
 ( SUBPARTITION P_MINVALUE_SP_300465 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_302076 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_303398 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_304665 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_305482 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_311647 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_312356 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_313957 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_315784 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_322669 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_323475 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_324805 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_325796 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_326461 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_328845 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_331467 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_333368 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_335106 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_336503 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_337568 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_338545 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_351823 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_352457 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_353553 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_354507 
  TABLESPACE BRSACCM , 
  SUBPARTITION P_MINVALUE_SP_356334 
  TABLESPACE BRSACCM ) ) COMPRESS 2 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SNAP_BALANCES ***
grant SELECT                                                                 on SNAP_BALANCES   to BARSREADER_ROLE;
grant SELECT                                                                 on SNAP_BALANCES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SNAP_BALANCES   to BARS_DM;
grant ALTER,SELECT                                                           on SNAP_BALANCES   to DM;
grant SELECT                                                                 on SNAP_BALANCES   to START1;
grant SELECT                                                                 on SNAP_BALANCES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SNAP_BALANCES.sql =========*** End ***
PROMPT ===================================================================================== 
