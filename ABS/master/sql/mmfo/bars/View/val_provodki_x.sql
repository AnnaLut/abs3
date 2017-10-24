

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_X.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view VAL_PROVODKI_X ***

  CREATE OR REPLACE FORCE VIEW BARS.VAL_PROVODKI_X ("PDAT", "FDAT", "REF", "TT", "KV", "OB_D", "NLSD", "NMSD", "OB_K", "NLSK", "NMSK", "S", "SQ", "NAZN", "SOS", "VOB") AS 
  SELECT n.PDAT, i.FDAT, i.REF, i.TT, i.KV, i.OB_D, i.NLSD,i.NMSD,  i.OB_K, i.NLSK,i.NMSK, i.S, i.SQ, n.NAZN, n.sos, n.VOB
from ( select * from oper  nn where sos < 0 and exists (select 1 from opldok where fdat = gl.bd and ref = nn.REF )  ) n ,
     ( SELECT oo.FDAT, oo.REF, oo.TT, ad.KV, oo.S/100 S, oo.SQ/100 SQ, ad.ob22 OB_D, ad.nls NLSD, ad.nms NMSD, ak.ob22 OB_K, ak.nls NLSK, ak.nms NMSK
       FROM (select ref, stmt, fdat, tt, s, sq, sum(decode(dk,0,acc,0)) ACCD,sum(decode(dk,1,acc,0)) ACCk
             from opldok pp where fdat = gl.BD and exists (select 1 from oper where ref = pp.ref and sos < 0 )  group by ref,stmt,fdat,tt,s,sq ) oo,
           (select * from accounts where nls like PUL.GET('D')||'%' ) ad,     (select * from accounts where nls like PUL.GET('K')||'%' ) ak
      WHERE ad.acc = oo.accD AND ak.acc = oo.accK
     ) i  where i.ref = n.ref  ;

PROMPT *** Create  grants  VAL_PROVODKI_X ***
grant SELECT                                                                 on VAL_PROVODKI_X  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_PROVODKI_X  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VAL_PROVODKI_X.sql =========*** End ***
PROMPT ===================================================================================== 
