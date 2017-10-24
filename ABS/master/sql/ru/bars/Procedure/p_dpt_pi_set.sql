

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DPT_PI_SET.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DPT_PI_SET ***

  CREATE OR REPLACE PROCEDURE BARS.P_DPT_PI_SET (p_old_dep_id in dpt_deposit.deposit_id%type, -- № достроково розірваного депозиту
                                         p_new_dep_id in dpt_deposit.deposit_id%type -- № нового депозиту
                                         ) is
  -- Процедура установки связи между досрочно расторгнутым допозитом и новым. Заявка на модифікацію №14/2-01/-ID-1241 від 26.02.2014р.
  l_dpt_cl_dat_begin  dpt_deposit_clos.dat_begin%type;
  l_dpt_row     dpt_deposit%rowtype;
  l_penalty_sum number;
begin
  -- Параметры переданых депозитов
  select max(dc.DAT_BEGIN)
    into l_dpt_cl_dat_begin
    from dpt_deposit_clos dc
   where dc.deposit_id = p_old_dep_id
     and dc.action_id in (0,3);
  select d.*
    into l_dpt_row
    from dpt_deposit d
   where d.deposit_id = p_new_dep_id;

  -- Проверка старого депозита
  declare
    l_dat_end          dpt_deposit.dat_end%type;
    l_termination_date date;
    l_kv               dpt_deposit.kv%type;
    l_balance          number;
    l_fio              customer.nmk%type;
    l_birth_date       person.bday%type;
    l_inn              customer.okpo%type;
    l_doc              varchar2(300);
    l_result_code      number;
    l_result_text      varchar2(500);
  begin
    p_dpt_pi_find_terminated(p_old_dep_id,
                             l_dpt_cl_dat_begin,
                             l_dat_end,
                             l_termination_date,
                             l_kv,
                             l_balance,
                             l_penalty_sum,
                             l_fio,
                             l_birth_date,
                             l_inn,
                             l_doc,
                             l_result_code,
                             l_result_text);

    if (l_result_code > 0) then
      raise_application_error(-20001,
                              'Помилка при перевірці старого депозиту: ' ||
                              l_result_text);
    end if;
  end;

  -- Проверка нового депозита
  declare
    l_dat_end     dpt_deposit.dat_end%type;
    l_kv          dpt_deposit.kv%type;
    l_sum         dpt_deposit.limit%type;
    l_fio         customer.nmk%type;
    l_birth_date  person.bday%type;
    l_inn         customer.okpo%type;
    l_doc         varchar2(300);
    l_result_code number;
    l_result_text varchar2(500);
  begin
    p_dpt_pi_find_new(p_old_dep_id,
                      p_new_dep_id,
                      l_dpt_row.dat_begin,
                      l_dat_end,
                      l_kv,
                      l_sum,
                      l_fio,
                      l_birth_date,
                      l_inn,
                      l_doc,
                      l_result_code,
                      l_result_text);

    if (l_result_code > 0) then
      raise_application_error(-20001,
                              'Помилка при перевірці нового депозиту: ' ||
                              l_result_text);
    end if;
  end;

  -- Сохраняем связь
  begin
    insert into dpt_political_instability
      (old_dpt_id,
       new_dpt_id,
       penalty_sum,
       crt_date,
       crt_staff_id,
       crt_branch)
    values
      (p_old_dep_id,
       p_new_dep_id,
       l_penalty_sum,
       sysdate,
       user_id,
       sys_context('bars_context', 'user_branch'));

       DPT_Ret_early(1, p_new_dep_id);
  exception
    when dup_val_on_index then
      -- !!! такого быть недолжно, но так и быть отловим
      null;
  end;

end p_dpt_pi_set;
/
show err;

PROMPT *** Create  grants  P_DPT_PI_SET ***
grant EXECUTE                                                                on P_DPT_PI_SET    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DPT_PI_SET.sql =========*** End 
PROMPT ===================================================================================== 
