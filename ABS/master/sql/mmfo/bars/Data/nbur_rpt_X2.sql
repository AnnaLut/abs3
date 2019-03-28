declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin
  bc.home;
  
  l_file_code := '#X2';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#42';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '#42 (КОНСОЛІДОВАНИЙ) Данi щодо максимального ризику на одного контрагента'
  , p_file_fmt         => 'TXT'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => r_file.UNIT_CODE
  , p_period_tp        => r_file.PERIOD_TYPE
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => '#42'
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_'||l_file_code
  , p_f_turns          => r_file.flag_turns
  );
  
  if l_file_id is not null then
      dbms_output.put_line( 'Created new file #' || to_char(l_file_id) );

      for l in ( select *
                   from NBUR_REF_FILES_LOCAL
                  where FILE_ID = r_file.ID 
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
       , p_proc_type => 'O'
       , p_proc_active => 'Y'
       , p_scheme => 'BARS'
       , p_proc_name => 'NBUR_P_FX2_NC'
       , p_description => r_file.FILE_NAME
       , p_version => '1.0'
       , p_date_start => date '2015-01-01'
       );

      --Удалим все ранее привязанные к отчету объекты, если такие были
      NBUR_FILES.SET_OBJECT_DEPENDENCIES
      ( 
        p_file_id => l_file_id
        , p_obj_id => null
        , p_strt_dt => date '2015-01-01'
      );

      NBUR_FILES.SET_FILE_DEPENDENCIES
      ( p_file_id  => l_file_id
      , p_file_pid => null
      );
      
      delete from NBUR_REF_FORM_STRU where file_id = l_file_id;
      insert into NBUR_REF_FORM_STRU
      select l_file_id, SEGMENT_NUMBER, SEGMENT_CODE, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE
      from NBUR_REF_FORM_STRU
      where file_id = r_file.id;
      commit;
      
      NBUR_FILES.SET_FILE_VIEW(p_file_id  => l_file_id );
      commit;
  end if;

end;
/
commit;

