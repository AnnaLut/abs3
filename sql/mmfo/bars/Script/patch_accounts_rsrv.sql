-- ================================================================================
-- Author : BAA
-- Date   : 26.02.2018
-- ================================== <Comments> ==================================
-- fill column ACCOUNTS_RSRV.RSRV_ID
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

begin
  BARS.NBUR_UTIL.NORMALIZATION_SEQUENCE('S_ACCOUNTS_RSRV','ACCOUNTS_RSRV','RSRV_ID');
end;
/

begin
  for c in ( select KF from BARS.MV_KF )
  loop
    BARS.BC.GO( c.KF );
    update BARS.ACCOUNTS_RSRV
       set RSRV_ID = S_ACCOUNTS_RSRV.NextVal
     where RSRV_ID is null;
    dbms_output.put_line( 'KF=' || c.KF || ': ' || to_char(sql%rowcount) || ' row(s) updated.' );
    commit;
  end loop;
  BARS.BC.HOME;
end;
/
