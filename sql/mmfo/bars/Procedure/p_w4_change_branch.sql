

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_W4_CHANGE_BRANCH.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_W4_CHANGE_BRANCH ***

  CREATE OR REPLACE PROCEDURE BARS.P_W4_CHANGE_BRANCH (p_proect_code varchar2, p_branch varchar2)
is
procedure set_branch (p_acc number, p_tobo varchar2, p_dazs date)
is
begin
  if p_acc is not null and p_tobo <> p_branch then
     if p_dazs is not null then
        update accounts set dazs = null where acc = p_acc;
     end if;
     update accounts set tobo = p_branch where acc = p_acc;
     if p_dazs is not null then
        update accounts set dazs = p_dazs where acc = p_acc;
     end if;
  end if;
end set_branch;
begin
  if p_proect_code is null then
     raise_application_error(-20000, 'Не вказано код З/П проекту');
  end if;
  if p_branch is null then
     raise_application_error(-20000, 'Не вказано код відділення');
  end if;
  for z in ( select o.*, a.tobo, a.dazs
               from w4_acc o, accounts a, accountsw w
              where o.acc_pk = a.acc
                and a.acc    = w.acc
                and w.tag    = 'PK_PRCT'
                and w.value  = to_char(p_proect_code) )
  loop
     set_branch(z.acc_pk, z.tobo, z.dazs);
     set_branch(z.acc_ovr, z.tobo, z.dazs);
     set_branch(z.acc_9129, z.tobo, z.dazs);
     set_branch(z.acc_3570, z.tobo, z.dazs);
     set_branch(z.acc_2208, z.tobo, z.dazs);
     set_branch(z.acc_2627, z.tobo, z.dazs);
     set_branch(z.acc_2207, z.tobo, z.dazs);
     set_branch(z.acc_3579, z.tobo, z.dazs);
     set_branch(z.acc_2209, z.tobo, z.dazs);
     set_branch(z.acc_2625x, z.tobo, z.dazs);
     set_branch(z.acc_2627x, z.tobo, z.dazs);
     set_branch(z.acc_2625d, z.tobo, z.dazs);
     set_branch(z.acc_2628, z.tobo, z.dazs);
     if z.dazs is null then
        bars_ow.add_deal_to_cmque(z.nd, 3);
     end if;
  end loop;
end p_w4_change_branch;
/
show err;

PROMPT *** Create  grants  P_W4_CHANGE_BRANCH ***
grant EXECUTE                                                                on P_W4_CHANGE_BRANCH to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_W4_CHANGE_BRANCH to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_W4_CHANGE_BRANCH.sql =========**
PROMPT ===================================================================================== 
