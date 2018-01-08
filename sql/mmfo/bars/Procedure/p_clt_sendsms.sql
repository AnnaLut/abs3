

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CLT_SENDSMS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CLT_SENDSMS ***

  CREATE OR REPLACE PROCEDURE BARS.P_CLT_SENDSMS ( p_phone varchar2, p_msg_text varchar2) is
l_msgid number;
begin
    bars_sms.create_msg(p_msgid           => l_msgid,
                        p_creation_time   => sysdate,
                        p_expiration_time => sysdate + 1,
                        p_phone           => p_phone,
                        p_encode          => 'lat',
                        p_msg_text        => p_msg_text,
                        p_kf              => sys_context('bars_context','user_mfo'));

exception
        when others then
           bars_audit.info('p_clt_sendsms: Error => ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
           raise_application_error(-20000, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
end p_clt_sendsms;
/
show err;

PROMPT *** Create  grants  P_CLT_SENDSMS ***
grant EXECUTE                                                                on P_CLT_SENDSMS   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CLT_SENDSMS.sql =========*** End
PROMPT ===================================================================================== 
