

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMS_RUN_REPORT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMS_RUN_REPORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMS_RUN_REPORT ("������� ������", "������� ���������", "��������� ��� ���������", "��������", "����� ���������", "��������� �������", "��� �� ������� ��������", "��������� ����������", "��������� ���", "��������� ���", "��������� ��������", "����������� ��������", "��� ������� �������", "��� ���������� �������", "��� ������� ����������", "��� ���������� ����������", "������������� ���������", "���� ��������� ���������") AS 
  select min(min(d.start_time)) over () "������� ������",
       max(max(d.start_time)) over () "������� ���������",
       to_char(extract(hour from numtodsinterval(max(max(d.start_time)) over () - min(min(d.start_time)) over (), 'day')), 'fm900') || ':' ||
               to_char(extract(minute from numtodsinterval(max(max(d.start_time)) over () - min(min(d.start_time)) over (), 'day')), 'fm00') || ':' ||
               to_char(extract(second from numtodsinterval(max(max(d.start_time)) over () - min(min(d.start_time)) over (), 'day')), 'fm00') "��������� ��� ���������",
       d.sequence_number "��������",
       d.task_name "����� ���������",
       bars.list_utl.get_item_name('BANKDATE_TASK_RUN_STATE', d.state_id) "��������� �������",
       listagg(d.branch || ' : ' ||
               to_char(extract(hour from d.elapsed_time), 'fm990') || ':' ||
               to_char(extract(minute from d.elapsed_time), 'fm00') || ':' ||
               to_char(extract(second from d.elapsed_time), 'fm00') || chr(10)) within group (order by d.branch) "��� �� ������� ��������",
       listagg(case when d.details is null then null else d.branch || chr(10) end || d.details) within group (order by d.branch) "��������� ����������",
       to_char(extract(hour from min(d.elapsed_time)), 'fm900') || ':' ||
               to_char(extract(minute from min(d.elapsed_time)), 'fm00') || ':' ||
               to_char(extract(second from min(d.elapsed_time)), 'fm00') "��������� ���",
       to_char(extract(hour from max(d.elapsed_time)), 'fm900') || ':' ||
               to_char(extract(minute from max(d.elapsed_time)), 'fm00') || ':' ||
               to_char(extract(second from max(d.elapsed_time)), 'fm00') "��������� ���",
       min(d.branch) keep (dense_rank first order by d.elapsed_time) "��������� ��������",
       min(d.branch) keep (dense_rank last order by d.elapsed_time) "����������� ��������",
       to_char(min(d.start_time), 'hh24:mi:ss') "��� ������� �������",
       to_char(max(d.start_time), 'hh24:mi:ss') "��� ���������� �������",
       to_char(min(d.finish_time), 'hh24:mi:ss') "��� ������� ����������",
       to_char(max(d.finish_time), 'hh24:mi:ss') "��� ���������� ����������",
       d.id "������������� ���������",
       d.task_statement "���� ��������� ���������"

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
order by "��������� �������", d.sequence_number
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMS_RUN_REPORT.sql =========*** End *
PROMPT ===================================================================================== 
