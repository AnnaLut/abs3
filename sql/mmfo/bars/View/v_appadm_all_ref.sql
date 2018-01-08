

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_REF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_APPADM_ALL_REF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_APPADM_ALL_REF ("TABID", "NAME", "ROLENAME", "REFTYPE") AS 
  select a.tabid, b.semantic, a.role2edit, t.name
  from references a, meta_tables b, typeref t
 where a.tabid = b.tabid
   and a.type  = t.type
minus
select a.tabid, t.semantic, a.role2edit, t.name
  from references a, meta_tables t, refapp b, typeref t
 where a.tabid = t.tabid
   and a.tabid = b.tabid
   and a.type  = t.type
   and b.codeapp = sys_context('bars_useradm', 'codeapp') 
 ;

PROMPT *** Create  grants  V_APPADM_ALL_REF ***
grant SELECT                                                                 on V_APPADM_ALL_REF to ABS_ADMIN;
grant SELECT                                                                 on V_APPADM_ALL_REF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_APPADM_ALL_REF.sql =========*** End *
PROMPT ===================================================================================== 
