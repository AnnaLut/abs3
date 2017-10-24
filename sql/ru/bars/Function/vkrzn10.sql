
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vkrzn10.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VKRZN10 (BDAT_ date,OKPO_ varchar2 )
RETURN varchar2 IS
BEGIN
 return OKPO_;
end vkrzn10;
/
 show err;
 
PROMPT *** Create  grants  VKRZN10 ***
grant EXECUTE                                                                on VKRZN10         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vkrzn10.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 