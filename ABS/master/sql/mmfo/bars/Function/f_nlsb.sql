
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nlsb.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NLSB (KV_ NUMBER, NLSB_ VARCHAR2) RETURN VARCHAR2 IS
NLS_  VARCHAR2(20) ;
-- функция возвращает номер техничего счета ПЦ для доп.реквизита CDAC
-- в операции PKK, PKR
--
-- Макаренко И.В. 06/2009 --
BEGIN

   BEGIN
      SELECT NVL(o.card_acct,'-')
        INTO NLS_
        FROM OBPC_ACCT o, tabval t
       WHERE t.KV= KV_
         AND o.currency =t.LCV
         AND o.lacct = NLSB_ ;
     EXCEPTION WHEN NO_DATA_FOUND THEN NLS_ := ' - ' ;
   END ;

   RETURN NLS_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nlsb.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 