

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_IICFILES_FORM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_IICFILES_FORM ("REF", "DK", "TT", "MSGCODE", "ACC", "NLS", "KV", "OKPO", "S", "VDAT", "NAZN") AS 
  SELECT UNIQUE
          p.REF,
          p.dk,
          p.tt,
          CASE
             WHEN p.tt = p.tt_asg THEN OW_FILES_PROC.get_w4_msgcode(p.nlsb, p.kv)
             ELSE NVL ((select m.msgcode
                           from ow_iic_msgcode m
                          where p.tt = m.tt and p.mfoa = m.mfoa and
                                (p.nlsa = m.nlsa or
                                (p.nlsa like m.nlsa and not exists
                                 (select 1
                                     from ow_iic_msgcode ooo
                                    where ooo.nlsa = p.nlsa)))
                         ), p.w4_msgcode) 
          END
             w4_msgcode,
          a.acc,
          bars_ow.get_nls(a.nls, a.nlsalt, a.kf) nls,
          a.kv,
          c.okpo,
          p.s / 100 s,
          p.vdat,
          p.nazn
     FROM table(OW_FILES_PROC.w4_form) p,
          accounts a,
          customer c
    WHERE     p.acc = a.acc
          AND a.rnk = c.rnk     
   UNION ALL
   -- —чета
   SELECT TO_NUMBER (TO_CHAR (q.dat, 'yyyymmddhh24miss')) REF,
          NULL,
          NULL,
          'PAYFAAS',
          a.acc,
          bars_ow.get_nls(a.nls, a.nlsalt, a.kf) nls,
          a.kv,
          c.okpo,
          q.s / 100 s,
          q.dat vdat,
          'арест суммы на счЄте 2625' nazn
     FROM ow_acc_que q, accounts a, customer c
    WHERE     q.sos = 0
          AND q.f_n IS NULL
          AND q.acc = a.acc
          AND a.rnk = c.rnk
          -- ранее отправленна€ сумма ареста по счету сквитована
          AND NOT EXISTS
                 (SELECT 1
                    FROM ow_acc_que
                   WHERE acc = q.acc AND sos = 1);

PROMPT *** Create  grants  V_OW_IICFILES_FORM ***
grant SELECT                                                                 on V_OW_IICFILES_FORM to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_IICFILES_FORM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_IICFILES_FORM to OW;
grant SELECT                                                                 on V_OW_IICFILES_FORM to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM.sql =========*** End
PROMPT ===================================================================================== 
