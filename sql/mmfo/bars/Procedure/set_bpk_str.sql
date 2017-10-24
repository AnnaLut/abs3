

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_BPK_STR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_BPK_STR ***

  CREATE OR REPLACE PROCEDURE BARS.SET_BPK_STR (p_mode number)
--
-- Процедура для заполнения кода страховой компании
--   по счетам БПК Way4 для клиентов старше 65 лет.
--
is
  l_id number;
begin
  for z in ( select a.acc, a.ob22
               from w4_acc o, accounts a, person p, accounts b, accounts c
              where o.acc_pk = a.acc
                and a.nls like '2625%' and a.ob22 in ('24','29','30')
                and a.dazs is null
                and a.rnk = p.rnk
                and p.bday <= add_months(trunc(sysdate), -12*65)
                and not exists (select 1 from accountsw where acc = a.acc and tag = 'PK_STR')
                and o.acc_ovr  = b.acc(+)
                and o.acc_9129 = c.acc(+)
                and (nvl(b.ostc,0) <> 0 or nvl(c.ostc,0) <> 0) )
  loop
     begin
        select id into l_id from bpk_arsenal_str where ob22 = z.ob22;
        insert into accountsw (acc, tag, value)
        values (z.acc, 'PK_STR', to_char(l_id));
     exception when no_data_found then null;
     end;
  end loop;
end set_bpk_str;
/
show err;

PROMPT *** Create  grants  SET_BPK_STR ***
grant EXECUTE                                                                on SET_BPK_STR     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SET_BPK_STR     to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_BPK_STR.sql =========*** End *
PROMPT ===================================================================================== 
