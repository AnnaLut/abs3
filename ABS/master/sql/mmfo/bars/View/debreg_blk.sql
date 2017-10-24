

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DEBREG_BLK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view DEBREG_BLK ***

  CREATE OR REPLACE FORCE VIEW BARS.DEBREG_BLK ("REQUESTID", "ERRORCODE", "OKPO", "NMK", "ADR", "CUSTTYPE", "REZID", "EVENTTYPE", "EVENTDATE", "DEBNUM", "KV", "CRDAGRNUM", "CRDDATE", "SUMM", "OSN") AS 
  SELECT q.requestid,
          TO_NUMBER (q.errorcode),
          d.okpo,
          d.nmk,
          d.adr,
          d.custtype,
          d.rezid,
          q.eventtype,
          q.eventdate,
          d.debnum,
          d.kv,
          d.crdagrnum,
          d.crddate,
          d.summ,
          d.osn
     FROM debreg d, debreg_query q
    WHERE     d.debnum = q.debnum
          AND phaseid = 'F'
          AND q.errorcode IS NOT NULL
          AND TO_NUMBER (q.errorcode) > 0;

PROMPT *** Create  grants  DEBREG_BLK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_BLK      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_BLK      to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DEBREG_BLK.sql =========*** End *** ===
PROMPT ===================================================================================== 
