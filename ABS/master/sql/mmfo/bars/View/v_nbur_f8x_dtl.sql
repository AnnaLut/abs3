
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f8x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_F8X_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.F034       
         , p.F035       
         , p.R030       
         , p.S080       
         , p.K111       
         , p.S260       
         , p.S032       
         , p.S245       
         , p.T100       
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
    from NBUR_LOG_FF8X p
         join NBUR_REF_FILES f on (f.FILE_CODE = 'F8X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_F8X_DTL is 'Детальний протокол файлу F8X';
comment on column v_nbur_F8X_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_F8X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column v_nbur_F8X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_F8X_DTL.EKP    is 'Код показника';
comment on column v_nbur_F8X_DTL.F034   is 'Код кількості та обсягу заборгованості';        
comment on column v_nbur_F8X_DTL.F035   is 'Код виду операцій';                             
comment on column v_nbur_F8X_DTL.R030   is 'Код валюти';                                    
comment on column v_nbur_F8X_DTL.S080   is 'Код класу боржника/контрагента';                
comment on column v_nbur_F8X_DTL.K111   is 'Код розділу виду економічної діяльності';       
comment on column v_nbur_F8X_DTL.S260   is 'Код виду індивідуального споживання за цілями'; 
comment on column v_nbur_F8X_DTL.S032   is 'Код узагальненого виду забезпечення кредиту';   
comment on column v_nbur_F8X_DTL.S245   is 'Код узагальнененого кінцевого строку погашення';
comment on column v_nbur_F8X_DTL.T100   is 'Сума/кількість';                                

comment on column v_nbur_F8X_DTL.DESCRIPTION  is 'Опис (коментар)';
comment on column v_nbur_F8X_DTL.ACC_ID       is 'Ід. рахунка';             
comment on column v_nbur_F8X_DTL.ACC_NUM      is 'Номер рахунка';           
comment on column v_nbur_F8X_DTL.KV           is 'Валюта';                  
comment on column v_nbur_F8X_DTL.CUST_ID      is 'Ід. клієнта';             
comment on column v_nbur_F8X_DTL.CUST_CODE    is 'Код клієнта';             
comment on column v_nbur_F8X_DTL.CUST_NAME    is 'Назва клієнта';           
comment on column v_nbur_F8X_DTL.ND           is 'Ід. договору';            
comment on column v_nbur_F8X_DTL.AGRM_NUM     is 'Номер договору';          
comment on column v_nbur_F8X_DTL.BEG_DT       is 'Дата початку договору';   
comment on column v_nbur_F8X_DTL.END_DT       is 'Дата закінчення договору';
comment on column v_nbur_F8X_DTL.BRANCH       is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f8x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
