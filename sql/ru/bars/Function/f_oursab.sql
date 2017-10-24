
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_oursab.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OURSAB return char is
l_sab char(3);

BEGIN
 begin
   select substr(sab,2,3)
     into l_sab
     from banks
    where mfo=f_ourmfo;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_sab:='   ';
 end;
return l_sab;
end f_oursab;
/
 show err;
 
PROMPT *** Create  grants  F_OURSAB ***
grant EXECUTE                                                                on F_OURSAB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OURSAB        to SALGL;
grant EXECUTE                                                                on F_OURSAB        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_oursab.sql =========*** End *** =
 PROMPT ===================================================================================== 
 