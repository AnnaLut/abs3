
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bankdate_vc.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BANKDATE_VC return varchar2 IS
 curdate_L varchar2(10);
-- текущая банковская дата в символьном формате
-- для динамического формирования назначения платежа
-- QWA  верс.1.0 20-10-2004
BEGIN
 BEGIN
   SELECT to_char(bankdate,'dd-mm-yyyy') into curdate_L from dual;
 EXCEPTION WHEN NO_DATA_FOUND THEN curdate_L := '';
 END;
 RETURN curdate_L;
END bankdate_vc;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bankdate_vc.sql =========*** End **
 PROMPT ===================================================================================== 
 