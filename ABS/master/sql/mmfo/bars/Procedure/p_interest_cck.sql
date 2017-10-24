

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INTEREST_CCK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INTEREST_CCK ***

  CREATE OR REPLACE PROCEDURE BARS.P_INTEREST_CCK (
        p_account_id in varchar2,

        p_type in number default 0,
        p_date_to in date)
    is
        l_accounts_id number_list;
        l_accounts_set number_list;
/*
  p_type = 1 -- КП S42: Нарахування %%  по поточних платіж. датах у КП ЮО
  p_type = 2 -- КП S53: Нарахування %%  по прострочених дог. у КП ФО
  p_type = 3 -- КП S54: Нарахування %%  по КД з залишками на рах. погашення ФО
  p_type = 4 -- КП S55: Нарахування %%  по КД з залишками на рах. погашення ЮО
  p_type = 5 -- КП: Нарахування щомiсячної комiсiї по КП
  
  p_type = 6 -- КП S42: Нарахування %%  по поточних платіж. датах у КП ЮЛ
  p_type = 7 -- КП F13: Щомiсячне Нарахування %% по всім дог. у КП ФО

  p_type = 8 -- КП S63: Нарахування Пенi  у КП ФО
  p_type = 9 -- КП S62: Нарахування Пенi  у КП ЮО
  
  p_type = 0 -- По всем счетам CC_DEAL

*/
begin
return; 
   l_accounts_id := tools.string_to_number_list(p_account_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
    -- Заглушка
    if p_type in (8,9) then return;
    end if;


    if p_type = 1 then
      select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null   and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where 
              d.sos <> 15
              and i.ID=0 and a.nbs like '20%' and a.tip in ('SS ','SP ') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=a.accc and fdat=gl.bd  and sumo>0 and not_sn is null);
        
    elsif p_type = 2 then
       select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null   and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where 
              d.sos <> 15
              and i.ID=0 and a.nbs like '22%' and a.tip in ('SP ') and i.acra is not null and i.acrb is not null;
    
    elsif p_type = 3 then
       select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null   and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where 
              d.sos <> 15
              and i.ID=0 and a.nbs like '22%' and a.tip in ('SS ','SP ' , 'SL ') and exists (select n.acc from nd_acc n, nd_acc n2,accounts a2  where n.acc=a.acc and  n.nd=n2.nd and n2.acc=a2.acc and a2.tip='SG ' and a2.ostc>0);  
    
    elsif p_type = 4 then
       select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null  and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where 
              d.sos <> 15
              and i.ID=0 and a.nbs like '20%' and a.tip in ('SS ','SP ' , 'SL ') and exists (select n.acc from nd_acc n, nd_acc n2,accounts a2  where n.acc=a.acc and  n.nd=n2.nd and n2.acc=a2.acc and a2.tip='SG ' and a2.ostc>0);
    
    elsif p_type = 5 then
       select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null   and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where 
              d.sos <> 15
              and i.metr>90;
    
    elsif p_type = 6 then
       select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null   and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where 
              d.sos <> 15
              and i.ID=0 and a.nbs like '20%' and a.tip in ('SS ','SP ') and i.acra is not null and i.acrb is not null and exists (select 1 from cc_lim where acc=a.accc and fdat=gl.bd  and sumo>0 and not_sn is null);
    
    elsif p_type = 7 then
       select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null   and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where 
              d.sos <> 15
              and i.ID in (0,1) and (a.dazs is null or a.dazs>gl.bd) and a.tip in ('SS ','SP ','SDI','S36')  and exists (select 1 from nd_acc n, cc_deal d where n.acc=a.acc and n.nd=d.nd and d.vidd in (11,12,13));
    
    
    elsif p_type = 0 then
       select unique a.acc
        bulk collect into l_accounts_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null   and a.tip <>'LIM'-- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < p_date_to
        join customer c on c.rnk = d.rnk
        where (l_accounts_id is null or l_accounts_id is empty or a.acc in (select column_value from table(l_accounts_id))) and
              d.sos <> 15;
    end if;
     
     tools.hide_hint(interest_utl.prepare_interest(l_accounts_set, p_date_to));
     
     if p_type in (6,7) then
        
       begin
           
         for i in (select * from int_reckoning t where t.reckoning_id = sys_context('bars_pul', 'reckoning_id') and t.state_id = 0) loop
            
            pul_dat(to_char(i.date_to, 'dd.mm.yyyy'), '');

            if (i.interest_rate is not null and i.interest_amount <> 0) then
                savepoint before_doc;

                begin
                    interest(i.date_from - 1, i.account_id, i.interest_kind);
                exception
                    when others then
                         rollback to before_doc;
                         bars_audit.error('p_interest_cck (exception)' || chr(10) || sqlerrm || dbms_utility.format_error_backtrace());
                end;
            end if;
         end loop;
       end;
     end if;
     
     
     
end;
/
show err;

PROMPT *** Create  grants  P_INTEREST_CCK ***
grant EXECUTE                                                                on P_INTEREST_CCK  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INTEREST_CCK.sql =========*** En
PROMPT ===================================================================================== 
