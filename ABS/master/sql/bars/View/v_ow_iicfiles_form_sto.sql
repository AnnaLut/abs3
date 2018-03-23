

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM_STO.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_IICFILES_FORM_STO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_IICFILES_FORM_STO ("REF", "DK", "TT", "MSGCODE", "ACC", "NLS", "KV", "OKPO", "S", "VDAT", "NAZN") AS 
  SELECT UNIQUE
          p.REF,
          p.dk,
          p.tt,
          CASE
             WHEN p.tt = p.tt_asg AND p.nlsb LIKE '2__9%' THEN 'LOANPAY1'
             WHEN p.tt = p.tt_asg AND p.nlsb LIKE '3579%' THEN 'LOANPAY2'
             WHEN p.tt = p.tt_asg AND p.nlsb LIKE '2__7%' THEN 'LOANPAY3'
             WHEN p.tt = p.tt_asg AND p.nlsb LIKE '2__8%' THEN 'LOANPAY4'
             WHEN p.tt = p.tt_asg AND p.nlsb LIKE '3578%' THEN 'LOANPAY5'
             WHEN p.tt = p.tt_asg AND p.nlsb LIKE '6___%' THEN 'LOANPAY7'
             WHEN p.tt = p.tt_asg THEN 'LOANPAY6'
             ELSE NVL (m.msgcode, p.w4_msgcode)
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
      with oper_lst as ( SELECT *
                     FROM oper
                    WHERE (REF, nlsa) IN (  SELECT MIN (REF), nlsa
                                              FROM oper o1
                                             WHERE tt IN (SELECT tt FROM w4_sto_tts)
                                               AND NOT EXISTS -- не отправлять документы в ПЦ, пока не сквитованы предыдущие)
                                                          (SELECT 1
                                                             FROM oper
                                                            WHERE nlsa = o1.nlsa
                                                              AND pdat >= bankdate - 30
							      and ref in (select ref from ow_pkk_que)
                                                              AND tt != NVL ( getglobaloption ('ASG_FOR_BPK'), 'W4Y')
                                                              AND sos BETWEEN 2 AND 4)
                                               AND sos > 0
                                               AND pdat >= bankdate - 30
                                               AND tt != NVL (getglobaloption ('ASG_FOR_BPK'),'W4Y')
                                               AND EXISTS
                                                      (SELECT REF
                                                         FROM ow_pkk_que
                                                        WHERE REF = o1.REF)
                                               and not exists (select ref from ow_pkk_que where ref = o1.ref and sos = 1 and drn is not null)
                                          GROUP BY nlsa))
           SELECT  q.acc,
                   q.REF,
                   q.dk,
                   d.tt,
                   -- mfoa, nlsa - mfo и счет отправителя
                   d.mfoa,
                   d.nlsa,
                   -- nlsb - счет-корреспондент к 2625
                   DECODE (q.dk, d.dk, d.nlsa, d.nlsb) nlsb,
                   DECODE (q.dk, d.dk, NVL (d.s2, d.s), d.s) s,
                   d.vdat,
                   d.nazn,
                   NVL (w.VALUE, t.w4_msgcode) w4_msgcode,
                   NVL (getglobaloption ('ASG_FOR_BPK'), 'W4Y') tt_asg
              FROM ow_pkk_que q,
                 oper_lst d,
                  obpc_trans_out t,
                   operw w
             WHERE     q.sos = 0
                   AND q.f_n IS NULL
                   AND q.REF = d.REF
                   AND d.tt = t.tt
                   AND q.dk = t.dk
                   -- оплачен
                   AND (d.sos = 5
                        -- по плану и след. виза = 30 Контролер БПК
                        OR d.sos = 1
                           AND d.nextvisagrp =
                                  LPAD (
                                     chk.to_hex (
                                        TO_NUMBER (
                                           getglobaloption ('BPK_CHK'))),
                                     2,
                                     '0'))
                   AND t.tt IN (  SELECT tt
                                    FROM obpc_trans_out
                                  HAVING COUNT (tt) = 1
                                GROUP BY tt)
                   AND d.REF = w.REF(+)
                   AND w.tag(+) = 'W4MSG'
           UNION ALL
           -- документы на пополнение-списание (списание с карточки на карточку)
           SELECT q.acc,
                  q.REF,
                  q.dk,
                  d.tt,
                  -- mfoa, nlsa - mfo и счет отправителя
                  d.mfoa,
                  d.nlsa,
                  -- nlsb - счет-корреспондент к 2625
                  DECODE (q.dk, d.dk, d.nlsa, d.nlsb) nlsb,
                  DECODE (q.dk, d.dk, NVL (d.s2, d.s), d.s) s,
                  d.vdat,
                  d.nazn,
                  t.w4_msgcode,
                  NVL (getglobaloption ('ASG_FOR_BPK'), 'W4Y') tt_asg
   FROM ow_pkk_que q,
                  oper_lst d,
                  obpc_trans_out t
            WHERE     q.sos = 0
                  AND q.f_n IS NULL
                  AND q.REF = d.REF
                  AND d.tt = t.tt
                  AND q.dk = t.dk
                  -- по плану
                  AND d.sos = 1
                  -- документы на списание, след. виза = 30 Контролер БПК
                  AND (q.dk = 0
                       AND d.nextvisagrp =
                              LPAD (
                                 chk.to_hex (
                                    TO_NUMBER (getglobaloption ('BPK_CHK'))),
                                 2,
                                 '0')
                       -- документы на пополнение, след. виза = 31 Контролер БПК-2
                       OR q.dk = 1
                          AND d.nextvisagrp =
                                 LPAD (
                                    chk.to_hex (
                                       TO_NUMBER (
                                          getglobaloption ('BPK_CHK2'))),
                                    2,
                                    '0'))
                  -- внутрибанк/входяший или сквитованный межбанк
                  AND (d.mfob = getglobaloption ('MFO')
                       OR d.mfob <> getglobaloption ('MFO')
                          AND EXISTS
                                 (SELECT 1
                                    FROM arc_rrp
                                   WHERE     REF = d.REF
                                         AND fn_b IS NOT NULL
                                         AND sos >= 7))
                  AND t.tt IN (  SELECT tt
                                   FROM obpc_trans_out
                                 HAVING COUNT (tt) = 2
                               GROUP BY tt)) p,
          accounts a,
          customer c,
          ow_iic_msgcode m
    WHERE     p.acc = a.acc
          AND a.rnk = c.rnk
          AND p.tt = m.tt(+)
          AND p.mfoa = m.mfoa(+)
          AND p.nlsa LIKE m.nlsa(+);

PROMPT *** Create  grants  V_OW_IICFILES_FORM_STO ***
grant SELECT                                                                 on V_OW_IICFILES_FORM_STO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_IICFILES_FORM_STO to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_IICFILES_FORM_STO.sql =========***
PROMPT ===================================================================================== 
