

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZ_NLO_351_1414.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZ_NLO_351_1414 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZ_NLO_351_1414 ("DAT", "RNK", "BRANCH", "NBS", "ND", "KV", "NLS", "NMK", "SDATE", "WDATE", "FIN", "KAT", "BV", "BVQ", "REZ", "REZQ", "ZAL", "ZALQ", "TIP", "OB22", "PD", "LGD", "CUSTTYPE", "OKPO", "RZ", "ISTVAL", "S080", "TIP_FIN") AS 
  SELECT B, 
          rnk,  
          branch, 
          nbs,
          acc, 
          kv, 
          nls, 
          nmk, 
          daos, 
          mdate, 
          FIN, 
          kat, 
          BV, 
          gl.p_icurval( kv, BV *100, NVL (TO_DATE (pul.get_mas_ini_val ('zFdat1'), 'dd.mm.yyyy'), gl.bd))/100 bvq,
          0 REZ,
          --round(GREATEST(f_pd(NVL(TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd) , rnk, acc, custtype,kv, nbs, fin, 0) * LGD * BV, 0),2) REZ,
          0 REZQ, 
          ZAL,
          ZALQ, 
          TIP, 
          OB22, 
          0 pd,
          --f_pd ( NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd) , rnk, acc, custtype,kv, nbs, fin, 0) PD,
          LGD,
          custtype,
          okpo,
          RZ,
          ISTVAL,
          f_get_s080 (nvl(TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd),
                      f_pd ( NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd), 
                             rnk, 
                             acc, 
                             custtype,
                             kv, 
                             nbs, 
                             fin, 
                             1
                            ), 
                      1) s080,
      f_pd ( NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd) , rnk, acc, custtype,kv, nbs, fin, 1) tip_fin 
     FROM (SELECT nvl(TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd) B, 
                  a.rnk, 
                  a.branch, 
                  a.acc, 
                  a.kv, 
                  a.nls, 
                  a.daos, 
                  a.mdate, 
                  nvl(a.nbs,substr(a.nls,1,4)) NBS,
                  1 FIN,  
                  --nvl(f_rnk_maxfin( NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd), a.rnk, decode(c.custtype,2,2,1), a.acc, 1), 1) fin,
                  1 kat, 
                  -OST_KORR (a.acc, NVL (TO_DATE (pul.get_mas_ini_val ('zFdat1'), 'dd.mm.yyyy'), gl.bd),z23.di, a.nbs) / 100 BV, 
                  nvl(a.ob22,'01') ob22, 
                  a.tip, 
                  0 ZAL,
                  0 ZALQ,  
                  c.custtype, 
                  c.OKPO,
                  substr(c.nmk,1,35) NMK,
                  1 LGD,
                  DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ,
                  (select NVL(istval,'0') from specparam  where acc = a.acc) istval
             FROM acc_nlo_1414 al, accounts a, customer c
            WHERE al.acc = a.acc and a.rnk=c.rnk AND 
                  OST_KORR (a.acc,  NVL (TO_DATE (pul.get_mas_ini_val ('zFdat1'), 'dd.mm.yyyy'), gl.bd), z23.di, a.nbs) < 0);

PROMPT *** Create  grants  V_REZ_NLO_351_1414 ***
grant SELECT                                                                 on V_REZ_NLO_351_1414 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZ_NLO_351_1414 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZ_NLO_351_1414.sql =========*** End
PROMPT ===================================================================================== 
