declare
   l_seq_num number; 
   l_id number;
begin
  select max(SEQUENCE_NUMBER) + 1
    into l_seq_num
    from TMS_TASK;

  l_id := TMS_UTL.CREATE_OR_REPLACE_TASK
         ( p_task_code               => 'T00_STATS'
         , p_task_group_id           => TMS_UTL.TASK_GROUP_BEFORE_FINISH -- на фініші дня
         , p_sequence_number         => l_seq_num 
         , p_task_name               => 'Накопичення інформації для звіту по транзитах'
         , p_task_description        => 'Накопичення інформації для звіту по транзитах'
         , p_separate_by_branch_mode => 3 -- TMS_UTL.BRANCH_PROC_MODE_PARALLEL
         , p_action_on_failure       => TMS_UTL.ACTION_ON_FAILURE_PROCEED
         , p_task_statement          => 'begin t00_stats_report.get_t00_report(gl.bd); end;'
         );
  commit;


end;
/

