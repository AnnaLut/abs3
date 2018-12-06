
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_95x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_95x_dtl
 as
select	   p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
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
         , p.DESCRIPTION
         , p.BRANCH
    from NBUR_LOG_F95X p
         join NBUR_REF_FILES f on (f.FILE_CODE = '95X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_95x_DTL 		is 'Детальний протокол файлу 95X';
comment on column v_nbur_95x_DTL.REPORT_DATE 	is 'Звітна дата';
comment on column v_nbur_95x_DTL.KF		is 'Код фiлiалу (МФО)';
comment on column v_nbur_95x_DTL.VERSION_ID	is 'Ід. версії файлу';
comment on column v_nbur_95x_DTL.EKP 		is 'Код показника';                                                             
comment on column v_nbur_95x_DTL.K030 		is 'Код резидентності афілійованої особи';                                        
comment on column v_nbur_95x_DTL.F051 		is 'Код відношення афілійованої особи до банку';                                  
comment on column v_nbur_95x_DTL.K020 		is 'Ідентифікаційний код афілійованої особи';                                     
comment on column v_nbur_95x_DTL.Q001 		is 'Найменування афілійованої особи';                                             
comment on column v_nbur_95x_DTL.Q002 		is 'Місцезнаходження афілійованої особи';                                         
comment on column v_nbur_95x_DTL.Q003 		is 'Порядковий номер афілійованої особи';                                         
comment on column v_nbur_95x_DTL.Q007 		is 'Дата реєстрації статутного фонду або змін до нього';                          
comment on column v_nbur_95x_DTL.T070 		is 'Розмір зареєстрованого статутного фонду афілійованої особи';                  
comment on column v_nbur_95x_DTL.T090_1 	is 'Відсоток прямої участі на дату набуття статусу афілійованої особи';           
comment on column v_nbur_95x_DTL.T090_2 	is 'Відсоток опосередкованої участі на дату набуття статусу афілійованої особи';  
comment on column v_nbur_95x_DTL.T090_3 	is 'Відсоток прямої участі на звітну дату';                                       
comment on column v_nbur_95x_DTL.T090_4 	is 'Відсоток опосередкованої участі на звітну дату';                              
comment on column v_nbur_95x_DTL.DESCRIPTION	is 'Опис (коментар)';
comment on column v_nbur_95x_DTL.BRANCH		is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_95x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
