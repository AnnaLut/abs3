prompt COBUMMFO-4409 update tms_task 9129 
begin
  update tms_task t set t.task_group_id=1 ,t.task_statement=replace(t.task_statement,'gl.bd','gl.bdate') where t.task_code in ('054','055','056');
  commit;
end;
/