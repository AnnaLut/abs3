

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/USER_MESSAGES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view USER_MESSAGES ***

  CREATE OR REPLACE FORCE VIEW BARS.USER_MESSAGES ("MSG_ID", "USER_ID", "MSG_TYPE_ID", "MSG_SENDER_ID", "MSG_SUBJECT", "MSG_TEXT", "MSG_DATE", "MSG_ACT_DATE", "MSG_DONE", "USER_COMMENT", "MSG_DONE_DATE") AS 
  select t.id msg_id,
       to_number(t.receiver_id) user_id,
       t.message_type_id msg_type_id,
       t.sender_id msg_sender_id,
       mt.message_type_name msg_subject,
       t.message_text msg_text,
       t.effective_time msg_date,
       t.expiration_time msg_act_date,
       case when t.processing_time is null then 0 else 1 end msg_done,
       t.processing_comment user_comment,
       t.processing_time msg_done_date
from   bms_message t
join   bms_message_type mt on mt.id = t.message_type_id and
                              mt.message_type_code in ('ASYNC_RUN_MESSAGE', 'BORU_MESSAGE', 'ORDINARY_MESSAGE', 'BACK_OFFICE_REQUEST')
where  t.effective_time <= sysdate
;

PROMPT *** Create  grants  USER_MESSAGES ***
grant SELECT                                                                 on USER_MESSAGES   to BARSREADER_ROLE;
grant SELECT                                                                 on USER_MESSAGES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/USER_MESSAGES.sql =========*** End *** 
PROMPT ===================================================================================== 
