

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WEB_MAIL_USER_OUT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WEB_MAIL_USER_OUT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WEB_MAIL_USER_OUT ("MAIL_ID", "MAIL_SENDER_ID", "MAIL_SUBJECT", "MAIL_BODY", "MAIL_DATE", "ATTACH_COUNT") AS 
  select b.mail_id, b.mail_sender_id, b.mail_subject, b.mail_body, b.mail_date,
       (select count (attach_id) from web_mail_attach where mail_id = b.mail_id) attach_count
    from web_mail_box b
    where b.mail_sender_id = bars.user_id;

PROMPT *** Create  grants  V_WEB_MAIL_USER_OUT ***
grant SELECT                                                                 on V_WEB_MAIL_USER_OUT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WEB_MAIL_USER_OUT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WEB_MAIL_USER_OUT.sql =========*** En
PROMPT ===================================================================================== 
