

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MESSAGE_FOR_RELEASE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MESSAGE_FOR_RELEASE ***

  CREATE OR REPLACE PROCEDURE BARS.P_MESSAGE_FOR_RELEASE (p_post_after_min number) is
   l_mess varchar2(1000);
begin
    l_mess := 'Увага! Чергове поновлення буде встановлене о '|| to_char( sysdate + (1/(24*60)) * p_post_after_min, 'hh24:mi:')||'00. Прохання тимчасово припинити роботу в АБС' ;
    p_message_for_active_users(p_message_text     =>  l_mess ,
                               p_post_after_min   =>  p_post_after_min,
                               p_delete_after_min =>  3);
end;
/
show err;

PROMPT *** Create  grants  P_MESSAGE_FOR_RELEASE ***
grant EXECUTE                                                                on P_MESSAGE_FOR_RELEASE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MESSAGE_FOR_RELEASE.sql ========
PROMPT ===================================================================================== 
