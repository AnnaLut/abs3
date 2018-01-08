

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BBBBS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BBBBS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BBBBS ("SDAT", "BRANCH", "NBS", "S985A", "S756A", "S124A", "S840A", "S643A", "S978A", "S826A", "S959A", "S961A", "S985P", "S756P", "S124P", "S840P", "S643P", "S978P", "S826P", "S959P", "S961P", "S985S", "S756S", "S124S", "S840S", "S643S", "S978S", "S826S", "S959S", "S961S") AS 
  SELECT SUBSTR ( (pul.get_mas_ini_val ('sFdat1')), 1, 10) sdat,
          BRANCH,
          NBS,
          S985A,
          S756A,
          S124A,
          S840A,
          S643A,
          S978A,
          S826A,
          S959A,
          S961A,
          S985P,
          S756P,
          S124P,
          S840P,
          S643P,
          S978P,
          S826P,
          S959P,
          S961P,
          S985A + S985P,
          S756A + S756P,
          S124a + S124P,
          S840a + S840p,
          S643a + S643p,
          S978a + S978p,
          S826a + S826p,
          S959a + S959p,
          S961a + S961p
     FROM (  SELECT branch,
                    NBS,
                    -SUM (DECODE (kv, 985, sa, 0)) / 100 S985A,
                    -SUM (DECODE (kv, 756, sa, 0)) / 100 S756A,
                    -SUM (DECODE (kv, 124, sa, 0)) / 100 S124A,
                    -SUM (DECODE (kv, 840, sa, 0)) / 100 S840A,
                    -SUM (DECODE (kv, 643, sa, 0)) / 100 S643A,
                    -SUM (DECODE (kv, 978, sa, 0)) / 100 S978A,
                    -SUM (DECODE (kv, 826, sa, 0)) / 100 S826A,
                    -SUM (DECODE (kv, 959, sa, 0)) / 100 S959A,
                    -SUM (DECODE (kv, 961, sa, 0)) / 100 S961A, --------------------------
                    SUM (DECODE (kv, 985, sp, 0)) / 100 S985p,
                    SUM (DECODE (kv, 756, sp, 0)) / 100 S756p,
                    SUM (DECODE (kv, 124, sp, 0)) / 100 S124p,
                    SUM (DECODE (kv, 840, sp, 0)) / 100 S840p,
                    SUM (DECODE (kv, 643, sp, 0)) / 100 S643p,
                    SUM (DECODE (kv, 978, sp, 0)) / 100 S978p,
                    SUM (DECODE (kv, 826, sp, 0)) / 100 S826p,
                    SUM (DECODE (kv, 959, sp, 0)) / 100 S959p,
                    SUM (DECODE (kv, 961, sp, 0)) / 100 S961p
               FROM (SELECT branch,
                            kv,
                            NBS,
                            DECODE (SIGN (s), -1, -s, 0) sa,
                            DECODE (SIGN (s), 1, s, 0) sp
                       FROM (SELECT a.branch,
                                    a.kv,
                                    a.NBS,
                                    fost(acc,NVL (TO_DATE ( pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd))  S
                               FROM v_gl a
                              WHERE     a.nbs LIKE NVL ( pul.get_mas_ini_val ('sFdat2'),'3800')
                                    AND a.kv <> 980
                                   ))
           GROUP BY branch, NBS);

PROMPT *** Create  grants  V_BBBBS ***
grant SELECT                                                                 on V_BBBBS         to BARSREADER_ROLE;
grant SELECT                                                                 on V_BBBBS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BBBBS         to SALGL;
grant SELECT                                                                 on V_BBBBS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BBBBS.sql =========*** End *** ======
PROMPT ===================================================================================== 
