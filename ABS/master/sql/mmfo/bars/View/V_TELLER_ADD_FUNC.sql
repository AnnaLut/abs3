 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_add_func.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_ADD_FUNC ("OP_NAME", "FUNC_NAME") AS 
  select '5.Скидання АТМ (просте)' as op_name, 'teller_soap_api.ResetOperationNormal' as func_name
  from dual
union
select '6.Скидання АТМ (повне)', 'teller_soap_api.ResetOperationAdmin'
  from dual
union
select '3.Порахувати купюри', 'teller_soap_api.CountOperation'
from dual
union
select '4.Результат підрахунку', 'teller_soap_api.EndCountOperation'
from dual
union
select '7.Перезавантаження АТМ', 'teller_soap_api.RebootATm'
from dual
union
select '8.Вимкнення АТМ', 'teller_soap_api.PowerOFFATM'
from dual
union
select '1.Нове підключення до АТМ', 'teller_soap_api.user_reconnect'
from dual
union
select '2.Звільнити АТМ', 'teller_soap_api.ReleaseATM'
from dual
union
select '9.Оновити дані лічильників АТМ','teller_soap_api.InventoryCount'
from dual
order by 1
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_add_func.sql =========*** End 
 PROMPT ===================================================================================== 
 