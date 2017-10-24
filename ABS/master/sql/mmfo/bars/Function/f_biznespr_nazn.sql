
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_biznespr_nazn.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BIZNESPR_NAZN (p_nazn varchar2)
  RETURN integer IS
  n_   integer;
BEGIN

  Select count(*) into n_
  From   biznespr_nazn
  Where  upper(p_nazn) like '%'||SLOVO||'%' ;

  RETURN n_;

END f_biznespr_nazn ;
/
 show err;
 
PROMPT *** Create  grants  F_BIZNESPR_NAZN ***
grant EXECUTE                                                                on F_BIZNESPR_NAZN to BARS014;
grant EXECUTE                                                                on F_BIZNESPR_NAZN to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BIZNESPR_NAZN to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_biznespr_nazn.sql =========*** En
 PROMPT ===================================================================================== 
 