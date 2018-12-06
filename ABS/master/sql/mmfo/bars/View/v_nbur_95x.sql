PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_95x.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_95X
AS
select   p.REPORT_DATE
       , p.KF
       , p.VERSION_ID
       , null  as field_code
       , p.EKP	
       , p.K030	
       , p.F051	
       , p.K020	
       , p.Q001	
       , p.Q002	
       , p.Q003	
       , p.Q007
       , p.T070	
       , p.T090_1
       , p.T090_2
       , p.T090_3
       , p.T090_4
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP'	  ) as EKP
               , extractValue( COLUMN_VALUE, 'DATA/K030'  ) as K030	 
               , extractValue( COLUMN_VALUE, 'DATA/F051'  ) as F051	 
               , extractValue( COLUMN_VALUE, 'DATA/K020'  ) as K020	 
               , extractValue( COLUMN_VALUE, 'DATA/Q001'  ) as Q001	 
               , extractValue( COLUMN_VALUE, 'DATA/Q002'  ) as Q002	 
               , extractValue( COLUMN_VALUE, 'DATA/Q003'  ) as Q003	 
               , extractValue( COLUMN_VALUE, 'DATA/Q007'  ) as Q007	 
               , extractValue( COLUMN_VALUE, 'DATA/T070'  ) as T070	 
               , extractValue( COLUMN_VALUE, 'DATA/T090_1') as T090_1
               , extractValue( COLUMN_VALUE, 'DATA/T090_2') as T090_2
               , extractValue( COLUMN_VALUE, 'DATA/T090_3') as T090_3
               , extractValue( COLUMN_VALUE, 'DATA/T090_4') as T090_4
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '95X'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020;

comment on table  v_nbur_95x is 'Файл 95X Дані про афілійовані особи банку';
comment on column v_nbur_95x.REPORT_DATE 	is 'Звiтна дата';
comment on column v_nbur_95x.KF 		is 'Фiлiя';
comment on column v_nbur_95x.VERSION_ID 	is 'Номер версії файлу';
comment on column v_nbur_95x.EKP 		is 'Код показника';
comment on column v_nbur_95x.K030	 	is 'Код резидентності афілійованої особи';                                      
comment on column v_nbur_95x.F051	 	is 'Код відношення афілійованої особи до банку';                                
comment on column v_nbur_95x.K020	 	is 'Ідентифікаційний код афілійованої особи';                                   
comment on column v_nbur_95x.Q001	 	is 'Найменування афілійованої особи';                                           
comment on column v_nbur_95x.Q002	 	is 'Місцезнаходження афілійованої особи';                                       
comment on column v_nbur_95x.Q003	 	is 'Порядковий номер афілійованої особи';                                       
comment on column v_nbur_95x.Q007	 	is 'Дата реєстрації статутного фонду або змін до нього';                        
comment on column v_nbur_95x.T070	 	is 'Розмір зареєстрованого статутного фонду афілійованої особи';                
comment on column v_nbur_95x.T090_1 		is 'Відсоток прямої участі на дату набуття статусу афілійованої особи';         
comment on column v_nbur_95x.T090_2 		is 'Відсоток опосередкованої участі на дату набуття статусу афілійованої особи';
comment on column v_nbur_95x.T090_3 		is 'Відсоток прямої участі на звітну дату';                                     
comment on column v_nbur_95x.T090_4 		is 'Відсоток опосередкованої участі на звітну дату';                            

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_95x.sql =========*** End *** ===
PROMPT ===================================================================================== 

