declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin
  bc.home;
  
  l_file_code := '36X';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#6E';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '(xml) 36X Дані про резидентів–суб’єктів зовн-економ. діяль-ті, які порушили строки'
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
  
  l_file_id := nvl(l_file_id, 35154);
  
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
   , p_proc_name => 'NBUR_P_F36X_NC'
   , p_description => '(xml) '||r_file.FILE_NAME
   , p_version => '1.0'
   , p_date_start => date '2015-01-01'
   );
   
   update NBUR_REF_FILES
   set file_code = '#36'
   where id = l_file_id;

end;
/
commit;

-- опис для підготовки XML
begin
    delete from NBUR_REF_PREPARE_XML WHERE FILE_CODE = '#36'; 
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START)
     Values
       ('#36', 'select EKP, KU, B040, F021, K020, K021, 
                    Q001_1, Q002, Q003_2, Q003_3, 
                    to_char(Q007_1, ''dd.mm.yyyy'') as Q007_1, 
                    Q001_2, K040, D070, F008, K112, 
                    to_char(Q007_5, ''dd.mm.yyyy'') as Q007_5,                     
                    to_char(Q007_2, ''dd.mm.yyyy'') as Q007_2, 
                    F019, F020, R030, T071, T070, Q006, Q023,
                    to_char(Q007_3, ''dd.mm.yyyy'') as Q007_3, 
                    to_char(Q007_4, ''dd.mm.yyyy'') as Q007_4 
            from nbur_log_f36X 
            where report_date = :p_rpt_dt
                       and kf = :p_kf ', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/

