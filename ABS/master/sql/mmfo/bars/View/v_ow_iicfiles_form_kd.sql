

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM_KD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_IICFILES_FORM_KD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_IICFILES_FORM_KD ("REF", "DK", "TT", "MSGCODE", "ACC", "NLS", "KV", "OKPO", "S", "VDAT", "NAZN") AS 
  SELECT UNIQUE
          p.REF,
          p.dk,
          p.tt,
          CASE
             WHEN p.nlsb LIKE '2__9%' THEN 'LOANPAY1'
             WHEN p.nlsb LIKE '3579%' THEN 'LOANPAY2'
             WHEN p.nlsb LIKE '2__7%' THEN 'LOANPAY3'
             WHEN p.nlsb LIKE '2__8%' THEN 'LOANPAY4'
             WHEN p.nlsb LIKE '3578%' THEN 'LOANPAY5'
             WHEN p.nlsb LIKE '6___%' THEN 'LOANPAY7'
             ELSE 'LOANPAY6'
          END
             w4_msgcode,
          a.acc,
          a.nls,
          a.kv,
          c.okpo,
          p.s / 100 s,
          p.vdat,
          p.nazn
     FROM (                                -- документы на пополнение/списание
           SELECT q.acc,
                  q.REF,
                  q.dk,
                  d.tt,
                  DECODE (q.dk, d.dk, d.nlsa, d.nlsb) nlsb,
                  DECODE (q.dk, d.dk, NVL (d.s2, d.s), d.s) s,
                  d.vdat,
                  d.nazn,
                  t.w4_msgcode
             FROM ow_pkk_que q,
                  (SELECT *
                     FROM oper
                    WHERE (REF, nlsa) IN (SELECT REF, nlsa
                                            FROM oper o1
                                           WHERE tt NOT IN (SELECT tt FROM w4_sto_tts)
                                             AND pdat >= bankdate - 30
                                             AND REF IN (SELECT REF FROM ow_pkk_que)))
                  d,
                  obpc_trans_out t
            WHERE     q.sos = 0
                  AND q.f_n IS NULL
                  AND q.REF = d.REF
                  AND d.tt = NVL (getglobaloption ('ASG_FOR_BPK'), 'W4Y')
                  AND d.tt = t.tt
                  AND q.dk = t.dk
                  -- оплачен
                  AND (   d.sos = 5
                       -- по плану и след. виза = 30 Контролер БПК
                       OR     d.sos = 1
                          AND d.nextvisagrp =
                                 LPAD (
                                    chk.to_hex (
                                       TO_NUMBER (
                                          getglobaloption ('BPK_CHK'))),
                                    2,
                                    '0'))) p,
          accounts a,
          customer c
    WHERE p.acc = a.acc AND a.rnk = c.rnk;

PROMPT *** Create  grants  V_OW_IICFILES_FORM_KD ***
grant SELECT                                                                 on V_OW_IICFILES_FORM_KD to BARSREADER_ROLE;
grant SELECT                                                                 on V_OW_IICFILES_FORM_KD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_IICFILES_FORM_KD to OW;
grant SELECT                                                                 on V_OW_IICFILES_FORM_KD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM_KD.sql =========*** 
PROMPT ===================================================================================== 
