

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_INTEREST_CRSOUR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_INTEREST_CRSOUR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_INTEREST_CRSOUR ("TTB", "VOB", "NLS", "KV", "MFOB", "NLSB", "KVB", "DK", "SUMR", "ORIGINAL_AMOUNT", "NAMB", "NAZN", "ACC", "OKPO", "NMS", "NMK", "FLI", "SNLS", "DEAL_NUMBER") AS 
  select i.ttb,
       decode(a.kv,
              i.kvb,
              decode(i.mfob,
                     f_ourmfo_g,
                     6,
                     decode(substr(s.nls, 1, 1), '2', 1, 6)),
              16) vob,
       a.nls,
       a.kv,
       i.mfob,
       i.nlsb,
       i.kvb,
       case when a.ostc < 0 then 0 else 1 end as dk,
       a.ostc / 100 sumr,
       a.ostc original_amount,
       i.namb,
       i.nazn,
       i.acc,
       nvl(i.okpo, k.okpo) okpo,
       a.nms,
       k.nmk,
       t.fli,
       s.nls snls, --?
       (select min(d.cc_id) keep (dense_rank first order by case when d.sos = 15 then 2 else 1 end, d.nd)
        from   cc_add dd
        join   cc_deal d on d.nd = dd.nd
        where  dd.accs = i.acc) deal_number
  FROM accounts a
  join int_accN i on i.acra = a.acc and i.id = 1
  join customer k on k.rnk = a.rnk
  join tts t on t.tt = i.ttb
  join saldo s on s.acc = a.acc
 WHERE a.ostc > 0
   AND a.ostc = a.ostb and
       a.nbs = '3905'
 ORDER BY a.nls, a.kv
;

PROMPT *** Create  grants  V_PAY_INTEREST_CRSOUR ***
grant SELECT                                                                 on V_PAY_INTEREST_CRSOUR to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_INTEREST_CRSOUR.sql =========*** 
PROMPT ===================================================================================== 
