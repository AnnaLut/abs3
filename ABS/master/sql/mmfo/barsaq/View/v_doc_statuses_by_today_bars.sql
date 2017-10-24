

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_DOC_STATUSES_BY_TODAY_BARS.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_STATUSES_BY_TODAY_BARS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_DOC_STATUSES_BY_TODAY_BARS ("REF", "DOC_ID", "STATUS_ID", "BANK_REF", "STATUS_CHANGE_TIME", "BANK_ACCEPT_DATE", "BANK_BACK_DATE", "STATUS", "CHANGE_TIME", "BACK_REASON", "PDAT") AS 
  select i.ref, e.doc_id, e.status_id, e.bank_ref,
                       e.status_change_time, e.bank_accept_date, e.bank_back_date,
                       o.status, o.change_time, o.back_reason, o.pdat
                         from doc_import i, doc_export e,
                            (select ref,case
                                        when sos<0 then -20
                                        when sos>=5 then 50
                                        else 45
                                        end as status,
                                    (select value from bars.operw where ref=p.ref and tag='BACKR')
                                    as back_reason,
                                    (select change_time from bars.sos_track s
                                     where old_sos<>new_sos and sos_tracker=
                                        (select max(sos_tracker) from bars.sos_track
                                         where ref=s.ref and new_sos=s.new_sos and old_sos<>new_sos)
                                        and ref=p.ref and new_sos=p.sos
                                    ) change_time,
                                    pdat
                             from bars.oper p) o
                         where i.insertion_date >= trunc(sysdate-2)
                           and i.ref is not null -- только документы АБС
                           and e.doc_id=to_number(i.ext_ref) and i.ref=o.ref
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_DOC_STATUSES_BY_TODAY_BARS.sql ====
PROMPT ===================================================================================== 
