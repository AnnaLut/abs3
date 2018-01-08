

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MARSH.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view MARSH ***

  CREATE OR REPLACE FORCE VIEW BARS.MARSH ("DK", "NLS", "VDAT", "ISO", "SV", "KURS", "BSUM", "SN") AS 
  select a.dk,a.nls,a.vdat,t.lcv,   to_char(a.sv/100,'99999999.99'),
  to_char((a.sn/a.sv)*t.nominal,'99999.9999'),  t.nominal,
  to_char(a.sn/100,'99999999.99')
from tabval t,
(SELECT decode(DK,0,'ÊÓÏIÂËß','ÏÐÎÄÀÆ') dk, NLS, VDAT, KV,
        sum(SV) SV, sum(SN) SN
 FROM (select decode(kv,980,dk,  1-dk) DK, decode(kv,980,nlsb,nlsa) NLS,
              vdat   VDAT,                 decode(kv,980,kv2,   kv) KV,
              decode(kv,980,s2,    s ) SV, decode(kv,980,s,     s2) SN
       from oper where sos=5 and kv<>kv2 and 980 in (kv,kv2) and dk in (0,1)
       )
    WHERE substr(NLS,1,1)='1'  GROUP BY DK, NLS, VDAT, KV
   ) a
where a.kv=t.kv
union all
select ' â ÏÔ',nls,fdat,'ãðí',to_char(kos/100,'99999999.99'),'',0,
 to_char(dos/100,'99999999.99')
     from sal
where acc in (select acc from specparam where idg=1) and kos+dos>0;

PROMPT *** Create  grants  MARSH ***
grant SELECT                                                                 on MARSH           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MARSH           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MARSH.sql =========*** End *** ========
PROMPT ===================================================================================== 
