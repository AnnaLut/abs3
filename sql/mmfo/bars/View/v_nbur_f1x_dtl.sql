PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f1x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_f1x_dtl ***

create or replace view v_nbur_f1x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.VERSION_ID
         , p.Field_Code --Код для связки с мастер-представлением
         , SUBSTR(p.FIELD_CODE, 1, 6) as EKP --Код показника
         , p.NBUC
         , substr(p.field_code, 7, 1)  as K030
         , substr(p.field_code, 8, 3)  as R030
         , substr(p.field_code, 11, 3) as K040
         , p.FIELD_VALUE as T071
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.MATURITY_DATE
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.nd
         , p.REF
         , p.BRANCH
    from NBUR_DETAIL_PROTOCOLS_ARCH p
         join NBUR_REF_FILES f on (f.FILE_CODE = p.REPORT_CODE )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
   where p.REPORT_CODE = 'F1X' 
         and v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table v_nbur_f1x_DTL is 'Детальний протокол файлу F1X';
comment on column v_nbur_f1x_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_f1x_DTL.KF is 'Код фiлiалу (МФО)';
comment on column v_nbur_f1x_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_f1x_DTL.FIELD_CODE is 'Зведений код показника';
comment on column v_nbur_f1x_DTL.EKP is 'Код показника';
comment on column v_nbur_f1x_DTL.NBUC is 'Код області управління розрізу юридичної особи';
comment on column v_nbur_f1x_DTL.K030 is 'Резидентнiсть';
comment on column v_nbur_f1x_DTL.R030 is 'Код валюти';
comment on column v_nbur_f1x_DTL.K040 is 'Код країни';
comment on column v_nbur_f1x_DTL.T071 is 'Сума у валюті';
comment on column v_nbur_f1x_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column v_nbur_f1x_DTL.ACC_ID is 'Ід. рахунка';
comment on column v_nbur_f1x_DTL.ACC_NUM is 'Номер рахунка';
comment on column v_nbur_f1x_DTL.KV is 'Ід. валюти';
comment on column v_nbur_f1x_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column v_nbur_f1x_DTL.CUST_ID is 'Ід. клієнта';
comment on column v_nbur_f1x_DTL.CUST_CODE is 'Код клієнта';
comment on column v_nbur_f1x_DTL.CUST_NAME is 'Назва клієнта';
comment on column v_nbur_f1x_DTL.ND is 'Ід. договору';
comment on column v_nbur_f1x_DTL.REF is 'Ід. платіжного документа';
comment on column v_nbur_f1x_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f1x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 