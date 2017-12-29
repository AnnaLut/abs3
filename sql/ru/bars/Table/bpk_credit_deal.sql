-- ======================================================================================
-- Module : PRVN
-- Author : BAA
-- Date   : 29.12.2017
-- ===================================== <Comments> =====================================
-- create table   BPK_CREDIT_DEAL
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
set echo         Off
set lines        500
set pages        500
set termout      On
set timing       Off
set trimspool    On

SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- == create table BPK_CREDIT_DEAL
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL', 'WHOLE',  null, null, null, null );
  bpa.alter_policy_info( 'BPK_CREDIT_DEAL', 'FILIAL', null, null, null, null );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 
  'create table BPK_CREDIT_DEAL
   ( CARD_ND    number(24)  constraint CC_BPKCREDITDEAL_CARDND_NN  not null,
     DEAL_ND    number(24)  constraint CC_BPKCREDITDEAL_DEALND_NN  not null,
     DEAL_SUM   number(24)  constraint CC_BPKCREDITDEAL_DEALSUM_NN not null,
     DEAL_KV    number(3)   constraint CC_BPKCREDITDEAL_DEALKV_NN  not null,
     DEAL_RNK   number(24)  constraint CC_BPKCREDITDEAL_DEALRNK_NN not null,
     OPEN_DT    date        constraint CC_BPKCREDITDEAL_OPENDT_NN  not null,
     MATUR_DT   date,
     CLOSE_DT   date,
     ACC_9129   number(24),
     ACC_OVR    number(24),
     ACC_2208   number(24),
     ACC_2207   number(24),
     ACC_2209   number(24),
     PC_TYPE    varchar2(3),
     CREATE_DT  date        default sysdate
                            constraint CC_BPKCREDITDEAL_CREATEDT_NN not null,
     KF         varchar2(6) default sys_context(''bars_context'',''user_mfo'')
                            constraint CC_BPKCREDITDEAL_KF_NN not null,
     constraint PK_BPKCREDITDEAL primary key   ( DEAL_ND ) using index tablespace brsmdli,
     constraint UK_BPKCREDITDEAL_CARDND unique ( CARD_ND ) using index tablespace brsmdli
   ) tablespace BRSMDLD';

  dbms_output.put_line( 'Table "BPK_CREDIT_DEAL" created.' );

exception 
  when e_tab_exists then
    dbms_output.put_line( 'Table "BPK_CREDIT_DEAL" already exists.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'BPK_CREDIT_DEAL' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BPK_CREDIT_DEAL           IS 'Договора кредитних лімітів під БПК';

COMMENT ON COLUMN BPK_CREDIT_DEAL.CARD_ND   IS 'Номер договору БПК';
COMMENT ON COLUMN BPK_CREDIT_DEAL.DEAL_ND   IS 'Номер договору кредитного ліміту';
COMMENT ON COLUMN BPK_CREDIT_DEAL.DEAL_SUM  IS 'Сума договору';
COMMENT ON COLUMN BPK_CREDIT_DEAL.DEAL_KV   IS 'Валюта договору';
COMMENT ON COLUMN BPK_CREDIT_DEAL.DEAL_RNK  IS 'РНК';
COMMENT ON COLUMN BPK_CREDIT_DEAL.OPEN_DT   IS 'Дата відкриття договору';
COMMENT ON COLUMN BPK_CREDIT_DEAL.MATUR_DT  IS 'Дата погашення (первинна)';
COMMENT ON COLUMN BPK_CREDIT_DEAL.CLOSE_DT  IS 'Дата закриття договору';
COMMENT ON COLUMN BPK_CREDIT_DEAL.ACC_9129  IS 'Ід. рах. НЕвикористаного кредитного ліміту';
COMMENT ON COLUMN BPK_CREDIT_DEAL.ACC_OVR   IS 'Ід. рах. використаного кредитного ліміту';
COMMENT ON COLUMN BPK_CREDIT_DEAL.ACC_2208  IS 'Ід. рах. нарахованих відсотків';
COMMENT ON COLUMN BPK_CREDIT_DEAL.ACC_2207  IS 'Ід. рах. простроченого боргу';
COMMENT ON COLUMN BPK_CREDIT_DEAL.ACC_2209  IS 'Ід. рах. прострочених відсотків';
COMMENT ON COLUMN BPK_CREDIT_DEAL.PC_TYPE   IS '';
COMMENT ON COLUMN BPK_CREDIT_DEAL.CREATE_DT IS 'Дата створення запису';
COMMENT ON COLUMN BPK_CREDIT_DEAL.KF        IS 'Код фiлiалу (МФО)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BPK_CREDIT_DEAL TO BARSUPL, UPLD;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
