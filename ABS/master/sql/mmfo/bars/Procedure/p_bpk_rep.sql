

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BPK_REP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BPK_REP ***

  CREATE OR REPLACE PROCEDURE BARS.P_BPK_REP (
-- 23.03.2018 LIA
  p_mode number,
  p_dat1 date,
  p_dat2 date,
  p_kf varchar2 )
is
  l_ost number;
  l_int number;
begin

  delete from tmp_bpk_rep;


  -- Інформація стосовно перегляду умов зобов'язань за кредитними договорами (БПК) військовослужбовців
  if p_mode = 1 then
     for z in ( select b.acc, c.nmk, c.rnk, to_date(w.value, 'dd/mm/yyyy') dat, a.nls, o.kf
                  from w4_acc o, accounts b, customer c, accountsw w, accounts a
                 where o.acc_ovr = b.acc
                   and b.nbs = '2203'
                   and b.dazs is null
                   and b.acc = w.acc
                   and w.tag = 'PK_DDAT'
                   and b.rnk = c.rnk
                   and (p_kf = '%' or o.kf = p_kf)
                   and o.acc_pk = a.acc)
     loop
        l_ost := abs(fost(z.acc, p_dat1));
        acrn.p_int(z.acc, 0, z.dat, p_dat1, l_int);
        insert into tmp_bpk_rep (acc, nmk, rnk, open_date, nls, kf, sum_borg, sum_int)
        values (z.acc,z.nmk,z.rnk,z.dat,z.nls,z.kf,abs(l_ost/100),abs(round(l_int/100,2)));
     end loop;
  end if;
end p_bpk_rep;

/
show err;

PROMPT *** Create  grants  P_BPK_REP ***
grant EXECUTE                                                                on P_BPK_REP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BPK_REP       to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BPK_REP.sql =========*** End ***
PROMPT ===================================================================================== 
