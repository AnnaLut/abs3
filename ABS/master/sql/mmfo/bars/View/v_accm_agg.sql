

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCM_AGG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCM_AGG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCM_AGG ("ACC", "YYYYMM", "CALDT_DATE", "VOST", "VOSTQ", "DOS", "DOSQ", "KOS", "KOSQ", "IOST", "IOSTQ") AS 
  select m.acc, to_char(b.caldt_date,'yyyy.mm') YYYYMM,   b.caldt_date,
        ( m.OST  + (m.dos +m.crdos ) - (m.kos +m.crkos ) ) / 100  vost ,
        ( m.OSTq + (m.dosq+m.crdosq) - (m.kosq+m.crkosq) ) / 100  vostq,
                   (m.dos +m.crdos )                       / 100  dOS  ,
                   (m.dosq+m.crdosq)                       / 100  dOSq ,
                                       (m.kos +m.crkos )   / 100  KOS  ,
                                       (m.kosq+m.crkosq)   / 100  KOSq ,
          m.OST                                            / 100  IOST ,
          m.OSTq                                           / 100 IOSTq
FROM ACCM_AGG_MONBALS m,
    (select to_char(caldt_date,'yyyy.mm') YYYYMM, caldt_id, caldt_date
     from ACCM_CALENDAR  where caldt_date =
     trunc(NVL(TO_DATE(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'),gl.bd ),'MM')
     ) b
where m.caldt_id=b.caldt_id ;

PROMPT *** Create  grants  V_ACCM_AGG ***
grant SELECT                                                                 on V_ACCM_AGG      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCM_AGG      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCM_AGG.sql =========*** End *** ===
PROMPT ===================================================================================== 
