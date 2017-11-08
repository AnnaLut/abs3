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

prompt DEPOSITS2 into 10 group
declare 
l_sql_id number;
l_file_id number;
begin
  select sql_id into l_sql_id from upl_sql where descript = 'CRM, Депозити(пілот)';
  select file_id into l_file_id from upl_files where file_code = 'DEPOSITS2';
  delete from upl_filegroups_rln where FILE_ID = l_file_id and GROUP_ID = 10;
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (10, l_file_id, l_sql_id);
exception
  when dup_val_on_index then null;
end;
/
commit;
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

prompt CUSTEXT into 10, 11 group
begin
  delete from upl_filegroups_rln where group_id in (10, 11) and file_id = 120;
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 120, 120);
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, 120, 1120);
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

prompt DEPOSITS2 into 11 group
declare 
l_sql_id number;
l_file_id number;
begin
  select sql_id into l_sql_id from upl_sql where descript = 'CRM, Депозити(пілот) - MONTH';
  select file_id into l_file_id from upl_files where file_code = 'DEPOSITS2';
  delete from upl_filegroups_rln where FILE_ID = l_file_id and GROUP_ID = 11;
  insert into upl_filegroups_rln(group_id, file_id, sql_id)
  values (11, l_file_id, l_sql_id);
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
prompt fix bpk_plt
delete from upl_filegroups_rln t where t.group_id in (10, 11) and t.file_id = 10051;
insert into upl_filegroups_rln (group_id, file_id, sql_id) values (10, 10051, 10052);
commit;