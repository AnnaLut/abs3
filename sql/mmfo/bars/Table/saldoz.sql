-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 12.05.2017
-- ===================================== <Comments> =====================================
-- create table SALDOZ
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF
SET TIMING       OFF
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table SALDOZ
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'SALDOZ', 'WHOLE' , NULL, 'E', 'E', 'E' );
  bars.bpa.alter_policy_info( 'SALDOZ', 'FILIAL',  'M', 'M', 'M', 'M' );
  bars.bpa.alter_policy_info( 'SALDOZ', 'CENTER', NULL, 'E', 'E', 'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  
  execute immediate q'[create table SALDOZ
( KF         VARCHAR2(6) default SYS_CONTEXT('BARS_CONTEXT','USER_MFO')
                         constraint CC_SALDOZ_KF_NN   NOT NULL
, FDAT       DATE        constraint CC_SALDOZ_FDAT_NN NOT NULL
, ACC        NUMBER(38)  constraint CC_SALDOZ_ACC_NN  NOT NULL
, DOS        NUMBER(24)  constraint CC_SALDOZ_DOS_NN  NOT NULL
, DOSQ       NUMBER(24)  constraint CC_SALDOZ_DOSQ_NN NOT NULL
, KOS        NUMBER(24)  constraint CC_SALDOZ_KOS_NN  NOT NULL
, KOSQ       NUMBER(24)  constraint CC_SALDOZ_KOSQ_NN NOT NULL
, DOS_YR     NUMBER(24)  default 0
, DOSQ_YR    NUMBER(24)  default 0
, KOS_YR     NUMBER(24)  default 0
, KOSQ_YR    NUMBER(24)  default 0
) TABLESPACE BRSMDLD
  STORAGE( INITIAL 32K NEXT 32K )
  PARTITION BY LIST (KF)
( PARTITION P_300465 VALUES ('300465')
, PARTITION P_302076 VALUES ('302076')
, PARTITION P_303398 VALUES ('303398')
, PARTITION P_304665 VALUES ('304665')
, PARTITION P_305482 VALUES ('305482')
, PARTITION P_311647 VALUES ('311647')
, PARTITION P_312356 VALUES ('312356')
, PARTITION P_313957 VALUES ('313957')
, PARTITION P_315784 VALUES ('315784')
, PARTITION P_322669 VALUES ('322669')
, PARTITION P_323475 VALUES ('323475')
, PARTITION P_324805 VALUES ('324805')
, PARTITION P_325796 VALUES ('325796')
, PARTITION P_326461 VALUES ('326461')
, PARTITION P_328845 VALUES ('328845')
, PARTITION P_331467 VALUES ('331467')
, PARTITION P_333368 VALUES ('333368')
, PARTITION P_335106 VALUES ('335106')
, PARTITION P_336503 VALUES ('336503')
, PARTITION P_337568 VALUES ('337568')
, PARTITION P_338545 VALUES ('338545')
, PARTITION P_351823 VALUES ('351823')
, PARTITION P_352457 VALUES ('352457')
, PARTITION P_353553 VALUES ('353553')
, PARTITION P_354507 VALUES ('354507')
, PARTITION P_356334 VALUES ('356334') 
)]';
  
  dbms_output.put_line( 'Table "SALDOZ" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "SALDOZ" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

exec BPA.DISABLE_POLICIES( 'SALDOZ' );

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table SALDOZ add DOS_YR number(24) default 0]';
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
  execute immediate q'[alter table SALDOZ add DOSQ_YR number(24) default 0]';
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
  execute immediate q'[alter table SALDOZ add KOS_YR number(24) default 0]';
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
  execute immediate q'[alter table SALDOZ add KOSQ_YR number(24) default 0]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

-- exec BPA.ENABLE_POLICIES( 'SALDOZ' );

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create unique index UK_SALDOZ ON SALDOZ ( KF, FDAT, ACC )
  TABLESPACE BRSMDLI
  LOCAL
  COMPRESS 2 ]';
  dbms_output.put_line( 'Index "UK_SALDOZ" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "UK_SALDOZ" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "KF", "FDAT", "ACC" already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICIES( 'SALDOZ' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  SALDOZ         IS 'Накопичення місячних корегуючих оборотів (OPER.VOB=96)';

comment on column SALDOZ.KF      IS 'Код філіалу (МФО)';
comment on column SALDOZ.FDAT    IS 'Дата';
comment on column SALDOZ.ACC     IS 'Ідентифікатор рахунку';
comment on column SALDOZ.DOS     IS 'Дебетовi обороти по коригуючих мiсячних';
comment on column SALDOZ.DOSQ    IS 'Дебетовi обороти по коригуючих мiсячних (в еквіваленті)';
comment on column SALDOZ.KOS     IS 'Кредитовi обороти по коригуючих мiсячних';
comment on column SALDOZ.KOSQ    IS 'Кредитовi обороти по коригуючих мiсячних (в еквіваленті)';
comment on column SALDOZ.DOS_YR  IS 'Дебетовi обороти по коригуючих рiчних';
comment on column SALDOZ.DOSQ_YR IS 'Дебетовi обороти по коригуючих рiчних (в еквіваленті)';
comment on column SALDOZ.KOS_YR  IS 'Кредитовi обороти по коригуючих рiчних';
comment on column SALDOZ.KOSQ_YR IS 'Кредитовi обороти по коригуючих рiчних (в еквіваленті)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT ON SALDOZ to BARS_ACCESS_DEFROLE;
grant SELECT ON SALDOZ to START1;
grant SELECT on SALDOZ to BARSREADER_ROLE;
grant SELECT on SALDOZ to BARS_DM;
grant SELECT on SALDOZ to DM;
grant SELECT on SALDOZ to UPLD;
