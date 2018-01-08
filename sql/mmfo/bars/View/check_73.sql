

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_73.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_73 ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_73 ("REF", "NLS", "KV", "DK", "NLSK", "KVK", "S", "S2", "NAZN", "VDATE", "ISP", "USER_NAME", "D73") AS 
  select distinct "REF","NLSA","KV","DK","NLSB","KV2","S","S2","NAZN","VDAT","ID","FIO","NVL(AUX1.VALUE,'000')" from (
SELECT o.ref,o.nlsa,o.kv,o.dk,o.nlsb,o.kv2,o.s,o.s2,o.nazn,o.vdat,s.id,
       s.fio,NVL(aux1.value,'000')
FROM  oper o, staff s, operw aux1
WHERE o.sos=5 and (o.kv<>980 or o.kv2<>980) and
      to_number(substr(o.nlsb,1,4))<1007 and s.id=o.userid and
      aux1.tag='D#73' and aux1.ref=o.ref and
      o.dk=1
UNION ALL
SELECT o.ref,o.nlsa,o.kv,o.dk,o.nlsb,o.kv2,o.s,o.s2,o.nazn,o.vdat,s.id,
       s.fio,NVL(aux1.value,'000')
FROM  oper o, staff s, operw aux1
WHERE o.sos=5 and (o.kv<>980 or o.kv2<>980) and
      to_number(substr(o.nlsb,1,4))<1007 and s.id=o.userid and
      aux1.tag = '73' || o.tt and aux1.ref = o.ref and
      o.dk=1
---------------------------------------------------------------------------
UNION ALL
SELECT o.ref,o.nlsa,o.kv,o.dk,o.nlsb,o.kv2,o.s,o.s2,o.nazn,o.vdat,s.id,
       s.fio,NVL(aux1.value,'000')
FROM  oper o, staff s, operw aux1
WHERE o.sos=5 and (o.kv<>980 or o.kv2<>980) and
      to_number(substr(o.nlsb,1,4))<1007 and s.id=o.userid and
      aux1.tag<>'D#73' and aux1.tag <> '73' || o.tt and
      aux1.ref=o.ref and o.dk=1
-----------------------------------------------------------------------------
UNION ALL
SELECT o.ref,o.nlsb,o.kv2,o.dk,o.nlsa,o.kv,o.s2,o.s,o.nazn,o.vdat,s.id,
       s.fio,NVL(aux1.value,'000')
FROM  oper o, staff s, operw aux1
WHERE o.sos=5 and (o.kv<>980 or o.kv2<>980) and
      to_number(substr(o.nlsb,1,4))<1007 and s.id=o.userid and
      aux1.tag='D#73' and aux1.ref=o.ref and
      o.dk=0
UNION ALL
SELECT o.ref,o.nlsb,o.kv2,o.dk,o.nlsa,o.kv,o.s2,o.s,o.nazn,o.vdat,s.id,
       s.fio,NVL(aux1.value,'000')
FROM  oper o, staff s, operw aux1
WHERE o.sos=5 and (o.kv<>980 or o.kv2<>980) and
      to_number(substr(o.nlsb,1,4))<1007 and s.id=o.userid and
      aux1.tag = '73' || o.tt and aux1.ref = o.ref and
      o.dk=0
-----------------------------------------------------------------------------
UNION ALL
SELECT o.ref,o.nlsb,o.kv2,o.dk,o.nlsa,o.kv,o.s2,o.s,o.nazn,o.vdat,s.id,
       s.fio,NVL(aux1.value,'000')
FROM  oper o, staff s, operw aux1
WHERE o.sos=5 and (o.kv<>980 or o.kv2<>980) and
      to_number(substr(o.nlsb,1,4))<1007 and s.id=o.userid and
      aux1.tag <> 'D#73' and aux1.tag <> '73' || o.tt and
      aux1.ref=o.ref and o.dk=0);

PROMPT *** Create  grants  CHECK_73 ***
grant SELECT                                                                 on CHECK_73        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_73        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_73.sql =========*** End *** =====
PROMPT ===================================================================================== 
