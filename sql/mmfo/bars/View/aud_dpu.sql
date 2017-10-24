

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AUD_DPU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view AUD_DPU ***

  CREATE OR REPLACE FORCE VIEW BARS.AUD_DPU ("VIDD", "NAME", "BRANCH", "ND", "DAOS", "KV", "ACC", "NLSD", "F_OB22D", "P_OB22D", "OSTD", "ACRA", "NLSI", "F_OB22I", "P_OB22I", "OSTI", "ACRB", "NLS7D", "F_OB227D", "P_OB227D", "ACCS", "NLS7K", "F_OB227K", "P_OB227K") AS 
  SELECT q.vidd, u.NAME, q.branch, q.nd, q.daos, q.kv, q.acc, q.nlsd,
         q.f_ob22d, u.ob22_dep, q.ostd, q.acra, q.nlsi, q.f_ob22i,
         u.ob22_int, q.osti, q.acrb, q.nls7d, q.f_ob227d, u.ob22_exp, q.accs,
         q.nls7k, q.f_ob227k, u.ob22_red
    FROM BARS.DPU_VIDD_OB22 u,
         (SELECT o.vidd, o.nd, o.daos, o.kv, o.branch, o.acc, o.nlsd,
                 o.f_ob22d, o.ostd, o.acra, o.nlsi, o.f_ob22i, o.osti,
                 o.acrb, o.nls7d, o.f_ob227d, s.acc accs, s.nls nls7k,
                 s.ob22 f_ob227k
             FROM accounts s,
                  (SELECT d.vidd, t.branch, d.nd, t.daos, t.kv, t.acc acc,
                          t.nls nlsd, t.ob22 f_ob22d, t.ostc / 100 ostd,
                          a.acc acra, a.nls nlsi, a.ob22 f_ob22i,
                          a.ostc / 100 osti, b.acc acrb, b.nls nls7d, b.ob22 f_ob227d
                     FROM int_accn i,  accounts t,
                          accounts a,  accounts b,
                          (SELECT vidd, dpu_id nd, acc  FROM dpu_deal) d
                    WHERE d.acc=i.acc AND i.acc=t.acc AND i.acra=a.acc AND i.acrb=b.acc ) o,
                  (SELECT nbs,rezid vidd, branch, NVL(g67n, g67) g, NVL (v67n, v67) v
                   FROM proc_dr$base WHERE sour = 4) p
            WHERE s.kv = 980
              AND s.nls = DECODE (o.kv, 980, g, v)
              AND p.nbs = SUBSTR (o.nlsd, 1, 4)
              AND p.vidd = o.vidd
              AND p.branch = o.branch) q
    WHERE u.vidd = q.vidd
      AND (   NVL (q.f_ob22d,  '  ') <> NVL (u.ob22_dep, '  ')
           OR NVL (q.f_ob22i,  '  ') <> NVL (u.ob22_int, '  ')
           OR NVL (q.f_ob227d, '  ') <> NVL (u.ob22_exp, '  ')
           OR NVL (q.f_ob227k, '  ') <> NVL (u.ob22_red, '  ')
          );

PROMPT *** Create  grants  AUD_DPU ***
grant SELECT                                                                 on AUD_DPU         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AUD_DPU         to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AUD_DPU.sql =========*** End *** ======
PROMPT ===================================================================================== 
