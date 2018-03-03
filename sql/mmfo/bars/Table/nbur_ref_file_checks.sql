-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 02.06.2016
-- ======================================================================================
-- create table NBUR_REF_FILE_CHECKS
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table NBUR_REF_FILE_CHECKS
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'NBUR_REF_FILE_CHECKS', 'WHOLE',  Null, Null, Null, Null );
  BPA.ALTER_POLICY_INFO( 'NBUR_REF_FILE_CHECKS', 'FILIAL', NULL,  'E',  'E',  'E' );
  BPA.ALTER_POLICY_INFO( 'NBUR_REF_FILE_CHECKS', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_REF_FILE_CHECKS
( CHK_ID          NUMBER(38)    CONSTRAINT CC_REFFILECHECKS_CHKID_NN  NOT NULL
, CHK_DSC         VARCHAR2(256) CONSTRAINT CC_REFFILECHECKS_CHKDSC_NN NOT NULL
, CHK_STE         NUMBER(1)     default 0 
                                constraint CC_REFFILECHECKS_ACTIVE_NN NOT NULL
, CHK_STMT        CLOB
, FILE_ID         NUMBER(5)     CONSTRAINT CC_REFFILECHECKS_FILEID_NN NOT NULL
, ACTV            number(1) as ( decode( CHK_STE, 1, 0, CHK_ID ) )
, constraint PK_REFFILECHECKS primary key ( CHK_ID ) using index tablespace BRSMDLI
, constraint FK_REFFILECHECKS_REFFILES foreign key ( FILE_ID ) references NBUR_REF_FILES ( ID )
) tablespace BRSMDLD
LOB ( CHK_STMT ) STORE AS SECUREFILE ( TABLESPACE BRSLOBD
                                       DISABLE STORAGE IN ROW
                                       COMPRESS HIGH
                                       NOCACHE
                                       NOLOGGING )]';
  
  dbms_output.put_line( 'Table "NBUR_REF_FILE_CHECKS" created.' );
  
exception
  when e_tab_exists
  then dbms_output.put_line( 'Table "NBUR_REF_FILE_CHECKS" already exists.' );
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate q'[create unique index UK_REFFILECHECKS_CHKSTE on NBUR_REF_FILE_CHECKS ( FILE_ID, CHK_STE, ACTV )
  tablespace BRSMDLI ]';
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
prompt -- Apply table policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'NBUR_REF_FILE_CHECKS' );
end;
/

commit;

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on table  BARS.NBUR_REF_FILE_CHECKS          is 'Довідник перевірок для сформоватих файлiв звітності';

comment on column BARS.NBUR_REF_FILE_CHECKS.CHK_ID   is 'Iд. перевірки';
comment on column BARS.NBUR_REF_FILE_CHECKS.CHK_DSC  is 'Опис перевірки';
comment on column BARS.NBUR_REF_FILE_CHECKS.FILE_ID  is 'Iд. файлу до якого застосовується перевірка';
comment on column BARS.NBUR_REF_FILE_CHECKS.CHK_STE  is 'Ознака активності (лише одна в межах файлу)';
comment on column BARS.NBUR_REF_FILE_CHECKS.CHK_STMT is 'Перевірочний запит';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON NBUR_REF_FILE_CHECKS TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
