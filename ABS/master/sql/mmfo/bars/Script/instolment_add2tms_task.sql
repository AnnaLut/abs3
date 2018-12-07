declare
l_id number;
begin
l_id:=tms_utl.create_or_replace_task(
        p_task_code => 'CLOSE_INST_ACC',
        p_task_group_id => 1,
        p_sequence_number => 70,
        p_task_name => 'Закриття договорів Інстолмент',
        p_task_description => null,
        p_separate_by_branch_mode => 1,
        p_action_on_failure => 1,
        p_task_statement => 'begin bars_ow.close_inst_acc; end;');
dbms_output.put_line(l_id);
commit;  
end;
/
declare
l_id number;
begin
l_id:=tms_utl.create_or_replace_task(
        p_task_code => 'SET_INST_OVD_90_DAYS',
        p_task_group_id => 1,
        p_sequence_number => 70,
        p_task_name => 'Встановлення ознаки прстрочки 90 днів Інстолмент',
        p_task_description => null,
        p_separate_by_branch_mode => 1,
        p_action_on_failure => 1,
        p_task_statement => 'begin bars_ow.set_inst_ovd_90_days; end;');
dbms_output.put_line(l_id);
commit;    
end;
/