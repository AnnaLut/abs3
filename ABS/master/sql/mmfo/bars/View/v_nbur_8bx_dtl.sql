PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_8BX_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_8BX_dtl ***

create or replace view v_nbur_8BX_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.F103
     , p.Q003_4
     , p.T070
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.ND         	 
     , p.AGRM_NUM	 
     , p.BEG_DT
     , p.END_DT     	 
     , p.REF
     , p.BRANCH
  from NBUR_LOG_F8BX p
       join NBUR_REF_FILES f on (f.FILE_CODE = '8BX')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by F103, Q003_4, acc_num, kv;
   
comment on table V_NBUR_8BX_DTL is 'Детальний протокол файлу 8BX';
comment on column V_NBUR_8BX_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_8BX_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_8BX_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_8BX_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_8BX_DTL.EKP is 'Код показника';
comment on column V_NBUR_8BX_DTL.F103   is 'Код даних для розрахунку економічних нормативів';
comment on column V_NBUR_8BX_DTL.Q003_4 is 'Умовний порядковий номер контрагента';
comment on column V_NBUR_8BX_DTL.T070      is 'Сума';
comment on column V_NBUR_8BX_DTL.DESCRIPTION 	is 'Опис (коментар)';          
comment on column V_NBUR_8BX_DTL.ACC_ID		is 'Ід. рахунка';              
comment on column V_NBUR_8BX_DTL.ACC_NUM 	is 'Номер рахунка';            
comment on column V_NBUR_8BX_DTL.KV		is 'Ід. валюти';               
comment on column V_NBUR_8BX_DTL.CUST_ID 	is 'Ід. клієнта';              
comment on column V_NBUR_8BX_DTL.CUST_CODE      is 'Код клієнта';              
comment on column V_NBUR_8BX_DTL.CUST_NAME	is 'Назва клієнта';            
comment on column V_NBUR_8BX_DTL.ND		is 'Ід. договору';             
comment on column V_NBUR_8BX_DTL.AGRM_NUM	is 'Номер договору';           
comment on column V_NBUR_8BX_DTL.BEG_DT		is 'Дата початку договору';    
comment on column V_NBUR_8BX_DTL.END_DT		is 'Дата закінчення договору'; 
comment on column V_NBUR_8BX_DTL.REF		is 'Ід. платіжного документа';
comment on column V_NBUR_8BX_DTL.BRANCH		is 'Код підрозділу';           

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_8BX_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 