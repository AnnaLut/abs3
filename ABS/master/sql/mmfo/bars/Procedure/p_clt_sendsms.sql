PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CLT_SENDSMS.sql =========*** Run
PROMPT ===================================================================================== 

PROMPT *** Create  procedure P_CLT_SENDSMS ***

create or replace procedure P_CLT_SENDSMS ( p_phone varchar2, p_msg_text varchar2)
is
begin
  BARS_SMS.CREATE_MSG( p_phone           => p_phone,
                       p_msg_text        => p_msg_text,
                       p_rnk             => null );
exception
  when others then
    bars_audit.error( 'p_clt_sendsms: ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace() );
    raise_application_error( -20000, sqlerrm );
end P_CLT_SENDSMS;
/

show err;

grant EXECUTE  on P_CLT_SENDSMS to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CLT_SENDSMS.sql =========*** End
PROMPT ===================================================================================== 
