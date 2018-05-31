-- ======================================================================================
-- Module : CAC
-- Author : BAA
-- Date   : 22.09.2017
-- ======================================================================================
-- create table SALDO_HOLIDAY
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table SALDO_HOLIDAY
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'SALDO_HOLIDAY', 'CENTER', null, 'E', 'E', 'E' );
  bpa.alter_policy_info( 'SALDO_HOLIDAY', 'FILIAL',  'M', 'M', 'M', 'M' );
  bpa.alter_policy_info( 'SALDO_HOLIDAY', 'WHOLE',  null, 'E', 'E', 'E' );
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table SALDO_HOLIDAY';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin 
  execute immediate 'create table SALDO_HOLIDAY
( KF    VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
                    constraint CC_SALDOHOLIDAY_KF_NN   NOT NULL
, FDAT  DATE        CONSTRAINT CC_SALDOHOLIDAY_FDAT_NN NOT NULL
, CDAT  DATE        CONSTRAINT CC_SALDOHOLIDAY_CDAT_NN NOT NULL
, ACC   NUMBER(38)  CONSTRAINT CC_SALDOHOLIDAY_ACC_NN  NOT NULL
, DOS   NUMBER(24)  CONSTRAINT CC_SALDOHOLIDAY_DOS_NN  NOT NULL
, KOS   NUMBER(24)  CONSTRAINT CC_SALDOHOLIDAY_KOS_NN  NOT NULL
) tablespace BRSBIGD
PARTITION BY LIST (KF)
( PARTITION P_300465 VALUES (''300465'')
, PARTITION P_302076 VALUES (''302076'')
, PARTITION P_303398 VALUES (''303398'')
, PARTITION P_304665 VALUES (''304665'')
, PARTITION P_305482 VALUES (''305482'')
, PARTITION P_311647 VALUES (''311647'')
, PARTITION P_312356 VALUES (''312356'')
, PARTITION P_313957 VALUES (''313957'')
, PARTITION P_315784 VALUES (''315784'')
, PARTITION P_322669 VALUES (''322669'')
, PARTITION P_323475 VALUES (''323475'')
, PARTITION P_324805 VALUES (''324805'')
, PARTITION P_325796 VALUES (''325796'')
, PARTITION P_326461 VALUES (''326461'')
, PARTITION P_328845 VALUES (''328845'')
, PARTITION P_331467 VALUES (''331467'')
, PARTITION P_333368 VALUES (''333368'')
, PARTITION P_335106 VALUES (''335106'')
, PARTITION P_336503 VALUES (''336503'')
, PARTITION P_337568 VALUES (''337568'')
, PARTITION P_338545 VALUES (''338545'')
, PARTITION P_351823 VALUES (''351823'')
, PARTITION P_352457 VALUES (''352457'')
, PARTITION P_353553 VALUES (''353553'')
, PARTITION P_354507 VALUES (''354507'')
, PARTITION P_356334 VALUES (''356334'')
)';

  dbms_output.put_line( 'Table created.' );

exception
  when e_tab_exists
  then null;
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
  execute immediate 'create unique index UK_SALDOHOLIDAY on SALDO_HOLIDAY ( KF, FDAT, CDAT, ACC ) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index created.' );
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
  bpa.alter_policies( 'SALDO_HOLIDAY' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  SALDO_HOLIDAY      IS 'Накопительная таблица оборотов по счетам по календарным дням';

comment on column SALDO_HOLIDAY.KF   IS 'Код фiлiалу (МФО)';
comment on column SALDO_HOLIDAY.FDAT IS 'Банківська дата';
comment on column SALDO_HOLIDAY.CDAT IS 'Календарна дата';
comment on column SALDO_HOLIDAY.ACC  IS 'Ід. рахунку';
comment on column SALDO_HOLIDAY.DOS  IS 'Сума Дт. оборотів';
comment on column SALDO_HOLIDAY.KOS  IS 'Сума Кт. оборотів';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on SALDO_HOLIDAY to BARS_ACCESS_DEFROLE;
grant SELECT on SALDO_HOLIDAY to BARSUPL;
grant SELECT on SALDO_HOLIDAY to BARS_DM;
