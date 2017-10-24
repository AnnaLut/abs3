

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FM_SET_RIZIK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FM_SET_RIZIK ***

  CREATE OR REPLACE PROCEDURE BARS.FM_SET_RIZIK (p_rnk number)
is
  l_old_value varchar2(20);
  l_value    varchar2(20);
  l_iddpr    varchar2(10);
  l_iddpl    date;
  /*v.1.1 06.04.2017 lypskykh*/
begin

-------------- Установка значения доп.реквизита "Рівень ризику" по установленным критериям

      select nvl(substr(f_get_cust_hlist(p_rnk,23,f_get_cust_fmdat(to_number(to_char(sysdate,'DDMMYYYY')))),1,20), 'Низький') into l_value from dual;
      begin
        select trim(value) into l_old_value from customerw where rnk = p_rnk and tag = 'RIZIK';
      exception
        when no_data_found then null;
      end;

      if l_old_value = l_value then
          p_set_rizik(p_rnk, l_value); --если результирующий риск тот же - подтверждаем, чтобы получить изменение в истории
      else
          begin
             update customerw
                set value = l_value
              where rnk = p_rnk and tag = 'RIZIK';
             if sql%rowcount = 0 then
                insert into customerw (rnk, tag, value, isp)
                values (p_rnk, 'RIZIK', l_value, 0);
             end if;
          end;
      end if;

-------------- Установка значения доп.реквизита "Дата планової ідентифікації" (меняется после изменения уровня риска(тут) или даті проведен.идент-ции (p_after_edit_client))
-------------- [Дата планової ідентифікації] = [Дата проведеної ідентифікації/уточнення інформації] + 1, 2 або 3 роки (відповідно для високого, середнього або низького рівня ризику), але не менше ніж поточна дата + 1 місяць;
      begin
        select nvl(c.value, to_char(trunc(bankdate), 'dd/mm/yyyy'))
        into l_iddpr
        from customerw c
        where rnk = p_rnk
        and tag = 'IDDPR';
      exception
        when no_data_found then l_iddpr := to_char(trunc(bankdate), 'dd/mm/yyyy');
      end;

       select add_months(to_date(l_iddpr,'dd/mm/yyyy'),
                        case when l_value in ('Неприйнятно високий', 'Високий') then 12
                             when l_value = 'Середній' then 24
                             else 36 end
                         ) into l_iddpl from dual;

       if l_iddpl < add_months(bankdate, 1) then
           l_iddpl := add_months(bankdate, 1);
       end if;

       update customerw c
       set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
       where c.tag = 'IDDPL'
       and c.rnk = p_rnk;

       if sql%rowcount = 0 then
         insert into customerw (  rnk,     tag,   value, isp)
                        values (p_rnk, 'IDDPL', to_char(l_iddpl,'dd/mm/yyyy'),   0);
       end if;

--------------

end fm_set_rizik;
/
show err;

PROMPT *** Create  grants  FM_SET_RIZIK ***
grant EXECUTE                                                                on FM_SET_RIZIK    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FM_SET_RIZIK    to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FM_SET_RIZIK.sql =========*** End 
PROMPT ===================================================================================== 
