

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DEAL_NUM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DEAL_NUM ***

  CREATE OR REPLACE PROCEDURE BARS.DEAL_NUM 
  (p_type        IN     char,
   p_module_code IN     deal_numerator.module_code%type,
   p_deal_num    IN OUT varchar2)
IS
  -- процедура получения / фиксации номера договора
  l_title varchar2(60) := 'deal_num: ';
  l_num   varchar2(50);
BEGIN

  bars_audit.trace('%s тип %s, модуль %s, номер %s',
                   l_title, p_type, p_module_code, p_deal_num);

  IF p_type = 'GET' THEN

     bars_audit.trace('%s получение номера', l_title);

     BEGIN
       -- получить след.свободный номер
       SELECT to_char(last_num + 1)
         INTO l_num
         FROM deal_numerator
        WHERE module_code = p_module_code
          AND branch = sys_context('bars_context','user_branch')
          FOR UPDATE OF last_num;
       bars_audit.trace('%s номер = %s', l_title, l_num);
     EXCEPTION
       WHEN OTHERS THEN
         bars_audit.trace('%s err: %s',l_title, sqlerrm);
   	 raise;
     END;

     p_deal_num := l_num;

  ELSIF p_type = 'FIX' THEN

     bars_audit.trace('%s фиксация номера', l_title);

     BEGIN
       -- зафиксировать использ.номер
       UPDATE deal_numerator
          SET last_num = to_number(p_deal_num)
        WHERE module_code = p_module_code
          AND branch = sys_context('bars_context','user_branch');
       bars_audit.trace('%s номер = %s', l_title, p_deal_num);
     EXCEPTION
       WHEN OTHERS THEN
         bars_audit.trace('%s err: %s',l_title, sqlerrm);
	 raise;
     END;

  ELSE

    RETURN;

  END IF;

END deal_num;
 
/
show err;

PROMPT *** Create  grants  DEAL_NUM ***
grant EXECUTE                                                                on DEAL_NUM        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DEAL_NUM        to DPT;
grant EXECUTE                                                                on DEAL_NUM        to DPT_ROLE;
grant EXECUTE                                                                on DEAL_NUM        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DEAL_NUM.sql =========*** End *** 
PROMPT ===================================================================================== 
