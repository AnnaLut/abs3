-- ======================================================================================
-- Module : SNP
-- Author : BAA
-- Date   : 10.02.2016
-- ======================================================================================
-- create table AGG_MONBALS_EXCHANGE
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table AGG_MONBALS_EXCHANGE
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'AGG_MONBALS_EXCHANGE', 'WHOLE' , null, null, null, null );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table AGG_MONBALS_EXCHANGE purge';
  dbms_output.put_line( 'Table "AGG_MONBALS_EXCHANGE" dropped.' );
exception
  when e_tab_not_exists then
    dbms_output.put_line( 'Table "AGG_MONBALS_EXCHANGE" does not exist.' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  
  execute immediate q'[CREATE TABLE BARS.AGG_MONBALS_EXCHANGE
( FDAT       DATE       constraint CC_AGG_MONBALS_EXG_FDAT_NN NOT NULL
, KF         CHAR(6)    constraint CC_AGG_MONBALS_EXG_KF_NN   NOT NULL
, ACC        INTEGER    constraint CC_AGG_MONBALS_EXG_ACC_NN  NOT NULL
, RNK        INTEGER    constraint CC_AGG_MONBALS_EXG_RNK_NN  NOT NULL
, OST        NUMBER(24) constraint CC_AGG_MONBALS_EXG_OST_NN  NOT NULL
, OSTQ       NUMBER(24) constraint CC_AGG_MONBALS_EXG_OSTQ_NN NOT NULL
, DOS        NUMBER(24) constraint CC_AGG_MONBALS_EXG_DOS_NN  NOT NULL
, DOSQ       NUMBER(24) constraint CC_AGG_MONBALS_EXG_DOSQ_NN NOT NULL
, KOS        NUMBER(24) constraint CC_AGG_MONBALS_EXG_KOS_NN  NOT NULL
, KOSQ       NUMBER(24) constraint CC_AGG_MONBALS_EXG_KOSQ_NN NOT NULL
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
]';
  
  dbms_output.put_line( 'Table "AGG_MONBALS_EXCHANGE" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "AGG_MONBALS_EXCHANGE" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_AGG_MONBALS_EXG ON BARS.AGG_MONBALS_EXCHANGE ( FDAT, KF, ACC )
  TABLESPACE BRSACCM
  PCTFREE 0
  COMPRESS 2 ]';
  dbms_output.put_line( 'Index "UK_AGG_MONBALS_EXG" created.' );
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line( 'Index "UK_AGG_MONBALS_EXG" already exists.' );
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'AGG_MONBALS_EXCHANGE_ALL' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  AGG_MONBALS_EXCHANGE            IS 'Накопительные балансы за місяць';

COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.FDAT       IS 'Дата балансу';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.KF         IS 'Код філіалу (МФО)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.ACC        IS 'Ід. рахунка';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.RNK        IS 'Ід. клієнта';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.OST        IS 'Вихідний залишок по рахунку (номінал)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.OSTQ       IS 'Вихідний залишок по рахунку (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.DOS        IS 'Сума дебетових оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.DOSQ       IS 'Сума дебетових оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.KOS        IS 'Сума кредитових оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.KOSQ       IS 'Сума кредитових оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CRDOS      IS 'Сума корегуючих дебетових  оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CRDOSQ     IS 'Сума корегуючих дебетових  оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CRKOS      IS 'Сума корегуючих кредитових оборотів (номінал)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CRKOSQ     IS 'Сума корегуючих кредитових оборотів (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CUDOS      IS 'Сума корегуючих дебетових  оборотів минулого місяця (номінал)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CUDOSQ     IS 'Сума корегуючих дебетових  оборотів минулого місяця (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CUKOS      IS 'Сума корегуючих кредитових оборотів минулого місяця (номінал)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.CUKOSQ     IS 'Сума корегуючих кредитових оборотів минулого місяця (еквівалент)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.YR_DOS     IS 'Дебетовi обороти по коригуючих рiчних';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.YR_DOS_UAH IS 'Дебетовi обороти по коригуючих рiчних (в еквіваленті)';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.YR_KOS     IS 'Кредитовi обороти по коригуючих рiчних';
COMMENT ON COLUMN AGG_MONBALS_EXCHANGE.YR_KOS_UAH IS 'Кредитовi обороти по коригуючих рiчних (в еквіваленті)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT, ALTER ON AGG_MONBALS_EXCHANGE      TO DM;
