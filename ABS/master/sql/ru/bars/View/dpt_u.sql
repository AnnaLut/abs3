

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_U.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_U ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_U ("USER_ID", "DPU_ID", "ND", "DPU_GEN", "DPU_ADD", "VIDD", "NAME", "KV", "ISO", "NAMEV", "SUM", "RNK", "NMK", "OKPO", "CUSTTYPE", "ACC", "NLS", "OSTC", "OSTB", "OST", "OSTQ", "ACRA", "NLSN", "PROC", "OSTN", "ACR_DAT", "APL_DAT", "FREQN", "FREQV", "COMPROC", "FREQ_NAME", "FL_ADD", "MIN_SUM", "ID_STOP", "DAT_Z", "DAT_N", "DAT_O", "DAT_V", "TERM_MONTHS", "TERM_DAYS", "MFOD", "NLSD", "NMSD", "MFOP", "NLSP", "NMSP", "CLOSED", "TOBO", "BRANCH", "TRUSTEE_ID", "ACC2", "SEGMENT", "CNT_DUBL", "BLKD") AS 
  SELECT d.user_id,
         d.dpu_id,
         DECODE(d.dpu_gen, NULL, d.nd, (SELECT nd FROM dpu_deal WHERE dpu_id = d.dpu_gen)),
         NVL(d.dpu_gen, d.dpu_id),
         d.dpu_add,
         d.vidd,
         v.name,
         v.kv,
         t.lcv,
         t.name,
         DECODE (d.dpu_gen, NULL, NVL( (SELECT SUM(SUM) FROM dpu_deal WHERE dpu_gen = d.dpu_id AND closed <> 1), d.SUM), d.SUM),
         c.rnk,
         c.nmk,
         c.okpo,
         c.custtype,
         a.acc,
         a.nls,
         a.ostc,
         a.ostb,
         NVL (fost (a.acc, bankdate), 0),
         gl.p_icurval (a.kv, a.ostc, bankdate),
         i.acra,
         n.nls,
         acrn.fproc (a.acc, bankdate),
         NVL (fost (i.acra, bankdate), 0),
         i.acr_dat,
         NVL (i.apl_dat, a.daos),
         i.freq,
         d.freqv,
         d.comproc,
         f.name,
         NVL (v.fl_add, 0),
         d.min_sum,
         d.id_stop,
         d.datz,
         d.dat_begin,
         d.dat_end,
         d.datv,
         ROUND (MONTHS_BETWEEN (d.dat_end, d.dat_begin)),
         d.dat_end - d.dat_begin + 1,
         d.mfo_d,
         d.nls_d,
         d.nms_d,
         d.mfo_p,
         d.nls_p,
         d.nms_p,
         d.closed,
         a.tobo,
         d.branch,
         d.trustee_id,
         d.acc2,
         NULL,
         nvl(d.cnt_dubl, 0),
         a.blkd
    FROM dpu_deal d,
         dpu_vidd v,
         customer c,
         accounts a,
         int_accn i,
         accounts n,
         tabval   t,
         freq     f
   WHERE d.vidd = v.vidd
     AND d.rnk = c.rnk
     AND d.acc = a.acc
     AND a.acc = i.acc
     AND i.id = 1
     AND i.acra = n.acc
     AND a.kv = t.kv
     AND d.freqv = f.freq
     AND d.BRANCH LIKE SYS_CONTEXT('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  DPT_U ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_U           to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_U           to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_U           to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPT_U           to WR_DEPOSIT_U;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_U.sql =========*** End *** ========
PROMPT ===================================================================================== 
