
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/to_nume.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TO_NUME ( znap_  varchar2)  RETURN NUMBER as
 nTmp_ number;
begin
 begin
   nTmp_ := to_number(znap_);
 EXCEPTION  WHEN OTHERS THEN null;
 end;
 return nTmp_;
end to_numE;
 
/
 show err;
 
PROMPT *** Create  grants  TO_NUME ***
grant EXECUTE                                                                on TO_NUME         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TO_NUME         to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/to_nume.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 