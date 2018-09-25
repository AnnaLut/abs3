CREATE OR REPLACE PROCEDURE BARSAQ.P_DOC_EXPORT_ALIGN_BYDOCID(p_doc_id in number) as
begin
  for c in (select i.ref,
                   e.doc_id,
                   tos.status_id,
                   e.bank_ref,
                   e.status_change_time,
                   e.bank_accept_date,
                   e.bank_back_date,
                   o.status,
                   o.change_time,
                   o.back_reason,
                   o.pdat
              from doc_import i,
                   doc_export e,
                   ibank.v_doc_export_open tos,
                   (select ref,
                           case
                             when sos < 0 then
                              -20
                             when sos >= 5 then
                              50
                             else
                              45
                           end as status,
                           (select value
                              from bars.operw
                             where ref = p.ref
                               and tag = 'BACKR') as back_reason,
                           (select change_time
                              from bars.sos_track s
                             where old_sos <> new_sos
                               and sos_tracker =
                                   (select max(sos_tracker)
                                      from bars.sos_track
                                     where ref = s.ref
                                       and new_sos = s.new_sos
                                       and old_sos <> new_sos)
                               and ref = p.ref
                               and new_sos = p.sos) change_time,
                           pdat
                      from bars.oper p) o
             where --i.insertion_date between sysdate - 30 and sysdate - 2 and 
                   o.status != tos.status_id
               and i.ref is not null
             -- только документы АБС
               and to_char(tos.doc_id) = i.ext_ref
               and i.ref = o.ref
               and e.doc_id = tos.doc_id
               and tos.doc_id = p_doc_id) 
   loop
     update doc_export
        set BANK_ACCEPT_DATE   = c.change_time,
            status_id          = c.status,
            bank_back_reason   = c.back_reason,
            status_change_time = c.change_time
      where doc_id = c.doc_id;
     update ibank.v_doc_export_open
        set BANK_ACCEPT_DATE   = c.change_time,
            status_id          = c.status,
            bank_back_reason   = c.back_reason,
            status_change_time = c.change_time
      where doc_id = c.doc_id;
  end loop;
  commit;
end;
/