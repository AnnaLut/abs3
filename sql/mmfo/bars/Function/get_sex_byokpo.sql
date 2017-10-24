
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_sex_byokpo.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_SEX_BYOKPO (p_okpo varchar2) return number
is
begin
  return 2 - mod(to_number(substr(p_okpo, 9, 1)), 2);
end get_sex_byokpo;
/
 show err;
 
PROMPT *** Create  grants  GET_SEX_BYOKPO ***
grant EXECUTE                                                                on GET_SEX_BYOKPO  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_SEX_BYOKPO  to CUST001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_sex_byokpo.sql =========*** End
 PROMPT ===================================================================================== 
 