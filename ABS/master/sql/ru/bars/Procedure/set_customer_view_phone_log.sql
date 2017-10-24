create or replace procedure set_customer_view_phone_log(p_rnk number, p_phone varchar2)
is
l_staff$base staff$base%rowtype;
begin

   select s.* into l_staff$base from staff$base s where s.id=user_id;
  
    insert into customer_view_phone_log(rnk, date_post, phone, branch, userid, logname, fio)
    values(p_rnk, sysdate, p_phone, sys_context('bars_context','user_branch'), user_id(), l_staff$base.logname, l_staff$base.fio);
   
   bars_audit.info('Користувач '||l_staff$base.logname||' переглянув телефон по клієнту з РНК №'||to_char(p_rnk));
    
end set_customer_view_phone_log;
/


grant execute on set_customer_view_phone_log to bars_access_defrole;
/
 