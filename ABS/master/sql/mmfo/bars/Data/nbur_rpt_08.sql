exec bc.home;

declare
  r_file        nbur_ref_files%rowtype;
  l_file_id     nbur_ref_files.id%type;
  l_file_code   nbur_ref_files.file_code%type;
  l_proc_id     nbur_ref_procs.id%type;
begin

  l_file_code := '08X';

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
   , p_proc_name => 'NBUR_P_F08X_NC'
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

SET DEFINE OFF;

-- опис для підготовки XML
begin
    delete from BARS.NBUR_REF_PREPARE_XML WHERE FILE_CODE = '08X'; 
    Insert into BARS.NBUR_REF_PREPARE_XML
       (FILE_CODE, DESC_XML, DATE_START)
     Values
       ('08X', 'select KU, T020, R020, R011, R030, K040, K072, S130, S183, ekp, sum(T070) as T070 
    from nbur_log_f08x t 
    where  report_date = :p_rpt_dt  and kf = :p_kf
    group by KU, T020, R020, R011, R030, K040, K072, S130, S183, ekp
     having sum(T070) <> 0', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/

-- опис показників 
begin
    delete from BARS.NBUR_REF_EKP_R020 WHERE FILE_CODE = '08X'; 

    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A08F30', 'Сума залишків за випущеними борговими цінними паперами', 'I010 (F3);
        T020 (1, 2);
        R020 (3300, 3301, 3303, 3305, 3306, 3308, 3310, 3313, 3314, 3315, 3316, 3318, 3320, 3326, 3328, 3330, 3335, 3336, 3338, 3380, 3385, 3386, 3388)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A08F40', 'Сума залишків за кредитами', 'I010 (F4);
        T020 (1, 2);
        R020 (1621, 1622, 1623, 1626, 1628, 2701, 2706, 2708)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A08F50', 'Сума залишків за випущеними привілейованими акціями', 'I010 (F5);
        T020 (1, 2);
        R020 (3370, 3376, 3378)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A08F70', 'Сума залишків  за похідними фінансовими інструментами та опціонами на придбання акцій працівниками', 'I010 (F7);
        T020 (1, 2);
        R020 (3040, 3041, 3042, 3043, 3044, 3049, 3140, 3141, 3142, 3143, 3144, 3350, 3351, 3352, 3353, 3354, 3359, 3360, 3361, 3362, 3363, 3364)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A08F80', 'Сума залишків за іншою дебіторською/кредиторською заборгованістю', 'I010 (F8);
    T020 (1, 2);  
    R020 (1811, 1819, 1911, 1912, 1919, 2800, 2801, 2805, 2806, 2809, 2900, 2901, 2902, 2903, 2904, 2905, 2906, 2907, 2908, 2909, 2920, 2924, 3500, 3510, 3511, 3519, 3520, 3521, 3522, 3540, 3541, 3542, 3548, 3550, 3551, 3552, 3559, 3570, 3578, 3600, 3610, 3611, 3615, 3619, 3620, 3621, 3622, 3623, 3631, 3640, 3641, 3642, 3647, 3648, 3653, 3654, 3658, 3670, 3678)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A08N60', 'Сума залишків за рахунками доходів', 'I010 (N6);
        T020 (1, 2);
        R020 (6000, 6002, 6003, 6010, 6011, 6012, 6013, 6014, 6015, 6016, 6017, 6018, 6019, 6020, 6021, 6022, 6023, 6024, 6025, 6026, 6027, 6030, 6031, 6032, 6033, 6034, 6035, 6040, 6041, 6042, 6043, 6044, 6045, 6046, 6047, 6050, 6052, 6053, 6054, 6055, 6060, 6061, 6062, 6063, 6070, 6071, 6072, 6073, 6074, 6075, 6076, 6077, 6078, 6079, 6080, 6081, 6082, 6083, 6084, 6085, 6086, 6087, 6090, 6091, 6092, 6093, 6094, 6095, 6096, 6100, 6101, 6102, 6103, 6104, 6105, 6106, 6107, 6110, 6111, 6112, 6113, 6120, 6121, 6122, 6123, 6124, 6125, 6126, 6127, 6128, 6130, 6140, 6141, 6300, 6301, 6302, 6303, 6397)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    Insert into NBUR_REF_EKP_R020
       (EKP, DSC, DESC_R020, DATE_START)
     Values
       ('A08N70', 'Сума залишків за рахунками витрат ', 'I010 (N7);
        T020 (1, 2);
        R020 (7000, 7002, 7003, 7004, 7006, 7010, 7011, 7012, 7014, 7015, 7016, 7017, 7020, 7021, 7028, 7030, 7040, 7041, 7060, 7070, 7071, 7120, 7121, 7122, 7123, 7124, 7125, 7130, 7140, 7141, 7397)', TO_DATE('01/01/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'));
    COMMIT;
end;
/
