-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 17.05.2017
-- ======================================================================================
-- create table NBUR_REF_XSD
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
prompt -- create table NBUR_REF_XSD
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'NBUR_REF_XSD', 'WHOLE',  Null, Null, Null, Null );
  BPA.ALTER_POLICY_INFO( 'NBUR_REF_XSD', 'FILIAL', Null,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table NBUR_REF_XSD
( FILE_ID    number(5)     constraint CC_NBURREFXSD_FILEID_NN Not Null
, SCM_DT     date          constraint CC_NBURREFXSD_SCMDT_NN  Not Null
, SCM_URL    varchar2(512) constraint CC_NBURREFXSD_SCMURL_NN Not Null
, CHG_USR    number(38)    constraint CC_NBURREFXSD_CHGUSR_NN Not Null
, CHG_DT     date          constraint CC_NBURREFXSD_CHGDT_NN  Not Null
, constraint PK_NBURREFXSD primary key ( FILE_ID, SCM_DT ) using index tablespace BRSSMLI
, constraint UK_NBURREFXSD_SCMURL unique ( SCM_URL ) using index tablespace BRSSMLI
, constraint FK_NBURREFXSD_REFFILES FOREIGN KEY ( FILE_ID ) references NBUR_REF_FILES ( ID )
) TABLESPACE BRSSMLD
]';
  
  dbms_output.put_line( 'Table "NBUR_REF_XSD" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "NBUR_REF_XSD" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

SET FEEDBACK ON

begin
  BPA.ALTER_POLICIES( 'NBUR_REF_XSD' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBUR_REF_XSD         IS 'Довідник XSD схем для файлів звітності НБУ';

COMMENT ON COLUMN NBUR_REF_XSD.FILE_ID IS 'Ід файлу';
COMMENT ON COLUMN NBUR_REF_XSD.SCM_DT  IS 'Date of the XML Schema document';
COMMENT ON COLUMN NBUR_REF_XSD.SCM_URL IS 'The XML Schema document';
COMMENT ON COLUMN NBUR_REF_XSD.CHG_USR IS 'Change user id';
COMMENT ON COLUMN NBUR_REF_XSD.CHG_DT  IS 'Change date';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON NBUR_REF_XSD TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
