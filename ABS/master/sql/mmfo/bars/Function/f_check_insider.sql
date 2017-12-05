
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_insider.sql =========*** Ru
 PROMPT ===================================================================================== 
 
create or replace function f_check_insider(p_nlsa accounts.nls%type, p_kva accounts.kv%type, p_nlsb accounts.nls%type, p_kvb accounts.kv%type, p_dk number) return varchar2
is
l_customer customer%rowtype;
l_ob22 accounts.ob22%type;
begin
  begin
      select c.* into l_customer from customer c, accounts a
      where c.rnk=a.rnk
      and a.nls= case when p_dk=1 then p_nlsa else p_nlsb end
      and a.kv= case when p_dk=1 then p_kva else p_kvb end;

      select a.ob22 into l_ob22 from accounts a
      where a.nls= case when p_dk=1 then p_nlsa else p_nlsb end
      and a.kv= case when p_dk=1 then p_kva else p_kvb end;
    exception when no_data_found then return '';
  end;

  if l_customer.prinsider=99
      then return '';
  else
     if newnbs.g_state= 0 then -- старый план счетов
        if (l_customer.custtype=2 and substr(case when p_dk=1 then p_nlsa else p_nlsb end,1,4) in('2020', '2030', '2062', '2063', '2071',
                                    '2082', '2083', '2102', '2103', '2112',
                                    '2113', '2122', '2123', '2132', '2133' ) )
                                    or (l_customer.custtype=3 and substr(case when p_dk=1 then p_nlsa else p_nlsb end,1,4) in('2202', '2203', '2207', '2211',
                                    '2232', '2233', '2237'))
            then
                if (l_customer.custtype=3 and substr(case when p_dk=1 then p_nlsa else p_nlsb end,1,4)='2202' and l_ob22 in ('08','09','10','11','12','13','14','15','16','17','18','23','45',
                                                                                                                              '46','47','48','49','50','51','52','53','59','60'  ) )
                  or
                   (l_customer.custtype=3 and substr(case when p_dk=1 then p_nlsa else p_nlsb end,1,4)='2203' and l_ob22 in ('15', '16', '36', '37', '38','39','40','41','42','43','44','49','50') )
                  then return '';
               else
                       return 'Увага операція з інсайдером!!!' ;
               end if; -- Не перевіряти по БПК певні ОБ22
        else
            return '';
        end if; --Перевірка по критеріям рахунків і типу клієнта
     elsif newnbs.g_state = 1 then -- новый план счетов
          if (     l_customer.custtype=2 
               and substr(case when p_dk=1 then p_nlsa else p_nlsb end,1,4) in('2020', '2030', '2063', '2071', 
                                                                               '2083', '2103', '2113', '2123', 
                                                                               '2133'))
            or (    l_customer.custtype=3 
                and substr(case when p_dk=1 then p_nlsa else p_nlsb end,1,4) in('2203', '2211', '2232', '2233'))
          then  
            if  (     l_customer.custtype=3 
                  and substr(case when p_dk=1 then p_nlsa else p_nlsb end,1,4) = '2203' 
                  and l_ob22 in ('15', '16', '36', '37', '38','39','40','41','42','43','44','49','50','59','60','70') ) 
            then return '';
            else
                    return 'Увага операція з інсайдером!!!' ;
            end if; -- Не перевіряти по БПК певні ОБ22
          else
              return '';
          end if; --Перевірка по критеріям рахунків і типу клієнта     
     end if;  
  end if; --Перевірка на належність до інсайдерів

end;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_INSIDER ***
grant EXECUTE                                                                on F_CHECK_INSIDER to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_insider.sql =========*** En
 PROMPT ===================================================================================== 
 