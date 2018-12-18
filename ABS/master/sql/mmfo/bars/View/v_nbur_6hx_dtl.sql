
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6Hx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
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
         , p.DESCRIPTION
         , p.ACC_ID     	 
	 , p.ACC_NUM    	 
         , p.KV         	 
         , p.CUST_ID    	 
         , p.CUST_CODE	 
         , p.CUST_NAME	 
         , p.ND         	 
         , p.AGRM_NUM	 
         , p.BEG_DT
         , p.END_DT     	 
         , p.BRANCH
         , p.VERSION_D8
    from NBUR_LOG_F6HX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#6H' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6Hx_DTL 		is 'Детальний протокол файлу 6HX';
comment on column v_nbur_6Hx_DTL.REPORT_DATE 	is 'Звітна дата';
comment on column v_nbur_6Hx_DTL.KF 		is 'Код фiлiалу (МФО)';
comment on column v_nbur_6Hx_DTL.VERSION_ID 	is 'Ід. версії файлу';
comment on column v_nbur_6Hx_DTL.EKP 		is 'Код показника';
comment on column v_nbur_6Hx_DTL.K020		is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';                       
comment on column v_nbur_6Hx_DTL.K021		is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';                                              
comment on column v_nbur_6Hx_DTL.Q003_2  	is 'Умовний порядковий номер договору';                                                                               
comment on column v_nbur_6Hx_DTL.Q003_4		is 'Умовний порядковий номер траншу';                                                                                 
comment on column v_nbur_6Hx_DTL.R030		is 'Код валюти';                                                                                                      
comment on column v_nbur_6Hx_DTL.Q007_1		is 'Дата виникнення заборгованості/фін.зобов’язань';                                                                  
comment on column v_nbur_6Hx_DTL.Q007_2		is 'Дата кінцевого погашення заборгованості/фін.зобов’язань';                                                         
comment on column v_nbur_6Hx_DTL.S210		is 'Код активної операції щодо реструктуризації/рефінансування';                                                      
comment on column v_nbur_6Hx_DTL.S083		is 'Код типу оцінки кредитного ризику';                                                                               
comment on column v_nbur_6Hx_DTL.S080_1  	is 'Код класу контрагента/пов’язної з банком особи';                                                                  
comment on column v_nbur_6Hx_DTL.S080_2  	is 'Код скоригованого класу контрагента/пов’язної з банком особи';                                                    
comment on column v_nbur_6Hx_DTL.F074		is 'Код фактору щодо належності до групи юридичних осіб під спільним контролем або до групи пов’язаних контрагентів'; 
comment on column v_nbur_6Hx_DTL.F077		is 'Код фактору щодо своєчасності сплати боргу';                                                                      
comment on column v_nbur_6Hx_DTL.F078		is 'Код фактору щодо додаткових характеристик';                                                                       
comment on column v_nbur_6Hx_DTL.F102		is 'Код щодо наявності інформації у Кредитному реєстрі';                                                              
comment on column v_nbur_6Hx_DTL.Q017		is 'Код фактору щодо наявності ознаки, що свідчить про високий кредитний ризик (за F075)';                            
comment on column v_nbur_6Hx_DTL.Q027		is 'Код фактору щодо події дефолту (за F076)';                                                                        
comment on column v_nbur_6Hx_DTL.Q034		is 'Код фактору, на підставі якого скориговано клас контрагента/пов’язаної з банком особи (за F079)';                 
comment on column v_nbur_6Hx_DTL.Q035		is 'Код ознаки події дефолту, щодо якої доведено відсутність дефолту (за F080)';                                      
comment on column v_nbur_6Hx_DTL.T070_2  	is 'Розмір кредитного ризику (CR)';                                                                                   
comment on column v_nbur_6Hx_DTL.T090		is 'Процентна ставка';                                                                                                
comment on column v_nbur_6Hx_DTL.T100_1  	is 'Коефіцієнт розміру кредитного ризику (PD)';                                                                       
comment on column v_nbur_6Hx_DTL.T100_2  	is 'Коефіцієнт LGD';                                                                                                  
comment on column v_nbur_6Hx_DTL.T100_3  	is 'Коефіцієнт CCF';                                                                                                  
comment on column v_nbur_6Hx_DTL.DESCRIPTION 	is 'Опис (коментар)';                                                                                         
comment on column v_nbur_6Hx_DTL.ACC_ID		is 'Ід. рахунка';                                                                                             
comment on column v_nbur_6Hx_DTL.ACC_NUM 	is 'Номер рахунка';                                                                                           
comment on column v_nbur_6Hx_DTL.KV		is 'Ід. валюти';                                                                                              
comment on column v_nbur_6Hx_DTL.CUST_ID 	is 'Ід. клієнта';                                                                                             
comment on column v_nbur_6Hx_DTL.CUST_CODE      is 'Код клієнта';                                                                                             
comment on column v_nbur_6Hx_DTL.CUST_NAME	is 'Назва клієнта';                                                                                           
comment on column v_nbur_6Hx_DTL.ND		is 'Ід. договору';                                                                                            
comment on column v_nbur_6Hx_DTL.AGRM_NUM	is 'Номер договору';                                                                                          
comment on column v_nbur_6Hx_DTL.BEG_DT		is 'Дата початку договору';                                                                                   
comment on column v_nbur_6Hx_DTL.END_DT		is 'Дата закінчення договору';                                                                                
comment on column v_nbur_6Hx_DTL.BRANCH		is 'Код підрозділу';                                                                                          
comment on column v_nbur_6Hx_DTL.VERSION_D8 	is 'Ід. версії файлу #D8';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Hx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
