declare 
 l_1 integer;
 l_seq_num   tms_task.sequence_number%type;
begin 
   select max(SEQUENCE_NUMBER)
    into l_seq_num
    from TMS_TASK;


 l_1:=tms_utl.create_task(p_task_code => 'BPK_DATEOFKK',
                                      p_task_group_id => 1,
                                      p_sequence_number => l_seq_num + 1,
                                      p_task_name => 'Кредити БПК - прострочені',
                                      p_task_description => 'Заповнення параметру DATEOFKK по простроченим кредитам БПК',
                                      p_separate_by_branch_mode => 3,
                                      p_action_on_failure => 1,
                                      p_task_statement => 'begin bpk_credits.set_accw_DATEOFKK; end;'
                                      );
end;
/
commit;
