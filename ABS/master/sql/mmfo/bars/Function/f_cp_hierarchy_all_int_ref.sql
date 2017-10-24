
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cp_hierarchy_all_int_ref.sql ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CP_HIERARCHY_ALL_INT_REF (p_id in cp_kod.id%type, p_date_start date, p_date_finish date, p_CP_ACCTYPE cp_accounts.CP_ACCTYPE%type, p_level int) return varchar2
is
l_res varchar2(32000);
begin
 bars_audit.info('f_cp_hierarchy_all_int: start p_id=' || p_id ||', p_date_start= ' ||to_char(p_date_start,'dd/mm/yyyy') ||', p_date_finish= ' ||to_char(p_date_finish,'dd/mm/yyyy') ||',p_CP_ACCTYPE=' || p_CP_ACCTYPE ||',p_level =' ||p_level );
 
  for times in (
    select ds, df, h_id, cp_id from(
    select GREATEST (cph.fdat, p_date_start) ds,
           GREATEST (NVL (LEAD (cph.fdat, 1) OVER (PARTITION BY cph.cp_id ORDER BY cph.fdat ASC), p_date_finish),p_date_finish) AS df, HIERARCHY_ID h_id, cp_id    
      from CP_HIERARCHY_HIST cph
     where (cph.fdat between p_date_start and p_date_finish
       OR (cph.fdat <= p_date_start and f_cp_get_hierarchy (cph.cp_id, p_date_finish) = cph.HIERARCHY_ID))
       and cph.cp_id = p_id)       
       where H_ID = p_level)
 loop        
       l_res := nvl(l_res,'') || nvl( f_cp_hierarchy_int_ref(p_id =>p_id,
                                                             p_date_start=>times.ds, 
                                                             p_date_finish=>times.df,
                                                             p_CP_ACCTYPE=>p_CP_ACCTYPE),0);
 end loop;                                           

return nvl(substr(l_res,1,2000),'');
end f_cp_hierarchy_all_int_ref;
/
 show err;
 
PROMPT *** Create  grants  F_CP_HIERARCHY_ALL_INT_REF ***
grant EXECUTE                                                                on F_CP_HIERARCHY_ALL_INT_REF to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cp_hierarchy_all_int_ref.sql ====
 PROMPT ===================================================================================== 
 