

PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Table/NBUR_REF_EKP2.sql ========= *** Run *** 
PROMPT ===================================================================================== 


SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

begin
  bars.bpa.alter_policy_info( 'NBUR_REF_EKP2', 'WHOLE',  Null, Null, Null, Null );
  bars.bpa.alter_policy_info( 'NBUR_REF_EKP2', 'FILIAL', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_REF_EKP2
(
  EKP        VARCHAR2(6 BYTE)   CONSTRAINT CC_NBURREFEKP2_EKP_NN NOT NULL,
  DSC        VARCHAR2(256 BYTE) CONSTRAINT CC_NBURREFEKP2_DSC_NN NOT NULL,
  FILE_CODE  VARCHAR2(3 BYTE) Generated Always as (SUBSTR("EKP",2,2)||'X')
)
TABLESPACE BRSMDLD]';
  
  dbms_output.put_line('table "NBUR_REF_EKP2" created.');
exception
  when e_tab_exists
  then  dbms_output.put_line( 'Table "NBUR_REF_EKP2" already exists.' );
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
  execute immediate q'[create unique index UK_NBURREFEKP2 on NBUR_REF_EKP2 (FILE_CODE, EKP)
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

begin
  bars.bpa.alter_policies( 'NBUR_REF_EKP2' );
end;
/

prompt -- ======================================================
prompt -- Comments

COMMENT ON TABLE  BARS.NBUR_REF_EKP2     IS 'Довідник кодів показників для використання в ''ручних'' файлах';
COMMENT ON COLUMN BARS.NBUR_REF_EKP2.EKP IS 'Код показника';
COMMENT ON COLUMN BARS.NBUR_REF_EKP2.DSC IS 'Опис показника';
COMMENT ON COLUMN BARS.NBUR_REF_EKP2.FILE_CODE IS 'Код файлу';

prompt -- ======================================================
prompt -- Grants

GRANT SELECT ON BARS.NBUR_REF_EKP2 TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.NBUR_REF_EKP2 TO START1;


PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Table/NBUR_REF_EKP2.sql ========= *** Run *** 
PROMPT ===================================================================================== 

