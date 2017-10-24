

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NEST_OVERDUE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NEST_OVERDUE ***

  CREATE OR REPLACE PROCEDURE BARS.P_NEST_OVERDUE (
              p_date      date,
              p_nd        number  default 0)
is
    l_startdate date;
begin
   select max(report_date) into l_startdate
     from bars.cc_overdue_dates
    where report_date <= p_date
      and ( (nd = p_nd and p_nd <> 0) or(p_nd = 0));

    l_startdate := nvl(l_startdate, to_date('01/01/1999','dd/mm/yyyy'));

   for c in (
                select nd, tip, max(fdat)  fdat
                 from ( select nd, tip, max(fdat) fdat
                          from ( select fdat, s.acc, a.nls, a.tip,  n.nd, s.ostf - s.dos +s.kos ost,
                                        sum(s.dos) over (partition by n.nd order by fdat desc) dos_sum, a.dos
                                   from bars.nd_acc n, bars.saldoa s, bars.accounts a, bars.cc_deal d, bars.cc_vidd v
                                  where n.acc = s.acc
                                    and s.fdat between l_startdate and  p_date
                                    and a.tip in ('SP ','SPN')
                                    and v.vidd = d.vidd
                                    and v.custtype = 2
                                    and d.nd = n.nd
                                    and a.acc = s.acc
                                    and (a.dazs is null or a.dazs > p_date)
                                    and a.daos <= p_date
                                    and ( (n.nd = p_nd and p_nd <> 0)
                                          or
                                          (p_nd = 0)
                                       )
                             )
                          where dos_sum >=  ost
                            and ost <> 0
                          group by nd,  tip
                          union all
                         select nd, 'SP ' tip,  to_date(txt, 'dd/mm/yyyy') dat
                           from bars.nd_txt
                          where tag = 'DATSP' and txt is not null
                            and ( (nd = p_nd and p_nd <> 0)  or (p_nd = 0))
                          union all
                         select nd,  overdue_type,   overdue_date
                           from bars.cc_overdue_dates
                          where report_date = l_startdate
                            and ( (nd = p_nd and p_nd <> 0)  or (p_nd = 0))
                      )
                group by nd,  tip
                order by nd
           )
   loop
      begin
        insert into bars.cc_overdue_dates
         (nd, ndtype, overdue_method ,overdue_type,  report_date, overdue_date)
        values(c.nd, 1,1, c.tip, p_date , c.fdat );
      exception when dup_val_on_index then null;
      end;
   end loop;


end;
/
show err;

PROMPT *** Create  grants  P_NEST_OVERDUE ***
grant EXECUTE                                                                on P_NEST_OVERDUE  to BARSDWH_ACCESS_USER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NEST_OVERDUE.sql =========*** En
PROMPT ===================================================================================== 
