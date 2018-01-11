
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_bars_mail.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_BARS_MAIL as object
(
  name     		varchar2(256),
  addr     		varchar2(256),
  subject  		varchar2(256),
  content_type  varchar2(60),
  charset  		varchar2(30),
  body     		clob
)
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_bars_mail.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 