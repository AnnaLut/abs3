

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AGG_YEARBALS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AGG_YEARBALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AGG_YEARBALS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''AGG_YEARBALS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''AGG_YEARBALS'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AGG_YEARBALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.AGG_YEARBALS 
   (	KF CHAR(6), 
	FDAT DATE, 
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
	WSDOS NUMBER(24,0), 
	WSKOS NUMBER(24,0), 
	WCDOS NUMBER(24,0), 
	WCKOS NUMBER(24,0)
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




PROMPT *** ALTER_POLICIES to AGG_YEARBALS ***
 exec bpa.alter_policies('AGG_YEARBALS');


COMMENT ON TABLE BARS.AGG_YEARBALS IS 'Накопительные балансы за год с проводками перекрытия';
COMMENT ON COLUMN BARS.AGG_YEARBALS.KF IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.FDAT IS 'Дата балансу';
COMMENT ON COLUMN BARS.AGG_YEARBALS.ACC IS 'Ід. рахунка';
COMMENT ON COLUMN BARS.AGG_YEARBALS.RNK IS 'Ід. клієнта';
COMMENT ON COLUMN BARS.AGG_YEARBALS.OST IS 'Вихідний залишок по рахунку (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.OSTQ IS 'Вихідний залишок по рахунку (еквівалент)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.DOS IS 'Сума дебетових оборотів (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.DOSQ IS 'Сума дебетових оборотів (еквівалент)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.KOS IS 'Сума кредитових оборотів (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.KOSQ IS 'Сума кредитових оборотів (еквівалент)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CRDOS IS 'Сума корегуючих дебетових  оборотів (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CRDOSQ IS 'Сума корегуючих дебетових  оборотів (еквівалент)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CRKOS IS 'Сума корегуючих кредитових оборотів (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CRKOSQ IS 'Сума корегуючих кредитових оборотів (еквівалент)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CUDOS IS 'Сума корегуючих дебетових  оборотів минулого року (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CUDOSQ IS 'Сума корегуючих дебетових  оборотів минулого року (еквівалент)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CUKOS IS 'Сума корегуючих кредитових оборотів минулого року (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.CUKOSQ IS 'Сума корегуючих кредитових оборотів минулого року (еквівалент)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.WSDOS IS 'Сума дебетових  оборотів перекриття (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.WSKOS IS 'Сума кредитових оборотів перекриття (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.WCDOS IS 'Сума корегуючих дебетових  оборотів перекриття (номінал)';
COMMENT ON COLUMN BARS.AGG_YEARBALS.WCKOS IS 'Сума корегуючих кредитових оборотів перекриття (номінал)';




PROMPT *** Create  constraint CC_YEARBALS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (KF CONSTRAINT CC_YEARBALS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_WCKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (WCKOS CONSTRAINT CC_YEARBALS_WCKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (ACC CONSTRAINT CC_YEARBALS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (RNK CONSTRAINT CC_YEARBALS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_OST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (OST CONSTRAINT CC_YEARBALS_OST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_OSTQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (OSTQ CONSTRAINT CC_YEARBALS_OSTQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_DOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (DOS CONSTRAINT CC_YEARBALS_DOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_DOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (DOSQ CONSTRAINT CC_YEARBALS_DOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_KOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (KOS CONSTRAINT CC_YEARBALS_KOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_KOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (KOSQ CONSTRAINT CC_YEARBALS_KOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CRDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CRDOS CONSTRAINT CC_YEARBALS_CRDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CRDOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CRDOSQ CONSTRAINT CC_YEARBALS_CRDOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CRKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CRKOS CONSTRAINT CC_YEARBALS_CRKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CRKOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CRKOSQ CONSTRAINT CC_YEARBALS_CRKOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CUDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CUDOS CONSTRAINT CC_YEARBALS_CUDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CUDOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CUDOSQ CONSTRAINT CC_YEARBALS_CUDOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CUKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CUKOS CONSTRAINT CC_YEARBALS_CUKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_CUKOSQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (CUKOSQ CONSTRAINT CC_YEARBALS_CUKOSQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_WSDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (WSDOS CONSTRAINT CC_YEARBALS_WSDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_WSKOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (WSKOS CONSTRAINT CC_YEARBALS_WSKOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_WCDOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (WCDOS CONSTRAINT CC_YEARBALS_WCDOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_YEARBALS_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AGG_YEARBALS MODIFY (FDAT CONSTRAINT CC_YEARBALS_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_YEARBALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_YEARBALS ON BARS.AGG_YEARBALS (FDAT, KF, ACC) 
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



PROMPT *** Create  grants  AGG_YEARBALS ***
grant SELECT                                                                 on AGG_YEARBALS    to BARS_ACCESS_DEFROLE;
grant ALTER,SELECT                                                           on AGG_YEARBALS    to DM;
grant SELECT                                                                 on AGG_YEARBALS    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AGG_YEARBALS.sql =========*** End *** 
PROMPT ===================================================================================== 
