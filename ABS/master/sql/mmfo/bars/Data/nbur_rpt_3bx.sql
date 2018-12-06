Prompt     create   file   3BX

exec bc.home;

DECLARE 
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;

BEGIN 
  
  l_file_code := '3BX';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#3B';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '3BX - Дані фінансової звітністі боржників банку'
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => r_file.UNIT_CODE
  , p_period_tp        => r_file.PERIOD_TYPE
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_3BX'
  , p_f_turns          => r_file.flag_turns
  );

    
  for k in ( select *  from NBUR_REF_FILES_LOCAL
             where FILE_ID = r_file.ID
  ) loop 
      NBUR_FILES.SET_FILE_LOCAL
      ( p_kf        => k.KF
      , p_file_id   => l_file_id
      , p_file_path => k.FILE_PATH
      , p_nbuc      => k.NBUC
      , p_e_address => k.E_ADDRESS
      );
  end loop;
  
  NBUR_FILES.SET_FILE_PROC
  ( p_proc_id => l_proc_id
   , p_file_id => l_file_id
   , p_proc_type => 'O'
   , p_proc_active => 'Y'
   , p_scheme => 'BARS'
   , p_proc_name => 'NBUR_P_F3BX_NC'
   , p_description => '3B XML-формат'
   , p_version => 'v.18.001'
   , p_date_start => date '2017-01-01'
   );

       
  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => null
  , p_strt_dt => date '2017-01-01'
  );

  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file.ID
  );

-- встановимо дату початку вручну (попередня процедура встановлює початок поточного року)
  update nbur_lnk_files_files
     set START_DATE=to_date('01.01.2017', 'dd.mm.yyyy')
   where file_id=r_file.ID
     and file_dep_id=l_file_id;

  COMMIT; 
END; 
/

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '3BX'; 
    Insert into NBUR_REF_PREPARE_XML
       ( DATE_START, FILE_CODE, DESC_XML )
     Values
       (TO_DATE('01/01/2017 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), '3BX',
'select EKP, F059, F060, F061, 
        K111, K031, F063, F064, S190, F073, F003, Q001, 
        K020, Q026, sum(T100) as T100
    from nbur_log_f3BX t
    where  report_date = :p_rpt_dt and
           kf = :p_kf
    group by EKP, F059, F060, F061, 
        K111, K031, F063, F064, S190, F073, F003, Q001, 
        K020, Q026
    having sum(T100) <> 0
    order by K020, EKP, F059, F060, F061' );

    COMMIT;
end;
/
