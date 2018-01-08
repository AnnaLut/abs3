

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_KV_KURS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_KV_KURS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_KV_KURS ("KV", "NAME", "KURS_S", "KURS_B", "BLK") AS 
  SELECT t.kv kv, (t.lcv||' '||t.name) name, d.kurs_s, d.kurs_b, d.blk
  FROM tabval t,
       (select user_id, kv, sort_ord from tabval_sort where user_id = USER_ID()) s,
       (select kv, kurs_s, kurs_b, blk
          from diler_kurs d_k
         where dat = (select max(dat)
                        from diler_kurs
                       where trunc(dat) = trunc(sysdate) AND kv = d_k.kv)) d
 WHERE t.kv != 980
   AND t.kv = s.kv(+)
   AND t.kv = d.kv(+)
ORDER BY s.sort_ord, t.kv;

PROMPT *** Create  grants  V_ZAY_KV_KURS ***
grant SELECT                                                                 on V_ZAY_KV_KURS   to BARSREADER_ROLE;
grant SELECT                                                                 on V_ZAY_KV_KURS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_KV_KURS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_KV_KURS.sql =========*** End *** 
PROMPT ===================================================================================== 
