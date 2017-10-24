
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ref_cp_nbu.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.REF_CP_NBU ( p_REF number)  return number is
  l_REF number;
begin
  l_ref := p_ref;
-- ¤«ο ¬®­®-”
 RETURN l_ref;

-- ¤«ο ¬γ«μβ¨-”
-- if gl.amfo ='300001' then
--    l_ref := ( p_ref - mod( p_ref,100) ) /100;
-- end if;
--

 RETURN l_ref;

end REF_CP_NBU ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ref_cp_nbu.sql =========*** End ***
 PROMPT ===================================================================================== 
 