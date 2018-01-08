

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMS_RUN_REPORT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMS_RUN_REPORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMS_RUN_REPORT ("Початок роботи", "Остання активність", "Загальний час виконання", "Пріоритет", "Назва процедури", "Результат запуску", "Час по кожному відділенню", "Додаткова інформація", "Найменший час", "Найдовший час", "Найшвидше відділення", "Найповільніше відділення", "Час першого запуску", "Час останнього запуску", "Час першого завершення", "Час останнього завершення", "Ідентифікатор процедури", "Блок виконання процедури") AS 
  select min(min(d.start_time)) over () "Початок роботи",
       max(max(d.start_time)) over () "Остання активність",
       to_char(extract(hour from numtodsinterval(max(max(d.start_time)) over () - min(min(d.start_time)) over (), 'day')), 'fm900') || ':' ||
               to_char(extract(minute from numtodsinterval(max(max(d.start_time)) over () - min(min(d.start_time)) over (), 'day')), 'fm00') || ':' ||
               to_char(extract(second from numtodsinterval(max(max(d.start_time)) over () - min(min(d.start_time)) over (), 'day')), 'fm00') "Загальний час виконання",
       d.sequence_number "Пріоритет",
       d.task_name "Назва процедури",
       bars.list_utl.get_item_name('BANKDATE_TASK_RUN_STATE', d.state_id) "Результат запуску",
       listagg(d.branch || ' : ' ||
               to_char(extract(hour from d.elapsed_time), 'fm990') || ':' ||
               to_char(extract(minute from d.elapsed_time), 'fm00') || ':' ||
               to_char(extract(second from d.elapsed_time), 'fm00') || chr(10)) within group (order by d.branch) "Час по кожному відділенню",
       listagg(case when d.details is null then null else d.branch || chr(10) end || d.details) within group (order by d.branch) "Додаткова інформація",
       to_char(extract(hour from min(d.elapsed_time)), 'fm900') || ':' ||
               to_char(extract(minute from min(d.elapsed_time)), 'fm00') || ':' ||
               to_char(extract(second from min(d.elapsed_time)), 'fm00') "Найменший час",
       to_char(extract(hour from max(d.elapsed_time)), 'fm900') || ':' ||
               to_char(extract(minute from max(d.elapsed_time)), 'fm00') || ':' ||
               to_char(extract(second from max(d.elapsed_time)), 'fm00') "Найдовший час",
       min(d.branch) keep (dense_rank first order by d.elapsed_time) "Найшвидше відділення",
       min(d.branch) keep (dense_rank last order by d.elapsed_time) "Найповільніше відділення",
       to_char(min(d.start_time), 'hh24:mi:ss') "Час першого запуску",
       to_char(max(d.start_time), 'hh24:mi:ss') "Час останнього запуску",
       to_char(min(d.finish_time), 'hh24:mi:ss') "Час першого завершення",
       to_char(max(d.finish_time), 'hh24:mi:ss') "Час останнього завершення",
       d.id "Ідентифікатор процедури",
       d.task_statement "Блок виконання процедури"

from   (select tt.id,
               tt.task_name,
               tt.task_statement,
               tt.sequence_number,
               t.branch,
               t.state_id,
               t.start_time,
               t.finish_time,
               numtodsinterval(t.finish_time - t.start_time, 'day') elapsed_time,
               (select dbms_lob.substr(ttr.details, 2000)
                from   bars.tms_task_run_tracking ttr
                where  ttr.rowid = (select min(tr.rowid) keep (dense_rank last order by tr.id)
                                    from   bars.tms_task_run_tracking tr
                                    where  tr.task_run_id = t.id)) details
        from   bars.tms_task_run t
        left join bars.tms_task tt on tt.id = t.task_id
        where  t.run_id = (select max(r.id) from tms_run r)) d
group by d.id, d.task_name, d.task_statement, d.sequence_number, d.state_id
order by "Результат запуску", d.sequence_number
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMS_RUN_REPORT.sql =========*** End *
PROMPT ===================================================================================== 
