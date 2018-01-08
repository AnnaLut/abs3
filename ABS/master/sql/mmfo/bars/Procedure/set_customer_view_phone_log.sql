

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_CUSTOMER_VIEW_PHONE_LOG.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_CUSTOMER_VIEW_PHONE_LOG ***

  CREATE OR REPLACE PROCEDURE BARS.SET_CUSTOMER_VIEW_PHONE_LOG (p_rnk number, p_phone varchar2)
is
l_staff$base staff$base%rowtype;
begin

   select s.* into l_staff$base from staff$base s where s.id=user_id;

    insert into customer_view_phone_log(rnk, date_post, phone, branch, userid, logname, fio)
    values(p_rnk, sysdate, p_phone, sys_context('bars_context','user_branch'), user_id(), l_staff$base.logname, l_staff$base.fio);

   bars_audit.info('Користувач '||l_staff$base.logname||' переглянув телефон по клієнту з РНК №'||to_char(p_rnk));

end set_customer_view_phone_log;
/
show err;

PROMPT *** Create  grants  SET_CUSTOMER_VIEW_PHONE_LOG ***
grant EXECUTE                                                                on SET_CUSTOMER_VIEW_PHONE_LOG to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_CUSTOMER_VIEW_PHONE_LOG.sql ==
PROMPT ===================================================================================== 
