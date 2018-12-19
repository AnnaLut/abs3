PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f5x.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_F5X
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.Z230
       , p.Z350
       , p.K045
       , p.Z130 
       , p.Z140 
       , p.Z150 
       , p.KU   
       , p.T070 
       , p.T080 
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'    ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/Z230'   ) as Z230
               , extractValue( COLUMN_VALUE, 'DATA/Z350'   ) as Z350
               , extractValue( COLUMN_VALUE, 'DATA/K045'   ) as K045
               , extractValue( COLUMN_VALUE, 'DATA/Z130'   ) as Z130
               , extractValue( COLUMN_VALUE, 'DATA/Z140'   ) as Z140
               , extractValue( COLUMN_VALUE, 'DATA/Z150'   ) as Z150
               , extractValue( COLUMN_VALUE, 'DATA/KU'     ) as KU 
               , extractValue( COLUMN_VALUE, 'DATA/T070'   ) as T070
               , extractValue( COLUMN_VALUE, 'DATA/T080'   ) as T080
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#F5'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p;

comment on table  v_nbur_F5X is 'F5X -Дані про збитки банку через cумнівні операції з платіжними картками';
comment on column v_nbur_F5X.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_F5X.KF is 'Фiлiя';
comment on column v_nbur_F5X.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_F5X.EKP     IS 'Код показника';                           
comment on column v_nbur_F5X.Z230    IS 'Код платіжної системи';
comment on column v_nbur_F5X.Z350    IS 'Код емітента платіжної картки';
comment on column v_nbur_F5X.K045    IS 'Код території, де здійснена незаконна дія/сумнівна операція';
comment on column v_nbur_F5X.Z130    IS 'Тип незаконної дії або сумнівної операції з платіжними картками';
comment on column v_nbur_F5X.Z140    IS 'Код учасника операцій з платіжними картками';
comment on column v_nbur_F5X.Z150    IS 'Код місця здійснення операції з платіжною карткою';
comment on column v_nbur_F5X.KU      IS 'Код адміністративно-територіальної одиниці України розташування платіжного пристрою';
comment on column v_nbur_F5X.T070    IS 'Сума збитків від незаконних дій з платіжними картками';
comment on column v_nbur_F5X.T080    IS 'Кількість сумнівних операцій з платіжними картками';
                  
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f5x.sql =========*** End *** ===
PROMPT ===================================================================================== 

