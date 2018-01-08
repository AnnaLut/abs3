

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KU_107.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KU_107 ***

  CREATE OR REPLACE FORCE VIEW BARS.KU_107 ("KV", "LCV", "NAME", "DATN", "S", "S1", "S2", "S3", "PR", "DN") AS 
  SELECT t.kv, t.lcv, v.name,d.wdate, d.s,
       iif_n(k.wdate-d.wdate+1,11,d.s,0,0),
       iif_n(k.wdate-d.wdate+1,10,0,0,iif_n(k.wdate-d.wdate+1,36,d.s,0,0)),
       iif_n(k.wdate-d.wdate+1,35,0,0,d.s),
       acrn.fproc(d.accs,d.wdate) ,
       round(k.wdate-d.wdate+1)
FROM tabval  t,
     cc_deal k,
     cc_vidd v,
     cc_add  d
WHERE k.nd=d.nd     AND
      k.vidd=v.vidd AND
      v.tipd=1      AND
      d.adds=0      AND
      d.kv=t.kv;

PROMPT *** Create  grants  KU_107 ***
grant SELECT                                                                 on KU_107          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KU_107          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KU_107.sql =========*** End *** =======
PROMPT ===================================================================================== 
