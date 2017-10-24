
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/vkr.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VKR (nls_ VARCHAR2) RETURN VARCHAR2 IS
-- ¬ычисление # счета с контрольным разр€дом
BEGIN
   RETURN VKRZN(SUBSTR(gl.aMFO,1,5),nls_);
END VKR;
/
 show err;
 
PROMPT *** Create  grants  VKR ***
grant EXECUTE                                                                on VKR             to FINMON01;
grant EXECUTE                                                                on VKR             to PUBLIC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/vkr.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 