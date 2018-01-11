

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACCM_AGG_MONBALS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view ACCM_AGG_MONBALS ***

  CREATE OR REPLACE FORCE VIEW BARS.ACCM_AGG_MONBALS ("CALDT_ID", "ACC", "RNK", "OST", "OSTQ", "DOS", "DOSQ", "KOS", "KOSQ", "CRDOS", "CRDOSQ", "CRKOS", "CRKOSQ", "CUDOS", "CUDOSQ", "CUKOS", "CUKOSQ") AS 
  SELECT
x.CALDT_ID,
    b.ACC,
    b.RNK,
NVL(    b.OST,0),
NVL(   b.OSTQ,0),
NVL(    b.DOS,0),
NVL(   b.DOSQ,0),
NVL(    b.KOS,0),
NVL(   b.KOSQ,0),
NVL(  b.CRDOS,0),
NVL( b.CRDOSQ,0),
NVL(  b.CRKOS,0),
NVL( b.CRKOSQ,0),
NVL(  b.CUDOS,0),
NVL( b.CUDOSQ,0),
NVL(  b.CUKOS,0),
NVL( b.CUKOSQ,0)
     FROM AGG_MONBALS b,
          (SELECT     LEVEL - 1 caldt_id
                 FROM DUAL
           CONNECT BY LEVEL < 100000) x
    WHERE b.fdat = TO_DATE (x.caldt_id + 2447892, 'J');

PROMPT *** Create  grants  ACCM_AGG_MONBALS ***
grant SELECT                                                                 on ACCM_AGG_MONBALS to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on ACCM_AGG_MONBALS to BARSREADER_ROLE;
grant SELECT                                                                 on ACCM_AGG_MONBALS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_AGG_MONBALS to START1;
grant SELECT                                                                 on ACCM_AGG_MONBALS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACCM_AGG_MONBALS.sql =========*** End *
PROMPT ===================================================================================== 
