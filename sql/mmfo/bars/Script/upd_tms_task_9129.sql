update tms_task t set t.task_statement = 'begin cck.cc_9129(gl.bdate, 0, 0); end;'  where t.task_code = '054';

update tms_task t set t.task_statement = 'begin cck.cc_9129(gl.bdate, 0, 2); end;'  where t.task_code = '055';

update tms_task t set t.task_statement = 'begin cck.cc_9129(gl.bdate, 0, 3); end;'  where t.task_code = '056';

commit;