

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPTREVIEWRATEDEALS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPTREVIEWRATEDEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPTREVIEWRATEDEALS ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "TYPE_ID", "TYPE_NAME", "BR_ID", "BR_NAME", "CUST_ID", "CUST_NAME", "ACC_ID", "ACC_NUM", "ACC_CUR", "ACC_ISO", "ACC_SALDO", "REVIEW_DATE", "REVIEW_RATE", "CURR_RATE") AS 
  select d.dpt_id, d.nd, d.datz, d.dat_begin, d.dat_end,
       v.vidd, v.type_name, b.br_id, b.name,
       c.rnk, c.nmk, a.acc, a.nls, a.kv, t.lcv, a.ostc,
       d.reviewdate, getbrat (d.reviewdate, v.br_id, v.kv, a.ostc), acrn.fproc(a.acc, d.reviewdate)
  from dpt_vidd v,
       accounts a,
       customer c,
       brates   b,
       tabval   t,
      (select d.deposit_id dpt_id, d.nd, d.datz, d.dat_begin, d.dat_end,
              d.acc, d.rnk, d.vidd,
              dpt.f_duration (d.dat_begin, rr.mnth_cnt, rr.days_cnt) reviewdate
         from dpt_deposit d, v_dptreviewratetypes rr
        where d.vidd  = rr.vidd
          and d.dat_end > bankdate) d
 where d.acc   = a.acc
   and d.vidd  = v.vidd
   and d.rnk   = c.rnk
   and v.br_id = b.br_id
   and a.kv    = t.kv
   and d.reviewdate <= bankdate
   and d.reviewdate >= dat_next_u(bankdate, -1)
   and acrn.fproc(a.acc, d.reviewdate) ! = getbrat (d.reviewdate, v.br_id, v.kv, a.ostc)
 ;

PROMPT *** Create  grants  V_DPTREVIEWRATEDEALS ***
grant SELECT                                                                 on V_DPTREVIEWRATEDEALS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPTREVIEWRATEDEALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPTREVIEWRATEDEALS to DPT_ADMIN;
grant SELECT                                                                 on V_DPTREVIEWRATEDEALS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPTREVIEWRATEDEALS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPTREVIEWRATEDEALS.sql =========*** E
PROMPT ===================================================================================== 
