-- ======================================================================================
-- Module : SNP
-- Author : BAA
-- Date   : 10.02.2016
-- ======================================================================================
-- create table AGG_MONBALS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table AGG_MONBALS
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'AGG_MONBALS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'AGG_MONBALS', 'FILIAL',  'M',  'M',  'M',  'M' );
  BPA.ALTER_POLICY_INFO( 'AGG_MONBALS', 'CENTER', null,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  
  execute immediate q'[create table AGG_MONBALS
( FDAT       DATE       constraint CC_AGG_MONBALS_FDAT_NN NOT NULL
, KF         CHAR(6)    constraint CC_AGG_MONBALS_KF_NN   NOT NULL
, ACC        INTEGER    constraint CC_AGG_MONBALS_ACC_NN  NOT NULL
, RNK        INTEGER    constraint CC_AGG_MONBALS_RNK_NN  NOT NULL
, OST        NUMBER(24) constraint CC_AGG_MONBALS_OST_NN  NOT NULL
, OSTQ       NUMBER(24) constraint CC_AGG_MONBALS_OSTQ_NN NOT NULL
, DOS        NUMBER(24) constraint CC_AGG_MONBALS_DOS_NN  NOT NULL
, DOSQ       NUMBER(24) constraint CC_AGG_MONBALS_DOSQ_NN NOT NULL
, KOS        NUMBER(24) constraint CC_AGG_MONBALS_KOS_NN  NOT NULL
, KOSQ       NUMBER(24) constraint CC_AGG_MONBALS_KOSQ_NN NOT NULL
, CRDOS      NUMBER(24) default 0
, CRDOSQ     NUMBER(24) default 0
, CRKOS      NUMBER(24) default 0
, CRKOSQ     NUMBER(24) default 0
, CUDOS      NUMBER(24) default 0
, CUDOSQ     NUMBER(24) default 0
, CUKOS      NUMBER(24) default 0
, CUKOSQ     NUMBER(24) default 0
, YR_DOS     NUMBER(24) default 0
, YR_DOS_UAH NUMBER(24) default 0
, YR_KOS     NUMBER(24) default 0
, YR_KOS_UAH NUMBER(24) default 0
, CALDT_ID   NUMBER Generated Always as (TO_NUMBER(TO_CHAR("FDAT",'j'))-2447892)
) TABLESPACE BRSACCM
COMPRESS BASIC
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED  0
PCTFREE  0
PARTITION BY RANGE (FDAT) INTERVAL ( NUMTODSINTERVAL(1,'DAY') ) 
SUBPARTITION BY LIST (KF) 
SUBPARTITION TEMPLATE
( SUBPARTITION SP_300465 VALUES ( '300465' )
, SUBPARTITION SP_302076 VALUES ( '302076' )
, SUBPARTITION SP_303398 VALUES ( '303398' )
, SUBPARTITION SP_304665 VALUES ( '304665' )
, SUBPARTITION SP_305482 VALUES ( '305482' )
, SUBPARTITION SP_311647 VALUES ( '311647' )
, SUBPARTITION SP_312356 VALUES ( '312356' )
, SUBPARTITION SP_313957 VALUES ( '313957' )
, SUBPARTITION SP_315784 VALUES ( '315784' )
, SUBPARTITION SP_322669 VALUES ( '322669' )
, SUBPARTITION SP_323475 VALUES ( '323475' )
, SUBPARTITION SP_324805 VALUES ( '324805' )
, SUBPARTITION SP_325796 VALUES ( '325796' )
, SUBPARTITION SP_326461 VALUES ( '326461' )
, SUBPARTITION SP_328845 VALUES ( '328845' )
, SUBPARTITION SP_331467 VALUES ( '331467' )
, SUBPARTITION SP_333368 VALUES ( '333368' )
, SUBPARTITION SP_335106 VALUES ( '335106' )
, SUBPARTITION SP_336503 VALUES ( '336503' )
, SUBPARTITION SP_337568 VALUES ( '337568' )
, SUBPARTITION SP_338545 VALUES ( '338545' )
, SUBPARTITION SP_351823 VALUES ( '351823' )
, SUBPARTITION SP_352457 VALUES ( '352457' )
, SUBPARTITION SP_353553 VALUES ( '353553' )
, SUBPARTITION SP_354507 VALUES ( '354507' )
, SUBPARTITION SP_356334 VALUES ( '356334' ) ) 
( PARTITION P_MINVALUE VALUES LESS THAN ( TO_DATE('01/01/2015','DD/MM/YYYY') ) ) ]';
  
  dbms_output.put_line( 'Table "AGG_MONBALS" created.' );
  
