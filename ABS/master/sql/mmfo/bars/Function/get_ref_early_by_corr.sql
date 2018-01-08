
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_ref_early_by_corr.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_REF_EARLY_BY_CORR (p_ref oper.ref%type) return number
is
/*
COBUSUPMMFO-239
при занесении изменений в доп.реквизитах KOD_N (Код ПРИЗНАЧЕННЯ пл.(1-ПБ)) и N (Код призначення платежу (1-ПБ)) на операциях типа Дт 3739 Кт 2603,2600,2602,2650,25*,2620,2625 (изменения заносятся в "Редагування дод.реквизитов" в АРМ Валютный контроль) автоматически обновлять эти доп.реквизиты по операциям сделанным ранее Дт1500 Кт3739.
Поиск предыдущей операции Дт1500 Кт3739 – по сумме, валюте,одинаковый аналит. счет 3739*, за период 3 дней.
*/
  l_oper_row oper%rowtype;
  l_ref      oper.ref%type;
  l_offset   pls_integer := 3;
begin
  select * into l_oper_row from oper where ref = p_ref;
  if l_oper_row.nlsa like '3739%' and (l_oper_row.nlsb like '2603%' or l_oper_row.nlsb like '2600%' or l_oper_row.nlsb like '2602%' or l_oper_row.nlsb like '2650%' or l_oper_row.nlsb like '25%' or l_oper_row.nlsb like '2620%' or l_oper_row.nlsb like '2625%') then
    begin
      select o.ref
      into l_ref
      from oper o where o.vdat >= gl.bd - l_offset and o.nlsa like '1500%' and o.nlsb = l_oper_row.nlsa and o.s = l_oper_row.s and o.kv = l_oper_row.kv and o.kf = l_oper_row.kf
                    and o.sos > 0;
      exception
        when no_data_found then
          return null;
        when too_many_rows then --for debug
          for   cur in (      select o.ref
                              from oper o
                              where o.vdat >= gl.bd - l_offset and o.nlsa like '1500%' and o.nlsb = l_oper_row.nlsa and o.s = l_oper_row.s and o.kv = l_oper_row.kv and o.kf = l_oper_row.kf)
          loop
            dbms_output.put_line('TOO_MANY_ROWS. REF='||cur.ref);
          end loop;
          raise;
    end;
    else
      return null;
  end if;
  return l_ref;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_ref_early_by_corr.sql =========
 PROMPT ===================================================================================== 
 