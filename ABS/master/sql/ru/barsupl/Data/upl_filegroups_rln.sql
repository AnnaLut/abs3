prompt BPK2 into 10 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (10, 4, 4);
exception
  when dup_val_on_index then null;
end;
/
prompt CLIENTFO2 into 10 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (10, 10054, 99442);
exception
  when dup_val_on_index then null;
end;
/
prompt CLIENTADDRESS into 10 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (10, 10055, 99443);
exception
  when dup_val_on_index then null;
end;
/
prompt DEPOSITS_PLT into 10 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (10, 10052, 10055);
exception
  when dup_val_on_index then null;
end;
/

prompt CUST_REL_S into 10 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (10, 6, 6);
exception
  when dup_val_on_index then null;
end;
/

prompt CREDITS_ZAL into 10 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (10, 8, 8);
exception
  when dup_val_on_index then null;
end;
/


commit;
/
prompt BPK2 into 11 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 4, 5);
exception
  when dup_val_on_index then null;
end;
/
prompt CLIENTFO2 into 11 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 10054, 99444);
exception
  when dup_val_on_index then null;
end;
/
prompt CLIENTADDRESS into 11 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 10055, 99445);
exception
  when dup_val_on_index then null;
end;
/
prompt DEPOSITS_PLT into 11 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 10052, 10055);
exception
  when dup_val_on_index then null;
end;
/

prompt CUST_REL_S into 11 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 6, 7);
exception
  when dup_val_on_index then null;
end;
/

prompt CREDITS_ZAL into 11 group
begin
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 8, 9);
exception
  when dup_val_on_index then null;
end;
/

commit;
/