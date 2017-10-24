

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_DOC_STATUSES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_STATUSES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_DOC_STATUSES ("REF", "INSERTION_DATE", "DOC_ID", "IBANK_STATUS_ID", "BARS_STATUS_ID", "BANK_REF", "STATUS_CHANGE_TIME", "BANK_ACCEPT_DATE", "BANK_BACK_DATE", "CHANGE_TIME", "BACK_REASON", "PDAT") AS 
  SELECT i.REF,
            i.insertion_date,
            e.doc_id,
            e.status_id,
            o.status,
            e.bank_ref,
            e.status_change_time,
            e.bank_accept_date,
            e.bank_back_date,
            o.change_time,
            o.back_reason,
            o.pdat
       FROM doc_import i,
            doc_export e,
            (SELECT REF,
                    CASE
                       WHEN sos < 0 THEN -20
                       WHEN sos >= 5 THEN 50
                       ELSE 45
                    END
                       AS status,
                    (SELECT VALUE
                       FROM bars.operw
                      WHERE REF = p.REF AND tag = 'BACKR')
                       AS back_reason,
                    (SELECT change_time
                       FROM bars.sos_track s
                      WHERE     old_sos <> new_sos
                            AND sos_tracker =
                                   (SELECT MAX (sos_tracker)
                                      FROM bars.sos_track
                                     WHERE     REF = s.REF
                                           AND new_sos = s.new_sos
                                           AND old_sos <> new_sos)
                            AND REF = p.REF
                            AND new_sos = p.sos)
                       change_time,
                    pdat
               FROM bars.oper p) o
      WHERE i.REF IS NOT NULL -- только документы АБС
            AND e.doc_id = TO_NUMBER (i.ext_ref)
            AND i.REF = o.REF;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_DOC_STATUSES.sql =========*** End *
PROMPT ===================================================================================== 
