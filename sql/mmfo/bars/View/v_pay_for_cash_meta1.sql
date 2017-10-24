

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PAY_FOR_CASH_META1.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PAY_FOR_CASH_META1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PAY_FOR_CASH_META1 ("MFOA", "REF", "FDAT", "S", "NAZN", "KV", "OK1", "OK1K", "OK7", "ACC", "NLS", "NMS", "NB") AS 
  select o.mfoa,
          o.ref,
          p.fdat,
          p.s / 100 s,
          o.nazn,
          a.kv,
          'Виконати' ok1,
          decode (a.kv, 980, '', 'Виконати') ok1k,
          'Виконати' ok7,
          a.acc,
          a.nls,
          a.nms,
          (select nb
             from banks
            where mfo = o.mfoa)
             nb
     from (select *
             from nlk_ref
            where     ref2 is null
                  and acc = to_number (pul.get_mas_ini_val ('ACC'))) k,
          oper o,
          opldok p,
          accounts a
    where     p.dk = 1
          and p.ref = o.ref
          and p.acc = k.acc
          and o.ref = k.ref1
          and k.acc = a.acc;

PROMPT *** Create  grants  V_PAY_FOR_CASH_META1 ***
grant SELECT                                                                 on V_PAY_FOR_CASH_META1 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PAY_FOR_CASH_META1 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PAY_FOR_CASH_META1.sql =========*** E
PROMPT ===================================================================================== 
