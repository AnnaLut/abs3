
   update NBUR_REF_PREPARE_XML
      set desc_xml =
'select ''A3K001'' as EKP
         , ekp_2                as Q003_1
         , F091                 as F091
         , R030                 as R030
         , T071                 as T071
         , K020                 as K020
         , K021                 as K021
         , K030                 as K030
         , Q001                 as Q001
         , Q024                 as Q024
         , D100                 as D100
         , S180                 as S180
         , F089                 as F089
         , F092                 as F092
         , Q003                 as Q003_2
         , Q007                 as Q007_1
         , Q006                 as Q006
  from ( select *
from ( select substr(field_code,5,3) ekp_2,
            substr(field_code,1,4) ekp_1, field_value znap
       from nbur_agg_protocols
      where report_code = ''#3K''
        and report_date = :p_rpt_dt
        and kf = :p_kf
  )
   pivot
  ( max(trim(znap))
    for ekp_1 in ( ''F091'' as F091, ''R030'' as R030, ''T071'' as T071,
                   ''K020'' as K020, ''K021'' as K021, ''K030'' as K030,
                   ''Q001'' as Q001, ''Q024'' as Q024, ''D100'' as D100,
                   ''S180'' as S180, ''F089'' as F089, ''F092'' as F092,
                   ''Q003'' as Q003, ''Q007'' as Q007, ''Q006'' as Q006 )
  ) )'
    where file_code ='#3K';


update f092
   set txt = 'купівля за власними операціями (у тому числі купівля валюти з метою збільшення валютної позиції банку)',
       d_mode = to_date ('20181229','yyyymmdd')
 where f092 ='164';

update f092
   set txt = 'продано власні кошти (у тому числі продано валюту з метою зменшення валютної позиції банку)',
       d_mode = to_date ('20181229','yyyymmdd')
 where f092 ='215';

commit;

