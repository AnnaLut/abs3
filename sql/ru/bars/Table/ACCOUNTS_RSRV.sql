-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 22.01.2018
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
, VID        NUMBER(2)
, RNK        NUMBER(38)
, AGRM_NUM   VARCHAR2(40)
, TRF_ID     NUMBER
, OB22       CHAR(2)
, USR_ID     NUMBER(38)
, CRT_DT     DATE
, RSRV_ID    NUMBER(38)
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
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table ACCOUNTS_RSRV add TRF_ID number';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "TRF_ID" already exists in table.' );
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table ACCOUNTS_RSRV add OB22 char(2)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then dbms_output.put_line( 'Column "OB22" already exists in table.' );
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table ACCOUNTS_RSRV add RSRV_ID number(38)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists 
  then dbms_output.put_line( 'Column "RSRV_ID" already exists in table.' );
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table ACCOUNTS_RSRV add VID number(2)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists 
  then dbms_output.put_line( 'Column "VID" already exists in table.' );
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
  execute immediate q'[create unique index UK_ACCRSRV_RSRVID on ACCOUNTS_RSRV ( RSRV_ID )
  tablespace BRSSMLI]';
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
COMMENT ON COLUMN ACCOUNTS_RSRV.TRF_ID   is 'Код тарифного пакету';
COMMENT ON COLUMN ACCOUNTS_RSRV.OB22     is 'ОБ22';
COMMENT ON COLUMN ACCOUNTS_RSRV.USR_ID   is 'Creator';
COMMENT ON COLUMN ACCOUNTS_RSRV.CRT_DT   is 'Creation date';
COMMENT ON COLUMN ACCOUNTS_RSRV.RSRV_ID  is 'Ід. запису про резерв номера рахунку';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON ACCOUNTS_RSRV TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
