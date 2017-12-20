

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REP3099.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REP3099 ***

CREATE OR REPLACE procedure BARS.p_rep3099(p_dat date)
 as

  /*
    http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4836


   rep_id =>  3099    Звіт за прострочену заборгованість по кредитах ЮО
   pkey   =>  \brs\sber\CCK\3099


  */
    --p_dat date := to_date('30-05-2016','dd-mm-yyyy');
    l_list_nd     NUMBER_LIST;
    i int := 0;
    l_list_nbs varchar2(4000) := '2020,2030,2062,2063,2071,2082,2083, 2102,2103,2112,2113,2122,2123,2132,2133,
                                  2028,2038,2068,2078,2088,2108,2118,2128,2138,
                                  2027,2037,2067,2077,2087,2107,2117,2127,2137,
                                  2029,2039,2069,2079,2089,2109,2119,2129,2139';
    l_dos_sp number;
    l_dos_spn number;
    l_kos_sp number;
    l_kos_spn number;
    sTmp number;
begin


        delete from TMP_CCK5;

        Select distinct cc.nd
              bulk collect into l_list_nd
          from cc_deal cc, nd_acc na, accounts a, saldoa s , (select to_char(column_value) nbs from table(getTokens(l_list_nbs))) nb
         where cc.vidd between 1 and 3
           and na.nd = cc.nd
           and cc.sos < 15
           and cc.branch like sys_context('bars_context','user_branch_mask')
           and na.acc = a.acc
           and tip in ('SP','SPN')
           and a.nbs = nb.nbs
           and (s.fdat) in (select max(fdat) from saldoa where acc = a.acc and fdat <= p_dat)
           and  s.acc = a.acc
           and  S.OSTF - s.dos+s.kos != 0;



 for x in (

               Select c.rnk, c.nmk, cc.nd, cc.cc_id, cc.sdate, cc.wdate, a.kv,
           sum(case when a.tip = 'SS '/*regexp_like(a.nbs,'(0|1|2|3)$')*/  then S.OSTF - s.dos+s.kos else 0 end)/100*-1 ost_ss,
           sum(case when a.tip != 'SNA' and a.tip = 'SN '/*regexp_like(a.nbs,'8$')*/  then S.OSTF - s.dos+s.kos else 0 end)/100*-1 ost_sn,
           sum(case when a.tip = 'SP '/*regexp_like(a.nbs,'7$')*/ then S.OSTF - s.dos+s.kos else 0 end)/100*-1 ost_sp,
           sum(case when a.tip != 'SNA' and a.tip = 'SPN'/* and regexp_like(a.nbs,'9$')*/  then S.OSTF - s.dos+s.kos else 0 end)/100*-1 ost_spn,
           LISTAGG(case when a.tip = 'SP '/*regexp_like(a.nbs,'7$')*/                    then a.acc else null end ,',') WITHIN GROUP (ORDER BY a.acc)  acc_sp,
           LISTAGG(case when a.tip != 'SNA' and a.tip = 'SPN' /*regexp_like(a.nbs,'9$')*/  then a.acc else null end ,',') WITHIN GROUP (ORDER BY a.acc)  acc_spn
          from  table(l_list_nd) nd,
           cc_deal cc, nd_acc na, customer c, v_gl a, saldoa s,
              (select to_char(column_value) nbs from table(getTokens(l_list_nbs))) nb
         where cc.vidd between 1 and 3
           and  value(nd) = cc.nd
           and na.nd = cc.nd
           and cc.sos < 15
           and cc.rnk = c.rnk
           and na.acc = a.acc
           and a.nbs = nb.nbs
           and (s.fdat) in (select max(fdat) from saldoa where acc = a.acc and fdat <= p_dat)
           and s.acc = a.acc
           group by  c.rnk, c.nmk, cc.nd, cc.cc_id, cc.sdate, cc.wdate, a.kv
           order by  c.rnk



          )
LOOP
 i:= i+1;

     select nvl(sum(dos),0)
       into l_dos_sp
       from saldoa
      where acc in (select column_value acc from table(getTokens(x.acc_sp)))
        and fdat between trunc(p_dat,'mm') and p_dat;

     select nvl(sum(dos),0)
       into l_dos_spn
       from saldoa
      where acc in (select column_value acc from table(getTokens(x.acc_spn)))
        and fdat between trunc(p_dat,'mm') and p_dat;


  l_kos_sp:= 0;
  for k in ( select to_number(column_value) acc from table(getTokens(x.acc_sp)))
  loop
     sTmp:= 0;
  select sum(case when not regexp_like(ad.nbs,'^2(0|1)') then ok.s else 0 end) kos
    into sTmp
    from saldoa s,
         opldok od, accounts ad,
         opldok ok--, accounts ak
    where s.acc = k.acc
      and s.fdat between trunc(p_dat,'mm') and p_dat
      and s.fdat = ok.fdat and ok.dk = 1 and ok.acc = s.acc
      and ok.fdat = od.fdat and od.dk = 0 and od.acc = ad.acc
      and od.ref = ok.ref and od.stmt = ok.stmt;

    l_kos_sp := l_kos_sp+sTmp;
   end loop;

  l_kos_spn:= 0;
  for k in ( select to_number(column_value) acc from table(getTokens(x.acc_spn)))
  loop
     sTmp:= 0;
  select sum(case when not regexp_like(ad.nbs,'^2(0|1)') then ok.s else 0 end) kos
    into sTmp
    from saldoa s,
         opldok od, accounts ad,
         opldok ok--, accounts ak
    where s.acc = k.acc
      and s.fdat between trunc(p_dat,'mm') and p_dat
      and s.fdat = ok.fdat and ok.dk = 1 and ok.acc = s.acc
      and ok.fdat = od.fdat and od.dk = 0 and od.acc = ad.acc
      and od.ref = ok.ref and od.stmt = ok.stmt;

    l_kos_spn := l_kos_spn+sTmp;
   end loop;



 insert into TMP_CCK5 ( s57,  kv ,   s11, s12, s13,s14, s21, s22, s23,s24)
      values ( x.nd, x.kv, x.ost_ss,  x.ost_sn, x.ost_sp,  x.ost_spn, l_dos_sp/100, l_dos_spn/100, l_kos_sp/100, l_kos_spn/100 );



END LOOP;

end;
/
show err;

PROMPT *** Create  grants  P_REP3099 ***
grant EXECUTE                                                                on P_REP3099       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REP3099.sql =========*** End ***
PROMPT ===================================================================================== 
