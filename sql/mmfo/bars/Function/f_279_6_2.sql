
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_279_6_2.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_279_6_2 
(p_6 int,               -- рабочая константа
 p_ND cc_deal.ND%type ) -- реф КД
 RETURN specparam.s080%type IS

/*
Реалiзацiя вимоги пункту 6.2 Положення №279.
 "Претенденти на змiну категорiї ризику"  по умовi:
  - кредитний договiр дiє не менше нiж шiсть мiсяцiв
  - Клiєнт з класом позичальника "В" або "Г"
  - обслуговування боргу протягом 6 м_сяц_в "добре"
  - та сплата вiдсоткiв - не рiдше одного разу на м_сяць
    (1=щодня, 3=щотижня, 5=щомiсяця - в термiнах АБС "БАРС Millennium".).
 Якщо клас позичальника = 3 (В), то s080 = 2 (пiд контролем)
 Якщо клас позичальника = 4 (Г), то s080 = 3 (субстандартна)
*/
-------------------------------
 l_m080 specparam.s080%type    ;  -- возможное S080 по данной постанове НБУ
 l_freq int_accn.freq%type     ;
 l_acc  TMP_REZ_RISK.acc%type  ;
 l_f080 specparam.s080%type    ;  -- фактическое s080
 l_kol  int := 0 ; -- счетчик месяцев
 l_obs  int := 0 ; -- обсуж = 1
--------------------------------
begin

  begin

    select decode ( nvl (d.fin,c.crisk),3, 2, 3 )
    into l_m080
    from cc_deal d , customer c
    where d.sos >=10 and d.sos<15                 -- действующие КД
      and months_between(d.wdate,d.sdate ) > p_6  -- более 6 мес
      and d.fin in (3,4)  -- Клiєнт з класом позичальника "В" або "Г"
      and d.obs = 1       --  обслуговування боргу "добре"
      and d.rnk = c.rnk
      and d.nd = p_ND ;

    -- сплата вiдсоткiв - не рiдше одного разу на м_сяць
    -- (1=щодня, 3=щотижня, 5=щомiсяця - в термiнах АБС "БАРС Millennium".).
    select freq  into l_freq from nd_acc n, accounts a, int_accn i
    where n.nd  = p_ND       and n.acc = a.acc   and a.tip = 'LIM'
      and a.acc = i.acc      and i.id  = 0       and i.freq in (1,3,5);

    --  основной ссудный счет  (один из них)
    select a.acc, nvl(s.s080,'0')
    into l_acc,l_f080 from nd_acc n,accounts a, specparam s
    where n.nd  = p_ND       and n.acc = a.acc   and a.tip = 'SS '
      and a.dazs is null     and a.ostc < 0      and a.acc = s.acc (+)
      and rownum = 1;

    -- обслуговування боргу протягом 6 мiсяцiв "добре"
    -- ищем в архиве резервов по ссудному счету

    l_kol := 0; l_obs := 0;
    for z in (select obs from TMP_REZ_RISK t where acc = l_acc   and exists
                (select 1 from REZ_PROTOCOL where userid=t.id and dat = t.dat)
              order by t.dat desc   )
    loop
       if l_kol < p_6 and z.obs = 1 then   l_obs := l_obs + 1;    end if;
       l_kol := l_kol + 1 ;
    end loop;

    If l_obs < p_6 OR  l_f080 = l_m080 then l_m080 := null; end if;

  exception when no_data_found then l_m080 := null;
  end;

  return l_m080;
end F_279_6_2 ;
/
 show err;
 
PROMPT *** Create  grants  F_279_6_2 ***
grant EXECUTE                                                                on F_279_6_2       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_279_6_2       to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_279_6_2.sql =========*** End *** 
 PROMPT ===================================================================================== 
 