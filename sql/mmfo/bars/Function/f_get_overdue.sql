
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_overdue.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_OVERDUE (
              p_date      date,                 -- дата на которую нужно получить рез-т
              p_nd        number  default 0)    -- Номер кредитного договора (0-все)
return t_cc_overdue_list pipelined
is
    l_row       t_cc_overdue;
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
         l_row := t_cc_overdue(c.nd, c.tip, c.fdat);
	 pipe row (l_row);

   end loop;


   return;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_OVERDUE ***
grant EXECUTE                                                                on F_GET_OVERDUE   to BARSDWH_ACCESS_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_overdue.sql =========*** End 
 PROMPT ===================================================================================== 
 