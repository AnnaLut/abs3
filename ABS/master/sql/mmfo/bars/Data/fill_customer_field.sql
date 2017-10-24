-- ======================================================================================
-- Module  : CDM (ЄБК)
-- Author  : BAA
-- Date    : 11.10.2016
-- ======================================================================================
-- COBUCDMCORP-64
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
set echo         Off
set lines        500
set pages        500
set termout      On
set timing       Off
set trimspool    On

begin
  Insert into BARS.CUSTOMER_FIELD
    ( TAG, NAME, B, U, F, TABNAME, TYPE, OPT, TABCOLUMN_CHECK
    , SQLVAL, CODE, NOT_TO_EDIT, U_NREZ, F_NREZ, F_SPD )
  Values
    ( 'EXCLN', 'ІПН є виключенням (не проходить валідацію по алгоритму)', 0, 0, 1, 'V_YESNO', 'N', 0, 'ID'
    , 'select ''0'' from dual', 'GENERAL', 1, 0, 0, 1 );
exception
  when dup_val_on_index then
    update BARS.CUSTOMER_FIELD
       set NAME        = 'ІПН є виключенням (не проходить валідацію по алгоритму)'
         , B           = 0
         , U           = 0
         , F           = 1
         , TABNAME     = 'V_YESNO'
         , TABCOLUMN_CHECK = 'ID'
         , SQLVAL      = 'select ''0'' from dual'
         , TYPE        = 'N'
         , OPT         = 0
         , CODE        = 'GENERAL'
         , NOT_TO_EDIT = 1
         , U_NREZ      = 0
         , F_NREZ      = 0
         , F_SPD       = 1
     where TAG = 'EXCLN';
end;
/

COMMIT;
