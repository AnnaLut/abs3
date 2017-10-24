-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 21.06.2017
-- ===================================== <Comments> =====================================
-- create unique index
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET TIMING       OFF
SET DEFINE       OFF
SET FEEDBACK     OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

declare
  E_IDX_NOT_EXIST        exception;
  pragma exception_init( E_IDX_NOT_EXIST, -01418 );
begin
  execute immediate 'drop index UK_NBURLSTOBJECTS_OBJECTSTATUS';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXIST then
    dbms_output.put_line( 'Specified index does not exist.' );
end;
/

SET FEEDBACK ON

merge
 into NBUR_LST_OBJECTS v
using ( select REPORT_DATE, KF, OBJECT_ID
             , max(VERSION_ID) as MAX_VRSN_ID
         from NBUR_LST_OBJECTS
         group by REPORT_DATE, KF, OBJECT_ID
        having sum( decode(OBJECT_STATUS, 'FINISHED',1,'BLOCKED',1,0) ) > 1
      ) t
   on ( t.REPORT_DATE = v.REPORT_DATE and t.KF = v.KF and t.OBJECT_ID = v.OBJECT_ID )
when matched 
then update 
        set OBJECT_STATUS = 'INVALID'
      where v.VERSION_ID  < t.MAX_VRSN_ID
;

commit;

SET FEEDBACK OFF

begin
  NBUR_UTIL.SET_COL('NBUR_LST_OBJECTS','VERSION_ID','NUMBER(3)');
  NBUR_UTIL.SET_COL('NBUR_LST_OBJECTS','VLD',q'[NUMBER(3) GENERATED ALWAYS AS ( decode( OBJECT_STATUS, 'FINISHED', 0, 'BLOCKED', 0, VERSION_ID ) )]', Null, 'Valid version' );
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
  execute immediate q'[create unique index UK_NBURLSTOBJECTS_OBJECTSTATUS on NBUR_LST_OBJECTS ( REPORT_DATE, KF, OBJECT_ID, VLD )
  TABLESPACE BRSMDLI
  COMPRESS 3 ]';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/
