declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin
  bc.home; 
  
  l_file_code := '#6E';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => 'C'
  , p_file_tp          => 1
  , p_file_nm          => '(xml) 6EX Äàí³ äëÿ ğîçğàõóíêó êîåô³ö³ºíòà ïîêğèòòÿ ë³êâ³äí³ñòş (LCR)'
  , p_file_fmt         => 'XML'
  , p_scm_num          => '03'
  , p_unit_code        => '01'
  , p_period_tp        => 'M'
  , p_location_code    => '1'
  , p_file_code_alt    => null
  , p_cnsl_tp          => '4'
  , p_val_tp_ind       => 'N'
  , p_view_nm          => 'V_NBUR_6EX'
  , p_f_turns          => 0
  );

  dbms_output.put_line( 'Created new file #' || to_char(l_file_id) );

  for l in ( select *
               from NBUR_REF_FILES_LOCAL
              where FILE_ID in (
			         select id
                                 from nbur_ref_files
                                 where file_code = '#A7'  
			       )
           )
  loop
    NBUR_FILES.SET_FILE_LOCAL
    ( p_kf        => l.KF
    , p_file_id   => l_file_id
    , p_file_path => l.FILE_PATH
    , p_nbuc      => l.NBUC
    , p_e_address => l.E_ADDRESS
    );
  end loop;


  NBUR_FILES.SET_FILE_PROC
  ( p_proc_id => l_proc_id
   , p_file_id => l_file_id
   , p_proc_type => 'F'
   , p_proc_active => 'Y'
   , p_scheme => 'BARS'
   , p_proc_name => 'NBUR_P_F6EX_NC'
   , p_description => '(xml) 6EX Äàí³ äëÿ ğîçğàõóíêó êîåô³ö³ºíòà ïîêğèòòÿ ë³êâ³äí³ñòş (LCR)'
   , p_version => '1.0'
   , p_date_start => date '2015-01-01'
   );

  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => NBUR_OBJECTS.F_GET_OBJECT_ID_BY_NAME('NBUR_DM_ACCOUNTS')
  , p_strt_dt => date '2015-01-01'
  );

  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => NBUR_OBJECTS.F_GET_OBJECT_ID_BY_NAME('NBUR_DM_CUSTOMERS')
  , p_strt_dt => date '2015-01-01'
  );

  NBUR_FILES.SET_OBJECT_DEPENDENCIES
  ( p_file_id => l_file_id
  , p_obj_id  => NBUR_OBJECTS.F_GET_OBJECT_ID_BY_NAME('NBUR_DM_BALANCES_DAILY')
  , p_strt_dt => date '2015-01-01'
  );
end;
/
commit;
