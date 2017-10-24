begin
update TMS_TASK t
set t.sequence_number = 284
where t.id = 302 
  and t.task_code = 'ELT';
  commit;
end;
/
