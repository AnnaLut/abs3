
   update NBUR_REF_PREPARE_XML
      set desc_xml =
    'select EKP, Q003_1, K020_1, K021_1, Q001_1, Q029_1,
            K020_2, K021_2, Q001_2, Q029_2, K014, K040, KU_1, K110,
            trim(to_char(T090_1A,''9990.0000'')) as T090_1,
            trim(to_char(T090_2A,''9990.0000'')) as T090_2
       from nbur_log_fD9X t
      where report_date = :p_rpt_dt
        and  kf = :p_kf'
    where file_code ='D9X';

commit;
