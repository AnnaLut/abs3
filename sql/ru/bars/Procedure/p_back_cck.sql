

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BACK_CCK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BACK_CCK ***

  CREATE OR REPLACE PROCEDURE BARS.P_BACK_CCK ( ref_ INT, lev_ SMALLINT) IS
/*

 Используется в p_back_dok как подпрограмма по #ifdef CCK
 для дополнительной бизнес-логики в частикредитного модуля при штатном выполнении БЭК операций

21.04.2016 Сухова. COBUSUPABS-4381 При сторнуванні операції з видачі (КЛ)  у графіку траншів CC_TRANS відповідний запис не видаляється.
20.05.2009 Сухова. Отключение контроля на OSTX по счету 8999*LIM во время выполнения БЭК-операций по погашению кредита.

*/

BEGIN

   delete from CC_TRANS  where ref = REF_;

   FOR k IN (SELECT a.accc  FROM opldok o, accounts a
             WHERE o.dk = 1  AND o.REF = ref_  AND o.acc = a.acc
               AND a.accc IS NOT NULL  AND EXISTS ( SELECT 1  FROM accounts   WHERE acc = a.accc AND tip = 'LIM'))
   LOOP UPDATE accounts  SET pap = 3 WHERE acc = k.accc;
        gl.bck (ref_, lev_);
        UPDATE accounts  SET pap = 1 WHERE acc = k.accc;
        RETURN;
   END LOOP;

END p_back_cck;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BACK_CCK.sql =========*** End **
PROMPT ===================================================================================== 
