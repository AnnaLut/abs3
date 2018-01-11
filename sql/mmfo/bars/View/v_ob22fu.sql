

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22FU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22FU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22FU ("ACC", "NLS", "NMS", "NBS", "OB22") AS 
  SELECT a.acc, a.nls, a.nms, a.nbs,  s.ob22
     FROM accounts a,
          specparam_int s
            WHERE a.acc = s.acc(+)
              AND a.kv = 980
              AND a.dazs is null 
              AND SUBSTR (nls, 1, 1) in ('6','7') 
 ;

PROMPT *** Create  grants  V_OB22FU ***
grant SELECT                                                                 on V_OB22FU        to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB22FU        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22FU        to START1;
grant SELECT                                                                 on V_OB22FU        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22FU        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22FU.sql =========*** End *** =====
PROMPT ===================================================================================== 
