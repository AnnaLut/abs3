
   update NBUR_REF_PREPARE_XML
      set desc_xml =
        'select    EKP
          , B040
          , R020
          , R030_1
          , nvl(R030_2, ''#'') as R030_2 
          , K040
          , S050
          , S184
          , F028
          , nvl(F045, ''#'') as F045
          , nvl(F046, ''#'') as F046
          , nvl(F047, ''#'') as F047
          , nvl(F048, ''#'') as F048
          , nvl(F049, ''#'') as F049
          , nvl(F050, ''#'') as F050
          , nvl(F052, ''#'') as F052
          , nvl(F053, ''#'') as F053
          , nvl(F054, ''#'') as F054
          , nvl(F055, ''#'') as F055
          , nvl(F056, ''#'') as F056
          , F057
          , nvl(F070, ''#'') as F070
          , K020
          , Q001_1 , Q001_2 , Q003_1
          , Q003_2 , Q003_3 , Q006
          , Q007_1 , Q007_2 , Q007_3
          , Q010_1 , Q010_2 , Q012
          , Q013
          , Q021
          , Q022a   as Q022
          , T071
    from   nbur_log_f4px
    where  report_date = :p_rpt_dt
          and kf = :p_kf '
    where file_code ='#4P';

commit;

