
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_sid.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_SID return int
is
  sid_  int;
begin
  SELECT SID
  into   sid_
  FROM   V$SESSION
  WHERE  AUDSID=USERENV('sessionid');
  return sid_;
exception when others then
  return null;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_SID ***
grant EXECUTE                                                                on F_GET_SID       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_SID       to TECH_MOM1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_sid.sql =========*** End *** 
 PROMPT ===================================================================================== 
 