
   update NBUR_REF_PREPARE_XML
      set desc_xml =
'select EKP, KU, sum(T071) as T071, Q003_1, F091, R030, F090, K040, F089, K020, K021,
        K030, Q001_1, B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006
    from nbur_log_f3MX t
    where report_date = :p_rpt_dt
      and kf = :p_kf
    group by EKP, KU, Q003_1, F091, R030, F090, K040, F089, K020, K021,
             K030, Q001_1, B010, Q033, Q001_2, Q003_2, Q007_1, F027, F02D, Q006
    having sum(T071) <> 0
    order by 4'
    where file_code ='#3M';

commit;

