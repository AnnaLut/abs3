
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_acc_branch.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ACC_BRANCH (p_acc accounts.acc%type)
  return varchar2
as
  l_branch accounts.branch%type;
begin
/*
  Функція повертає бранч існуючого рахунку, або якщо рахунок ще не відкрито то повертає поточний бранч користувача.
  Використовується в картці рахунку для довідника "Код ПАКЕТУ тарифів"
  select l.* from bars.sparam_list l where l.semantic='Код ПАКЕТУ тарифiв' and l.tabname='ACCOUNTSW' and l.nsiname='V_TARIF_SCHEME_ACCBRANCH';
*/
  if p_acc = 0 then
    l_branch := sys_context('bars_context','user_branch');
  else
    begin
      select branch
        into l_branch
        from accounts
       where acc=to_number(p_acc) and nbs is not null;
    exception
      when no_data_found then
       l_branch := sys_context('bars_context','user_branch');
    end;
  end if;
return l_branch;
end;
/
 show err;
 
PROMPT *** Create  grants  F_ACC_BRANCH ***
grant EXECUTE                                                                on F_ACC_BRANCH    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_acc_branch.sql =========*** End *
 PROMPT ===================================================================================== 
 