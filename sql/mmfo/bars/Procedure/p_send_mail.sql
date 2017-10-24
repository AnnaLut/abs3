

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SEND_MAIL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SEND_MAIL ***

  CREATE OR REPLACE PROCEDURE BARS.P_SEND_MAIL (
                                        msg_to varchar2,
                                        msg_subject varchar2,
                                        msg_text varchar2)
IS
  v_cur_db_name        VARCHAR2(30)   := SYS_CONTEXT('USERENV', 'DB_NAME');
  v_cur_server_host    VARCHAR2(30)   := SYS_CONTEXT ('USERENV', 'SERVER_HOST');
  v_From               VARCHAR2(80)   := 'noreply@oschadbank.ua';
  v_Recipient          VARCHAR2(80)   :=  msg_to;
  v_Subject            VARCHAR2(80)   :=  msg_subject;
  v_Text               VARCHAR2(4000) :=  msg_text;
  v_Mail_Host          VARCHAR2(30)   := 'mail.oschadbank.ua'; -- local database host
  v_Mail_Conn          utl_smtp.Connection;
  crlf                 VARCHAR2(2)    := chr(13)||chr(10);

BEGIN
  v_Mail_Conn := utl_smtp.Open_Connection(v_Mail_Host, 25);
  utl_smtp.Helo(v_Mail_Conn, v_Mail_Host);
  utl_smtp.Mail(v_Mail_Conn, v_From);
  utl_smtp.Rcpt(v_Mail_Conn, v_Recipient);
  utl_smtp.Data(v_Mail_Conn,
    'Date: '   || to_char(sysdate, 'Dy, DD Mon YYYY hh24:mi:ss') || crlf ||
    'From: '   || 'MMFO DB <noreply@oschadbank.ua>' || crlf ||
    'Subject: '|| 'Oracle Database - '|| v_cur_db_name ||', Server Host - '|| v_cur_server_host|| ' ' || v_Subject || crlf ||
    'To: '     || v_Recipient || crlf ||
    crlf ||
    v_Text || crlf -- Message body
  );
  utl_smtp.Quit(v_mail_conn);
EXCEPTION
  WHEN UTL_SMTP.INVALID_OPERATION THEN
       --dbms_output.put_line('Invalid Operation in Mail attempt using UTL_SMTP.');
       raise_application_error(-20001,'Invalid Operation in Mail attempt using UTL_SMTP: ' || sqlerrm);
  WHEN UTL_SMTP.TRANSIENT_ERROR THEN
       --dbms_output.put_line('Temporary e-mail issue – try again');
       raise_application_error(-20002,'Temporary e-mail issue – try again: ' || sqlerrm);
  WHEN UTL_SMTP.PERMANENT_ERROR THEN
       --dbms_output.put_line('Permanent Error Encountered.');
       raise_application_error(-20003,'Permanent Error Encountered: ' || sqlerrm);
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SEND_MAIL.sql =========*** End *
PROMPT ===================================================================================== 
