Prompt     create   file   A4X

exec bc.home;

DECLARE 
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;

BEGIN 
  
  l_file_code := 'A4X';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#A4';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => 'A4X - ���i ��� ������� �� �i��i ��������i ������� (���������i 6,7 ����)'
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => r_file.UNIT_CODE
  , p_period_tp        => 'Q'
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_A4X'
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
   , p_proc_name => 'NBUR_P_FA4X_NC'
   , p_description => 'A4 XML-������'
   , p_version => 'v.19.001'
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

-- ���������� ���� ������� ������ (��������� ��������� ���������� ������� ��������� ����)
  update nbur_lnk_files_files
     set START_DATE=to_date('01.01.2017', 'dd.mm.yyyy')
   where file_id=r_file.ID
     and file_dep_id=l_file_id;

  COMMIT; 
END; 
/

-- ���� ��� ��������� XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = 'A4X'; 
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START,ATTR_NIL)
     Values
       ('A4X', 'select EKP, KU, R020, T020, R030, K040, 
                sum(T070) as T070, sum(T071) as T071
    from nbur_log_fA4X t 
    where  report_date = :p_rpt_dt and 
           kf = :p_kf 
    group by EKP, KU, R020, T020, R030, K040', 
    TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'),
    null);
    COMMIT;
end;
/
