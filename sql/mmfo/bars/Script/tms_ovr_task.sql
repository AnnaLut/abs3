begin
    update tms_task t
    set    t.sequence_number = 58
    where  t.task_code = 'OVRN_FINISH';

    update tms_task t
    set    t.sequence_number = 289
    where  t.task_code = 'OVRN_START';

    commit;
end;
/
