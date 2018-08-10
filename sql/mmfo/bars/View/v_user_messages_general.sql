prompt create view v_user_messages_general
create or replace force view v_user_messages_general as
select
  t."MSG_ID",
  t."USER_ID",
  t."MSG_TYPE_ID",
  t."MSG_SENDER_ID",
  t."MSG_TEXT",
  t."MSG_DATE",
  t."MSG_ACT_DATE",
  t."MSG_DONE",
  t."USER_COMMENT",
  case
    when trunc(t.msg_date) = trunc(sysdate)
      then to_char(msg_date,'hh24:mi')
    else
      to_char(t.msg_date, 'dd.mm hh24:mi')
  end date_text,
  case when trunc(t.msg_date) = trunc(sysdate) then 1 else 0 end today,
  'Нове повідомлення' msg_done_text
from (
select t.id msg_id,
       to_number(t.receiver_id) user_id,
       t.message_type_id msg_type_id,
       t.sender_id msg_sender_id,
       t.message_text msg_text,
       t.effective_time msg_date,
       t.expiration_time msg_act_date,
       case when t.processing_time is null then 0 else 1 end msg_done,
       t.processing_comment user_comment,
       t.processing_time msg_done_date
from   bms_message t
where  t.message_type_id in (4, 3, 1, 2) and t.effective_time <= sysdate
) t where t.msg_done=0;

grant select on bars.v_user_messages_general to bars_access_defrole;