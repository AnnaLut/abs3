

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TARIF_SCHEME_ACCBRANCH.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TARIF_SCHEME_ACCBRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TARIF_SCHEME_ACCBRANCH ("ID", "NAME", "BRANCH") AS 
  select a.id, a.name, a.branch
  from ( select t.id, t.name, b.branch, (select max(branch) from tarif_scheme_accbranch where id = t.id and b.branch like branch||'%') br
           from tarif_scheme t, branch b
          where t.id in (select unique id from tarif_scheme_accbranch)
            and (t.d_close is null or d_close > bankdate) ) a,
       tarif_scheme_accbranch s
 where a.id = s.id and a.br = s.branch
   and nvl(s.dat_begin,bankdate) <= bankdate
   and nvl(s.dat_end,bankdate) >= bankdate;

PROMPT *** Create  grants  V_TARIF_SCHEME_ACCBRANCH ***
grant SELECT                                                                 on V_TARIF_SCHEME_ACCBRANCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TARIF_SCHEME_ACCBRANCH to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TARIF_SCHEME_ACCBRANCH.sql =========*
PROMPT ===================================================================================== 
