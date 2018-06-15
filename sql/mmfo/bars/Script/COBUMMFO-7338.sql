begin
  update TMS_TASK t
    set t.sequence_number = 7
  where t.id = 66
    and t.task_code = '041'  ;
end;
/    
commit;
/