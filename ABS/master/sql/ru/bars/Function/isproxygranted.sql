
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/isproxygranted.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ISPROXYGRANTED (uname varchar2)
return int is
/*
  возвращает флаг 0/1 дано ли право пользователю соединяться
  через прокси-пользователя
*/
  cnt int;
begin
  select count(*) into cnt from proxy_users
  where client=uname and proxy=(select nvl(min(val),'APPSERVER') from params where par='PROXYUSR');
  return cnt;
end;
/
 show err;
 
PROMPT *** Create  grants  ISPROXYGRANTED ***
grant EXECUTE                                                                on ISPROXYGRANTED  to ABS_ADMIN;
grant EXECUTE                                                                on ISPROXYGRANTED  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ISPROXYGRANTED  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/isproxygranted.sql =========*** End
 PROMPT ===================================================================================== 
 