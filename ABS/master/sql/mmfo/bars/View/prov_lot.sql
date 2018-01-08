

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROV_LOT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view PROV_LOT ***

  CREATE OR REPLACE FORCE VIEW BARS.PROV_LOT ("TT", "REF", "NLSD", "S", "FDAT", "NLSK", "BRANCH", "NAZN", "TEMA") AS 
  select tt, REF, nlsd, s, fdat, nlsk, BRANCH, NAZN,
       decode (substr(nlsd,1,4),'9819', 'Прийнято з дороги, шт.',
       decode (substr(nlsd,1,4),'9910', 'Розповсюджено, шт.'    ,
       decode (substr(nlsd,1,4),'9812', 'Сплашено вигр, шт.'    ,
       decode (substr(nlsd,1,3),'100' , 'Прийнято коштiв, грн.' ,
       decode (substr(nlsd,1,1),'2'   , 'Сплачено коштiв, грн.' ,
       ''
       )  )  )  )  )  tema
from provodki
where fdat >= add_months(sysdate,-1 ) and
 (   NLSD LIKE '9819%' and  NLSK like '989%'
  OR NlSD LIKE '9910%' and  NLSK like '9819%'
  OR NlSD like '9812%' and  NlSK like '9910%'
  OR NlSD like '100%'  and  NlSK like '2905%'
  OR NlSD like '100%'  and  NlSK like '2805%'
  OR NlSD like '2905%' and  NlSK like '100%'
  OR NlSD like '2805%' and  NlSK like '100%'
 )
 ;

PROMPT *** Create  grants  PROV_LOT ***
grant SELECT                                                                 on PROV_LOT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PROV_LOT        to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROV_LOT.sql =========*** End *** =====
PROMPT ===================================================================================== 
