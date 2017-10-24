

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OPLDOK_ACCESS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OPLDOK_ACCESS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OPLDOK_ACCESS ("REF", "STMT", "TT", "FDAT", "DACC", "DS", "DTXT", "KACC", "KS", "KTXT") AS 
  select "REF","STMT","TT","FDAT","DACC","DS","DTXT","KACC","KS","KTXT" from (
  select d.ref, d.stmt, d.tt, d.fdat, 
       d.acc dacc, d.s ds, d.txt dtxt,
       k.acc kacc, k.s ks, k.txt ktxt
  from opldok d, opldok k 
  where d.ref=k.ref and d.stmt=k.stmt and d.dk=0 and k.dk=1) 
where (dacc, kacc) in (select a.acc, b.acc from saldo a, saldo b) 
 ;

PROMPT *** Create  grants  V_OPLDOK_ACCESS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OPLDOK_ACCESS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OPLDOK_ACCESS.sql =========*** End **
PROMPT ===================================================================================== 
