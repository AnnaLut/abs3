

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_AFTER_EDIT_CLIENT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_AFTER_EDIT_CLIENT ***

  CREATE OR REPLACE PROCEDURE BARS.P_AFTER_EDIT_CLIENT (p_rnk number)
is
  l_iddpr    varchar2(10);
  l_iddpl    date;
  l_rizik    number;
  l_id_yn    number(1);
  l_publ     varchar2(3);
  l_pep      varchar2(15);
  l_pep_valid  number(1);
--------
-- ver. 27/11/2015
--------
  ver_awk   constant varchar2(512)  := ''
    ||'КОММ.БАНК (ФМ)'||chr(10)
;

begin

-------------- Установка значения доп.реквизита
-------------- [Дата планової ідентифікації] = [Дата проведеної ідентифікації/уточнення інформації] + 1, 2 або 3 роки (відповідно для високого, середнього або низького рівня ризику), але не менше ніж поточна дата + 1 місяць;
      begin
        select c.value into l_iddpr from customerw c where rnk = p_rnk and tag = 'IDDPR';
      exception when no_data_found then null;
      end;
      if l_iddpr is not null then
    -- brsmain-2230
        begin
          select  decode(value,'Ні',0,1) into l_id_yn from customerw where rnk = p_rnk and tag = 'ID_YN';
        exception when no_data_found then l_id_yn := 1;
        end;
        if l_id_yn = 0 and to_date(l_iddpr,'dd/mm/yyyy') < to_date('01/01/2011','dd/mm/yyyy') then
                l_iddpl:= to_date('22/10/2011','dd/mm/yyyy');
        --
        else
          begin
            select decode(value,'Неприйнятно високий',1,'Високий',1,'Середній',2,3)  into l_rizik from customerw where rnk = p_rnk and tag = 'RIZIK';
          exception when no_data_found then l_rizik := 3;
          end;
          select add_months(to_date(l_iddpr,'dd/mm/yyyy'),decode(l_rizik,1,12,2,24,36)) into l_iddpl from dual;
          if l_iddpl < add_months(bankdate,1) then l_iddpl := add_months(bankdate,1); end if;
        end if;

        update customerw c set c.value = to_char(l_iddpl,'dd/mm/yyyy') where c.tag = 'IDDPL' and c.rnk = p_rnk;
        if sql%rowcount = 0 then
          insert into customerw (  rnk,     tag,   value, isp)
                         values (p_rnk, 'IDDPL', to_char(l_iddpl,'dd/mm/yyyy'),   0);
        end if;

      end if;
--------------

end;
/
show err;

PROMPT *** Create  grants  P_AFTER_EDIT_CLIENT ***
grant EXECUTE                                                                on P_AFTER_EDIT_CLIENT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_AFTER_EDIT_CLIENT to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_AFTER_EDIT_CLIENT.sql =========*
PROMPT ===================================================================================== 
