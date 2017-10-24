

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VZ_ESCR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VZ_ESCR ***

  CREATE OR REPLACE FORCE VIEW BARS.VZ_ESCR ("TT", "REF", "NLSB", "OSTC", "NAZN", "S", "ACC", "ND", "SDATE", "CC_ID", "ID_B", "TXT") AS 
  select  o.tt, o.ref, o.nlsb, a.ostc, o.nazn, o.s, a.acc,
         substr(F_DOP(o.ref,'ND'  ),1,10)  nd,
         substr(F_DOP(o.REF,'DAT1'),1,10)  sdate,
         substr(F_DOP(o.REF,'CC_ID'),1,30) cc_id,
         substr(F_DOP(o.REF,'IDB'),1,10)   id_b,
         (select txt from opldok where ref = o.ref and rownum =1) txt
from oper o, nlk_ref r, accounts a
where a.tip ='NLQ' and a.acc= r.acc and r.ref2 is null and r.ref1 = o.ref;

PROMPT *** Create  grants  VZ_ESCR ***
grant SELECT                                                                 on VZ_ESCR         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VZ_ESCR.sql =========*** End *** ======
PROMPT ===================================================================================== 
