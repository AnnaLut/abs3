DECLARE 
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;

BEGIN 
  
    l_file_code := '2FX';
    select n.*
    into r_file
    from NBUR_REF_FILES n
   where n.FILE_CODE = '#2F';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '2FX - Дані про оцінку ризиків у сфері фінансового моніторингу'
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => '01'                 
  , p_period_tp        => r_file.PERIOD_TYPE
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_2FX'
  , p_f_turns          => r_file.flag_turns
  );

    
  for k in 
    ( 
      select *  
      from NBUR_REF_FILES_LOCAL
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
   , p_proc_name => 'NBUR_P_F2FX_NC'
   , p_description => '2F XML-формат'
   , p_version => 'v.18.001'
   , p_date_start => date '2018-01-01'
   );

       
  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => null
  , p_strt_dt => date '2018-01-01'
  );

  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file.ID
  );

  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file.ID
  );

  COMMIT; 
END; 
/

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '2FX'; 
    
    Insert into NBUR_REF_PREPARE_XML
       ( DATE_START, FILE_CODE, DESC_XML )
     Values
       ( DATE '2018-01-01','2FX',
       'select  x.EKP, x.D110, x.K014, x.K019, x.K030, x.K040, x.K044, x.KU, x.R030, 
          sum(x.T070_1) as T070_1, 
          sum(x.T070_2) as T070_2,
          sum(x.T100)   as T100
        from nbur_log_f2fx x
        where x.report_date = :p_rpt_dt 
          and x.kf = :p_kf
        group by x.EKP, x.D110, x.K014, x.K019, x.K030, x.K040, x.K044, x.KU, x.R030
        order by x.EKP' 
    );

    COMMIT;
end;
/
