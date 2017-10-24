

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EAD_SYNC_QUEUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EAD_SYNC_QUEUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EAD_SYNC_QUEUE ("SYNC_ID", "CRT_DATE", "TYPE_ID", "TYPE_NAME", "OBJ_ID", "STATUS_ID", "STATUS_NAME", "ERR_TEXT", "ERR_COUNT", "MESSAGE_ID", "MESSAGE_DATE", "RESPONCE_ID", "RESPONCE_DATE") AS 
  select sq.id as sync_id,
       sq.crt_date,
       sq.type_id,
       t.name           as type_name,
       sq.obj_id,
       sq.status_id,
       s.name           as status_name,
       sq.err_text,
       sq.err_count,
       sq.message_id,
       sq.message_date,
       sq.responce_id,
       sq.responce_date
  from ead_sync_queue sq, ead_types t, ead_statuses s
 where sq.crt_date >
       add_months(sysdate, -1 * ead_pack.g_process_actual_time)
   and sq.type_id = t.id
   and sq.status_id = s.id
 order by sq.id desc;

PROMPT *** Create  grants  V_EAD_SYNC_QUEUE ***
grant SELECT                                                                 on V_EAD_SYNC_QUEUE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EAD_SYNC_QUEUE.sql =========*** End *
PROMPT ===================================================================================== 
