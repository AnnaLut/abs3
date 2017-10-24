

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DPT_PI_FIND_TERMINATED.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DPT_PI_FIND_TERMINATED ***

  CREATE OR REPLACE PROCEDURE BARS.P_DPT_PI_FIND_TERMINATED (p_deposit_id       in dpt_deposit.deposit_id%type, -- №
                                                     p_dat_begin        in dpt_deposit.dat_begin%type, -- Дата початку
                                                     p_dat_end          out dpt_deposit.dat_end%type, -- Дата закінчення
                                                     p_termination_date out date, -- Дата розірвання
                                                     p_kv               out dpt_deposit.kv%type, -- Валюта
                                                     p_balance          out number, -- Залишок на момент розірвання
                                                     p_penalty_sum      out number, -- Сума штрафу
                                                     p_fio              out customer.nmk%type, -- ПІБ клієнта
                                                     p_birth_date       out person.bday%type, -- Дата народження клієнта
                                                     p_inn              out customer.okpo%type, -- ІПН клієнта
                                                     p_doc              out varchar2, -- Документ клієнта
                                                     p_result_code      out number,
                                                     p_result_text      out varchar2) is
  -- Процедура поиска досрочно расторгнутого депозита в период политической нестабильности. Заявка на модифікацію №14/2-01/-ID-1241 від 26.02.2014р.
begin
  -- Инициализируем состоянием "Успешно"
  p_result_code := 0;
  p_result_text := null;

  -- Поиск депозита
  begin
    select max(dc.dat_end), dc.kv
      into p_dat_end, p_kv
      from dpt_deposit_clos dc
     where dc.deposit_id = p_deposit_id
       and dc.dat_begin = p_dat_begin
       and dc.action_id in (0,3)
       group by  dc.kv;
  exception
    when no_data_found then
      p_result_code := 1;
      p_result_text := 'Депозит №' || p_deposit_id || ' від ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' не знайдено.';

      return;
  end;

  -- Проверяем вид вклада
  begin
    select max(dc.dat_end), dc.kv
      into p_dat_end, p_kv
      from dpt_deposit_clos dc
     where dc.deposit_id = p_deposit_id
       and dc.dat_begin = p_dat_begin
       and dc.action_id in (0,3)
       and dc.vidd in (select v.vidd
                         from dpt_vidd v, dpt_types t
                        where v.type_id = t.type_id
                          and t.type_id in (1, -- Авансовий
                                            2, -- Депозитний Ощадного банку
                                            4, -- Накопичувальний
                                            5, -- Дитячий
                                            9, -- Новий відсоток
                                            10 -- Строковий пенсійний
                                            -- ??? Майбутнє дітям
                                            ))
    group by  dc.kv;
  exception
    when no_data_found then
      p_result_code := 2;
      p_result_text := 'Вид депозиту №' || p_deposit_id || ' від ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' не відповідає умовам ("Авансовий", "Депозитний Ощадного банку", "Накопичувальний", "Дитячий", "Новий відсоток", "Строковий пенсійний", "Майбутнє дітям").';

      return;
  end;

  -- Был ли депозит досрочно закрыт
  begin
    select trunc(dc.when),
           fost(dc.acc, trunc(dc.when) - 1) / 100,
           nvl(BARS.get_deal_penalty(dc.deposit_id),0)
       into p_termination_date, p_balance, p_penalty_sum
      from dpt_deposit_clos dc ,  int_accn i
     where i.acc = dc.acc and i.id = 1
       and dc.deposit_id = p_deposit_id
       and dc.dat_begin = p_dat_begin
       and dc.action_id = 5
       and exists (select 1
              from dpt_deposit_clos dc1
             where dc1.deposit_id = dc.deposit_id
               and dc1.action_id = 2)
       group by dc.when, dc.acc, dc.deposit_id;
  exception
    when no_data_found then
      p_result_code := 3;
      p_result_text := 'Депозит №' || p_deposit_id || ' від ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' не був розірваний достроково або по ньому не стягувався штраф.';

      return;
  end;

  -- Проверяем остатки на счетах вклада
  begin
    select max(dc.dat_end), dc.kv
      into p_dat_end, p_kv
      from dpt_deposit_clos dc
     where dc.deposit_id = p_deposit_id
       and dc.dat_begin = p_dat_begin
       and dc.action_id in (0,3)
       and fost(dc.acc, sysdate) / 100 = 0
       and (select fost(ia.acra, sysdate) / 100 as int_bal
              from int_accn ia
             where ia.acc = dc.acc
               and ia.id = 1) = 0
    group by dc.kv;
  exception
    when no_data_found then
      p_result_code := 4;
      p_result_text := 'Вклад №' || p_deposit_id || ' від ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' не був вилучений повністю, так як має залишки на рахунках.';

      return;
  end;

  -- Проверяем дату досрочного расторжения
  declare
    l_pi_begin date := to_date(GetGlobalOption('PI_START'), 'dd.mm.yyyy');
    l_pi_end   date := to_date(GetGlobalOption('PI_END'), 'dd.mm.yyyy');
  begin
    select dc.dat_end, dc.kv
      into p_dat_end, p_kv
      from dpt_deposit_clos dc
     where dc.deposit_id = p_deposit_id
       and dc.dat_begin = p_dat_begin
       and dc.action_id = 2
       and dc.when between l_pi_begin and l_pi_end;
  exception
    when no_data_found then
      p_result_code := 5;
      p_result_text := 'Вклад №' || p_deposit_id || ' від ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' був вилучений НЕ у період політичної нестабільності (з ' ||
                       to_char(l_pi_begin, 'dd.mm.yyyy') || ' по ' ||
                       to_char(l_pi_end, 'dd.mm.yyyy') || ').';

      return;
  end;

  -- Проверяем отделение депозита
  begin
    select dc.dat_end, dc.kv
      into p_dat_end, p_kv
      from dpt_deposit_clos dc
     where dc.deposit_id = p_deposit_id
       and dc.dat_begin = p_dat_begin
       and dc.branch like sys_context('bars_context', 'user_branch_mask')
       and rownum = 1;
  exception
    when no_data_found then
      p_result_code := 6;
      p_result_text := 'Вклад №' || p_deposit_id || ' від ' ||
                       to_char(p_dat_begin, 'dd.mm.yyyy') ||
                       ' був відкритий не у поточному відділенні.';

      return;
  end;

  -- Получаем параметры клиента
  select c.nmk, p.bday, c.okpo, p.ser || p.numdoc
    into p_fio, p_birth_date, p_inn, p_doc
    from customer c, person p, dpt_deposit_clos dc
   where dc.deposit_id = p_deposit_id
     and dc.dat_begin = p_dat_begin
     and dc.action_id in (0,3)
     and dc.rnk = c.rnk
     and c.rnk = p.rnk;

end p_dpt_pi_find_terminated;
/
show err;

PROMPT *** Create  grants  P_DPT_PI_FIND_TERMINATED ***
grant EXECUTE                                                                on P_DPT_PI_FIND_TERMINATED to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DPT_PI_FIND_TERMINATED.sql =====
PROMPT ===================================================================================== 
