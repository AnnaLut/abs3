

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MON2.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MON2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MON2 ("KOD", "NAME", "NOM_MON", "CENA2", "KODF", "NAMEF", "CENAF2", "PRODAZA") AS 
  select
  kod, NAME,NOM_MON,CENA2,KODF,NAMEF,CENAF2,
  make_docinput_url
         ('BMY', 'Продати',
          'reqv_BM__C',  KOD,
          'reqv_BM__N',  NAME,
          'reqv_BM__Y',  NOM_MON,
          'reqv_BM__R',  CENA2 ,
          'reqv_BM_FC',  KODF,
          'reqv_BM_FN',  NAMEF,
          'reqv_BM_FR',  CENAF2
         )
from v_mon1 
 ;

PROMPT *** Create  grants  V_MON2 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_MON2          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MON2.sql =========*** End *** =======
PROMPT ===================================================================================== 
