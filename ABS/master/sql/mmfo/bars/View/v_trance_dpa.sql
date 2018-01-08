

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TRANCE_DPA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TRANCE_DPA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TRANCE_DPA ("OC", "NLSALT", "KV", "DAT_ALT") AS 
  SELECT 'Відкритий в результаті трансформації' AS oc
      ,a.nlsalt
      ,a.kv
      ,a.dat_alt
  FROM bars.accounts a
      ,(SELECT DISTINCT nbs
          FROM dpa_nbs) dpa
      ,(SELECT *
          FROM bars.ree_tmp
         WHERE odat = to_date('18/12/2017'
                             ,'dd:mm:yyyy')) ree
 WHERE a.dat_alt IS NOT NULL
   AND substr(a.nlsalt
             ,1
             ,4) = dpa.nbs
   AND a.nlsalt = ree.nls
   AND a.kv = ree.kv
   AND a.nbs IS NOT NULL
   AND ree.ot = 5
UNION ALL
SELECT 'Закритий в результаті трансформації' AS ot
      ,a.nls
      ,a.kv
       ,a.dat_alt
  FROM bars.accounts a
      ,(SELECT DISTINCT nbs
          FROM bars.dpa_nbs) dpa
      ,(SELECT *
          FROM bars.ree_tmp
         WHERE odat = to_date('18/12/2017'
                             ,'dd:mm:yyyy')) ree
 WHERE a.dat_alt IS NOT NULL
   AND substr(a.nls
             ,1
             ,4) = dpa.nbs
   AND a.nls = ree.nls
   AND a.kv = ree.kv
   AND a.nbs IS NOT NULL
   AND ree.ot = 6;

PROMPT *** Create  grants  V_TRANCE_DPA ***
grant SELECT                                                                 on V_TRANCE_DPA    to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on V_TRANCE_DPA    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TRANCE_DPA.sql =========*** End *** =
PROMPT ===================================================================================== 
