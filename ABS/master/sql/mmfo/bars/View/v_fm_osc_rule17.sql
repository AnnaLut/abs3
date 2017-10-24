

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE17.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FM_OSC_RULE17 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FM_OSC_RULE17 ("REF", "VDAT") AS 
  select o.ref, o.vdat
  from oper o, opldok p, accounts a, customer c, country r,
       customer_address d, country r2,
       ( select w.ref, k.k040 country
           from operw w, kl_k040 k
          where (    w.tag = '59'  and substr(w.value,1,1) = '/'
                  or w.tag = '57A' and length(w.value) = 6
                  or w.tag = '50F' and w.value like '%' || chr(13) || chr(10) || '3/%'
                  or w.tag = 'KOD_G' )
            and decode(trim(w.tag), '59',  substr(w.value,2,2),
                                    '57A', substr(w.value,5,2),
                                    '50F', substr(w.value, instr(w.value, chr(13) || chr(10) || '3/') + 4, 2),
                                    w.value) =
                decode(trim(w.tag), '59',  k.a2,
                                    '57A', k.a2,
                                    '50F', k.a2,
                                    k.k040) ) w, country r3
 where o.ref = p.ref
   and p.acc = a.acc
   and a.rnk = c.rnk    and c.country = r.country
   and c.rnk = d.rnk(+) and d.country = r2.country(+)
   and o.ref = w.ref(+) and w.country = r3.country(+)
   and ( r.fatf = 1 or r2.fatf = 1 or r3.fatf = 1 )
   and gl.p_icurval(nvl(o.kv,980), nvl(o.s,0), o.vdat) >= 15000000 ;

PROMPT *** Create  grants  V_FM_OSC_RULE17 ***
grant SELECT                                                                 on V_FM_OSC_RULE17 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FM_OSC_RULE17 to FINMON01;
grant SELECT                                                                 on V_FM_OSC_RULE17 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FM_OSC_RULE17.sql =========*** End **
PROMPT ===================================================================================== 
