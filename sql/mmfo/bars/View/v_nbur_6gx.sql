PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Gx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_6GX
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP
       , p.K020	
       , p.K021	
       , p.Q003_2	
       , p.Q003_3	
       , p.Q007		
       , p.B040		
       , p.T070_1	
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'   )	as EKP
               , extractValue( COLUMN_VALUE, 'DATA/K020'  )	as K020	 
               , extractValue( COLUMN_VALUE, 'DATA/K021'  )	as K021	 
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2')	as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q003_3')	as Q003_3
               , extractValue( COLUMN_VALUE, 'DATA/Q007	' )	as Q007
               , extractValue( COLUMN_VALUE, 'DATA/B040	' )	as B040
               , extractValue( COLUMN_VALUE, 'DATA/T070_1')	as T070_1
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6G'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020;

comment on table  v_nbur_6Gx is 'Файл 6GX - Данi про концентрацію ризиків за активними операціями банку';
comment on column v_nbur_6Gx.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_6Gx.KF 	is 'Фiлiя';
comment on column v_nbur_6Gx.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_6Gx.EKP	is 'Код показника';
comment on column v_nbur_6Gx.K020	is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';                       
comment on column v_nbur_6Gx.K021	is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';                                              
comment on column v_nbur_6Gx.Q003_2	is 'Умовний порядковий номер договору';                                                          
comment on column v_nbur_6Gx.Q003_3	is 'Номер основного договору';                                                                   
comment on column v_nbur_6Gx.Q007	is 'Дата основного договору';                                                                    
comment on column v_nbur_6Gx.B040	is 'Код підрозділу банку, де зберігається документація по договору';                             
comment on column v_nbur_6Gx.T070_1	is 'Сума інших надходжень (RC)';                                                                  

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Gx.sql =========*** End *** ===
PROMPT ===================================================================================== 