exception
  when e_tab_exists then 
    dbms_output.put_line( 'Table "AGG_MONBALS" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

exec BPA.DISABLE_POLICIES( 'AGG_MONBALS' );

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table AGG_MONBALS add YR_DOS number(24)]';
  execute immediate q'[alter table AGG_MONBALS modify YR_DOS default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/
-- When adding a column on compressed tables, do not specify a default value.

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table AGG_MONBALS add YR_DOS_UAH number(24)]';
  execute immediate q'[alter table AGG_MONBALS modify YR_DOS_UAH default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table AGG_MONBALS add YR_KOS number(24)]';
  execute immediate q'[alter table AGG_MONBALS modify YR_KOS default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table AGG_MONBALS add YR_KOS_UAH number(24)]';
  execute immediate q'[alter table AGG_MONBALS modify YR_KOS_UAH default 0 ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  
  execute immediate q'[create unique index UK_AGG_MONBALS on AGG_MONBALS ( FDAT, KF, ACC )
  TABLESPACE BRSACCM
  PCTFREE 0
  COMPRESS 2 ]';
  
  dbms_output.put_line( 'Index "UK_AGG_MONBALS" created.' );
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index BARS.UK_AGG_MONBALS already exists.' );
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'AGG_MONBALS' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  AGG_MONBALS            IS 'Накопительные балансы за місяць';
                             
COMMENT ON COLUMN AGG_MONBALS.FDAT       IS 'Дата балансу';
COMMENT ON COLUMN AGG_MONBALS.KF         IS 'Код філіалу (МФО)';
COMMENT ON COLUMN AGG_MONBALS.ACC        IS 'Ід. рахунка';
COMMENT ON COLUMN AGG_MONBALS.RNK        IS 'Ід. клієнта';
COMMENT ON COLUMN AGG_MONBALS.OST        IS 'Вихідний залишок по рахунку (номінал)';
COMMENT ON COLUMN AGG_MONBALS.OSTQ       IS 'Вихідний залишок по рахунку (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS.DOS        IS 'Сума дебетових оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS.DOSQ       IS 'Сума дебетових оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS.KOS        IS 'Сума кредитових оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS.KOSQ       IS 'Сума кредитових оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS.CRDOS      IS 'Сума корегуючих дебетових  оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS.CRDOSQ     IS 'Сума корегуючих дебетових  оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS.CRKOS      IS 'Сума корегуючих кредитових оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS.CRKOSQ     IS 'Сума корегуючих кредитових оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS.CUDOS      IS 'Сума корегуючих дебетових  оборотів минулого місяця (номінал)';
COMMENT ON COLUMN AGG_MONBALS.CUDOSQ     IS 'Сума корегуючих дебетових  оборотів минулого місяця (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS.CUKOS      IS 'Сума корегуючих кредитових оборотів минулого місяця (номінал)';
COMMENT ON COLUMN AGG_MONBALS.CUKOSQ     IS 'Сума корегуючих кредитових оборотів минулого місяця (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS.YR_DOS     IS 'Дебетовi обороти по коригуючих рiчних';
COMMENT ON COLUMN AGG_MONBALS.YR_DOS_UAH IS 'Дебетовi обороти по коригуючих рiчних (в еквіваленті)';
COMMENT ON COLUMN AGG_MONBALS.YR_KOS     IS 'Кредитовi обороти по коригуючих рiчних';
COMMENT ON COLUMN AGG_MONBALS.YR_KOS_UAH IS 'Кредитовi обороти по коригуючих рiчних (в еквіваленті)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT, ALTER on AGG_MONBALS to DM;
grant SELECT        on AGG_MONBALS to BARS_ACCESS_DEFROLE;
grant SELECT        on AGG_MONBALS to BARS_DM;
grant SELECT        on AGG_MONBALS to START1;
grant SELECT        on AGG_MONBALS to BARSREADER_ROLE;
grant SELECT        on AGG_MONBALS to UPLD;
