
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6Fx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6Fx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.K020	
         , p.K021	
         , p.Q001	
         , p.F084	
         , p.K040	
         , p.KU_1	
         , p.K110	
         , p.K074	
         , p.K140	
         , p.Q020	
         , p.Q003_1
         , p.Q029
	 , p.FLAG_XML       
         , p.DESCRIPTION
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
    from NBUR_LOG_F6FX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#6F' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6Fx_DTL is 'Детальний протокол файлу 6FX';
comment on column v_nbur_6Fx_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_6Fx_DTL.KF is 'Код фiлiалу (МФО)';
comment on column v_nbur_6Fx_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_6Fx_DTL.EKP is 'Код показника';
comment on column v_nbur_6Fx_DTL.K020	is 'Ідентифікаційний/реєстраційний код/номер контрагента/пов?язаної з банком особи';                       
comment on column v_nbur_6Fx_DTL.K021	is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';                                              
comment on column v_nbur_6Fx_DTL.Q001	is 'Найменування контрагента/пов’язаної з банком особи';                                                   
comment on column v_nbur_6Fx_DTL.F084	is 'Код щодо належності контрагента до компанії спеціального призначення (SPE)';                           
comment on column v_nbur_6Fx_DTL.K040	is 'Код країни';                                                                                           
comment on column v_nbur_6Fx_DTL.KU_1	is 'Код регіону';                                                                                          
comment on column v_nbur_6Fx_DTL.K110	is 'Код виду економічної діяльності';                                                                      
comment on column v_nbur_6Fx_DTL.K074	is 'Код інституційного сектору економіки';                                                                 
comment on column v_nbur_6Fx_DTL.K140	is 'Код розміру суб’єкта господарювання';                                                                  
comment on column v_nbur_6Fx_DTL.Q020	is 'Код типу пов’язаної з банком особи';                                                                   
comment on column v_nbur_6Fx_DTL.Q003_1	is 'Порядковий номер групи контрагентів';                                                                  
comment on column v_nbur_6Fx_DTL.Q029  	is 'Код контрагента/ПО банку нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини';
comment on column v_nbur_6Fx_DTL.FLAG_XML       is 'Флаг попадання у XML файл (1-так, 0-ні)';
comment on column v_nbur_6Fx_DTL.DESCRIPTION 	is 'Опис (коментар)';                                                                              
comment on column v_nbur_6Fx_DTL.KV		is 'Ід. валюти';                                                                                   
comment on column v_nbur_6Fx_DTL.CUST_ID 	is 'Ід. клієнта';                                                                                  
comment on column v_nbur_6Fx_DTL.CUST_CODE      is 'Код клієнта';                                                                                  
comment on column v_nbur_6Fx_DTL.CUST_NAME	is 'Назва клієнта';                                                                                
comment on column v_nbur_6Fx_DTL.ND		is 'Ід. договору';                                                                                 
comment on column v_nbur_6Fx_DTL.AGRM_NUM	is 'Номер договору';                                                                               
comment on column v_nbur_6Fx_DTL.BEG_DT		is 'Дата початку договору';                                                                        
comment on column v_nbur_6Fx_DTL.END_DT		is 'Дата закінчення договору';                                                                     
comment on column v_nbur_6Fx_DTL.BRANCH		is 'Код підрозділу';                                                                               
comment on column v_nbur_6Fx_DTL.VERSION_D8 is 'Ід. версії файлу #D8';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6Fx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
