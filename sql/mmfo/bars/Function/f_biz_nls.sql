
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_biz_nls.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BIZ_NLS (nls_ varchar2)
  RETURN integer IS
  n_   integer;
BEGIN

  Select count(*) into n_
  From   BIZ_NLS
  Where  trim(NLS)=trim(nls_) ;

  RETURN n_;

END F_BIZ_NLS ;
/
 show err;
 
PROMPT *** Create  grants  F_BIZ_NLS ***
grant EXECUTE                                                                on F_BIZ_NLS       to BARS014;
grant EXECUTE                                                                on F_BIZ_NLS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BIZ_NLS       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_biz_nls.sql =========*** End *** 
 PROMPT ===================================================================================== 
 