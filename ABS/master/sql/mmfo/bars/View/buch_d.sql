

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BUCH_D.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view BUCH_D ***

  CREATE OR REPLACE FORCE VIEW BARS.BUCH_D ("NM", "TT", "DK", "REF", "MFO", "ND", "NLS", "NLSK", "SK", "S", "DATD", "PLAT", "POLU", "NAZ1", "VDATE", "VOB", "TP", "KOD") AS 
  select decode(o.mfoa,NULL,1,3),
       o.tt,
       o.dk,
       o.ref,
       o.mfoa,
       o.nd,
       o.nlsb,
       o.nlsa,
       0,
       o.s,
       o.datd,
       o.nam_a,
       o.nam_b,
       o.nazn,
       o.vdat,
       o.vob,
       o.userid,
       o.id_a
from oper o  where  o.sos=5  and o.tt in ('R01','D01')
UNION ALL
select decode (t.fli,1,2,1),
       t.tt,
       decode( NVL(o.sk,0), 0, o.dk, decode(o.dk,1,0,1) ),
       d1.ref,
       decode(t.fli,1,o.mfob,'0'),
       o.nd,
       decode(t.fli,1,o.nlsa,decode(NVL(o.sk,0), 0, k2.nls, d2.nls)),
       decode(t.fli,1,o.nlsb,decode(NVL(o.sk,0), 0, d2.nls, k2.nls)),
       decode(t.tt,o.tt,o.sk,t.sk),
       least(d1.s,k1.s),
       o.datd,
       decode(t.fli,1,o.nam_a,decode(NVL(o.sk,0), 0, k2.nms, d2.nms)),
       decode(t.fli,1,o.nam_b,decode(NVL(o.sk,0), 0, d2.nms, k2.nms)),
       o.nazn,
       d1.fdat,
       o.vob,
       o.userid,
       o.id_a
from oper o, tts t, opldok d1, opldok k1 , accounts d2, accounts k2
where o.ref  = d1.ref   and      t.tt   = d1.tt     and
      d1.sos = 5        and      (o.dk=0 or o.dk=1) and
      d1.dk=o.dk and k1.sos = 5 and k1.dk<>d1.dk and
      d1.ref = k1.ref   and      d1.tt  = k1.tt     and
      d1.fdat= k1.fdat  and      d1.acc = d2.acc    and
      k1.acc = k2.acc   and      d2.kv  = 980       and
      k2.kv  = 980      and      t.tt not in ('R01','D01');

PROMPT *** Create  grants  BUCH_D ***
grant SELECT                                                                 on BUCH_D          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BUCH_D          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BUCH_D.sql =========*** End *** =======
PROMPT ===================================================================================== 
