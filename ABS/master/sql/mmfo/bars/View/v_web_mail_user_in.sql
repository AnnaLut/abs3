

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WEB_MAIL_USER_IN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WEB_MAIL_USER_IN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WEB_MAIL_USER_IN ("MAIL_ID", "MAIL_SENDER_ID", "MAIL_SUBJECT", "MAIL_BODY", "MAIL_DATE", "MAIL_RECIPIENT_ID", "READED", "READED_DATE", "MAIL_SENDER_NAME", "ATTACH_COUNT") AS 
  select b.mail_id, b.mail_sender_id, b.mail_subject, b.mail_body,
          b.mail_date, t.mail_recipient_id, t.readed, t.readed_date,
          s1.fio mail_sender_name, (select count (attach_id)
                                      from web_mail_attach
                                     where mail_id = b.mail_id) attach_count
     from web_mail_box b, web_mail_to t, staff s1
     where t.mail_id = b.mail_id
      and t.mail_recipient_id = bars.user_id
      and b.mail_sender_id = s1.id;

PROMPT *** Create  grants  V_WEB_MAIL_USER_IN ***
grant SELECT                                                                 on V_WEB_MAIL_USER_IN to BARSREADER_ROLE;
grant SELECT                                                                 on V_WEB_MAIL_USER_IN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WEB_MAIL_USER_IN to START1;
grant SELECT                                                                 on V_WEB_MAIL_USER_IN to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WEB_MAIL_USER_IN.sql =========*** End
PROMPT ===================================================================================== 
