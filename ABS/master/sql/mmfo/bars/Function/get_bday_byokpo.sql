
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_bday_byokpo.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_BDAY_BYOKPO (p_okpo varchar2) return date
is
begin
  return to_date('31/12/1899', 'dd/MM/yyyy') + to_number(substr(p_okpo, 1, 5));
end get_bday_byokpo;
/
 show err;
 
PROMPT *** Create  grants  GET_BDAY_BYOKPO ***
grant EXECUTE                                                                on GET_BDAY_BYOKPO to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_BDAY_BYOKPO to CUST001;
grant EXECUTE                                                                on GET_BDAY_BYOKPO to PFU;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_bday_byokpo.sql =========*** En
 PROMPT ===================================================================================== 
 