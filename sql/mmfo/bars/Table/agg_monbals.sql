

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AGG_MONBALS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AGG_MONBALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AGG_MONBALS'', ''CENTER'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''AGG_MONBALS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''AGG_MONBALS'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AGG_MONBALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.AGG_MONBALS 
   (	FDAT DATE, 
	KF VARCHAR2(6), 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOS NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOS NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CRDOS NUMBER(24,0), 
	CRDOSQ NUMBER(24,0), 
	CRKOS NUMBER(24,0), 
	CRKOSQ NUMBER(24,0), 
	CUDOS NUMBER(24,0), 
	CUDOSQ NUMBER(24,0), 
	CUKOS NUMBER(24,0), 
	CUKOSQ NUMBER(24,0), 
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
 (PARTITION P_MINVALUE  VALUES LESS THAN (TO_DATE('' 2015-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) 
PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSACCM 
 COMPRESS BASIC ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AGG_MONBALS ***
 exec bpa.alter_policies('AGG_MONBALS');


COMMENT ON TABLE BARS.AGG_MONBALS IS 'Ќакопительные балансы за мес€ц';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRKOS IS '—ума корегуючих кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRKOSQ IS '—ума корегуючих кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUDOS IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUDOSQ IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUKOS IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CUKOSQ IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CALDT_ID IS '≤д. дати балансу';
COMMENT ON COLUMN BARS.AGG_MONBALS.KOS IS '—ума кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS.KOSQ IS '—ума кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRDOS IS '—ума корегуючих дебетових  оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS.CRDOSQ IS '—ума корегуючих дебетових  оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS.FDAT IS 'ƒата балансу';
COMMENT ON COLUMN BARS.AGG_MONBALS.KF IS ' од фiлiалу (ћ‘ќ)';
COMMENT ON COLUMN BARS.AGG_MONBALS.ACC IS '≤д. рахунка';
COMMENT ON COLUMN BARS.AGG_MONBALS.RNK IS '≤д. кл≥Їнта';
COMMENT ON COLUMN BARS.AGG_MONBALS.OST IS '¬их≥дний залишок по рахунку (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS.OSTQ IS '¬их≥дний залишок по рахунку (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS.DOS IS '—ума дебетових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS.DOSQ IS '—ума дебетових оборот≥в (екв≥валент)';




PROMPT *** Create  constraint CC_AGG_MONBALS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (KF CONSTRAINT CC_AGG_MONBALS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (FDAT CONSTRAINT CC_AGG_MONBALS_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (OST CONSTRAINT CC_AGG_MONBALS_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (ACC CONSTRAINT CC_AGG_MONBALS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (KOSQ CONSTRAINT CC_AGG_MONBALS_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (OSTQ CONSTRAINT CC_AGG_MONBALS_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (DOS CONSTRAINT CC_AGG_MONBALS_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (DOSQ CONSTRAINT CC_AGG_MONBALS_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (KOS CONSTRAINT CC_AGG_MONBALS_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AGG_MONBALS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_MONBALS MODIFY (RNK CONSTRAINT CC_AGG_MONBALS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_AGG_MONBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_AGG_MONBALS ON BARS.AGG_MONBALS (FDAT, KF, ACC) 
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



PROMPT *** Create  grants  AGG_MONBALS ***
grant SELECT                                                                 on AGG_MONBALS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AGG_MONBALS     to BARS_DM;
grant ALTER,SELECT                                                           on AGG_MONBALS     to DM;
grant SELECT                                                                 on AGG_MONBALS     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AGG_MONBALS.sql =========*** End *** =
PROMPT ===================================================================================== 
