-- ================================================================================
-- Module   : SOC
-- Author   : BAA
-- Date     : 11.07.2017
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     ON

prompt -- ======================================================
prompt -- Remove duplicates
prompt -- ======================================================

merge
 into SOCIAL_AGENCY sa
using ( select TYPE_ID, BRANCH
              , max(DATE_ON)   as MAX_DATE_ON
              , max(AGENCY_ID) as MAX_AGNC_ID
           from SOCIAL_AGENCY
          where DATE_OFF Is Null 
          group by TYPE_ID, BRANCH
         having count(1) > 1
      ) d
   on ( sa.TYPE_ID = d.TYPE_ID and sa.BRANCH = d.BRANCH )
 when MATCHED 
 then update
         set sa.DATE_OFF = greatest(d.MAX_DATE_ON, sa.DATE_ON)
           , sa.DETAILS  = 'Duplicate of social agency #' || to_char(d.MAX_AGNC_ID)
       where sa.AGENCY_ID < d.MAX_AGNC_ID
;

commit;



prompt -- ======================================================
prompt -- Index
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
 execute immediate q'[create index IDX_SOCIALAGENCY_TPID_BR on SOCIAL_AGENCY ( TYPE_ID, BRANCH )
  tablespace BRSSMLI
  compress 1 ]';
  dbms_output.put_line( 'Index "IDX_SOCIALAGENCY_TPID_BR" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

prompt -- ======================================================
prompt -- Finish
prompt -- ======================================================
