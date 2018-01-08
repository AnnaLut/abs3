

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VREZ14.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view VREZ14 ***

  CREATE OR REPLACE FORCE VIEW BARS.VREZ14 ("RI", "MFO", "RNK", "ND", "KV", "Z14", "P14", "Z15", "P15", "EVENT", "REF", "P152", "Z14N", "Z15N", "PF", "V14", "V15", "V14N", "V15N", "VIDD", "NZ15", "NV15", "QZ15", "QV15", "NZ15U", "NV15U", "QZ15U", "QV15U", "Z14U", "V14U", "REF15", "BVQ14", "BVQ15", "B9Q14", "B9Q15", "REFP14", "REFP15", "REF152", "P153", "REF153", "TIPA", "NLS", "ID") AS 
  select rowid RI, r."MFO",r."RNK",r."ND",r."KV",r."Z14",r."P14",r."Z15",r."P15",r."EVENT",r."REF",r."P152",r."Z14N",r."Z15N",r."PF",r."V14",r."V15",r."V14N",r."V15N",r."VIDD",r."NZ15",r."NV15",r."QZ15",r."QV15",r."NZ15U",r."NV15U",r."QZ15U",r."QV15U",r."Z14U",r."V14U",r."REF15",r."BVQ14",r."BVQ15",r."B9Q14",r."B9Q15",r."REFP14",r."REFP15",r."REF152",r."P153",r."REF153",r."TIPA",r."NLS",r."ID" from REZ14 r;

PROMPT *** Create  grants  VREZ14 ***
grant SELECT,UPDATE                                                          on VREZ14          to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on VREZ14          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VREZ14.sql =========*** End *** =======
PROMPT ===================================================================================== 
