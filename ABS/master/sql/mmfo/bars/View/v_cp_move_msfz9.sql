create or replace view v_cp_move_msfz9 as
select * from
      (select k.id, k.cp_id, d.ref, d.acc, a.nls nlsn, nvl(fost(a.acc,gl.bd), 0)/100 ostn, decode(d.active, 1, 'връ', 'ЭГ') active,
             p.nls nlsp, nvl(fost(p.acc,gl.bd), 0)/100 ostp,
             di.nls nlsd, nvl(fost(di.acc,gl.bd), 0)/100 ostd,
             s.nls nlss, nvl(fost(s.acc,gl.bd), 0)/100 osts,
             s2.nls nlss2, nvl(fost(s2.acc,gl.bd), 0)/100 osts2,
             r.nls nlsr, nvl(fost(r.acc,gl.bd), 0)/100 ostr,
             r2.nls nlsr2, nvl(fost(r2.acc,gl.bd), 0)/100 ostr2,
             r3.nls nlsr3, nvl(fost(r3.acc,gl.bd), 0)/100 ostr3,
             (select listagg(a.nls, ',') within group (order by a.nls) as nls from cp_accounts gar, accounts a where gar.cp_acc = a.acc and gar.cp_acctype = 'GAR' and gar.cp_ref = d.ref) nlsgar,
             (select sum(nvl(fost(a.acc,gl.bd), 0)/100) as ostgar from cp_accounts gar, accounts a where gar.cp_acc = a.acc and gar.cp_acctype = 'GAR' and gar.cp_ref = d.ref) ostgar,
             dm.ref ref_move,
             (select least (CASE
                             WHEN o.sos > 0 AND o.sos < 5 THEN 0
                             WHEN o.sos = 5 THEN 1
                             WHEN o.sos < 0 THEN -1
                           END,
                           dm.active)
                from oper o
                where o.ref=dm.ref) as active_move,
             d.initial_ref,
             d.op   
      from cp_deal d, cp_kod k, accounts a,
           accounts p, accounts s, accounts di, accounts r, accounts r2, accounts r3,
           (select * from cp_accounts s2, accounts as2 where s2.cp_acc = as2.acc and s2.cp_acctype = 'S2') s2,
           cp_deal dm
      where d.id = k.id and d.acc = a.acc
        and d.accp = p.acc (+)
        and d.accd = di.acc (+)
        and d.accs = s.acc (+)
        and d.ref = s2.cp_ref (+)
        and d.accr = r.acc (+)
        and d.accr2 = r2.acc (+)
        and d.accr3 = r3.acc (+)
        and decode(d.op, 3, d.initial_ref,d.ref ) = dm.initial_ref (+)
        and d.ref in (47243380501,
                      47243435101,
                      47243305401,
                      47243182101,
                      82334825401,
                      65947008401,
                      49146681101,
                      49148483201,
                      85894251301,
                      --
                      25539502101,
                      25539559601,
                      25539589601,
                      28356622201,
                      28356682201,
                      50126769501
                      )
         ) ug
where nvl(ug.ref_move, 0) =
      (select nvl(max(ref), 0) from cp_deal where decode(ug.op, 3, ug.initial_ref, ug.ref) = initial_ref)
order by ug.nlsn;


grant SELECT                                                                 on V_CP_ALL_ZAL    to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_ALL_ZAL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_ALL_ZAL    to START1;
grant SELECT                                                                 on V_CP_ALL_ZAL    to UPLD;
