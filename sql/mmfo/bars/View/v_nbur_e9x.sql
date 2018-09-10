PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_e9x.sql =========*** Run *** ===
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_e9x ***

create or replace view v_nbur_E9X 
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF as NBUC
       , null as FIELD_CODE
       , t.EKP
       , t.D060_1
       , t.K020
       , t.K021
       , t.F001
       , t.F098
       , t.R030
       , t.K040_1
       , t.KU_1
       , t.K040_2
       , t.KU_2
       , t.D060_2
       , t.Q001
       , t.T071
       , t.T080
from   (select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/D060_1') as D060_1
               , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020
               , extractValue( COLUMN_VALUE, 'DATA/K021'  ) as K021
               , extractValue( COLUMN_VALUE, 'DATA/F001'  ) as F001
               , extractValue( COLUMN_VALUE, 'DATA/F098'  ) as F098
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/K040_1') as K040_1
               , extractValue( COLUMN_VALUE, 'DATA/KU_1'  ) as KU_1               
               , extractValue( COLUMN_VALUE, 'DATA/K040_2') as K040_2               
               , extractValue( COLUMN_VALUE, 'DATA/KU_2'  ) as KU_2
               , extractValue( COLUMN_VALUE, 'DATA/T071'  ) as T071
               , extractValue( COLUMN_VALUE, 'DATA/T080'  ) as T080
               , extractValue( COLUMN_VALUE, 'DATA/D060_2') as D060_2
               , extractValue( COLUMN_VALUE, 'DATA/Q001'  ) as Q001
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = 'E9X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;

comment on table v_nbur_e9x is 'Файл E9X - Перекази з використанням систем переказу коштів';
comment on column v_nbur_e9x.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_e9x.KF is 'Фiлiя';
comment on column v_nbur_e9x.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_e9x.FIELD_CODE is 'Зведений код показника';
comment on column v_nbur_e9x.NBUC is 'Код МФО';
comment on column v_nbur_e9x.EKP is 'Код показника';
comment on column v_nbur_e9x.D060_1 is 'Код системи переказу коштів';
comment on column v_nbur_e9x.K020 is 'Код відправника/отримувача';
comment on column v_nbur_e9x.K021 is 'Код ознаки ідентифікаційного коду';
comment on column v_nbur_e9x.F001 is 'Код учасників переказу коштів';
comment on column v_nbur_e9x.F098 is 'Код типу переказу';
comment on column v_nbur_e9x.R030 is 'Код валюти';
comment on column v_nbur_e9x.K040_1 is 'Код країни установи-відправника';
comment on column v_nbur_e9x.KU_1 is 'Область відправника';
comment on column v_nbur_e9x.K040_2 is 'Код країни установи-отримувача';
comment on column v_nbur_e9x.KU_2 is 'Область отримувача';
comment on column v_nbur_e9x.T071 is 'Сума';
comment on column v_nbur_e9x.T080 is 'Кількість';
comment on column v_nbur_e9x.D060_2 is 'Код міжнародної системи переказу коштів';
comment on column v_nbur_e9x.Q001 is 'Найменування банку кореспондента-нерезидента';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_e9x.sql =========*** End *** ===
PROMPT ===================================================================================== 