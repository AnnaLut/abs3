

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_2909.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_2909 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_2909 ("NLS", "NMS", "OB22", "TXT", "SPLATA", "POVERN") AS 
  SELECT a.nls, a.nms, a.ob22, SUBSTR (n.txt, 1, 35) txt,
          CASE
             WHEN a.nbs = '2909'
                THEN make_docinput_url ('V29',
                                        'Виплата',
                                        'reqv_V2909',
                                        a.nls,
                                        'reqv_N2909',
                                        a.nms,
                                        'Nls_A',
                                        a.nls
                                       )
             ELSE NULL
          END splata,
          CASE
             WHEN a.nbs = '2909'
                THEN make_docinput_url ('P29',
                                        'Повернення',
                                        'reqv_V2909',
                                        a.nls,
                                        'reqv_N2909',
                                        a.nms,
                                        'Nls_A',
                                        a.nls
                                       )
             ELSE NULL
          END povern
     FROM accounts a,  sb_ob22 n
    WHERE a.nbs = '2909' AND a.ob22 IN ('49','50','51','53','54','01','29')
      AND a.dazs IS NULL
      AND bc.is_pbranch (a.branch, 1) = 1
      AND a.kv = 980
      AND a.nbs = n.r020
      AND a.ob22 = n.ob22
      AND n.d_close IS NULL;

PROMPT *** Create  grants  V_2909 ***
grant SELECT                                                                 on V_2909          to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V_2909          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_2909          to PYOD001;
grant SELECT                                                                 on V_2909          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_2909          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_2909          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_2909.sql =========*** End *** =======
PROMPT ===================================================================================== 
