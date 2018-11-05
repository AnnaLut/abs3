declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin
  bc.home;
  
  l_file_code := 'I6X';

  select *
    into r_file
    from NBUR_REF_FILES
   where FILE_CODE = '#D6';

  NBUR_FILES.SET_FILE
  ( p_file_id          => l_file_id
  , p_file_code        => l_file_code
  , p_scm_code         => r_file.SCHEME_CODE
  , p_file_tp          => r_file.FILE_TYPE
  , p_file_nm          => '(xml) Дані про процентні ставки за непогашеними сумами депозитів (за класифікаціями видів депозитів та контрагентів)'
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
   , p_proc_name => 'NBUR_P_FI6X_NC'
   , p_description => '(xml) '||r_file.FILE_NAME
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
  , p_file_pid => r_file.ID
  );

end;
/
commit;

-- опис для підготовки XML
begin
    delete from NBUR_REF_PREPARE_XML WHERE FILE_CODE = 'I6X'; 
    Insert into NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START)
     Values
   ('I6X', 'select * from (
                    select EKP, KU, T020, R020, R011, R030, K040, K072, K111, 
                           S183, S241, F048, 
                           to_char(sum(T070)) as T070, 
                           trim(to_char(sum(T070 * T090) / sum(T070), ''fm9990.0000'')) as T090
                    from nbur_log_fI6X 
                    where report_date = :p_rpt_dt
                               and kf = :p_kf 
                    group by  EKP, KU, T020, R020, R011, R030, K040, K072, K111, 
                           S183, S241, F048
                    having sum(T070) <> 0 )', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));    
    COMMIT;
end;
/

begin
    delete from NBUR_REF_EKP_R020 where file_code = 'I6X';
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('AI61F2', 'Сума середніх залишків  за депозитами та розрахована процентна ставка', 'I010 (F2);
        T020 (1, 2);
        R020 (1602, 1608, 1610, 1613, 1616, 1618, 2512, 2513, 2518, 2520, 2523, 2525, 2526, 2528, 2530, 2531, 2538, 2541, 2542, 2544, 2545, 2546, 2548, 2550, 2551, 2552, 2553, 2554, 2555, 2556, 2558, 2560, 2561, 2562, 2565, 2568, 2570, 2571, 2572, 2601, 2602, 2603, 2604, 2606, 2608, 2610, 2611, 2616, 2618, 2622, 2628, 2630, 2636, 2638, 2640, 2641, 2642, 2643, 2644, 2651, 2654, 2656, 2658, 3650, 3651, 3652, 3659)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('AI62F2', 'Сума середніх залишків за депозитами на вимогу та розрахована процентна ставка', 'I010 (F2);
        T020 (1, 2);
        R020 (1600, 2600, 2605, 2620, 2625, 2650, 2655)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
--        
--    Insert into NBUR_REF_EKP_R020
--       (EKP, DSC, DESC_R020, DATE_START)
--     Values
--       ('AI63N7', 'Сума визнаних процентних витрат (реальні дебетові обороти без врахування переоцінки курсової різниці)', 'I010 (F2);
--        T020 (5);
--        R020 (1600, 1602, 1608, 1610, 1613, 1616, 1618, 2512, 2513, 2518, 2520, 2523, 2525, 
--        2526, 2528, 2530, 2531, 2538, 2541, 2542, 2544, 2545, 2546, 2548, 2550, 2551, 2552, 
--        2553, 2554, 2555, 2556, 2558, 2560, 2561, 2562, 2565, 2568, 2570, 2571, 2572, 2600, 
--        2601, 2602, 2603, 2604, 2605, 2606, 2608, 2610, 2611, 2616, 2618, 2620, 2622, 2625, 
--        2628, 2630, 2636, 2638, 2640, 2641, 2642, 2643, 2644, 2650, 2651, 2654, 2655, 2656, 
--        2658, 3650, 3651, 3652, 3659)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));

    COMMIT;
end;
/

