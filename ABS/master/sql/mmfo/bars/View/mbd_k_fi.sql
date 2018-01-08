

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBD_K_FI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view MBD_K_FI ***

  CREATE OR REPLACE FORCE VIEW BARS.MBD_K_FI ("ACC", "CC_ID", "ND", "NBS", "NLS", "KV", "NMS", "BRANCH", "TAG", "VALUE", "SEMANTIC") AS 
  SELECT a.acc,
          p.cc_id,
          p.nd,
          a.nbs,
          a.nls,
          a.kv,
          a.nms,
          a.branch,
          w.tag,
          w.VALUE,
          s.semantic
     FROM (SELECT *
             FROM accounts
            WHERE nbs IN ('1623',
                          '1624',
                          '1627',
                          '1324',
                          '1327')) a,
          (SELECT *
             FROM accountsw
            WHERE tag = 'FI_ND') w,
          (SELECT *
             FROM sparam_list
            WHERE tag = 'FI_ND') s,
          mbd_k p
    WHERE     a.acc = w.acc(+)
          AND w.tag = 'FI_ND'
          AND w.tag = s.tag
          AND w.VALUE IS NOT NULL
          AND a.acc = p.acc;

PROMPT *** Create  grants  MBD_K_FI ***
grant SELECT                                                                 on MBD_K_FI        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBD_K_FI        to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBD_K_FI.sql =========*** End *** =====
PROMPT ===================================================================================== 
