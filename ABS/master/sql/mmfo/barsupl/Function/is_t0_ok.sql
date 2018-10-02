
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/function/is_t0_ok.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSUPL.IS_T0_OK (p_date in date default null) return number
    -- функци€ возвращает 1 если выгрузка T0 в мес€це p_date была выполнена и 0 в противном случае
    -- 01/10/2018 - disable RESULT_CACHE clause (COBUMMFO-9544) V.Kharin
    is
        l_T0    number(1) := 0;
        l_date  date;
    begin
        l_date := nvl(p_date, trunc(sysdate));
        select decode(max(upl_bankdate), null, 0, 1)
          into l_T0
          from ( -- провер€ю наличие выгрузки в архиве протокола
                    select max(s0.upl_bankdate) upl_bankdate
                      from barsupl.upl_stats_archive s0,
                           barsupl.upl_stats_archive s1
                     where s1.group_id = 7
                       and s1.file_id is null
                       and s1.upl_errors is null
                       and s0.parent_id = s1.id
                       and s0.file_id = 2
                       and s0.status_id = 1
                       and s0.upl_errors is null
                       and trunc(s0.upl_bankdate,'MM') = trunc(l_date,'MM')
                    union all
                 -- провер€ю наличие выгрузки в протоколе
                    select max(s0.upl_bankdate) upl_bankdate
                      from barsupl.upl_stats s0,
                           barsupl.upl_stats s1
                     where s1.group_id = 7
                       and s1.file_id is null
                       and s1.upl_errors is null
                       and s0.parent_id = s1.id
                       and s0.file_id = 2
                       and s0.status_id = 1
                       and s0.upl_errors is null
                       and trunc(s0.upl_bankdate,'MM') = trunc(l_date,'MM')
                    union all
                 -- провер€ю наличие запущеного задани€ выгрузки
                    select last_start_date
                      from barsupl.v_upl_scheduler_jobs
                     where job_name like ( select job_name || '%'
                                             from barsupl.upl_autojob_param_values
                                            where param = 'GROUPID'
                                              and value = 7
                                         )
                       and state = 'RUNNING'
                );
        return l_T0;
    end is_T0_OK;
/
 show err;
 
PROMPT *** Create  grants  IS_T0_OK ***
grant EXECUTE                                                                on BARSUPL.IS_T0_OK        to BARS;
grant EXECUTE                                                                on BARSUPL.IS_T0_OK        to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSUPL/function/is_t0_ok.sql =========*** End **
 PROMPT ===================================================================================== 
 