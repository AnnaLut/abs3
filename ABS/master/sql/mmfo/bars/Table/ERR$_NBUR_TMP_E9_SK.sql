-- ======================================================================================
-- Module : NBUR
-- Author : Virko
-- Date   : 13.03.2018
-- ======================================================================================
-- create table ERR$_NBUR_TMP_E9_SK
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table ERR$_NBUR_TMP_E9_SK
prompt -- ======================================================

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[CREATE TABLE BARS.ERR$_NBUR_TMP_E9_SK
    (
      ORA_ERR_NUMBER$  NUMBER,
      ORA_ERR_MESG$    VARCHAR2(2000 BYTE),
      ORA_ERR_ROWID$   UROWID(4000),
      ORA_ERR_OPTYP$   VARCHAR2(2 BYTE),
      ORA_ERR_TAG$     VARCHAR2(2000 BYTE),
      REPORT_DATE      DATE
    , KF               VARCHAR2(4000 BYTE)
    , CTEDRPOU         VARCHAR2(4000 BYTE)
    , CTKOD_EKP        VARCHAR2(4000 BYTE)
    , CTKOD_D060_1     VARCHAR2(4000 BYTE)
    , CTKOD_K020       VARCHAR2(4000 BYTE)
    , CTKOD_K021       VARCHAR2(4000 BYTE)
    , CTKOD_F001       VARCHAR2(4000 BYTE)
    , CTKOD_R030       VARCHAR2(4000 BYTE)
    , CTKOD_K040_1     VARCHAR2(4000 BYTE)
    , CTKOD_KU_1       VARCHAR2(4000 BYTE)
    , CTKOD_K040_2     VARCHAR2(4000 BYTE)
    , CTKOD_KU_2       VARCHAR2(4000 BYTE)
    , CTKOD_T071       VARCHAR2(4000 BYTE)
    , CTKOD_T080       VARCHAR2(4000 BYTE)
    , CTKOD_D060_2     VARCHAR2(4000 BYTE)
    , CTKOD_Q001       VARCHAR2(4000 BYTE) 
    )
    TABLESPACE BRSDYND ]';

  dbms_output.put_line('table "ERR$_NBUR_TMP_E9_SK" created.');

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "ERR$_NBUR_TMP_E9_SK" already exists.' );
end;
/

COMMENT ON TABLE BARS.ERR$_NBUR_TMP_E9_SK IS 'DML Error Logging table for "NBUR_TMP_E9_SK"';
