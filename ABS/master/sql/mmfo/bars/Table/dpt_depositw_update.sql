-- ======================================================================================
-- Module : DPT
-- Author : BAA
-- Date   : 08.05.2015
-- ======================================================================================
-- create table DPT_DEPOSITW_UPDATE
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table DPT_DEPOSITW_UPDATE
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'DPT_DEPOSITW_UPDATE', 'WHOLE',  null, 'E', 'E', 'E' );
  bpa.alter_policy_info( 'DPT_DEPOSITW_UPDATE', 'FILIAL',  'M', 'M', 'M', 'M' );
  BPA.ALTER_POLICY_INFO( 'DPT_DEPOSITW_UPDATE', 'CENTER', null, 'E', 'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table DPT_DEPOSITW_UPDATE
( EFFDT      DATE         constraint CC_DEPOSITWUPDAT_EFFDT_NN    NOT NULL
, KF         VARCHAR2(6)  constraint CC_DEPOSITWUPDATE_KF_NN      NOT NULL
, CHGID      NUMBER(38)   constraint CC_DEPOSITWUPDATE_IDUPD_NN   NOT NULL
, CHGACTN    CHAR(1)      constraint CC_DEPOSITWUPDATE_CHGACTN_NN NOT NULL
, CHGDT      DATE         constraint CC_DEPOSITWUPDATE_CHGDT_NN   NOT NULL
, DONEBY     NUMBER(38)   constraint CC_DEPOSITWUPDATE_DONEBY_NN  NOT NULL
, DPT_ID     NUMBER(38)   constraint CC_DEPOSITWUPDATE_DPTID_NN   NOT NULL
, TAG        CHAR(5)      constraint CC_DEPOSITWUPDATE_TAG_NN     NOT NULL
, VALUE      VARCHAR2(500)
, constraint PK_DEPOSITWUPDATE primary key (CHGID) using index tablespace BRSMDLI
) tablespace BRSMDLD
STORAGE( INITIAL 32K NEXT 32K )
PARTITION BY RANGE (EFFDT) INTERVAL( NUMTOYMINTERVAL(1,'YEAR') )
SUBPARTITION BY LIST (KF)
SUBPARTITION TEMPLATE
( SUBPARTITION SP_300465 VALUES ('300465')
, SUBPARTITION SP_302076 VALUES ('302076')
, SUBPARTITION SP_303398 VALUES ('303398')
, SUBPARTITION SP_304665 VALUES ('304665')
, SUBPARTITION SP_305482 VALUES ('305482')
, SUBPARTITION SP_311647 VALUES ('311647')
, SUBPARTITION SP_312356 VALUES ('312356')
, SUBPARTITION SP_313957 VALUES ('313957')
, SUBPARTITION SP_315784 VALUES ('315784')
, SUBPARTITION SP_322669 VALUES ('322669')
, SUBPARTITION SP_323475 VALUES ('323475')
, SUBPARTITION SP_324805 VALUES ('324805')
, SUBPARTITION SP_325796 VALUES ('325796')
, SUBPARTITION SP_326461 VALUES ('326461')
, SUBPARTITION SP_328845 VALUES ('328845')
, SUBPARTITION SP_331467 VALUES ('331467')
, SUBPARTITION SP_333368 VALUES ('333368')
, SUBPARTITION SP_335106 VALUES ('335106')
, SUBPARTITION SP_336503 VALUES ('336503')
, SUBPARTITION SP_337568 VALUES ('337568')
, SUBPARTITION SP_338545 VALUES ('338545')
, SUBPARTITION SP_351823 VALUES ('351823')
, SUBPARTITION SP_352457 VALUES ('352457')
, SUBPARTITION SP_353553 VALUES ('353553')
, SUBPARTITION SP_354507 VALUES ('354507')
, SUBPARTITION SP_356334 VALUES ('356334')
)
( PARTITION DEPOSITWUPDATE_Y2018 VALUES LESS THAN ( TO_DATE('2019-01-01','YYYY-MM-DD') )
)]';

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
  execute immediate 'create index IDX_DEPOSITWUPDATE_DPTID on DPT_DEPOSITW_UPDATE ( KF, DPT_ID ) tablespace BRSMDLI local compress 1';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DEPOSITWUPDATE_TAG on DPT_DEPOSITW_UPDATE ( KF, TAG ) tablespace BRSMDLI local compress 1';
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
  BPA.ALTER_POLICIES( 'DPT_DEPOSITW_UPDATE' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  DPT_DEPOSITW_UPDATE IS 'Історія змін дод. параметрів депозитів ФО';

comment on column DPT_DEPOSITW_UPDATE.CHGID   IS 'Ідентифікатор зміни параметру';
comment on column DPT_DEPOSITW_UPDATE.CHGACTN IS 'Тип зміни параметру';
comment on column DPT_DEPOSITW_UPDATE.CHGDT   IS 'Календарна дата зміни параметру';
comment on column DPT_DEPOSITW_UPDATE.EFFDT   IS 'Банківська дата зміни параметру';
comment on column DPT_DEPOSITW_UPDATE.DONEBY  IS 'Ідентифікатор користувача, що виконав зміни';
comment on column DPT_DEPOSITW_UPDATE.KF      IS 'Код фiлiалу (МФО)';
comment on column DPT_DEPOSITW_UPDATE.DPT_ID  IS 'Ідентифікатор вкладу ФО';
comment on column DPT_DEPOSITW_UPDATE.TAG     IS 'Код дод. параметру';
comment on column DPT_DEPOSITW_UPDATE.VALUE   IS 'Значення дод. параметру';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON DPT_DEPOSITW_UPDATE TO BARSREADER_ROLE;
GRANT SELECT ON DPT_DEPOSITW_UPDATE TO UPLD;
GRANT SELECT ON DPT_DEPOSITW_UPDATE TO BARS_ACCESS_DEFROLE;
