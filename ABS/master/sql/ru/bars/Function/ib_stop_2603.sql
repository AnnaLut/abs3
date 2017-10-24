
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ib_stop_2603.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.IB_STOP_2603 
( P_nbs   accounts.nbs%type,
  P_ob22  accounts.ob22%type,
  P_nlsA  accounts.NLS%type,
  P_nlsB  accounts.NLS%type,
  p_kv    accounts.kv%type,
  p_s     oper.s%type
)
  return accounts.nls%type is

/*
    Подбор счета 2603 клієнта по rnk рахунка
    для валютних рахунків
*/

  l_nls     accounts.NLS%type   := null;
  l_rnk     accounts.rnk%type   := null;
  l_rnk_a   accounts.rnk%type   := null;
  l_okpo_a  customer.okpo%type  := null;
  l_okpo_B  customer.okpo%type  := null;
  l_kodk_a  rnkp_kod.kodk%type  := null;
  l_kodk_b  rnkp_kod.kodk%type  := null;
begin

  case when substr(P_nlsB,1,4) in ('2600', '2650','2530') and p_kv != 980
       then null;
       else return p_s;
  end case;

  begin
    select a.rnk, c.okpo
    into   l_rnk_a, l_okpo_a
    from accounts a, customer c
    where a.dazs is null  and a.nls = p_NLSA  and kv = p_kv and a.rnk = c.rnk;
  EXCEPTION WHEN NO_DATA_FOUND THEN
         raise_application_error( -20203, '\9356 - не знайдено рахунок '||p_NLSa||'('||p_kv||')',TRUE);
  end;

  begin
    select a.rnk, c.okpo
    into   l_rnk, l_okpo_B
    from accounts a, customer c
    where a.dazs is null  and a.nls = p_NLSB  and kv = p_kv and a.rnk = c.rnk;
  EXCEPTION WHEN NO_DATA_FOUND THEN
         raise_application_error( -20203, '\9356 - не знайдено рахунок '||p_NLSB||'('||p_kv||')',TRUE);
  end;

  begin
    select kodk into l_kodk_a from rnkp_kod where rnk = l_rnk_a;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    l_kodk_a := null;
  end;

  begin
    select kodk into l_kodk_b from rnkp_kod where rnk = l_rnk;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    l_kodk_b := null;
  end;

  if  ((l_rnk_a = l_rnk or l_okpo_a = l_okpo_B) or
       (l_okpo_a in ('40075815','21560045') and l_kodk_a is not null and l_kodk_b is not null)) then
	return p_s;
  End if;

  begin
    select nls
    into   l_nls
    from accounts a
    where a.dazs is null  and a.rnk = l_rnk  and a.nbs = P_nbs and a.ob22 = P_ob22 and kv = p_kv and rownum = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  case when l_nls is not null
            then  Return p_s;
            else  raise_application_error( -20203, '\     Не знайдено рахунок '||P_nbs||'/'||P_ob22||'('||p_kv||') для обов"язкового зарахування коштів',TRUE);
  end case;

end ib_stop_2603;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ib_stop_2603.sql =========*** End *
 PROMPT ===================================================================================== 
 