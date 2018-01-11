

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_USER_MESSAGES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_USER_MESSAGES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_USER_MESSAGES ("MSG_ID", "USER_ID", "MSG_TYPE_ID", "MSG_SENDER_ID", "MSG_SUBJECT", "MSG_TEXT", "MSG_DATE", "MSG_ACT_DATE", "MSG_DONE", "USER_COMMENT", "DATE_TEXT", "TODAY", "MSG_DONE_TEXT") AS 
  select
  t."MSG_ID",t."USER_ID",t."MSG_TYPE_ID",t."MSG_SENDER_ID",t."MSG_SUBJECT",t."MSG_TEXT",t."MSG_DATE",t."MSG_ACT_DATE",t."MSG_DONE",t."USER_COMMENT",
  case
    when trunc(t.msg_date) = trunc(sysdate)
      then to_char(msg_date,'hh24:mi')
    else
      to_char(t.msg_date, 'dd.mm hh24:mi')
  end date_text,
  case when trunc(t.msg_date) = trunc(sysdate) then 1 else 0 end today,
  case
    when t.msg_done = 0 then 'Нове повідомлення'
    when t.msg_done = 1 then 'Оброблене'
  end msg_done_text
from user_messages t where t.msg_done=0 and t.user_id = bars.user_id;

PROMPT *** Create  grants  V_USER_MESSAGES ***
grant SELECT                                                                 on V_USER_MESSAGES to BARSREADER_ROLE;
grant SELECT                                                                 on V_USER_MESSAGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_USER_MESSAGES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_USER_MESSAGES.sql =========*** End **
PROMPT ===================================================================================== 
