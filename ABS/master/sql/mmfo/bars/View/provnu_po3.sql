

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVNU_PO3.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVNU_PO3 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVNU_PO3 ("ACCD", "TT", "REF", "KV", "NLSD", "S", "FDAT", "NAZN", "ACCK", "NLSK", "ISP", "VOB", "VDAT", "OTM", "STMT") AS 
  SELECT    o.accd, o.tt, o.ref, ad.kv,
          DECODE (ad.tip, 'T00', p.nlsa, ad.nls), o.s,  o.fdat,
          DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.name)),
          o.acck, DECODE (ak.tip, 'T00', p.nlsb, ak.nls), p.userid, p.vob,
          p.vdat, o.otm, o.stmt
     FROM oper p, tts t, accounts ad, accounts ak,
        (select l.fdat,l.ref,l.stmt,l.tt,l.s, l.otm,
                sum(decode(l.dk,0,l.acc,0)) accd, sum(decode(l.dk,1,l.acc,0)) acck
         from opldok l
         where l.sos>=4    and exists (select ref from opldok where fdat>=gl.bd-5 and ref=l.ref
                               and otm in (bitand(nvl(otm,0),254)+1,bitand(nvl(otm,0),253)+2))
               and fdat>=gl.bd-5
               group by fdat, ref,stmt,tt,s,otm
         ) o
    WHERE      p.ref = o.ref          AND   t.tt = O.tt
          AND o.accD = ad.acc         AND o.accK = ak.acc
union all        -- для того чтобы работал триггер instead...
select null,null,null,null,null,
       null,null,null,null,null,
       null,null,null,null,null
from dk where dk=0
minus
select null,null,null,null,null,
       null,null,null,null,null,
       null,null,null,null,null
from dk where dk=0
 ;

PROMPT *** Create  grants  PROVNU_PO3 ***
grant SELECT,UPDATE                                                          on PROVNU_PO3      to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on PROVNU_PO3      to NALOG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVNU_PO3.sql =========*** End *** ===
PROMPT ===================================================================================== 
