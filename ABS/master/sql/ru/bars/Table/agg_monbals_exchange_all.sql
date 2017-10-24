-- ======================================================================================
-- Module : SNP
-- Author : BAA
-- Date   : 17.05.2016
-- ======================================================================================
-- create table AGG_MONBALS_EXCHANGE_ALL (for MMFO scheme)
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table AGG_MONBALS_EXCHANGE_ALL
prompt -- ======================================================

begin
  execute immediate q'[DROP TABLE BARS.AGG_MONBALS_EXCHANGE_ALL CASCADE CONSTRAINTS PURGE]';
  dbms_output.put_line('Table BARS.AGG_MONBALS_EXCHANGE_ALL dropped.');
exception
  when OTHERS then
    if ( sqlcode = -00942 )
    then
      dbms_output.put_line('Table "AGG_MONBALS_EXCHANGE_ALL" does not exist.');
      bars.bpa.alter_policy_info( 'AGG_MONBALS_EXCHANGE_ALL', 'WHOLE' , NULL, NULL, NULL, NULL );
    else
      raise;
    end if;
end;
/

declare
  l_qty       number(3);
  l_tab_stmt  varchar2(4000);
  l_idx_stmt  varchar2(1000);
begin
  
  -- create partitioned table for exchange
    
  l_tab_stmt := q'[CREATE TABLE BARS.AGG_MONBALS_EXCHANGE_ALL
( FDAT       DATE        NOT NULL
, KF         VARCHAR2(6) NOT NULL
, ACC        INTEGER     NOT NULL
, RNK        INTEGER     NOT NULL
, OST        NUMBER(24)  NOT NULL
, OSTQ       NUMBER(24)  NOT NULL
, DOS        NUMBER(24)  NOT NULL
, DOSQ       NUMBER(24)  NOT NULL
, KOS        NUMBER(24)  NOT NULL
, KOSQ       NUMBER(24)  NOT NULL
, CRDOS      NUMBER(24)  DEFAULT 0
, CRDOSQ     NUMBER(24)  DEFAULT 0
, CRKOS      NUMBER(24)  DEFAULT 0
, CRKOSQ     NUMBER(24)  DEFAULT 0
, CUDOS      NUMBER(24)  DEFAULT 0
, CUDOSQ     NUMBER(24)  DEFAULT 0
, CUKOS      NUMBER(24)  DEFAULT 0
, CUKOSQ     NUMBER(24)  DEFAULT 0
, CALDT_ID   NUMBER(38)  Generated Always as (TO_NUMBER(TO_CHAR("FDAT",'j'))-2447892)
) TABLESPACE BRSACCM
COMPRESS BASIC
PARALLEL 26
STORAGE( INITIAL 128K NEXT 128K )
PCTUSED  0
PCTFREE  0 
PARTITION BY LIST (KF)
( PARTITION SP_300465 VALUES ('300465')
, PARTITION SP_302076 VALUES ('302076')
, PARTITION SP_303398 VALUES ('303398')
, PARTITION SP_304665 VALUES ('304665')
, PARTITION SP_305482 VALUES ('305482')
, PARTITION SP_311647 VALUES ('311647')
, PARTITION SP_312356 VALUES ('312356')
, PARTITION SP_313957 VALUES ('313957')
, PARTITION SP_315784 VALUES ('315784')
, PARTITION SP_322669 VALUES ('322669')
, PARTITION SP_323475 VALUES ('323475')
, PARTITION SP_324805 VALUES ('324805')
, PARTITION SP_325796 VALUES ('325796')
, PARTITION SP_326461 VALUES ('326461')
, PARTITION SP_328845 VALUES ('328845')
, PARTITION SP_331467 VALUES ('331467')
, PARTITION SP_333368 VALUES ('333368')
, PARTITION SP_335106 VALUES ('335106')
, PARTITION SP_336503 VALUES ('336503')
, PARTITION SP_337568 VALUES ('337568')
, PARTITION SP_338545 VALUES ('338545')
, PARTITION SP_351823 VALUES ('351823')
, PARTITION SP_352457 VALUES ('352457')
, PARTITION SP_353553 VALUES ('353553')
, PARTITION SP_354507 VALUES ('354507')
, PARTITION SP_356334 VALUES ('356334') 
) ]';
    
  l_idx_stmt := q'[CREATE UNIQUE INDEX BARS.UK_AGG_MONBALS_EXCHANGE_ALL ON BARS.AGG_MONBALS_EXCHANGE_ALL ( FDAT, KF, ACC )
  TABLESPACE BRSACCM
  PCTFREE 0
  LOCAL
  COMPRESS 2 ]';
  
  execute immediate l_tab_stmt;
  
  dbms_output.put_line('Table BARS.AGG_MONBALS_EXCHANGE_ALL created.');
  
  execute immediate l_idx_stmt;
  
  dbms_output.put_line('Index BARS.UK_AGG_MONBALS_EXCHANGE_ALL created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.AGG_MONBALS_EXCHANGE_ALL already exists.');
    else raise;
    end if;  
end;
/

begin
  bars.bpa.alter_policies( 'AGG_MONBALS_EXCHANGE_ALL' );
end;
/

commit;

prompt -- ======================================================
prompt -- table comments
prompt -- ======================================================

SET FEEDBACK ON

COMMENT ON TABLE  BARS.AGG_MONBALS_EXCHANGE_ALL          IS 'Ќакопительные балансы за мес€ц';

COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.FDAT     IS 'ƒата балансу';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.KF       IS ' од ф≥л≥алу (ћ‘ќ)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.ACC      IS '≤д. рахунка';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.RNK      IS '≤д. кл≥Їнта';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.OST      IS '¬их≥дний залишок по рахунку (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.OSTQ     IS '¬их≥дний залишок по рахунку (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.DOS      IS '—ума дебетових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.DOSQ     IS '—ума дебетових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.KOS      IS '—ума кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.KOSQ     IS '—ума кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CRDOS    IS '—ума корегуючих дебетових  оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CRDOSQ   IS '—ума корегуючих дебетових  оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CRKOS    IS '—ума корегуючих кредитових оборот≥в (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CRKOSQ   IS '—ума корегуючих кредитових оборот≥в (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CUDOS    IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CUDOSQ   IS '—ума корегуючих дебетових  оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CUKOS    IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (ном≥нал)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CUKOSQ   IS '—ума корегуючих кредитових оборот≥в минулого м≥с€ц€ (екв≥валент)';
COMMENT ON COLUMN BARS.AGG_MONBALS_EXCHANGE_ALL.CALDT_ID IS '≤д. дати балансу (дл€ сум≥сност≥ ≥з попередньою верс≥Їю)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT, ALTER ON BARS.AGG_MONBALS_EXCHANGE_ALL      TO DM;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
