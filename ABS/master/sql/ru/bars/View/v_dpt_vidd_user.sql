

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_USER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_VIDD_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_VIDD_USER ("VIDD", "TYPE_NAME", "KV", "TYPE_ID") AS 
  (select vidd, type_name, kv, type_id
     from dpt_vidd 
    where flag = 1 
      and (select nvl(val, '0') from params$global where par = 'DPT_ADM') = '0'
    union 
   select v.vidd, v.type_name, v.kv, v.type_id
     from dpt_vidd v, dpt_vidd_staff s, params$global p 
    where v.flag = 1 
      and v.vidd = s.vidd
      and s.userid = user_id 
      and s.approve = 1
      and date_is_valid (s.adate1, s.adate2, s.rdate1, s.rdate2) = 1
      and p.par = 'DPT_ADM'
      and p.val in ('1', '2')
    union 
   select v.vidd, v.type_name, v.kv, v.type_id
     from dpt_vidd v, dpt_vidd_branch b, params$global p
    where v.flag = 1 
      and v.vidd = b.vidd 
      and b.branch = sys_context('bars_context','user_branch')
      and p.par = 'DPT_ADM' 
      and p.val = '2' 
   ) ;

PROMPT *** Create  grants  V_DPT_VIDD_USER ***
grant SELECT                                                                 on V_DPT_VIDD_USER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_VIDD_USER to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_VIDD_USER to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_USER.sql =========*** End **
PROMPT ===================================================================================== 
