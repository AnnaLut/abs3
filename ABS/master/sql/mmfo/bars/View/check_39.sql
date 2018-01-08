

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CHECK_39.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CHECK_39 ***

  CREATE OR REPLACE FORCE VIEW BARS.CHECK_39 ("REF", "VDATE", "NLS", "NLSK", "KV1", "KV2", "S1", "S2", "RATE", "NAZN", "FIO", "D39") AS 
  select
  o.ref,o.vdat,o.nlsa,o.nlsb,o.kv,o.kv2,o.s,o.s2,
  NVL( aux2.value,''),
  nazn,s.fio,
  NVL( aux1.value,'')
from oper o, staff s, operw aux1, operw aux2
where
 o.sos=5 and
 aux1.ref (+) = o.ref    and
 aux2.ref (+) = o.ref    and
 aux1.tag (+) = 'D#39'   and
 aux2.tag (+) = 'KURS'   and
 s.id=o.userid and not (
 (o.kv=o.kv2) and o.kv=980 ) and (
 (o.nlsa like '1819%' and o.nlsb like '1819%') or
 (o.nlsa like '1819%' and o.nlsb like '1500%') or
 (o.nlsa like '1819%' and o.nlsb like '1600%') or
 (o.nlsa like '1819%' and o.nlsb like '39%')   or
 (o.nlsa like '1500%' and o.nlsb like '1819%') or
 (o.nlsa like '1600%' and o.nlsb like '1819%') or
 (o.nlsa like '3720%' and o.nlsb like '1819%') or
 (o.nlsa like '2900%' and o.nlsb like '2600%') or
 (o.nlsa like '2900%' and o.nlsb like '3901%') or
 (o.nlsa like '2900%' and o.nlsb like '2620%') or
 (o.nlsa like '2900%' and o.nlsb like '2077%') or
 (o.nlsa like '39%'   and o.nlsb like '1819%') or
 (o.nlsa like '39%'   and o.nlsb like '2900%') or
 (o.nlsa like '260%'  and o.nlsb like '2900%') or
 (o.nlsa like '2903%' and o.nlsb like '2900%') );

PROMPT *** Create  grants  CHECK_39 ***
grant SELECT                                                                 on CHECK_39        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHECK_39        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CHECK_39.sql =========*** End *** =====
PROMPT ===================================================================================== 
