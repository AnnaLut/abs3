
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/rb.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.RB IS
---------------------------------
-- заголовок процедуры расчета резервного фонда
PROCEDURE REZ (  FDAT_  date );
----------------------------------
END RB;

 
/
CREATE OR REPLACE PACKAGE BODY BARS.RB IS
-----------------------------------

-- тело процедуры расчета резервного фонда
PROCEDURE REZ (  FDAT_  date ) IS
 ern  CONSTANT POSITIVE := 021; erm  VARCHAR2(80); err  EXCEPTION;
BEGIN
 return;
end REZ ;
--------------------------------------
END RB;
/
 show err;
 
PROMPT *** Create  grants  RB ***
grant EXECUTE                                                                on RB              to ABS_ADMIN;
grant EXECUTE                                                                on RB              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RB              to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/rb.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 