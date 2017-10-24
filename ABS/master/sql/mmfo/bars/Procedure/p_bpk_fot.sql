

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BPK_FOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BPK_FOT ***

  CREATE OR REPLACE PROCEDURE BARS.P_BPK_FOT (p_dat date)
is
  l_dat1  date;
  l_dat2  date;
  l_kos   boolean := false;
  l_fot   number := 0;
  l_kred  number := 0;
  l_pkred number := 0;
begin

  delete from bpk_fot;

  -- данные за предыдущий мес€ц
  l_dat1 := trunc(trunc(p_dat,'mm')-1,'mm');
  l_dat2 := trunc(p_dat,'mm')-1;
bars_audit.info('p_bpk_fot. p_dat=>' || to_char(p_dat) || ' l_dat1=>' || to_char(l_dat1) || ' l_dat2=>' || to_char(l_dat2));
  for z in ( select a.acc, nvl(o.acc_ovr,o.acc_2203) acc_ovr, o.acc_9129, o.acc_2207, o.acc_2209, o.acc_3579,
                    a.branch, p.name, p.okpo, a.daos, c.fs, ws.name card_name
               from w4_acc o, accounts a, accountsw w, bpk_proect p, customer c,
                    w4_card wc, w4_subproduct ws
              where o.acc_pk = a.acc
                and a.daos <= l_dat2
                and a.dazs is null
                and a.ob22 in ('24', '27', '31', '32')
                and a.acc = w.acc and w.tag = 'PK_PRCT'
                and w.value = to_char(p.id)
                and a.rnk = c.rnk
                and o.card_code = wc.code
                and wc.sub_code = ws.code )
  loop
     l_kos   := false;
     l_fot   := 0;
     l_kred  := 0;
     l_pkred := 0;
     for x in ( select tt, s from opldok where acc = z.acc and fdat between l_dat1 and l_dat2 and dk = 1 and sos = 5 )
     loop
        l_kos := true;
        if x.tt in ('PKS', 'KL1', 'KL2', 'IB1', 'IB2', 'IB5','R01') then
           l_fot := l_fot + x.s;
        end if;
     end loop;
     if l_kos = true then
        select nvl2(z.acc_ovr, fost(z.acc_ovr, l_dat2), 0)
             + nvl2(z.acc_9129, fost(z.acc_9129, l_dat2), 0) into l_kred from dual;
        select nvl2(z.acc_2207, fost(z.acc_2207, l_dat2), 0)
             + nvl2(z.acc_2209, fost(z.acc_2209, l_dat2), 0)
             + nvl2(z.acc_3579, fost(z.acc_3579, l_dat2), 0) into l_pkred from dual;
        insert into bpk_fot (branch, org_name, org_okpo, daos, fs, card_type, bpk_count, fot, kred, pkred)
        values (z.branch, z.name, z.okpo, z.daos, z.fs, z.card_name, 1, l_fot, l_kred, l_pkred);
     end if;
  end loop;

  for z in ( select branch, org_name, org_okpo, daos, fs, card_type,
                   sum(bpk_count) bpk_count, sum(fot) fot, sum(kred) kred, sum(pkred) pkred
              from bpk_fot
             group by branch, org_name, org_okpo, daos, fs, card_type )
  loop
     delete from bpk_fot where org_okpo = z.org_okpo;
     insert into bpk_fot (branch, org_name, org_okpo, daos, fs, card_type, bpk_count, fot, kred, pkred)
     values (z.branch, z.org_name, z.org_okpo, z.daos, z.fs, z.card_type, z.bpk_count, z.fot, z.kred, z.pkred);
  end loop;

end p_bpk_fot;
/
show err;

PROMPT *** Create  grants  P_BPK_FOT ***
grant EXECUTE                                                                on P_BPK_FOT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BPK_FOT       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BPK_FOT.sql =========*** End ***
PROMPT ===================================================================================== 
