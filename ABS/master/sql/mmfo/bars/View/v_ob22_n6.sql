

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22_N6.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22_N6 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22_N6 ("ACC", "ISP", "NLS", "NMS", "OST", "DAOS") AS 
  SELECT acc, isp, nls, nms, ostc, daos
     FROM accounts
    WHERE SUBSTR (nls, 1, 1) = '6%' and SUBSTR (nls, 1, 4) in
          (select r020_fa from sb_p0853 where r020_fa<>'0000')
      AND dazs IS NULL
      AND acc NOT IN (SELECT acc
                        FROM v_ob22nu) 
 ;

PROMPT *** Create  grants  V_OB22_N6 ***
grant SELECT                                                                 on V_OB22_N6       to BARSREADER_ROLE;
grant SELECT                                                                 on V_OB22_N6       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OB22_N6       to NALOG;
grant SELECT                                                                 on V_OB22_N6       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22_N6       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22_N6.sql =========*** End *** ====
PROMPT ===================================================================================== 
