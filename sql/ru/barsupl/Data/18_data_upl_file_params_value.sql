
begin
     insert into upl_file_param_values
     select distinct f.file_id, 'UPL_METHOD' param, 'BUFF' value
       from upl_files f,
            UPL_FILEGROUPS_RLN r
      where f.file_id = r.file_id
        and r.group_id in (15,16,17);
exception when dup_val_on_index then null; 
end;
/

COMMIT;

