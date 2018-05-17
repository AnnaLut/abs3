begin
    update tms_task set SEQUENCE_NUMBER = 287 where id = 283  and task_code = 'RKO2';
exception 
 when dup_val_on_index then null;
end;
/

commit;
