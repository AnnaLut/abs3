

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TMS_RUN_REPORT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TMS_RUN_REPORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TMS_RUN_REPORT ("�������������� �����", "������� ������", "������� ���������", "��������� ���", "��� ������ ��������", "��������", "����� ���������", "��������� �������", "��� �� ������� ��������", "��������� ����������", "��������� ���", "��������� ���", "��������� ��������", "����������� ��������", "��� ������� �������", "��� ���������� �������", "��� ������� ����������", "��� ���������� ����������", "������������� ���������", "���� ��������� ���������") AS 
  SELECT listagg(d.task_run_id, ',') within group (order by d.branch) task_run_ids,
           MIN (MIN (d.start_time)) OVER () "������� ������",
            MAX (MAX (d.start_time)) OVER ()
               "������� ���������",
               TO_CHAR (
                  EXTRACT (
                     HOUR FROM NUMTODSINTERVAL (
                                    MAX (MAX (d.start_time)) OVER ()
                                  - MIN (MIN (d.start_time)) OVER (),
                                  'day')),
                  'fm900')
            || ':'
            || TO_CHAR (
                  EXTRACT (
                     MINUTE FROM NUMTODSINTERVAL (
                                      MAX (MAX (d.start_time)) OVER ()
                                    - MIN (MIN (d.start_time)) OVER (),
                                    'day')),
                  'fm00')
            || ':'
            || TO_CHAR (
                  EXTRACT (
                     SECOND FROM NUMTODSINTERVAL (
                                      MAX (MAX (d.start_time)) OVER ()
                                    - MIN (MIN (d.start_time)) OVER (),
                                    'day')),
                  'fm00')
               "��������� ���",
               TO_CHAR (
                  EXTRACT (
                     HOUR FROM NUMTODSINTERVAL (
                                  SUM (MAX (d.finish_time - d.start_time))
                                     OVER (),
                                  'day')),
                  'fm900')
            || ':'
            || TO_CHAR (
                  EXTRACT (
                     MINUTE FROM NUMTODSINTERVAL (
                                    SUM (MAX (d.finish_time - d.start_time))
                                       OVER (),
                                    'day')),
                  'fm00')
            || ':'
            || TO_CHAR (
                  EXTRACT (
                     SECOND FROM NUMTODSINTERVAL (
                                    SUM (MAX (d.finish_time - d.start_time))
                                       OVER (),
                                    'day')),
                  'fm00')
               "��� ������ ��������",
            d.sequence_number "��������",
            d.task_name "����� ���������",
            bars.list_utl.get_item_name ('BANKDATE_TASK_RUN_STATE', d.state_id)
               "��������� �������",
            LISTAGG (
                  d.branch
               || ' : '
               || TO_CHAR (EXTRACT (HOUR FROM d.elapsed_time), 'fm990')
               || ':'
               || TO_CHAR (EXTRACT (MINUTE FROM d.elapsed_time), 'fm00')
               || ':'
               || TO_CHAR (EXTRACT (SECOND FROM d.elapsed_time), 'fm00')
               || CHR (10))
            WITHIN GROUP (ORDER BY d.branch)
               "��� �� ������� ��������",
            LISTAGG (
                  CASE
                     WHEN d.details IS NULL THEN NULL
                     ELSE d.branch || CHR (10)
                  END
               || d.details)
            WITHIN GROUP (ORDER BY d.branch)
               "��������� ����������",
               TO_CHAR (EXTRACT (HOUR FROM MIN (d.elapsed_time)), 'fm900')
            || ':'
            || TO_CHAR (EXTRACT (MINUTE FROM MIN (d.elapsed_time)), 'fm00')
            || ':'
            || TO_CHAR (EXTRACT (SECOND FROM MIN (d.elapsed_time)), 'fm00')
               "��������� ���",
               TO_CHAR (EXTRACT (HOUR FROM MAX (d.elapsed_time)), 'fm900')
            || ':'
            || TO_CHAR (EXTRACT (MINUTE FROM MAX (d.elapsed_time)), 'fm00')
            || ':'
            || TO_CHAR (EXTRACT (SECOND FROM MAX (d.elapsed_time)), 'fm00')
               "��������� ���",
            MIN (d.branch) KEEP (DENSE_RANK FIRST ORDER BY d.elapsed_time)
               "��������� ��������",
            MIN (d.branch) KEEP (DENSE_RANK LAST ORDER BY d.elapsed_time)
               "����������� ��������",
            TO_CHAR (MIN (d.start_time), 'hh24:mi:ss')
               "��� ������� �������",
            TO_CHAR (MAX (d.start_time), 'hh24:mi:ss')
               "��� ���������� �������",
            TO_CHAR (MIN (d.finish_time), 'hh24:mi:ss')
               "��� ������� ����������",
            TO_CHAR (MAX (d.finish_time), 'hh24:mi:ss')
               "��� ���������� ����������",
            d.id "������������� ���������",
            d.task_statement "���� ��������� ���������"
       FROM (SELECT t.id task_run_id,
                    tt.id,
                    tt.task_name,
                    tt.task_statement,
                    tt.sequence_number,
                    t.branch,
                    t.state_id,
                    t.start_time,
                    t.finish_time,
                    NUMTODSINTERVAL (t.finish_time - t.start_time, 'day')
                       elapsed_time,
                    (SELECT DBMS_LOB.SUBSTR (ttr.details, 2000)
                       FROM bars.tms_task_run_tracking ttr
                      WHERE ttr.ROWID =
                               (SELECT MIN (tr.ROWID)
                                          KEEP (DENSE_RANK LAST ORDER BY tr.id)
                                  FROM bars.tms_task_run_tracking tr
                                 WHERE tr.task_run_id = t.id))
                       details
               FROM    bars.tms_task_run t
                    LEFT JOIN
                       bars.tms_task tt
                    ON tt.id = t.task_id
              WHERE t.run_id = (SELECT MAX (r.id)
                                  FROM tms_run r)) d
   GROUP BY d.id,
            d.task_name,
            d.task_statement,
            d.sequence_number,
            d.state_id
   ORDER BY "��������� �������", d.sequence_number;

PROMPT *** Create  grants  V_TMS_RUN_REPORT ***
grant SELECT                                                                 on V_TMS_RUN_REPORT to BARSREADER_ROLE;
grant SELECT                                                                 on V_TMS_RUN_REPORT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TMS_RUN_REPORT.sql =========*** End *
PROMPT ===================================================================================== 
