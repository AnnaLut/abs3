

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_30.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_30 ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_30 ("ACC", "ID", "KV", "NLS", "DAT1", "DAT2", "FREQ", "S", "MFOP", "NLSP") AS 
  SELECT a.acc,d.deposit_id,a.kv,a.nls,i.apl_dat,
       decode(v.freq_k,
                  1,i.apl_dat+1,
                  3,i.apl_dat+7,
                  5,ADD_MONTHS(i.apl_dat,1),
                  7,ADD_MONTHS(i.apl_dat,3),
                    ADD_MONTHS(i.apl_dat,v.freq_k/30)),
       v.freq_k,a.ostc, d.mfo_p,d.nls_p
FROM dpt_deposit d, accounts a, int_accN i, dpt_vidd v
WHERE d.acc=i.acc         AND
      i.id=1              AND
      i.acra=a.acc        AND
      d.vidd=v.vidd       AND
      d.mfo_p is not NULL AND
      d.nls_p is not NULL
 ;

PROMPT *** Create  grants  DPT_30 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_30          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_30.sql =========*** End *** =======
PROMPT ===================================================================================== 
