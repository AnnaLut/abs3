 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== MV_ASVO_IMMOBILE_MMFO full refresh =========*** Run *** ========
 PROMPT ===================================================================================== 
begin
  mmfo_login.login_user(sys_guid,1,'CRNV',null);  
  mmfo_bc.go('/');
  dbms_mview.refresh(list => 'MV_ASVO_IMMOBILE_MMFO',method => 'COMPLETE',atomic_refresh => false);
end;
/

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== MV_ASVO_IMMOBILE_MMFO gather stats =========*** Run *** ========
 PROMPT ===================================================================================== 

begin
  dbms_stats.gather_table_stats(ownname          => 'BARS',
                                tabname          => 'MV_ASVO_IMMOBILE_MMFO',
                                cascade          => true);
end;
/

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== MV_ASVO_IMMOBILE_CRNV full refresh =========*** Run *** ========
 PROMPT ===================================================================================== 

begin
  dbms_mview.refresh(list => 'MV_ASVO_IMMOBILE_CRNV',method => 'COMPLETE',atomic_refresh => false);  
end;  
/

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== MV_ASVO_IMMOBILE_CRNV gather stats =========*** Run *** ========
 PROMPT ===================================================================================== 

begin
  dbms_stats.gather_table_stats(ownname          => 'BARS',
                                tabname          => 'MV_ASVO_IMMOBILE_CRNV',
                                cascade          => true);
end;
/
