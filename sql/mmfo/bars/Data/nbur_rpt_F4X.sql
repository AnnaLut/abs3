declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin
  l_file_code := 'F4X';

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
   , p_proc_name => 'NBUR_P_FF4X_NC'
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
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = 'F4X'; 
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START)
     Values
       ('F4X', 'select EKP, KU, T020, R020, R011, R030, K072, K111, K140, F074, S180, D020, 
         sum(T070) as T070, round(sum(T070 * T090) / sum(T070), 4) as T090 
    from nbur_log_fF4X t 
    where  report_date = :p_rpt_dt and 
           kf = :p_kf and
           ekp <> ''XXXXXX'' 
    group by EKP, KU, T020, R020, R011, R030, K072, K111, K140, F074, S180, D020
    having sum(T070) <> 0', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/

-- опис показникґв 
begin
    delete from BARS.NBUR_REF_EKP_R020 WHERE FILE_CODE = 'F4X'; 
    Insert into BARS.NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('AF43F4', 'Сума та процентна ставка за рахунками кредитів з дебетовим оборотом', 'I010 (F4);
    T020 (5);  
    R020 (1520, 1521, 1522, 1524, 1532, 1533, 1542, 1543, 2010, 2020, 2030, 2040, 2041, 2042, 2043, 2044, 2045, 2063, 2071, 2083, 2103, 2113, 2123, 2133, 2140, 2141, 2142, 2143, 2203, 2211, 2220, 2233, 2240, 2241, 2242, 2243, 2301, 2303, 2310, 2311, 2320, 2321, 2330, 2331, 2340, 2341, 2351, 2353, 2360, 2361, 2362, 2363, 2370, 2371, 2372, 2373, 2380, 2381, 2382, 2383, 2390, 2391, 2392, 2393, 2394, 2395, 2401, 2403, 2410, 2411, 2420, 2421, 2431, 2433, 2450, 2451, 2452, 2453)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into BARS.NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('AF43F2', 'Сума та процентна ставка за рахунками депозитів з дебетовим оборотом', 'I010 (F2);
    T020 (5);  
    R020 (1600, 2600, 2605, 2620, 2625, 2650, 2655)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into BARS.NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('AF44F2', 'Сума та процентна ставка за рахунками депозитів з кредитовим оборотом', 'I010 (F2);
    T020 (6);  
    R020 (1600, 1602, 1610, 1613, 2525, 2546, 2610, 2611, 2630, 2651, 2600, 2605, 2620, 2625, 2650, 2655)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/