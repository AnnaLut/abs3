

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_LOSS_DELAY_DAYS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_LOSS_DELAY_DAYS ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_LOSS_DELAY_DAYS (p_date in date default trunc(sysdate))
is /* Процедура для ежедневного расчета(сохранения) дней просрочки по КД, МБК, ЦБ */
 l_event_type number(1);
 l_status number(1);
 l_proc_lanch number(1) :=0;
 l_days number(10) := 0;
 l_days_corr number(10) := 0;
 l_event_date date := trunc(sysdate);
 --21.09.2015 Иванова Ирина
 l_event_date1 date;
begin
     delete from prvn_loss_delay_days where reporting_date = p_date;
    ---* КД *-----
    for c_cck in (select * from cc_deal
                     where vidd in (1,2,3,11,12,13)
                       and sos in (0,10,11,13,15))
    loop
      bars_loss_events.loss_delay('CCK',
                 c_cck.nd,
                 c_cck.sos,
                 c_cck.sdate,
                 null,
                 null,
                 p_date ,
                 l_event_type,
                 --21.09.2015 Иванова Ирина
                 l_event_date1,
                 l_status,
                 l_days,
                 l_days_corr,
                 0,
                 trunc(sysdate));
      --сохраняем дни просрочки
      if l_days <> 0 or l_days_corr <> 0 then
         insert into prvn_loss_delay_days( reporting_date, ref_agr, days, days_corr, event_date, object_type, lanch_monthly )
                                  values ( p_date, c_cck.nd, l_days, l_days_corr, l_event_date, 'CCK', l_proc_lanch);
      end if;
    end loop;

    ---* МБК *---
    for c_mbk in (select * from cc_deal where length(vidd) > 3 and sos in (0,10,11,13))
    loop
       bars_loss_events.loss_delay('MBK',
                  c_mbk.nd,
                  c_mbk.sos,
                  c_mbk.sdate,
                  null,
                  null,
                  p_date ,
                  l_event_type,
                  --21.09.2015 Иванова Ирина
                  l_event_date,
                  l_status,
                  l_days,
                  l_days_corr,
                 0,
                 trunc(sysdate));

       --сохраняем дни просрочки
       if l_days <> 0 or l_days_corr <> 0 then
          insert into prvn_loss_delay_days( reporting_date, ref_agr, days, days_corr, event_date, object_type, lanch_monthly )
                                   values ( p_date, c_mbk.nd, l_days, l_days_corr, l_event_date, 'MBK', l_proc_lanch);

       end if;
    end loop;

    ---* ЦБ *---
    for c_cp in (select d.ryn, d.accr, d.accr2, d.dat_ug, d.ref, d.id
                    from cp_deal d --  субпортфели
                   where d.dat_ug <= p_date
                     and d.active = 1
                     and d.ryn in (select ryn
                                      from cp_accc
                                     where nlsr like '___9%' or nlsr2 like '___9%' )) --просрочка
    loop
       bars_loss_events.loss_delay('CP',
                  c_cp.ryn,
                  null,
                  null,
                  c_cp.accr,
                  c_cp.accr2,
                  p_date ,
                  l_event_type,
                  --21.09.2015 Иванова Ирина
                  l_event_date1,
                  l_status,
                  l_days,
                  l_days_corr,
                 0,
                 trunc(sysdate));
      --сохраняем дни просрочки
       if l_days <> 0  or l_days_corr <> 0 then
          insert into prvn_loss_delay_days( reporting_date, ref_agr, days, days_corr, event_date, object_type, lanch_monthly )
                                   values ( p_date, c_cp.ref, l_days, l_days_corr, l_event_date, 'CP', l_proc_lanch);
       end if;
    end loop;
end bars_loss_delay_days;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_LOSS_DELAY_DAYS.sql =========
PROMPT ===================================================================================== 
