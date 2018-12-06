-- ======================================================================================
-- Module : NBUR
-- Author : 
-- Date   : 28.08.2018
-- ======================================================================================
-- create table NBUR_REF_PREPARE_XML
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table NBUR_REF_PREPARE_XML
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'NBUR_REF_PREPARE_XML', 'WHOLE',  Null, Null, Null, Null );
  bars.bpa.alter_policy_info( 'NBUR_REF_PREPARE_XML', 'FILIAL', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.NBUR_REF_PREPARE_XML
(
  FILE_CODE  VARCHAR2(3 BYTE) CONSTRAINT CC_NBURREFPREPXML_FILECODE_NN NOT NULL,
  DESC_XML   CLOB CONSTRAINT CC_NBURREFPREPXML_DESCXML_NN NOT NULL,
  DATE_START DATE CONSTRAINT CC_NBURREFPREPXML_DATEST_NN NOT NULL
, constraint FK_NBURREFPREPXML_NBURREFFILES foreign key (FILE_CODE) references NBUR_REF_FILES (FILE_CODE)
)
TABLESPACE BRSMDLD]';
  
  dbms_output.put_line('table "NBUR_REF_PREPARE_XML" created.');
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_REF_PREPARE_XML" already exists.' );
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
  execute immediate q'[create unique index UK_NBURREFPREPXML on NBUR_REF_PREPARE_XML (FILE_CODE, DATE_START)
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
  bars.bpa.alter_policies( 'NBUR_REF_PREPARE_XML' );
end;
/

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE BARS.NBUR_REF_PREPARE_XML IS 'Довідник SQL-запитів для формування XML файлів';

COMMENT ON COLUMN BARS.NBUR_REF_PREPARE_XML.FILE_CODE IS 'Код файлу';

COMMENT ON COLUMN BARS.NBUR_REF_PREPARE_XML.DESC_XML IS 'Опис SQL-запитів для формування XML файлу';

COMMENT ON COLUMN BARS.NBUR_REF_PREPARE_XML.DATE_START IS 'Дата початку дії';

PROMT ========================================================== 
PROMT ======================== ADD COLUMNS =====================
PROMT ========================================================== 
begin  EXECUTE IMMEDIATE 'ALTER TABLE BARS.NBUR_REF_PREPARE_XML ADD (ATTR_NIL varchar(128)) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/
comment on column BARS.NBUR_REF_PREPARE_XML.ATTR_NIL is 'Перелік (через кому без пробілів, elem1,elem2,...,elemN) елементів для заміни атрибуту xsi:nil';
/

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================


GRANT SELECT ON BARS.NBUR_REF_PREPARE_XML TO BARS_ACCESS_DEFROLE;
