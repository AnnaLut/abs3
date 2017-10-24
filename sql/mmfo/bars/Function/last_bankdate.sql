
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/last_bankdate.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.LAST_BANKDATE return date
is
   l_date  date;
begin
   select max(fdat) into l_date
   from fdat where fdat < bankdate;
   return l_date;
end;
 
/
 show err;
 
PROMPT *** Create  grants  LAST_BANKDATE ***
grant EXECUTE                                                                on LAST_BANKDATE   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LAST_BANKDATE   to START1;
grant EXECUTE                                                                on LAST_BANKDATE   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/last_bankdate.sql =========*** End 
 PROMPT ===================================================================================== 
 