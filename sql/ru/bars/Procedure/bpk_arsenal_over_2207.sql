

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BPK_ARSENAL_OVER_2207.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BPK_ARSENAL_OVER_2207 ***

  CREATE OR REPLACE PROCEDURE BARS.BPK_ARSENAL_OVER_2207 (p_dat date)
--
-- Version 1.3 28.11.2014
-- ƒобавлен NBS 2207 (COBUSUPABS-4334) 28.03.2016
--
 is
  l_dat1        date;
  l_day         number;
  l_s           number;
  l_tarif       number;
  l_set_date    date;
  l_set_day     number;
  l_old_accovr  number;
begin

  delete from tmp_bpk_arsenal;

  -- l_dat1 - первый день мес€ца
  l_dat1 := trunc(p_dat, 'mm');

  -- l_day - количество дней в мес€це
  l_day := last_day(p_dat) + 1 - l_dat1;

  -- по каждой страховой компании
  for s in (select id from bpk_arsenal_str) loop
    begin
      -- определение страхового тарифа годового по коду страховой компании
      select tarif
        into l_tarif
        from bpk_arsenal_tarif
       where id = s.id
         and dat = (select max(dat)
                      from bpk_arsenal_tarif
                     where id = s.id
                       and dat <= p_dat);

      -- по каждому счету
      for k in (select o.pc, o.nd, o.acc_ovr, a.kv
                  from bpk_all_accounts o, accounts a, accountsw p
                 where o.acc_ovr = a.acc
                   and a.dazs is null
                   and a.daos <= last_day(p_dat)
                   and o.acc_pk = p.acc
                   and p.tag = 'PK_STR'
                   and trim(p.value) = to_char(s.id)
                   and a.branch like sys_context('bars_context', 'user_branch_mask')
                union -- 2207 (COBUSUPABS-4334)
                select o.pc, o.nd, o.acc_2207 as acc_ovr, a.kv
                  from bpk_all_accounts o, accounts a, accountsw p
                 where o.acc_2207 = a.acc
                   and a.dazs is null
                   and a.daos <= last_day(p_dat)
                   and o.acc_pk = p.acc
                   and p.tag = 'PK_STR'
                   and trim(p.value) = to_char(s.id)
                   and o.acc_2207 is not null
                   and a.branch like sys_context('bars_context', 'user_branch_mask'))
      loop
        l_s := 0;

        if k.pc = 'PK' then
          for i in 0 .. l_day - 1 loop
            l_s := l_s + gl.p_icurval(k.kv,
                                      fost_h(k.acc_ovr, l_dat1 + i),
                                      l_dat1 + i);
          end loop;
        else
          -- когда заполнилс€ acc_ovr?
          select nvl(min(effectdate), l_dat1)
            into l_set_date
            from w4_acc_update
           where nd = k.nd
             and acc_ovr = k.acc_ovr;
          -- счет установилс€ раньше отчетной даты
          if l_set_date <= l_dat1 then
            for i in 0 .. l_day - 1 loop
              l_s := l_s + gl.p_icurval(k.kv,
                                        fost_h(k.acc_ovr, l_dat1 + i),
                                        l_dat1 + i);
            end loop;
            -- счет установилс€ позже отчетной даты
          else
            begin
              select acc_ovr
                into l_old_accovr
                from w4_acc_update u
               where nd = k.nd
                 and idupd = (select max(idupd)
                                from w4_acc_update
                               where nd = u.nd
                                 and effectdate < l_set_date);
            exception
              when no_data_found then
                l_old_accovr := null;
            end;
            if l_old_accovr is null then
              for i in 0 .. l_day - 1 loop
                l_s := l_s + gl.p_icurval(k.kv,
                                          fost_h(k.acc_ovr, l_dat1 + i),
                                          l_dat1 + i);
              end loop;
            else
              l_set_day := to_number(to_char(l_set_date, 'dd'));
              for i in 0 .. l_set_day - 1 loop
                l_s := l_s + gl.p_icurval(k.kv,
                                          fost_h(l_old_accovr, l_dat1 + i),
                                          l_dat1 + i);
              end loop;
              for i in l_set_day .. l_day - 1 loop
                l_s := l_s + gl.p_icurval(k.kv,
                                          fost_h(k.acc_ovr, l_dat1 + i),
                                          l_dat1 + i);
              end loop;
            end if;
          end if;
        end if;

        insert into tmp_bpk_arsenal
          (id, acc, debt, tarif)
        values
          (s.id, k.acc_ovr, abs(l_s / l_day), l_tarif / 12);

      end loop;

    exception
      when no_data_found then
        null;
    end;
  end loop;

end bpk_arsenal_over_2207;
/
show err;

PROMPT *** Create  grants  BPK_ARSENAL_OVER_2207 ***
grant EXECUTE                                                                on BPK_ARSENAL_OVER_2207 to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BPK_ARSENAL_OVER_2207.sql ========
PROMPT ===================================================================================== 
