-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 22.06.2017
-- ===================================== <Comments> =====================================
-- create table ACCOUNTS_RSRV
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table ACCOUNTS_RSRV
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'ACCOUNTS_RSRV', 'WHOLE' , NULL,  'E',  'E', 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'ACCOUNTS_RSRV', 'FILIAL',  'M',  'M',  'M', 'M' );
  BARS.BPA.ALTER_POLICY_INFO( 'ACCOUNTS_RSRV', 'CENTER', NULL,  'E',  'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table ACCOUNTS_RSRV
( KF         VARCHAR2(6)   default SYS_CONTEXT('BARS_CONTEXT','USER_MFO') 
                           constraint CC_ACCRSRV_KF_NN  Not Null
, NLS        VARCHAR2(15)  constraint CC_ACCRSRV_NLS_NN Not Null
, KV         NUMBER(3)     constraint CC_ACCRSRV_KV_NN  Not Null
, NMS        VARCHAR2(70)
, BRANCH     VARCHAR2(30)  default SYS_CONTEXT('BARS_CONTEXT','USER_BRANCH')
, ISP        NUMBER(38)
, RNK        NUMBER(38)
, AGRM_NUM   VARCHAR2(40)
, USR_ID     NUMBER(38)
, CRT_DT     DATE
, constraint PK_ACCRSRV primary key (NLS,KV) using index tablespace BRSMDLI
, constraint FK_ACCRSRV_MVKF foreign key (KF) references MV_KF (KF)
) tablespace BRSSMLD]';
  
  dbms_output.put_line( 'Table "ACCOUNTS_RSRV" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "ACCOUNTS_RSRV" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

SET FEEDBACK ON

begin
  BPA.ALTER_POLICIES( 'ACCOUNTS_RSRV' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  ACCOUNTS_RSRV          is 'Зарезервовані номера рахунків';

COMMENT ON COLUMN ACCOUNTS_RSRV.KF       is 'Код фiлiалу (МФО)';
COMMENT ON COLUMN ACCOUNTS_RSRV.NLS      is 'Номер рахунку';
COMMENT ON COLUMN ACCOUNTS_RSRV.KV       is 'Валюта рахунку';
COMMENT ON COLUMN ACCOUNTS_RSRV.NMS      is 'Назва рахунку';
COMMENT ON COLUMN ACCOUNTS_RSRV.BRANCH   is 'Код ТВБВ';
COMMENT ON COLUMN ACCOUNTS_RSRV.ISP      is 'Ід. відповіднального виконавця';
COMMENT ON COLUMN ACCOUNTS_RSRV.RNK      is 'Реєстраційний Номер Клієнта (РНК)';
COMMENT ON COLUMN ACCOUNTS_RSRV.AGRM_NUM is 'Номер договору банківського обслуговування (SPECPARAM.NKD)';
COMMENT ON COLUMN ACCOUNTS_RSRV.USR_ID   is 'Creator';
COMMENT ON COLUMN ACCOUNTS_RSRV.CRT_DT   is 'Creation date';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON ACCOUNTS_RSRV TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
