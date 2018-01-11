

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BULK_SET_RIZIK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BULK_SET_RIZIK ***

  CREATE OR REPLACE PROCEDURE BARS.P_BULK_SET_RIZIK (p_filter in varchar2)
  is
/*author: lypskykh
ФМ. массовое подтверждение уровня риска клиентов
v.2.0 12.06.2017 уходим от прямой вставки в update-таблицу*/

l_get_statement varchar2(3500);
val_custw t_dictionary; -- pre-built table(varchar2, varchar2) type
begin
  -- получаем значения для обновления
  l_get_statement := q'[select T_DICTIONARY_ITEM(to_char(rnk), rizik) from V_CUSTOMER_RIZIK where ]' || p_filter;
  execute immediate l_get_statement bulk collect into val_custw;
  -- удаляем существующие по списку - чтобы сработал триггер
  delete from customerw where rnk in (select to_number(key) from table(val_custw)) and tag = 'RIZIK';
  -- вставляем новые данные
  insert into bars.customerw (rnk, tag, value, isp)
  select to_number(w.key), 'RIZIK', w.value, 0 from table(val_custw) w;
end;
/
show err;

PROMPT *** Create  grants  P_BULK_SET_RIZIK ***
grant DEBUG,EXECUTE                                                          on P_BULK_SET_RIZIK to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BULK_SET_RIZIK.sql =========*** 
PROMPT ===================================================================================== 
