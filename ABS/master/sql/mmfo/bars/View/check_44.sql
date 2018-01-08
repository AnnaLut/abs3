

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_44.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_44 ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_44 ("REF", "NLS", "KV", "NLSK", "KVK", "S", "S2", "NAZN", "VDATE", "MFOA", "MFOB", "USER_NAME", "D44", "D73", "FIO") AS 
  select
      o.ref,o.nlsb,o.kv2,o.nlsa,o.kv,o.s2,o.s,o.nazn,o.datd,
      o.mfob,o.mfoa,s.fio, NVL(substr(a1.value,1,6),'000000'),
      NVL(substr(a2.value,1,3),'000'), NVL(substr(a3.value,1,40),'   ')
from
      oper o, staff s, operw a1, operw a2, operw a3
where
      o.sos=5 and o.tt in ('R01','D01') and s.id=o.userid and
      a1.ref(+)=o.ref and a1.tag(+)='D#44' and
      a2.ref(+)=o.ref and a2.tag(+)='D#73' and
      a3.ref(+)=o.ref and a3.tag(+)='FIO'
union all
select
       d1.ref,d2.nls, d2.kv, decode (t.fli,1,o.nlsb,k2.nls),
       decode (t.fli,1,o.kv2,k2.kv),d1.s,k1.s,o.nazn,o.datd,
       o.mfoa,
       decode(t.fli,1,o.mfob,o.mfoa),
       s.fio, NVL(substr(a1.value,1,6),'000000'),
       NVL(substr(a2.value,1,3),'000'), NVL(substr(a3.value,1,40),'   ')
from
       oper o, tts t, opldok d1, opldok k1 , accounts d2, accounts k2,
       staff s, operw a1, operw a2, operw a3
 where o.ref  = d1.ref   and      t.tt   = d1.tt    and
       d1.sos = 5 and d1.dk=0 and k1.sos = 5 and k1.dk=1 and
       d1.ref = k1.ref   and      d1.tt  = k1.tt    and
       d1.s   = k1.s     and      d1.fdat= k1.fdat  and
       d1.acc = d2.acc   and      k1.acc = k2.acc   and
       d2.kv  =  k2.kv   and      s.id=o.userid     and
       t.tt not in ('R01','D01')                    and
       a1.ref(+)=o.ref and a1.tag(+)='D#44'         and
       a2.ref(+)=o.ref and a2.tag(+)='D#73'         and
       a3.ref(+)=o.ref and a3.tag(+)='FIO';

PROMPT *** Create  grants  CHECK_44 ***
grant SELECT                                                                 on CHECK_44        to BARSREADER_ROLE;
grant SELECT                                                                 on CHECK_44        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_44        to START1;
grant SELECT                                                                 on CHECK_44        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_44.sql =========*** End *** =====
PROMPT ===================================================================================== 
