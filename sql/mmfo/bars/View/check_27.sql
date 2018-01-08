

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_27.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_27 ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_27 ("REF", "ND", "VDATE", "NLS", "KV", "MFOB", "NLSK", "KV2", "S", "D020", "NAZ1", "PLAT", "POLU", "RNK", "NMK", "FIO", "ID") AS 
  SELECT
       o.ref, o.nd, o.vdat, o.nlsa, o.kv, o.mfob, o.nlsb, o.kv2,
       o.s, NVL(aux1.value,'00'), o.nazn, o.nam_a, o.nam_b, c.rnk, c.nmk,
       s.fio, s.id
FROM  oper o, accounts a, cust_acc ca, customer c,
      staff s, operw aux1
WHERE o.sos=5              and
      ca.acc=a.acc         and ca.rnk=c.rnk              and
      a.nls=o.nlsa         and a.kv=o.kv                 and
      o.dk=1               and substr(o.nlsa,1,4)='2603' and
      o.kv<>980                                          and
---      o.kv=o.kv2           and o.kv<>980  and (не включалась конверсия)
      aux1.ref (+) = o.ref and aux1.tag (+) = 'D#27'     and
      s.id=o.userid
union all
SELECT
       o.ref, o.nd, o.vdat, o.nlsb, o.kv2, o.mfob, o.nlsa, o.kv,
       o.s2, NVL(aux1.value,'00'), o.nazn, o.nam_b, o.nam_a, c.rnk, c.nmk,
       s.fio, s.id
FROM  oper o, accounts a, cust_acc ca, customer c,
      staff s, operw aux1
WHERE o.sos=5                   and ca.acc=a.acc         and
      ca.rnk=c.rnk              and a.nls=o.nlsb         and
      a.kv=o.kv2                and o.dk=0               and
      substr(o.nlsb,1,4)='2603'                          and
---      substr(o.nlsb,1,4)='2603' and o.kv=o.kv2  and (не включалась конверсия)
      o.kv2<>980                 and aux1.ref (+) = o.ref and
      aux1.tag (+) = 'D#27'     and s.id=o.userid;

PROMPT *** Create  grants  CHECK_27 ***
grant SELECT                                                                 on CHECK_27        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_27        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_27.sql =========*** End *** =====
PROMPT ===================================================================================== 
