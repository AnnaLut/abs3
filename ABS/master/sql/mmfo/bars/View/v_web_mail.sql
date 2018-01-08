

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WEB_MAIL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WEB_MAIL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WEB_MAIL ("MAIL_ID", "MAIL_SENDER_ID", "MAIL_SUBJECT", "MAIL_BODY", "MAIL_DATE", "MAIL_RECIPIENT_ID", "READED", "READED_DATE", "MAIL_RECIPIENT_NAME", "MAIL_SENDER_NAME") AS 
  select b.mail_id, b.mail_sender_id, b.mail_subject, b.mail_body,
          b.mail_date, t.mail_recipient_id, t.readed, t.readed_date,
          web_mail.mail_recipients (b.mail_id) mail_recipient_name,
          s.fio mail_sender_name
     from web_mail_box b, web_mail_to t, staff s
    where t.mail_id(+) = b.mail_id
      and b.mail_sender_id = s.id
      and (   t.mail_recipient_id = bars.user_id
           or b.mail_sender_id = bars.user_id
          );

PROMPT *** Create  grants  V_WEB_MAIL ***
grant SELECT                                                                 on V_WEB_MAIL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WEB_MAIL      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WEB_MAIL.sql =========*** End *** ===
PROMPT ===================================================================================== 
