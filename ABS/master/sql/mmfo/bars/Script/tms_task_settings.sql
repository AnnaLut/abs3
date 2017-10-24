begin
    -- ��������� ����� ���������� 
    update tms_task t
    set    t.task_statement = 'begin dpt_execute_job(''JOB_PIPL'', null); end;'
    where  t.task_code = '141';

    -- ������������ �'����� ������ �������� ��� ��������� ������� ��������� ����� ��������: ��������� ��������� �������� ������������
    -- ������� ����������� ������� ��� ��������� ������� ���������� �� ����� ����������, �� ����������� �������
    update tms_task t
    set    t.action_on_failure = tms_utl.ACTION_ON_FAILURE_PROCEED
    where  t.task_code = 'AAA';

    update tms_task t
    set    t.action_on_failure = tms_utl.ACTION_ON_FAILURE_PROCEED
    where  t.task_code = '020';

    commit;
end;
/
