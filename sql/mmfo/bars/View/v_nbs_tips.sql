

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBS_TIPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBS_TIPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBS_TIPS ("NBS", "OB22", "TIP", "NAME", "ORD") AS 
  select n.NBS, n.OB22, n.TIP, t.NAME, t.ORD
  from NBS_TIPS n
  join TIPS     t
    on ( t.TIP = n.TIP )
 union
select p.NBS, null, t.TIP, t.NAME, t.ORD
  from PS   p
     , TIPS t
 where regexp_like( p.NBS, '^\d{4}$')
   and t.TIP = 'ODB'
 union
select null, null, t.TIP, t.NAME, t.ORD
  from TIPS t
 where t.TIP = 'ODB';

PROMPT *** Create  grants  V_NBS_TIPS ***
grant SELECT                                                                 on V_NBS_TIPS      to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBS_TIPS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBS_TIPS      to CUST001;
grant SELECT                                                                 on V_NBS_TIPS      to START1;
grant SELECT                                                                 on V_NBS_TIPS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBS_TIPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
