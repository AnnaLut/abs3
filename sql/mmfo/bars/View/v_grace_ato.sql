

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRACE_ATO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRACE_ATO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRACE_ATO ("ND", "RNK", "SDATE", "WDATE", "CC_ID", "KK1", "GPP", "OTM1", "OTM2", "ADD3", "P_DAT", "REFP", "ACC", "NLS", "KV", "OSTC", "OSTB", "OSTF") AS 
  SELECT d.nd,
          d.rnk,
          d.sdate,
          d.wdate,
          d.cc_id,
          0 KK1,                                 -- KK1~Виконати~згорнення зал
          0 GPP,                                  -- GPP~Виконати~побудову ГПП
          0 OTM1,                                -- Сократить~на переплату~ГПП
          0 OTM2,                                      -- Отменить~остаток~ГПП
          0 ADD3,                         -- Добавить переплату равными долями
          (SELECT TO_DATE (txt, 'dd/mm/yyyy')
             FROM nd_txt
            WHERE nd = d.nd AND tag = 'GRACE')
             p_dat,
          (SELECT refp
             FROM cc_add
            WHERE adds = 0 AND nd = d.nd)
             REFP,
          x.acc,
          x.nls,
          x.kv,
          x.ostc,
          x.ostb,
          x.ostf
     FROM cc_deal d,
          (SELECT a.acc,
                  a.nls,
                  a.kv,
                  a.ostc / 100 ostc,
                  a.ostb / 100 ostb,
                  (a.ostb + a.ostf) / 100 ostf,
                  n.nd
             FROM nd_acc n, accounts a
            WHERE tip = 'SNO' AND n.acc = a.acc) x
    WHERE     d.sos < 15
          AND d.vidd = 11
          AND d.wdate > (gl.bd + 31)
          AND d.nd = x.nd(+);

PROMPT *** Create  grants  V_GRACE_ATO ***
grant SELECT                                                                 on V_GRACE_ATO     to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRACE_ATO     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRACE_ATO     to START1;
grant SELECT                                                                 on V_GRACE_ATO     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRACE_ATO.sql =========*** End *** ==
PROMPT ===================================================================================== 
