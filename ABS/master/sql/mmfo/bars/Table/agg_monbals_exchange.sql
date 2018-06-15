-- ======================================================================================
-- Module : SNP
-- Author : BAA
-- Date   : 19.04.2016
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
  execute immediate q'[create table AGG_MONBALS_EXCHANGE
( FDAT       date        constraint CC_AGG_MONBALS_EXG_FDAT_NN NOT NULL
, KF         varchar2(6) constraint CC_AGG_MONBALS_EXG_KF_NN   NOT NULL
, ACC        integer     constraint CC_AGG_MONBALS_EXG_ACC_NN  NOT NULL
, RNK        integer     constraint CC_AGG_MONBALS_EXG_RNK_NN  NOT NULL
, OST        number(24)  constraint CC_AGG_MONBALS_EXG_OST_NN  NOT NULL
, OSTQ       number(24)  constraint CC_AGG_MONBALS_EXG_OSTQ_NN NOT NULL
, DOS        number(24)  constraint CC_AGG_MONBALS_EXG_DOS_NN  NOT NULL
, DOSQ       number(24)  constraint CC_AGG_MONBALS_EXG_DOSQ_NN NOT NULL
, KOS        number(24)  constraint CC_AGG_MONBALS_EXG_KOS_NN  NOT NULL
, KOSQ       number(24)  constraint CC_AGG_MONBALS_EXG_KOSQ_NN NOT NULL
, CRDOS      number(24)  default 0
, CRDOSQ     number(24)  default 0
, CRKOS      number(24)  default 0
, CRKOSQ     number(24)  default 0
, CUDOS      number(24)  default 0
, CUDOSQ     number(24)  default 0
, CUKOS      number(24)  default 0
, CUKOSQ     number(24)  default 0
, CALDT_ID   number      Generated Always as (TO_NUMBER(TO_CHAR("FDAT",'j'))-2447892)
, YR_DOS     number(24)  default 0
, YR_DOS_UAH number(24)  default 0
, YR_KOS     number(24)  default 0
, YR_KOS_UAH number(24)  default 0
) tablespace BRSACCM
COMPRESS BASIC
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED  0
PCTFREE  0
]';

  dbms_output.put_line( 'Table "AGG_MONBALS_EXCHANGE" created.' );

exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "AGG_MONBALS_EXCHANGE" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create unique index UK_AGG_MONBALS_EXG ON BARS.AGG_MONBALS_EXCHANGE ( FDAT, KF, ACC )
  TABLESPACE BRSACCM
  PCTFREE 0
  COMPRESS 2 ]';
  dbms_output.put_line( 'Index "UK_AGG_MONBALS_EXG" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'AGG_MONBALS_EXCHANGE' );
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
