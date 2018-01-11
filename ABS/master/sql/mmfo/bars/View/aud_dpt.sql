

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/AUD_DPT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view AUD_DPT ***

  CREATE OR REPLACE FORCE VIEW BARS.AUD_DPT ("PROD", "BRANCH", "ND", "DAOS", "KV", "NLSD", "OB22FD", "OSTD", "OB22PD", "NLSI", "OB22FI", "OSTI", "OB22PI") AS 
  SELECT 'D' || v.vidd, d.branch, d.deposit_id, ad.daos, ad.kv, ad.nls,
          NVL (ad.ob22, '__'), ad.ostc / 100, v.ob22de, ai.nls,
          NVL (ai.ob22, '__'), ai.ostc / 100, v.ob22ie
     FROM dpt_deposit d,
          int_accn i,
          accounts ad,
          accounts ai,
          (SELECT v.vidd, NVL (SUBSTR (p1.val, 1, 2), '__') ob22de,
                  NVL (SUBSTR (p2.val, 1, 2), '__') ob22ie
             FROM dpt_vidd v, dpt_vidd_params p1, dpt_vidd_params p2
            WHERE v.vidd = p1.vidd
              AND p1.tag = 'DPT_OB22'
              AND v.vidd = p2.vidd(+)
              AND NVL (p2.tag, 'INT_OB22') = 'INT_OB22') v
    WHERE d.acc = i.acc
      AND i.ID = 1
      AND d.vidd = v.vidd
      AND d.acc = ad.acc
      AND i.acra = ai.acc(+)
      AND (v.ob22de != NVL (ad.ob22, '__') OR v.ob22ie != NVL (ai.ob22, '__'))
   UNION ALL
   SELECT 'S' || v.vidd, s.branch, s.contract_id, ad.daos, ad.kv, ad.nls,
          NVL (ad.ob22, '__'), ad.ostc / 100, v.ob22de, ai.nls,
          NVL (ai.ob22, '__'), ai.ostc / 100, v.ob22ie
     FROM social_contracts s,
          social_dpt_types t,
          int_accn i,
          accounts ad,
          accounts ai,
          (SELECT v.vidd, NVL (SUBSTR (p1.val, 1, 2), '__') ob22de,
                  NVL (SUBSTR (p2.val, 1, 2), '__') ob22ie
             FROM dpt_vidd v, dpt_vidd_params p1, dpt_vidd_params p2
            WHERE v.vidd = p1.vidd
              AND p1.tag = 'DPT_OB22'
              AND v.vidd = p2.vidd(+)
              AND NVL (p2.tag, 'INT_OB22') = 'INT_OB22') v
    WHERE s.acc = i.acc(+)
      AND s.acc =  ad.acc(+)
      AND i.acra = ai.acc(+)
      AND s.type_id = t.type_id
      AND t.dpt_vidd = v.vidd
      AND s.acc = ad.acc
      AND (v.ob22de != NVL (ad.ob22, '__') OR v.ob22ie != NVL (ai.ob22, '__') );

PROMPT *** Create  grants  AUD_DPT ***
grant SELECT                                                                 on AUD_DPT         to BARSREADER_ROLE;
grant SELECT                                                                 on AUD_DPT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AUD_DPT         to SALGL;
grant SELECT                                                                 on AUD_DPT         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on AUD_DPT         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/AUD_DPT.sql =========*** End *** ======
PROMPT ===================================================================================== 
