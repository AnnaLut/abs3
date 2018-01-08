

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OB22_NN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OB22_NN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OB22_NN ("OB22", "ACC", "ISP", "NLS", "NMS", "OST", "DAOS", "VIDF") AS 
  SELECT s.ob22, a.acc, a.isp, a.nls, a.nms, a.ostc, a.daos,
       decode(a.vid,89,1,0) vidf
     FROM accounts a,specparam_int s
    WHERE a.acc=s.acc(+) and
        SUBSTR (a.nls, 1, 4) in
          (select r020_fa from sb_p0853 where r020_fa<>'0000')
      AND a.dazs IS NULL
      AND a.acc NOT IN (SELECT acc FROM v_ob22nu)
      order by ob22;

PROMPT *** Create  grants  V_OB22_NN ***
grant SELECT,UPDATE                                                          on V_OB22_NN       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_OB22_NN       to NALOG;
grant SELECT                                                                 on V_OB22_NN       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OB22_NN       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OB22_NN.sql =========*** End *** ====
PROMPT ===================================================================================== 
