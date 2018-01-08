

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ERROR_351.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ERROR_351 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ERROR_351 (
          P_dat01       date,
          p_nd          integer,
          p_id          integer,
          p_tip         NUMBER,
          p_acc         integer,
          p_custtype    VARCHAR2,
          p_kv          VARCHAR2,
          p_branch      VARCHAR2,
          p_error_txt   VARCHAR2,
          p_rnk         integer,
          p_nls         VARCHAR2) is
  PRAGMA AUTONOMOUS_TRANSACTION;

/* Версия 1.1  18-09-2017  18-01-2017
   Формирование файла ошибок
   1) 18-09-2017 - Добавлено условие в update  and TIP = p_tip;
*/

l_txt varchar2(1000);

begin

   begin
      select error_txt into l_txt from SREZERV_ERROR_TYPES where error_type = p_tip;
   EXCEPTION  WHEN NO_DATA_FOUND  THEN l_txt := null;
   end;

   update errors_351 set id = p_id, custtype =p_custtype, branch = p_branch, nls = p_nls, kv = p_kv, TIP = p_tip,
          ERROR_TXT = substr( p_error_txt || ' ' || l_txt , 1, 999)
   where  fdat = p_dat01 and nd = p_nd and rnk = p_rnk and TIP = p_tip;
   IF SQL%ROWCOUNT=0 then
      insert into errors_351 (fdat   , nd  , id  , custtype  , branch  , acc  , rnk  , nls  , kv  , TIP  , ERROR_TXT)
                      values (p_dat01, p_nd, p_id, p_custtype, p_branch, p_acc, p_rnk, p_nls, p_kv, p_TIP, substr( p_error_txt || ' ' || l_txt , 1, 999));
   END IF;
   COMMIT;
end;
/
show err;

PROMPT *** Create  grants  P_ERROR_351 ***
grant EXECUTE                                                                on P_ERROR_351     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ERROR_351     to RCC_DEAL;
grant EXECUTE                                                                on P_ERROR_351     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ERROR_351.sql =========*** End *
PROMPT ===================================================================================== 
