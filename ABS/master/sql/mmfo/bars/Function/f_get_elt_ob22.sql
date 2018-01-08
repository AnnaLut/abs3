
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_elt_ob22.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ELT_OB22 
(p_id int, p_nbs varchar2)
RETURN e_tarif.ob22_3570%type IS

-- *** ver 1.1 в_д 16/02-16 ***
-- Пошук OB22 по E_TARIF

l_ret   e_tarif.ob22_3570%type;

begin
 begin
 select decode(p_nbs,'3570',ob22_3570,'3579',ob22_3579,'6110',ob22_6110,'')
 into l_ret
 from e_tarif
 where id=p_id;
 exception when no_data_found then null;
 end;
 RETURN l_ret;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ELT_OB22 ***
grant EXECUTE                                                                on F_GET_ELT_OB22  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ELT_OB22  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_elt_ob22.sql =========*** End
 PROMPT ===================================================================================== 
 