PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_d9x.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_D9X
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP   
       , p.Q003_1
       , p.K020_1
       , p.K021_1
       , p.Q001_1
       , p.Q029_1
       , p.K020_2
       , p.K021_2
       , p.Q001_2
       , p.Q029_2
       , p.K014  
       , p.K040  
       , p.KU_1  
       , p.K110  
       , p.T090_1
       , p.T090_2
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/Q003_1'  ) as Q003_1
               , extractValue( COLUMN_VALUE, 'DATA/K020_1'  ) as K020_1
               , extractValue( COLUMN_VALUE, 'DATA/K021_1'  ) as K021_1
               , extractValue( COLUMN_VALUE, 'DATA/Q001_1'  ) as Q001_1
               , extractValue( COLUMN_VALUE, 'DATA/Q029_1'  ) as Q029_1
               , extractValue( COLUMN_VALUE, 'DATA/K020_2'  ) as K020_2
               , extractValue( COLUMN_VALUE, 'DATA/K021_2'  ) as K021_2
               , extractValue( COLUMN_VALUE, 'DATA/Q001_2'  ) as Q001_2
               , extractValue( COLUMN_VALUE, 'DATA/Q029_2'  ) as Q029_2
               , extractValue( COLUMN_VALUE, 'DATA/K014'    ) as K014  
               , extractValue( COLUMN_VALUE, 'DATA/K040'    ) as K040  
               , extractValue( COLUMN_VALUE, 'DATA/KU_1'    ) as KU_1  
               , extractValue( COLUMN_VALUE, 'DATA/K110'    ) as K110  
               , extractValue( COLUMN_VALUE, 'DATA/T090_1'  ) as T090_1
               , extractValue( COLUMN_VALUE, 'DATA/T090_2'  ) as T090_2
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'D9X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by 2,6,7,9,10;

comment on table  v_nbur_d9x is 'Файл D9X -Дані про найбільших (прямих та опосередкованих) учасників контрагентів банку';
comment on column v_nbur_d9x.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_d9x.KF is 'Фiлiя';
comment on column v_nbur_d9x.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_d9x.EKP    is 'Код показника';                           
comment on column v_nbur_d9x.Q003_1 is 'Умовний порядковий номер запису';         
comment on column v_nbur_d9x.K020_1 is 'Код контрагента';                         
comment on column v_nbur_d9x.K021_1 is 'Ознака коду контрагента';                 
comment on column v_nbur_d9x.Q001_1 is 'Назва контрагента';                       
comment on column v_nbur_d9x.Q029_1 is 'Код контрагента нерезидента';             
comment on column v_nbur_d9x.K020_2 is 'Код учасника контрагента';                
comment on column v_nbur_d9x.K021_2 is 'Ознака коду учасника контрагента';        
comment on column v_nbur_d9x.Q001_2 is 'Назва учасника контрагента';              
comment on column v_nbur_d9x.Q029_2 is 'Код учасника контрагента нерезидента';    
comment on column v_nbur_d9x.K014   is 'Тип учасника контрагента';                
comment on column v_nbur_d9x.K040   is 'Країна учасника контрагента';             
comment on column v_nbur_d9x.KU_1   is 'Регіон реєстрації учасника контрагента';  
comment on column v_nbur_d9x.K110   is 'КВЕД учасника контрагента';               
comment on column v_nbur_d9x.T090_1 is 'Відсоток прямої участі учасника';         
comment on column v_nbur_d9x.T090_2 is 'Відсоток опосередкованої участі учасника';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_d9x.sql =========*** End *** ===
PROMPT ===================================================================================== 

