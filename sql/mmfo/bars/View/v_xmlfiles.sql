

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLFILES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLFILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLFILES ("PNAM", "DATF", "DATP", "NDOCTOTAL", "NDOCPAYED", "MESSCODE", "MESSTYPE", "DIRECTION", "REFNAME", "SYNCTYPE", "SYNCTYPENAME") AS 
  select pnam, datf, datp, ndoctotal, ndocpayed,    descript,   decode(type, 'service', type, 'document'),
               0,         '',      0,       ''
          from xml_gate g, xml_messtypes t
         where g.messtype = t.message
        union  all
        select pnam, datf, datf, rowscnt,   0 ndocpayed,  'REFS',    '',
               1,    r.descript, f.synctype, t.descript
          from xml_syncfiles f, xml_reflist r, xml_synctypes t
         where f.refname = r.kltable_name and f.synctype = t.synctype
     
 ;

PROMPT *** Create  grants  V_XMLFILES ***
grant SELECT                                                                 on V_XMLFILES      to KLBX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLFILES.sql =========*** End *** ===
PROMPT ===================================================================================== 
