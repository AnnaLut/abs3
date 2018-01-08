

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL_UPD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ELT_DEAL_UPD ***

  CREATE OR REPLACE PROCEDURE BARS.P_ELT_DEAL_UPD (
p_nd       e_deal$base.nd%type,      -- Реф. угоди
p_user_id  e_deal$base.user_id%type, -- Вик.
p_cc_id    e_deal$base.cc_id%type,   -- Ідент. угоди
p_dat1     e_deal$base.sdate%type,   -- Дата угоди
p_dat4     e_deal$base.wdate%type,   -- Дата поререднього розрахунку
p_nls36    accounts.nls%type,        -- Рах. для сплати абонплати
p_avans    e_deal$base.sa%type,      -- Розр-ва абонплатю
p_nls_d    accounts.nls%type,        -- Р-к боргу абонплати 3578/3579
p_nls_p    accounts.nls%type,        -- Рахунок-платник (NLS_P)
p_avto     int                       -- Авт
)
is
l_rnk      customer.rnk%type;
l_acc_36   accounts.acc%type;
l_nbs_36   accounts.nbs%type;
l_ob22_36  accounts.ob22%type;
l_acc_d    accounts.acc%type;
l_nbs_d    accounts.nbs%type;
l_ob22_d   accounts.ob22%type;
l_acc_p    accounts.acc%type;
begin

  -- 3570 02 - нараховані доходи за обсл. Суб.Госп. через системи дистанцўйного обслуговування
  begin
    select acc,      nbs,      nvl(ob22,'XX')
      into l_acc_36, l_nbs_36, l_ob22_36
      from accounts
     where nls = p_nls36 and kv = 980;
    case
      when (l_nbs_36 <> '3570') then raise_application_error( -20444, 'Недопустиме значення балансового рахунка!', true );
      when (l_ob22_36 not in ('02','33','35')) then raise_application_error( -20444, 'Недопустиме значення параметра ОБ22!', true );
      else null;
    end case;
  exception when no_data_found then l_acc_36 := null;
  end;

  -- 3579 24 - прострочені нараховані доходи за обсл. Суб.Госп. через системи дистанційного обслуговування
if newnbs.g_state= 1 then  --переход на новый план счетов
   begin
    select acc,     nbs,     nvl(ob22,'XX')
      into l_acc_d, l_nbs_d, l_ob22_d
      from accounts
     where nls = p_nls_d and kv = 980;
    case
      when (l_nbs_d <> '3570') then raise_application_error( -20444, 'Недопустиме значення балансового рахунка!', true );
      when (l_ob22_d not in ('38','47','49')) then raise_application_error( -20444, 'Недопустиме значення параметра ОБ22!', true );
      else null;
    end case;
  exception when no_data_found then null;
  end;
else
  begin
    select acc,     nbs,     nvl(ob22,'XX')
      into l_acc_d, l_nbs_d, l_ob22_d
      from accounts
     where nls = p_nls_d and kv = 980;
    case
      when (l_nbs_d <> '3579') then raise_application_error( -20444, 'Недопустиме значення балансового рахунка!', true );
      when (l_ob22_d not in ('24','88','92')) then raise_application_error( -20444, 'Недопустиме значення параметра ОБ22!', true );
      else null;
    end case;
  exception when no_data_found then null;
  end;
end if;

  -- nls_p
  begin
    select acc
      into l_acc_p
      from accounts
     where nls = p_nls_p and kv = gl.baseval;
    logger.info('E_DEAL зміна рахунку, що платить для ND='||p_nd||', nlsp='||p_nls_p);
  exception
    when no_data_found then null;
    logger.info('E_DEAL вказаний рах-к Не знайдено для ND '||p_nd||', nlsp='||p_nls_p);
  end;

 update e_deal$base
    set cc_id   = p_cc_id,
        sdate   = p_dat1,
        wdate   = p_dat4,
        user_id = p_user_id,
        sa      = p_avans * 100,
        acc36   = l_acc_36,
        accd    = l_acc_d,
        accp    = l_acc_p
  where nd      = p_nd;

  select rnk into l_rnk from e_deal$base where nd = p_nd;

  begin
    insert into customerw (rnk, tag, value, isp) values (l_rnk, 'Y_ELT', case p_avto when 1 then 'Y' else 'N' end, 0);
  exception when dup_val_on_index then
    update customerw set value = case p_avto when 1 then 'Y' else 'N' end where tag = 'Y_ELT' and rnk = l_rnk;
  end;

end;
/
show err;

PROMPT *** Create  grants  P_ELT_DEAL_UPD ***
grant EXECUTE                                                                on P_ELT_DEAL_UPD  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ELT_DEAL_UPD.sql =========*** En
PROMPT ===================================================================================== 
