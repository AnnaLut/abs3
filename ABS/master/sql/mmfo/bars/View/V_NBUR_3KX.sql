PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3kx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

create or replace force view v_nbur_3kx 
(  REPORT_DATE
       , KF
       , VERSION_ID
       , NBUC
         , FIELD_CODE
       , EKP
       , Q003_1
       , F091
       , R030
       , T071
       , K020
       , K021
       , K030
       , Q001
       , Q024  
       , D100
       , S180
       , F089
       , F092
       , Q003_2
       , Q007_1
       , Q006 )
as
select t.REPORT_DATE
       , t.KF
       , t.VERSION_ID
       , t.KF      as NBUC
         , substr(trim(t.Q003_1),1,3)   as FIELD_CODE
       , t.EKP
       , t.Q003_1
       , t.F091
       , t.R030
       , t.T071
       , t.K020
       , t.K021
       , t.K030
       , t.Q001
       , t.Q024
       , t.D100
       , t.S180
       , t.F089
       , t.F092
       , t.Q003_2
       , t.Q007_1
       , t.Q006
from   (select
               v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/Q003_1') as Q003_1
               , extractValue( COLUMN_VALUE, 'DATA/F091'  ) as F091
               , extractValue( COLUMN_VALUE, 'DATA/R030'  ) as R030
               , extractValue( COLUMN_VALUE, 'DATA/T071'  ) as T071
               , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020
               , extractValue( COLUMN_VALUE, 'DATA/K021'  ) as K021
               , extractValue( COLUMN_VALUE, 'DATA/K030'  ) as K030
               , extractValue( COLUMN_VALUE, 'DATA/Q001'  ) as Q001
               , extractValue( COLUMN_VALUE, 'DATA/Q024'  ) as Q024
               , extractValue( COLUMN_VALUE, 'DATA/D100'  ) as D100
               , extractValue( COLUMN_VALUE, 'DATA/S180'  ) as S180
               , extractValue( COLUMN_VALUE, 'DATA/F089'  ) as F089
               , extractValue( COLUMN_VALUE, 'DATA/F092'  ) as F092
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
               , extractValue( COLUMN_VALUE, 'DATA/Q006'  ) as Q006
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#3K'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) t;

comment on table  v_nbur_3kx is '3KX - Дані про купівлю, продаж безготівкової іноземної валюти';
comment on column v_nbur_3kx.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_3kx.KF is 'Фiлiя';
comment on column v_nbur_3kx.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_3kx.NBUC is 'Код розрізу даних';
comment on column v_nbur_3kx.FIELD_CODE is 'Код показника';
comment on column v_nbur_3kx.EKP is 'XML Код показника';
comment on column v_nbur_3kx.Q003_1 is 'Умовний номер рядка';
comment on column v_nbur_3kx.F091 is 'Код операції';
comment on column v_nbur_3kx.R030 is 'Код валюти';
comment on column v_nbur_3kx.T071 is 'Сума купівлі/продажу';
comment on column v_nbur_3kx.K020 is 'Код відправника/отримувача';
comment on column v_nbur_3kx.K021 is 'Код ознаки ідентифікаційного коду';
comment on column v_nbur_3kx.K030 is 'Код резидентності';
comment on column v_nbur_3kx.Q001 is 'Назва покупця/продавця';
comment on column v_nbur_3kx.Q024 is 'Тип контрагента';
comment on column v_nbur_3kx.D100 is 'Код умов валютної операції';
comment on column v_nbur_3kx.S180 is 'Строк валютної операції';
comment on column v_nbur_3kx.F089 is 'Ознака консолідації';
comment on column v_nbur_3kx.F092 is 'Підстава для купівлі/ мета продажу';
comment on column v_nbur_3kx.Q003_2 is 'Номер контракту';
comment on column v_nbur_3kx.Q007_1 is 'Дата контракту';
comment on column v_nbur_3kx.Q006 is 'Відомості про операцію';


GRANT SELECT ON BARS.V_NBUR_3KX TO BARSREADER_ROLE;
GRANT SELECT ON BARS.V_NBUR_3KX TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_NBUR_3KX TO UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3kx.sql =========*** End *** ===
PROMPT ===================================================================================== 

