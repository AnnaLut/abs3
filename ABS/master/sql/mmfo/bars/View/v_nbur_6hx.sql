PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx.sql =========*** Run *** ===
PROMPT ===================================================================================== 

CREATE OR REPLACE VIEW BARS.V_NBUR_6HX
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
       , p.Q007_1
       , p.Q007_2
       , p.S210	
       , p.S083	
       , p.S080_1
       , p.S080_2
       , p.F074	
       , p.F077	
       , p.F078	
       , p.F102	
       , p.Q017	
       , p.Q027	
       , p.Q034	
       , p.Q035	
       , p.T070_2
       , p.T090	
       , p.T100_1
       , p.T100_2
       , p.T100_3
from   (select   v.REPORT_DATE
               , v.KF
               , v.version_id
               , extractValue( COLUMN_VALUE, 'DATA/EKP   '  )	as EKP   
               , extractValue( COLUMN_VALUE, 'DATA/K020	 '  )	as K020	 
               , extractValue( COLUMN_VALUE, 'DATA/K021	 '  )	as K021	 
               , extractValue( COLUMN_VALUE, 'DATA/Q003_2'  )	as Q003_2
               , extractValue( COLUMN_VALUE, 'DATA/Q003_4'  )	as Q003_4
               , extractValue( COLUMN_VALUE, 'DATA/R030	 '  )	as R030	 
               , extractValue( COLUMN_VALUE, 'DATA/Q007_1'  )	as Q007_1
               , extractValue( COLUMN_VALUE, 'DATA/Q007_2'  )	as Q007_2
               , extractValue( COLUMN_VALUE, 'DATA/S210	 '  )	as S210	 
               , extractValue( COLUMN_VALUE, 'DATA/S083	 '  )	as S083	 
               , extractValue( COLUMN_VALUE, 'DATA/S080_1'  )	as S080_1
               , extractValue( COLUMN_VALUE, 'DATA/S080_2'  )	as S080_2
               , extractValue( COLUMN_VALUE, 'DATA/F074	 '  )	as F074	 
               , extractValue( COLUMN_VALUE, 'DATA/F077	 '  )	as F077	 
               , extractValue( COLUMN_VALUE, 'DATA/F078	 '  )	as F078	 
               , extractValue( COLUMN_VALUE, 'DATA/F102	 '  )	as F102	 
               , extractValue( COLUMN_VALUE, 'DATA/Q017	 '  )	as Q017	 
               , extractValue( COLUMN_VALUE, 'DATA/Q027	 '  )	as Q027	 
               , extractValue( COLUMN_VALUE, 'DATA/Q034	 '  )	as Q034	 
               , extractValue( COLUMN_VALUE, 'DATA/Q035	 '  )	as Q035	 
               , extractValue( COLUMN_VALUE, 'DATA/T070_2'  )	as T070_2
               , extractValue( COLUMN_VALUE, 'DATA/T090	 '  )	as T090	 
               , extractValue( COLUMN_VALUE, 'DATA/T100_1'  )	as T100_1
               , extractValue( COLUMN_VALUE, 'DATA/T100_2'  )	as T100_2
               , extractValue( COLUMN_VALUE, 'DATA/T100_3'  )	as T100_3
         from   NBUR_REF_FILES f
                , NBUR_LST_FILES v
                , table( XMLSequence( XMLType( v.FILE_BODY ).extract('/NBUSTATREPORT/DATA') ) ) t
         where  f.ID        = v.FILE_ID
                and f.FILE_CODE = '#6H'
                and f.FILE_FMT  = 'XML'
                and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
       ) p
 order by K020;

comment on table  v_nbur_6Hx is 'Файл 6HX - Данi про концентрацію ризиків за активними операціями банку з контрагентами і ПО (Інформація за валютами та траншами)';
comment on column v_nbur_6Hx.REPORT_DATE is 'Звiтна дата';
comment on column v_nbur_6Hx.KF 	is 'Фiлiя';
comment on column v_nbur_6Hx.VERSION_ID is 'Номер версії файлу';
comment on column v_nbur_6Hx.EKP	is 'Код показника';
comment on column v_nbur_6Hx.K020	is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';                       
comment on column v_nbur_6Hx.K021	is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';                                              
comment on column v_nbur_6Hx.Q003_2	is 'Умовний порядковий номер договору';                                                                                 
comment on column v_nbur_6Hx.Q003_4	is 'Умовний порядковий номер траншу';                                                                                   
comment on column v_nbur_6Hx.R030	is 'Код валюти';                                                                                                        
comment on column v_nbur_6Hx.Q007_1	is 'Дата виникнення заборгованості/фін.зобов’язань';                                                                    
comment on column v_nbur_6Hx.Q007_2	is 'Дата кінцевого погашення заборгованості/фін.зобов’язань';                                                           
comment on column v_nbur_6Hx.S210	is 'Код активної операції щодо реструктуризації/рефінансування';                                                        
comment on column v_nbur_6Hx.S083	is 'Код типу оцінки кредитного ризику';                                                                                 
comment on column v_nbur_6Hx.S080_1	is 'Код класу контрагента/пов’язної з банком особи';                                                                    
comment on column v_nbur_6Hx.S080_2	is 'Код скоригованого класу контрагента/пов’язної з банком особи';                                                      
comment on column v_nbur_6Hx.F074	is 'Код фактору щодо належності до групи юридичних осіб під спільним контролем або до групи пов’язаних контрагентів';   
comment on column v_nbur_6Hx.F077	is 'Код фактору щодо своєчасності сплати боргу';                                                                        
comment on column v_nbur_6Hx.F078	is 'Код фактору щодо додаткових характеристик';                                                                         
comment on column v_nbur_6Hx.F102	is 'Код щодо наявності інформації у Кредитному реєстрі';                                                                
comment on column v_nbur_6Hx.Q017	is 'Код фактору щодо наявності ознаки, що свідчить про високий кредитний ризик (за F075)';                              
comment on column v_nbur_6Hx.Q027	is 'Код фактору щодо події дефолту (за F076)';                                                                          
comment on column v_nbur_6Hx.Q034	is 'Код фактору, на підставі якого скориговано клас контрагента/пов’язаної з банком особи (за F079)';                   
comment on column v_nbur_6Hx.Q035	is 'Код ознаки події дефолту, щодо якої доведено відсутність дефолту (за F080)';                                        
comment on column v_nbur_6Hx.T070_2	is 'Розмір кредитного ризику (CR)';                                                                                     
comment on column v_nbur_6Hx.T090	is 'Процентна ставка';                                                                                                  
comment on column v_nbur_6Hx.T100_1	is 'Коефіцієнт розміру кредитного ризику (PD)';                                                                         
comment on column v_nbur_6Hx.T100_2	is 'Коефіцієнт LGD';                                                                                                    
comment on column v_nbur_6Hx.T100_3	is 'Коефіцієнт CCF';                                                                                                    

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx.sql =========*** End *** ===
PROMPT ===================================================================================== 

