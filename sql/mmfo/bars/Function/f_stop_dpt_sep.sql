 
PROMPT ============================================================================================= 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_stop_dpt_sep.sql =========*** Run *** ===
PROMPT ============================================================================================= 

create or replace function f_stop_dpt_sep(p_nlsb in varchar2,
                                          p_kv   in integer,
                                          p_s    in number,
                                          p_date in date) return integer is
  l_flag      integer := 0;
  title       varchar2(50) := 'f_stop_dpt_sep: ';
  l_deposit   dpt_deposit.deposit_id%type;
  l_term_add  dpt_vidd.term_add%type;
  l_term_add1 number(5);
  l_acc       accounts.acc%type;
  l_dat_begin dpt_deposit.dat_begin%type;
  l_limit     dpt_deposit.limit%type;
  l_res       number(10);
  l_count_mm  number(5);
  l_dat_start date;
  l_dat_end   date;
  l_dat_s     date;
  l_dat_po    date;
  l_sum_month oper.s%type;
  l_sum       dpt_deposit.limit%type;
  l_comproc   dpt_vidd.comproc%type;
  l_is_bnal   dpt_depositw.value%type;
begin

  begin
    -- 1.вычисляем возможный срок пополения, если без срока = выходим
    select dd.deposit_id, dd.acc, v.term_add, dd.dat_begin, dd.limit, v.comproc
      into l_deposit, l_acc, l_term_add, l_dat_begin, l_limit, l_comproc
      from dpt_deposit dd, accounts a, dpt_vidd v
     where dd.acc = a.acc
       and a.nls = p_nlsb
       and a.kv = p_kv
       and dd.vidd = v.vidd;

    l_term_add1 := to_number(floor(l_term_add));

     bars_audit.info(title || ' Депозит №' || l_deposit ||
                         ' Термін поповнення: ' || l_term_add1 ||
                         ' місяців Дата С: ' || l_dat_begin || ' Сумма: ' ||
                         l_limit);

    if nvl(l_term_add1, 0) = 0 then
      bars_audit.info('безсрочній вид вклада');
      return 0;
    end if;

    -- 2.вычислить вид вклада, является он пополняемым
    l_res := dpt_web.forbidden_amount(l_acc, p_s);
    bars_audit.info(title || 'Результат можливості поповнення: ' ||
                         l_res);
    if (l_res = 0) then
      bars_audit.info(title || 'Можливо поповнити: ' || l_res);
      null;
    elsif (l_res = 1) then
      bars_audit.info(title || 'Вклад не передбачає поповнення: ' ||
                           l_res);
      return 1;
    else
      bars_audit.info(title ||
                           'Cума зарахування на депозитний рахунок #' ||
                           to_char(l_acc) ||
                           ' менша за мінімальну суму поповнення вкладу (' ||
                           to_char(l_res / 100) || ' / ' || p_kv || ')');
      return 1;
    end if;

    -- 3.проверить можно ли его пополнить в указанных сроках на виде вклада
    l_dat_start := l_dat_begin;
    l_dat_end   := add_months(l_dat_begin, l_term_add1) - 1;

    bars_audit.info(title || 'Період можливого поповнення Депозиту №' ||
                         l_deposit || ' ' || l_dat_start || ' - ' ||
                         l_dat_end);

    if --Все ОК, пополнять можно
     p_date between l_dat_start and l_dat_end then
      bars_audit.info(title || 'Депозит №' || l_deposit ||
                           ' пополнять можно ');
      null;
    else
      bars_audit.info(title || 'По Депозиту №' || l_deposit ||
                           ' закічився термін поповнення! Вклад можливо було поповнювати протягом ' ||
                           to_char(l_term_add1) || ' міcяців.');
      -- Закончился срок пополнения
      return 1;
    end if;

    -- 4.вычислить граничные даты  месяца
    select floor(months_between(p_date, (l_dat_begin)))
      into l_count_mm
      from dual;

    bars_audit.info(title ||
                         ' Кількість повних місяців по Депозиту №' ||
                         l_deposit || ' ' || l_count_mm);

    l_dat_s  := add_months(l_dat_begin, l_count_mm);
    l_dat_po := add_months(l_dat_s, 1) - 1;

    bars_audit.info(title || ' Граничні дати поточного місяця ' ||
                         l_dat_s || ' - ' || l_dat_po);

    --5.вычислить за этот период сумму пополнений по вкладу
    if nvl(l_comproc, 0) = 0 then 
     --нет капитализации-то учитываем сумму пополнения операций 'DP5' и 'DPL 
    select nvl(sum(o.s), 0)
      into l_sum_month
      from dpt_payments p, oper o
     where p.ref = o.ref
       and p.dpt_id = l_deposit
       and o.sos >= 0
       and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DP5', 'DPD', 'DPI', 'DPL', 'W2D', 'DBF', 'ALT',
		    '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO') 
       and o.pdat between l_dat_s and l_dat_po;
       
     else 
       --есть капитализация-то не учитываем в сумму пополнения операций 'DP5' и 'DPL'
         select nvl(sum(o.s), 0)
      into l_sum_month
      from dpt_payments p, oper o
     where p.ref = o.ref
       and p.dpt_id = l_deposit
       and o.sos >= 0
       and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DPD', 'DPI', 'W2D', 'DBF', 'ALT',
	            '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO') 
       and o.pdat between l_dat_s and l_dat_po;
       
    end if;

    bars_audit.info(title || ' Сума поповнення ' || l_sum_month ||
                         ' за поточний місяць ' || l_dat_s || ' - ' ||
                         l_dat_po);
     bars_audit.info(title || ' Сума поповнення ' || p_s);
    -- прибавить общую сумму к сумме документу
    l_sum := l_sum_month + p_s;
     bars_audit.info(title || ' Загальна сума: ' || l_sum);

    --6.сравнить лимит депозита с полученной суммой
    -- если общая сумма не превышает лимит = позволяем вставить документ, если нет = выдаем сообщение при вставке документа
     bars_audit.info(title || ' Загальна сума: ' || l_sum ||
                         ' Сумма депозиту: ' || l_limit);
     
     l_is_bnal := bars.dpt.f_dptw(l_deposit, 'NCASH');
     
     bars_audit.trace('1478 безнал: ' || l_is_bnal);

      if (l_count_mm = 0) and (l_is_bnal = '1') then -- первый месяц и безнал
       if kost(l_acc,trunc(sysdate - 1)) = 0 then -- первичный взнос
        return 0;
       else 
        if l_sum > l_limit * 2 then
           bars_audit.info(title || ' Перевищено суму ліміту ' ||
                           to_char(l_limit) || ' за місць з ' ||
                           to_char(l_dat_s) || ' по ' || to_char(l_dat_po));
           return 1;
        else
           return 0;
        end if;
       end if; 
      elsif l_sum > l_limit then
         bars_audit.info(title || ' Перевищено суму ліміту ' ||
                           to_char(l_limit) || ' за місць з ' ||
                           to_char(l_dat_s) || ' по ' || to_char(l_dat_po));
         return 1;
      else
         return 0;
      end if;
      
  exception
    when others then
       bars_audit.info(title || ' error: ' || sqlerrm);
      return 0;
  end;

  return l_flag;
end f_stop_dpt_sep;
/
show err;
 
PROMPT *** Create  grants  f_stop_dpt_sep ***
grant EXECUTE                                                                on f_stop_dpt_sep to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on f_stop_dpt_sep to OPERKKK;
grant EXECUTE                                                                on f_stop_dpt_sep to PYOD001;
grant EXECUTE                                                                on f_stop_dpt_sep to WR_ALL_RIGHTS;
grant EXECUTE                                                                on f_stop_dpt_sep to WR_DOC_INPUT;

 
 
PROMPT ============================================================================================= 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_stop_dpt_sep.sql =========*** End *** ===
PROMPT ============================================================================================= 
 

