

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_LOSS_DELAY_DAYS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_LOSS_DELAY_DAYS ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_LOSS_DELAY_DAYS 
( p_date in date default trunc(sysdate)
) is /* Процедура для ежедневного расчета(сохранения) дней просрочки по КД, МБК, ЦБ */
  l_event_type    number(1);
  l_status        number(1);
  l_days          number(10);
  l_days_corr     number(10);
  l_event_date    date := trunc(sysdate);
  l_proc_lanch    prvn_loss_delay_days.lanch_monthly%type := 0;
  l_obj_tp        prvn_loss_delay_days.object_type%type;
  l_ev_dt         prvn_loss_delay_days.event_date%type;
begin

  delete PRVN_LOSS_DELAY_DAYS
   where REPORTING_DATE = p_date;

  -- КД + МБК
  for c_cck in
  ( select KF, ND, SOS, SDATE, VIDD
      from cc_deal
     where sos in (0,10,11,13)
       and VIDD in ( select VIDD
                       from CC_VIDD
                      where TIPD = 1
                        and ( VIDD in (1,2,3,11,12,13)   and CUSTTYPE > 1
                           or VIDD between 1000 and 9999 and CUSTTYPE = 1 )
                   )
  ) loop

    if ( c_cck.VIDD in (1,2,3,11,12,13) )
    then l_obj_tp := 'CCK';
    else l_obj_tp := 'MBK';
    end if;

    bars_loss_events.loss_delay( p_object_type => l_obj_tp
                               , p_nd          => c_cck.nd
                               , p_sos         => c_cck.sos
                               , p_sdate       => c_cck.sdate
                               , p_accr        => null
                               , p_accr2       => null
                               , p_date        => p_date
                               , p_event_type  => l_event_type -- out
                               , p_event_date  => l_ev_dt      -- out
                               , p_status      => l_status     -- out
                               , p_days        => l_days       -- out
                               , p_days_corr   => l_days_corr  -- out
                               , p_zo          => 0
                               , p_mdate       => l_event_date );

    if ( l_days <> 0 or l_days_corr <> 0 )
    then -- сохраняем дни просрочки
      insert
        into PRVN_LOSS_DELAY_DAYS
           ( REPORTING_DATE, KF, REF_AGR, DAYS, DAYS_CORR, EVENT_DATE, OBJECT_TYPE, LANCH_MONTHLY )
      values ( p_date, c_cck.KF, c_cck.nd, l_days, l_days_corr, l_event_date, l_obj_tp, l_proc_lanch );
    end if;

  end loop;

  -- ЦП
  for c_cp in
  ( select d.KF, d.ryn, d.accr, d.accr2, d.dat_ug, d.ref, d.id
      from cp_deal d --  субпортфели
     where d.dat_ug <= p_date
       and d.active = 1
       and d.ryn in ( select ryn
                        from cp_accc
                       where nlsr like '___9%' or nlsr2 like '___9%' ) -- просрочка
  ) loop

    bars_loss_events.loss_delay( 'CP',
                                 c_cp.ryn,
                                 null,
                                 null,
                                 c_cp.accr,
                                 c_cp.accr2,
                                 p_date,
                                 l_event_type, -- out
                                 l_ev_dt,      -- out
                                 l_status,     -- out
                                 l_days,       -- out
                                 l_days_corr,  -- out
                                 0,
                                 l_event_date );

    if l_days <> 0  or l_days_corr <> 0
    then -- сохраняем дни просрочки
      insert
        into PRVN_LOSS_DELAY_DAYS
           ( REPORTING_DATE, KF, REF_AGR, DAYS, DAYS_CORR, EVENT_DATE, OBJECT_TYPE, LANCH_MONTHLY )
      values ( p_date, c_cp.KF, c_cp.REF, l_days, l_days_corr, l_event_date, 'CP', l_proc_lanch );
    end if;

  end loop;

end bars_loss_delay_days;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_LOSS_DELAY_DAYS.sql =========
PROMPT ===================================================================================== 
