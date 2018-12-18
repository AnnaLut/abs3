PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Ix.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_6IX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.K020	
       , p.K021	
       , p.Q003_2
       , p.Q003_4
       , p.R030	
       , p.R020
       , p.F081
       , p.S031
       , p.T070
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP   '  )	as EKP   
               , extractValue( COLUMN_VALUE, 'DATA/K020	 '  )	as K020	 
               , extractValue( COLUMN_VALUE, 'DATA/K021	 '  )	as K021	 
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2'  )	as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q003_4'  )	as Q003_4
               , extractValue( COLUMN_VALUE, 'DATA/R030	 '  )	as R030	 
               , extractValue( COLUMN_VALUE, 'DATA/R020'  )	as R020
               , extractValue( COLUMN_VALUE, 'DATA/F081'  )	as F081
               , extractValue( COLUMN_VALUE, 'DATA/S031'  )	as S031
               , extractValue( COLUMN_VALUE, 'DATA/T070'  )	as T070
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6I'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020;

comment on table  v_nbur_6Ix is 'Файл 6IX - Данi про концентрацію ризиків за активними операціями банку з контрагентами і ПО (Інформація за валютами та траншами)';
comment on column v_nbur_6Ix.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_6Ix.KF 	is 'Фiлiя';
comment on column v_nbur_6Ix.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_6Ix.EKP	is 'Код показника';
comment on column v_nbur_6Ix.K020	is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';                       
comment on column v_nbur_6Ix.K021	is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';                                              
comment on column v_nbur_6Ix.Q003_2	is 'Умовний порядковий номер договору';                                                                                 
comment on column v_nbur_6Ix.Q003_4	is 'Умовний порядковий номер траншу';                                                                                   
comment on column v_nbur_6Ix.R030	is 'Код валюти';                                                                                                        
comment on column v_nbur_6Ix.R020	is 'Номер рахунку';                                                  
comment on column v_nbur_6Ix.F081	is 'Код щодо включення до розрахунку нормативів кредитного ризику';  
comment on column v_nbur_6Ix.S031	is 'Код виду забезпечення кредитної операції за договором';          
comment on column v_nbur_6Ix.T070	is 'Сума';                                                           

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Ix.sql =========*** End *** ===
PROMPT ===================================================================================== 

