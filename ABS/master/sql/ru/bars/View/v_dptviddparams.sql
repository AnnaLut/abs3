

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPTVIDDPARAMS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPTVIDDPARAMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPTVIDDPARAMS ("VIDD", "VIDDNAME", "TAG", "TAGNAME", "EDITABLE", "PARAMVAL") AS 
  select v.vidd, v.type_name, t.tag, t.name, t.editable,
      (select substr(p.val, 1, 254) val
         from dpt_vidd_params p
        where p.vidd = v.vidd
          and p.tag  = t.tag)
  from dpt_vidd_tags t,
       dpt_vidd      v
 where t.status = 'Y' ;

PROMPT *** Create  grants  V_DPTVIDDPARAMS ***
grant SELECT                                                                 on V_DPTVIDDPARAMS to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPTVIDDPARAMS.sql =========*** End **
PROMPT ===================================================================================== 
