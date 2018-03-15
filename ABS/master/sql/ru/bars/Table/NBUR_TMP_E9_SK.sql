-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 13.03.2018
-- ======================================================================================
-- create table NBUR_TMP_E9_SK
-- ======================================================================================

prompt -- ======================================================
prompt -- create table NBUR_TMP_E9_SK
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_SK', 'WHOLE' , NULL, NULL, NULL, 'E' );
  BARS.BPA.ALTER_POLICY_INFO( 'NBUR_TMP_E9_SK', 'FILIAL',  'M',  'M',  'M', 'M' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_TMP_E9_SK
( REPORT_DATE     DATE         CONSTRAINT CC_NBURTMPE9SK_REPORTDT_NN   NOT NULL
, KF              CHAR(6)      CONSTRAINT CC_NBURTMPE9SK_KF_NN         NOT NULL
, CTEDRPOU        VARCHAR2(10)
, CTKOD_EKP       VARCHAR2(10)
, CTKOD_D060_1    VARCHAR2(2)
, CTKOD_K020      VARCHAR2(10)
, CTKOD_K021      VARCHAR2(1)
, CTKOD_F001      VARCHAR2(1)
, CTKOD_R030      VARCHAR2(3)
, CTKOD_K040_1    VARCHAR2(3)
, CTKOD_KU_1      VARCHAR2(2)
, CTKOD_K040_2    VARCHAR2(3)
, CTKOD_KU_2      VARCHAR2(2)
, CTKOD_T071      NUMBER(38)
, CTKOD_T080      NUMBER(38)
, CTKOD_D060_2    VARCHAR2(2)
, CTKOD_Q001      VARCHAR2(100)
) TABLESPACE BRSMDLD ]';

  dbms_output.put_line('table "NBUR_TMP_E9_SK" created.');

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "NBUR_TMP_E9_SK" already exists.' );
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
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate q'[create index UK_NBURTMPE9SK_FILESTATUS on NBUR_TMP_E9_SK ( REPORT_DATE, KF) 
  TABLESPACE BRSMDLI ]';
  dbms_output.put_line( 'Index created.' );
exception
  when E_IDX_EXISTS
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when E_COL_ALREADY_IDX
  then dbms_output.put_line( 'Such column list already indexed.' );
  when E_DUP_KEYS_FOUND
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_TMP_E9_SK' );
end;
/

commit;

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on  table BARS.NBUR_TMP_E9_SK              is 'Отримані з XML файлу дані по ШК для Е9 файлу';

comment on column BARS.NBUR_TMP_E9_SK.REPORT_DATE  is 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.KF           IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTEDRPOU     IS 'Код ЄДРПОУ платіжної організації';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_EKP     IS 'Код показника ';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_D060_1     IS 'Код системи переказу коштів ';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K020     IS 'Код відправника/отримувача переказу';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K021     IS 'Код ознаки ідентифікаційного коду';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_F001     IS 'Код учасників переказу коштів';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_R030     IS 'Цифровий код валюти, у якій відправлено перекази';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K040_1     IS 'Коди країни установи-відправника';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_KU_1     IS 'Код області відправлення переказів';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_K040_2     IS 'Коди країни установи-отримувача';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_KU_2     IS 'Код області отримання переказів';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_T071     IS 'Сума у валюті, у сотих частках одиниць валюти без урахування суми комісійних';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_T080     IS 'Кількість';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_D060_2     IS 'Код міжнародної системи переказу коштів, створеної нерезидентом, за участю якої здійснено транскордонний переказ';
COMMENT ON COLUMN BARS.NBUR_TMP_E9_SK.CTKOD_Q001     IS 'Найменування банку кореспондента-нерезидента, за участю якого здійснено транскордонний переказ';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_TMP_E9_SK TO BARSUPL;
GRANT SELECT ON BARS.NBUR_TMP_E9_SK TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================

--drop table NBUR_TMP_E9_SK cascade constraints