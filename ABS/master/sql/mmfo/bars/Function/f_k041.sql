
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_k041.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_K041 (country_ number)
 return int result_cache is

  K041_ char(1) := '1';
begin
  If country_ <> 804 then
     begin
       select k041 into k041_ from kl_k040
       where k040=substr('000'||country_,-3);
     EXCEPTION WHEN NO_DATA_FOUND THEN  K041_:='0';
     end;
  end if;
  RETURN K041_;
end F_K041 ;
 
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_k041.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 