

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/LORO_SEP_SWT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view LORO_SEP_SWT ***

  CREATE OR REPLACE FORCE VIEW BARS.LORO_SEP_SWT ("REC_O", "VDAT", "REF", "S", "D_REC", "BIC", "COUNTRY", "MFOA", "NLSA", "NAM_A", "NLSB", "NAM_B", "NAZN", "ACC", "KV", "RNK", "KOD_N", "P59_1", "P59_2", "K50", "P57", "P70") AS 
  SELECT t.rec_o, o.vdat, o.REF, o.s/100 S, o.d_rec, b.bic, c.country, o.mfoa, o.nlsa, o.nam_a, o.nlsB, o.nam_b, o.nazn,
         a.acc, a.kv, a.rnk, '1222' KOD_N, '' P59_1, '' P59_2,
         SUBSTR (Bars_swift.STRTOSWIFT (o.nam_a), 1,  38) k50,
         SUBSTR (Bars_swift.STRTOSWIFT (o.nam_b), 1,  38) P57,
         SUBSTR (Bars_swift.STRTOSWIFT (o.nazn ), 1, 160) p70
   FROM oper o,  customer c,
       (select * from accounts where nbs='1600' AND kv=980 ) a,
       (select * from t902     where blk=8                 ) t,
       (select * from custbank where bic IS NOT NULL       ) b
   WHERE o.REF=t.REF AND o.kv=a.kv AND o.nlsb=a.nls AND a.rnk=c.rnk  AND a.rnk=b.rnk
  ;

PROMPT *** Create  grants  LORO_SEP_SWT ***
grant SELECT                                                                 on LORO_SEP_SWT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LORO_SEP_SWT    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/LORO_SEP_SWT.sql =========*** End *** =
PROMPT ===================================================================================== 
