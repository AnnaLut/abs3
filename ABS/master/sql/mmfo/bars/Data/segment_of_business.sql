begin 
    insert into segment_of_business (id, segment_code, segment_name)
    values (1, 'SMB_DEPOSIT', '�������� ����');
    commit;
    exception 
       when dup_val_on_index then null;
end;
/