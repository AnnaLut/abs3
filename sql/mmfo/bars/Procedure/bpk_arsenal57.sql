

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BPK_ARSENAL57.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BPK_ARSENAL57 ***

  CREATE OR REPLACE PROCEDURE BARS.BPK_ARSENAL57 (p_dat date)
is
  l_lim        number;
  l_lim_begin  number;
  l_bday       date;
  l_dat_57     date;
  l_dat        date;
  l_lastday    date;
  i number;
begin
  delete from tmp_bpk_arsenal57;

  -- последний день отчетного мес€ца
  l_lastday := last_day(p_dat);

  for k in ( select a.card_acct, a.client_n, a.open_date, a.expiry,
                    s.branch, s.acc, s.nls, a.currency lcv, s.lim, r.okpo
               from obpc_acct a, accounts s, customer r
              where a.serv_code = 'F'
                and a.acc = s.acc
                and s.lim <> 0
                and s.rnk = r.rnk and r.okpo <> '000000000'
                and s.branch like sys_context ('bars_context', 'user_branch_mask') )
  loop
     -- день рождени€ по ќ ѕќ
     l_bday := to_date('31/12/1899','DD/MM/YYYY') + to_number(substr(k.okpo,1,5));

     -- дата 57 лет
     l_dat_57 := add_months(l_bday, 12*57);

     -- если уже исполнилось 57
     if l_dat_57 <= l_lastday then

        -- лимит в дату до l_dat_57
        begin
           select lim into l_lim_begin
             from accounts_update u
            where u.acc = k.acc
              and u.idupd = ( select max(idupd) from accounts_update
                               where acc = u.acc and chgdate < l_dat_57 );
        exception when no_data_found then l_lim_begin := k.lim;
        end;

        -- лимит на сегодн€
        l_lim := l_lim_begin;
        l_dat := l_dat_57;

        i := 0;
        while l_dat <= l_lastday and i < 24 loop
           l_lim := l_lim - l_lim_begin/24;
           l_dat := add_months(l_dat, 1);
           i := i + 1;
        end loop;

        -- сохран€ем, если нужно помен€ть лимит
        if l_lim_begin <> l_lim then
           insert into tmp_bpk_arsenal57 (card_acct, open_date, expiry, branch, acc, nls, lcv, nmk, lim_begin, lim, bday)
           values (k.card_acct, k.open_date, k.expiry, k.branch, k.acc, k.nls, k.lcv, k.client_n, l_lim_begin, l_lim, l_bday);
        end if;

     end if;

  end loop;

end bpk_arsenal57;
/
show err;

PROMPT *** Create  grants  BPK_ARSENAL57 ***
grant EXECUTE                                                                on BPK_ARSENAL57   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BPK_ARSENAL57   to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BPK_ARSENAL57.sql =========*** End
PROMPT ===================================================================================== 
