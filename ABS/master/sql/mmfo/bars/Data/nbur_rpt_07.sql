declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin
  l_file_code := '07X';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#'||substr(l_file_code,1,2);

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '(xml) '||r_file.FILE_NAME
  , p_file_fmt         => 'XML'
  , p_scm_num          => r_file.SCHEME_NUMBER
  , p_unit_code        => r_file.UNIT_CODE
  , p_period_tp        => r_file.PERIOD_TYPE
  , p_location_code    => r_file.LOCATION_CODE
  , p_file_code_alt    => null
  , p_cnsl_tp          => r_file.CONSOLIDATION_TYPE
  , p_val_tp_ind       => r_file.VALUE_TYPE_IND
  , p_view_nm          => 'V_NBUR_'||l_file_code
  , p_f_turns          => r_file.flag_turns
  );

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
   , p_proc_name => 'NBUR_P_F07X_NC'
   , p_description => '(xml) '||r_file.FILE_NAME
   , p_version => '1.0'
   , p_date_start => date '2015-01-01'
   );

  NBUR_FILES.SET_FILE_DEPENDENCIES
  ( p_file_id  => l_file_id
  , p_file_pid => r_file.ID
  );

end;
/
commit;

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '07X'; 
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START)
     Values
       ('07X', 'select KU, EKP, Q003, Q130, S130, T020, R020, R011, K040, K072, S183, S240, R030, sum(T100) as T100 
    from nbur_log_f07x t 
    where  report_date = :p_rpt_dt and 
           kf = :p_kf and
           ekp <> ''XXXXXX'' 
    group by KU, EKP, Q003, Q130, S130, T020, R020, R011, K040, K072, S183, S240, R030
     having sum(T100) <> 0', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/   

-- опис показникґв 
begin
    delete from BARS.NBUR_REF_EKP_R020 WHERE FILE_CODE = '07X'; 
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A07F32', 'Сума залишків за борговими цінними паперами', 'I010 (F3);
    T020 (1, 2);  
    R020 (1400, 1401, 1402, 1403, 1404, 1405, 1406, 1408, 1410, 1411, 1412, 1413, 1414, 
    1415, 1416, 1418, 1420, 1421, 1422, 1423, 1424, 1426, 1428, 3010, 3011, 3012, 3013, 
    3014, 3015, 3016, 3018, 3110, 3111, 3112, 3113, 3114, 3115, 3116, 3118,  3210, 3211, 
    3212, 3213, 3214, 3216, 3218)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A07F31', 'Кількість боргових цінних паперів', 'I010 (F3, F8);
    T020 (0);  
    R020 (1400, 1401, 1402, 1403, 1404, 1405, 1406, 1408, 1410, 1411, 1412, 1413, 1414, 
    1415, 1416, 1418, 1420, 1421, 1422, 1423, 1424, 1426, 1428, 3010, 3011, 3012, 3013, 
    3014, 3015, 3016, 3018, 3110, 3111, 3112, 3113, 3114, 3115, 3116, 3118, 3210, 3211, 
    3212, 3213, 3214, 3216, 3218, 1419, 1429, 3119, 3219)', 
    TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A07F51', 'Кількість акцій та інших пайових цінних паперів', 'I010 (F5);
    T020 (0);  
    R020 (3002, 3003, 3005, 3007, 3008, 3102, 3103, 3105, 3107, 3108, 3412, 3413, 3415, 
    3418, 3422, 3423, 3425, 3428, 4102, 4103, 4105, 4108, 4202, 4203, 4205, 4208)', 
    TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A07F82', 'Сума залишків  за резервами під заборгованість за борговими цінними паперами', 'I010 (F8);
    T020 (1, 2);  
    R020 (1419, 1429, 3119, 3219)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A07F52', 'Сума залишків  за капіталом і акціями інвестиційних фондів', 'I010 (F5);
    T020 (1, 2);  
    R020 (3002, 3003, 3005, 3007, 3008, 3102, 3103, 3105, 3107, 3108, 3412, 3413, 3415, 
    3418, 3422, 3423, 3425, 3428, 4102, 4103, 4105, 4108, 4202, 4203, 4205, 4208)', 
    TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/
    
