SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     ON
SET TIMING       ON

begin

  lock table SPECPARAM in exclusive mode;

  bpa.disable_policies( 'SPECPARAM' );
  bpa.disable_policies( 'SPECPARAM_UPDATE' );

  insert /*+ APPEND */ 
    into SPECPARAM ( KF, ACC )
  select a.KF, a.ACC
    from ACCOUNTS a
    left
    join SPECPARAM s
      on ( s.ACC = a.ACC )
   where s.ACC is null;
  
  dbms_output.put_line( to_char(sql%rowcount) || ' rows inserted.' );
  
  bpa.enable_policies( 'SPECPARAM' );
  bpa.enable_policies( 'SPECPARAM_UPDATE' );
  
  commit;
  
end;
/