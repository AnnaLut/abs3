

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/MGR_RESUMABLE_ALERT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger MGR_RESUMABLE_ALERT ***

  CREATE OR REPLACE TRIGGER BARS.MGR_RESUMABLE_ALERT 
AFTER SUSPEND
ON DATABASE
DECLARE
   v_ret_value     BOOLEAN;
   v_error_type    VARCHAR2(30);
   v_obj_type      VARCHAR2(30);
   v_obj_owner     VARCHAR2(30);
   v_tbs_name      VARCHAR2(30);
   v_obj_name      VARCHAR2(30);
   v_sub_obj_name  VARCHAR2(30);
BEGIN
   --Get all error variables
   v_ret_value := sys.dbms_resumable.space_error_info(
                  error_type       => v_error_type,
                  object_type      => v_obj_type,
                  object_owner     => v_obj_owner,
                  table_space_name => v_tbs_name,
                  object_name      => v_obj_name,
                  sub_object_name  => v_sub_obj_name);

   --Set timeout to 8 hours.This is the time that DBAs have to fix space problem
   sys.dbms_resumable.set_timeout(28800);
   -- Send email to DBA via UTL_SMTP package
   p_send_mail(msg_to      => 'kikotiv@oschadbank.ua',
               msg_subject => 'Resumable Alert For Migration!!!',
               msg_text    => 'Check database for space problems!'||chr(10)||
                              'Error type:' ||v_error_type||chr(10)||
                              'Obj Name:' ||v_obj_name||chr(10)||
                              'Obj Type:' ||v_obj_type||chr(10)||
                              'Obj Owner:' ||v_obj_owner||chr(10)||
                              'Tablespace Name:' ||v_tbs_name||chr(10)||
                              'Sub object name:' ||v_sub_obj_name||chr(10)||
                              ' Space resumable alert found in the database' || chr(10) ||
                              ' Iusse --select user_id,session_id, status, start_time, suspend_time,resume_time, error_msg from dba_resumable--' || chr(10) ||
                              ' Check the alert log for suspended sessions!');
END;

/
ALTER TRIGGER BARS.MGR_RESUMABLE_ALERT DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/MGR_RESUMABLE_ALERT.sql =========***
PROMPT ===================================================================================== 
