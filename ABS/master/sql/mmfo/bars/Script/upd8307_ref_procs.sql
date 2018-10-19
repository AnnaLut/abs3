
prompt   update nbur_ref_procs -изменение типа и версии процедуры для 3MX
BEGIN
    bc.home;

    update nbur_ref_procs
       set proc_type ='F', version ='v.18.003'
     where file_id = (select id from nbur_ref_files where file_code='#3M');

    COMMIT;

EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/
