PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_79X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_36X ***

create or replace view v_nbur_36X as
select
          v.REPORT_DATE
          , v.KF
          , v.VERSION_ID
          , extractValue(COLUMN_VALUE, 'DATA/EKP') as EKP
          , extractValue(COLUMN_VALUE, 'DATA/B040') as B040
          , extractValue(COLUMN_VALUE, 'DATA/F021') as F021
          , extractValue(COLUMN_VALUE, 'DATA/K020') as K020
          , extractValue(COLUMN_VALUE, 'DATA/K021') as K021
          , extractValue(COLUMN_VALUE, 'DATA/Q001_1') as Q001_1
          , extractValue(COLUMN_VALUE, 'DATA/Q001_2') as Q001_2
          , extractValue(COLUMN_VALUE, 'DATA/Q002') as Q002
          , extractValue(COLUMN_VALUE, 'DATA/Q003_2') as Q003_2
          , extractValue(COLUMN_VALUE, 'DATA/Q003_3') as Q003_3
          , extractValue(COLUMN_VALUE, 'DATA/Q007_1') as Q007_1
          , extractValue(COLUMN_VALUE, 'DATA/Q007_2') as Q007_2
          , extractValue(COLUMN_VALUE, 'DATA/Q007_3') as Q007_3
          , extractValue(COLUMN_VALUE, 'DATA/Q007_4') as Q007_4
          , extractValue(COLUMN_VALUE, 'DATA/Q007_5') as Q007_5
          , extractValue(COLUMN_VALUE, 'DATA/K040') as K040
          , extractValue(COLUMN_VALUE, 'DATA/D070') as D070
          , extractValue(COLUMN_VALUE, 'DATA/F008') as F008
          , extractValue(COLUMN_VALUE, 'DATA/K112') as K112
          , extractValue(COLUMN_VALUE, 'DATA/F019') as F019
          , extractValue(COLUMN_VALUE, 'DATA/F020') as F020
          , extractValue(COLUMN_VALUE, 'DATA/R030') as R030
          , extractValue(COLUMN_VALUE, 'DATA/Q023') as Q023
          , extractValue(COLUMN_VALUE, 'DATA/T071') as T071
          , extractValue(COLUMN_VALUE, 'DATA/T070') as T070
          , extractValue(COLUMN_VALUE, 'DATA/Q006') as Q006
    from  NBUR_REF_FILES f
          , NBUR_LST_FILES v
          , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
   where  f.ID        = v.FILE_ID
          and f.FILE_CODE = '#36'
          and f.FILE_FMT  = 'XML'
          and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED');
           
comment on table V_NBUR_36X              is 'Файл 36X - Дані про концетрацію ризиків за пасивними операціями банку';
comment on column V_NBUR_36X.REPORT_DATE is 'Звiтна дата';
comment on column V_NBUR_36X.KF          is 'Фiлiя';
comment on column V_NBUR_36X.VERSION_ID  is 'Номер версії файлу';
comment on column V_NBUR_36X_DTL.EKP     is 'Код показника';
comment on column V_NBUR_36X.B040        is 'Код стуктурного підрозділу';
comment on column V_NBUR_36X.F021        is 'Код повідомлення про взяття на контроль/зняття з контролю';        
comment on column V_NBUR_36X.K020        is 'Код резидента';        
comment on column V_NBUR_36X.K021        is 'Ознака коду';        
comment on column V_NBUR_36X.Q001_1      is 'Повне найменування резидента';        
comment on column V_NBUR_36X.Q001_2      is 'Повне найменування нерезидента (згідно з контрактом)';        
comment on column V_NBUR_36X.Q002        is 'Місцезнаходження резидента';        
comment on column V_NBUR_36X.Q003_2      is 'Умовний порядковий номер контракта';        
comment on column V_NBUR_36X.Q003_3      is 'Номер зовнішньоекономічного контракту';        
comment on column V_NBUR_36X.Q007_1      is 'Дата укладення зовнішньоекономічного контракту';        
comment on column V_NBUR_36X.Q007_2      is 'Дата першого дня перевищення строку розрахунків';        
comment on column V_NBUR_36X.Q007_3      is 'Дата внесення змін до інформації';        
comment on column V_NBUR_36X.Q007_4      is 'Дата зняття резидента з контролю';        
comment on column V_NBUR_36X.Q007_5      is 'Дата відвантаження продукції відповідно до митних декларацій або дата виконання відповідного платіжного доручення';        
comment on column V_NBUR_36X.K040        is 'Код країни нерезидента';        
comment on column V_NBUR_36X.D070        is 'Код зовнішньоекономічної операції клієнта';        
comment on column V_NBUR_36X.F008        is 'Код  змісту зовнішньоекономічної операції клієнта';        
comment on column V_NBUR_36X.K112        is 'Код секції виду економічної діяльності';        
comment on column V_NBUR_36X.F019        is 'Код причини виникнення заборгованості';        
comment on column V_NBUR_36X.F020        is 'Код відмітки про безнадійну заборгованість резидентів за зовнішньоекономічним контрактом';        
comment on column V_NBUR_36X.R030        is 'Код валюти розрахунку';        
comment on column V_NBUR_36X.Q023        is 'Код підрозділу банку, який ліквідовано';        
comment on column V_NBUR_36X.T071        is 'Сума неповернених коштів у валюті';        
comment on column V_NBUR_36X.T070        is 'Сума неповернених коштів у гривневому еквіваленті';        
comment on column V_NBUR_36X.Q006        is 'Примітка'; 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_36X.sql =========*** End *** =
PROMPT ===================================================================================== 

