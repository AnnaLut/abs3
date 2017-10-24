

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MESSAGE_FOR_ACTIVE_USERS.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MESSAGE_FOR_ACTIVE_USERS ***

  CREATE OR REPLACE PROCEDURE BARS.P_MESSAGE_FOR_ACTIVE_USERS (p_message_text varchar2, 
                                                            p_post_after_min number, 
                                                            p_delete_after_min number) is
begin
    insert into tmp_msg_uids
    select unique s.user_id
    from   staff_user_session s
    where  s.logout_time is null;
    bms.send_message(null, 1, p_message_text, p_post_after_min * 60, p_delete_after_min * 60);
    commit;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MESSAGE_FOR_ACTIVE_USERS.sql ===
PROMPT ===================================================================================== 
