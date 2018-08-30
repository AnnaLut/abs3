-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 13.08.2018
-- ======================================================================================
-- create table NBUR_REF_EKP_R020
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_REF_EKP_R020
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_REF_EKP_R020', 'WHOLE',  Null, Null, Null, Null );
  bars.bpa.alter_policy_info( 'NBUR_REF_EKP_R020', 'FILIAL', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_REF_EKP_R020
(
  EKP        VARCHAR2(6 BYTE) CONSTRAINT CC_NBURREFEKPR020_EKP_NN NOT NULL,
  DSC        VARCHAR2(128 BYTE) CONSTRAINT CC_NBURREFEKPR020_DSC_NN NOT NULL,
  FILE_CODE  VARCHAR2(3 BYTE) Generated Always as (SUBSTR("EKP",2,2)||'X'),
  DESC_R020  CLOB CONSTRAINT CC_NBURREFEKPR020_DESCR020_NN NOT NULL,
  DATE_START DATE CONSTRAINT CC_NBURREFEKPR020_DATEST_NN NOT NULL
, constraint FK_NBURREFEKPR020_NBURREFFILES foreign key (FILE_CODE) references NBUR_REF_FILES (FILE_CODE)
)
TABLESPACE BRSMDLD]';
  
  dbms_output.put_line('table "NBUR_REF_EKP_R020" created.');
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_REF_EKP_R020" already exists.' );
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
  execute immediate q'[create unique index UK_NBURREFEKPR020 on NBUR_REF_EKP_R020 (FILE_CODE, EKP, DATE_START)
  TABLESPACE BRSMDLI
  COMPRESS 1 ]';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_REF_EKP_R020' );
end;
/

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE BARS.NBUR_REF_EKP_R020 IS 'Довідник кодів показників з описом правил формування';

COMMENT ON COLUMN BARS.NBUR_REF_EKP_R020.EKP IS 'Код показника';

COMMENT ON COLUMN BARS.NBUR_REF_EKP_R020.DSC IS 'Опис показника';

COMMENT ON COLUMN BARS.NBUR_REF_EKP_R020.FILE_CODE IS 'Код файлу';

COMMENT ON COLUMN BARS.NBUR_REF_EKP_R020.DESC_R020 IS 'Опис правил формування показника з файлу Registry_XXX.xls';

COMMENT ON COLUMN BARS.NBUR_REF_EKP_R020.DATE_START IS 'Дата початку дії';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.NBUR_REF_EKP_R020 TO BARS_ACCESS_DEFROLE;
