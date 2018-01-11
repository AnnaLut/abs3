

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V8_OVRN.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V8_OVRN ***

  CREATE OR REPLACE FORCE VIEW BARS.V8_OVRN ("KOD", "NAME", "ACC", "TAR") AS 
  select T.kod, T.name, A.acc,  NVL( A.TAR, T.TAR) TAR
from
 (SELECT NAME, KOD, decode(kod, 141,PR, 144,PR, tar/100) TAR FROM     tarif where kod in (141, 142, 143, 144, 145, 146 ) )         T,
 (SELECT ACC , KOD, decode(kod, 141,PR, 144,PR, tar/100) TAR from acc_tarif where acc = to_number ( pul.Get_Mas_Ini_Val('ACC') ) ) A
WHERE T.KOD = A.KOD (+) ;

PROMPT *** Create  grants  V8_OVRN ***
grant SELECT                                                                 on V8_OVRN         to BARSREADER_ROLE;
grant SELECT                                                                 on V8_OVRN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V8_OVRN         to START1;
grant SELECT                                                                 on V8_OVRN         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V8_OVRN.sql =========*** End *** ======
PROMPT ===================================================================================== 
