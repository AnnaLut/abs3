

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/BUCH_B.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view BUCH_B ***

  CREATE OR REPLACE FORCE VIEW BARS.BUCH_B ("NM", "TT", "DK", "REF", "MFO", "ND", "NLS", "NLSK", "SK", "S", "VDATE", "DATD", "PLAT", "POLU", "NAZ1", "VOB", "TP", "KOD") AS 
  SELECT
  nm,
  tt,
  dk,
  ref,
  TO_NUMBER(mfo),
  nd,
  nls,
  nlsk,
  sk,
  s,
  vdate,
  datd,
  plat,
  polu,
  naz1,
  vob,
  SUBSTR(tp,1,2),
  kod
FROM buch_d
where  substr(nls, 1,2)<>'86' and
      (substr(nls, 1,2)<>'26' or
       substr(nlsk,1,2)<>'26');

PROMPT *** Create  grants  BUCH_B ***
grant SELECT                                                                 on BUCH_B          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BUCH_B          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/BUCH_B.sql =========*** End *** =======
PROMPT ===================================================================================== 
