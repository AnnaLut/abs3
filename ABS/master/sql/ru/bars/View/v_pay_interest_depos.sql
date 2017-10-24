create or replace view v_pay_interest_depos as
SELECT i.ttb,
       DECODE(a.kv,
              i.kvb,
              DECODE(i.mfob,
                     f_ourmfo_g,
                     6,
                     DECODE(SUBSTR(s.nls, 1, 1), '2', 1, 6)),
              16) vob,
       a.nls,
       a.kv,
       i.mfob,
       i.nlsb,
       i.kvb,
       case when a.ostc < 0 then 0 else 1 end as dk,
       abs(a.ostc) sumr,
       i.namb,
       i.nazn,
       i.acc,
       nvl(i.okpo, k.okpo) okpo,
       a.nms,
       k.nmk,
       t.fli,
       s.nls snls --?
  FROM int_accN i, accounts a, customer k, tts t, saldo s
 WHERE i.acra = a.acc
   AND a.rnk = k.rnk
   AND i.id = 1
   AND a.ostc <> 0
   AND a.ostc = a.ostb
   AND i.ttb = t.tt
   AND i.acc = s.acc
 ORDER BY a.nls, a.kv;
/
GRANT SELECT ON v_pay_interest_depos TO BARS_ACCESS_DEFROLE;