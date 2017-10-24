
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_cust_fmdat.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CUST_FMDAT ( p_dat number ) return date is
-- p_dat в формате ddMMyyyy
  l_dat date;
begin
  if ( p_dat = 0 or p_dat is null ) then
     l_dat := bankdate;
  else
     l_dat := to_date(lpad(to_char(p_dat),8,'0'), 'ddMMyyyy');
  end if;
  return l_dat;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CUST_FMDAT ***
grant EXECUTE                                                                on F_GET_CUST_FMDAT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_CUST_FMDAT to CC_DOC;
grant EXECUTE                                                                on F_GET_CUST_FMDAT to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_cust_fmdat.sql =========*** E
 PROMPT ===================================================================================== 
 