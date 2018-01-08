

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DEBREG_DETAILS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view DEBREG_DETAILS ***

  CREATE OR REPLACE FORCE VIEW BARS.DEBREG_DETAILS ("FN", "DAT", "NUM", "OKPO", "NMK", "ADR", "CUSTTYPE", "REZID", "EVENTTYPE", "EVENTDATE", "DEBNUM", "KV", "CRDAGRNUM", "CRDDATE", "SUMM", "OSN") AS 
  SELECT q.filename,
          q.filedate,
          q.ilnum,
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
          AND q.filename IS NOT NULL
          AND SUBSTR (q.filename, 1, 2) = 'PF'
          AND q.filedate IS NOT NULL;

PROMPT *** Create  grants  DEBREG_DETAILS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_DETAILS  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEBREG_DETAILS  to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DEBREG_DETAILS.sql =========*** End ***
PROMPT ===================================================================================== 
