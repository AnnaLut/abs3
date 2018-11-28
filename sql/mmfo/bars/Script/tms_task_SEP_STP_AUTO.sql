declare 
 l_1 integer;
 l_seq_num   tms_task.sequence_number%type;
begin 
   select max(SEQUENCE_NUMBER)
    into l_seq_num
    from TMS_TASK;


 l_1:=tms_utl.create_task(p_task_code => 'STP_AUTO',
                                      p_task_group_id => 1,
                                      p_sequence_number => l_seq_num + 1,
                                      p_task_name => 'Відключення СТП=1 по платежам СЕП',
                                      p_task_description => 'Відключення параметру STP_AUTO для платежів СЕП',
                                      p_separate_by_branch_mode => 3,
                                      p_action_on_failure => 1,
                                      p_task_statement => 'begin sep_utl.set_STP_AUTO(0); end;'
                                      );
end;
/
commit;
/
