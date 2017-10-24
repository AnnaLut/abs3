
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/isproxygrantedid.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ISPROXYGRANTEDID (uid int)
return int is
/*
  возвращает флаг 0/1 дано ли право пользователю соединяться
  через прокси-пользователя
*/
  usr   varchar2(30);
begin
  select logname into usr from staff where id=uid;
  return IsProxyGranted(usr);
end;
/
 show err;
 
PROMPT *** Create  grants  ISPROXYGRANTEDID ***
grant EXECUTE                                                                on ISPROXYGRANTEDID to ABS_ADMIN;
grant EXECUTE                                                                on ISPROXYGRANTEDID to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ISPROXYGRANTEDID to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/isproxygrantedid.sql =========*** E
 PROMPT ===================================================================================== 
 