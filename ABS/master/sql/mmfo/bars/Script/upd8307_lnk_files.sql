
prompt   update nbur_files_objects -установка связей с витринами для 3MX
BEGIN
    bc.home;

    update nbur_ref_procs
       set version ='v.18.004'
     where file_id = (select id from nbur_ref_files where file_code='#3M');

    delete from nbur_lnk_files_files
     where file_dep_id = (select id from nbur_ref_files where file_code='#3M');

    delete from nbur_lnk_files_objects
     where file_id = (select id from nbur_ref_files where file_code='#3M');

    insert into nbur_lnk_files_objects
             ( file_id, object_id, start_date )
        select (select id from nbur_ref_files where file_code='#3M'),
               object_id, start_date
          from nbur_lnk_files_objects
         where file_id = (select id from nbur_ref_files where file_code='#C9');

    begin
    insert into nbur_lnk_files_objects
             ( file_id, object_id, start_date )
        select (select id from nbur_ref_files where file_code='#3M'),
               object_id, start_date
          from nbur_lnk_files_objects
         where file_id = (select id from nbur_ref_files where file_code='#E2');
    exception
       when dup_val_on_index
          then    null; 
    end;

    COMMIT;

EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/

