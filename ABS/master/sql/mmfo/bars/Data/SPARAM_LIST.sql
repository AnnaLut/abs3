-- ======================================================================================
-- Author : BAA
-- Date   : 18.05.2017
-- ===================================== <Comments> =====================================
-- OB22
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF

begin
  update SPARAM_LIST
     set TABNAME = 'ACCOUNTS'
       , INUSE   = 0
   where NAME    = 'OB22';
  if ( sql%rowcount > 0 )
  then
    dbms_output.put_line( 'Changed name of the table for parameter OB22.' );
  end if;
end;
/

commit;
