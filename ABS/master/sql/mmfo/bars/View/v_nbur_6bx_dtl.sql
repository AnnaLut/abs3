
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_6bx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_6bx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.F083
         , p.F082
         , p.S083
         , p.S080
         , p.S031
         , p.K030
         , p.R030
         , p.T070
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.REF
         , p.BRANCH
    from NBUR_LOG_F6BX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '6BX' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_6bx_DTL is 'Детальний протокол файлу 6BX';
comment on column v_nbur_6bx_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_6bx_DTL.KF is 'Код фiлiалу (МФО)';
comment on column v_nbur_6bx_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_6bx_DTL.EKP is 'Код показника';
comment on column v_nbur_6bx_DTL.T070 is 'Сума';
comment on column v_nbur_6bx_DTL.F083 is 'Код значення коефіцієнта кредитної конверсії, рівня покриття боргу заставою, складової балансової вартості';
comment on column v_nbur_6bx_DTL.F082 is 'Код типу боржника';
comment on column v_nbur_6bx_DTL.S083 is 'Код типу оцінки кредитного ризику';
comment on column v_nbur_6bx_DTL.S080 is 'Код класу боржника/контрагента';
comment on column v_nbur_6bx_DTL.S031 is 'Код виду забезпечення кредиту';
comment on column v_nbur_6bx_DTL.K030 is 'Код резидентності';
comment on column v_nbur_6bx_DTL.R030 is 'Код валюти';
comment on column v_nbur_6bx_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column v_nbur_6bx_DTL.ACC_ID is 'Ід. рахунка';
comment on column v_nbur_6bx_DTL.ACC_NUM is 'Номер рахунка';
comment on column v_nbur_6bx_DTL.KV is 'Ід. валюти';
comment on column v_nbur_6bx_DTL.CUST_ID is 'Ід. клієнта';
comment on column v_nbur_6bx_DTL.CUST_CODE is 'Код клієнта';
comment on column v_nbur_6bx_DTL.CUST_NAME is 'Назва клієнта';
comment on column v_nbur_6bx_DTL.REF is 'Ід. платіжного документа';
comment on column v_nbur_6bx_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_6bx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
