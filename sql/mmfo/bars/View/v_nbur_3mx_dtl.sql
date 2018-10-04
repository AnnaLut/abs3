PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_3mx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_3MX_DTL
AS
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.Q003_1   as FIELD_CODE
         , p.EKP
         , p.KU
         , p.T071
         , p.Q003_1
         , p.F091
         , p.R030
         , p.F090
         , p.K040
         , p.F089
         , p.K020
         , p.K021
         , p.Q001_1
         , p.B010
         , p.Q033
         , p.Q001_2
         , p.Q003_2
         , p.Q007_1
         , p.F027
         , p.F02D
         , p.Q006
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , p.REF
         , p.BRANCH
    from NBUR_LOG_F3MX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#3M' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table v_nbur_3mx_DTL is 'Детальний протокол файлу 3MX';
comment on column v_nbur_3mx_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_3mx_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_3mx_DTL.NBUC is 'Код розрізу даних';
comment on column v_nbur_3mx_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_3mx_DTL.FIELD_CODE is 'Код показника';
comment on column v_nbur_3mx_DTL.EKP is 'XML Код показника';
comment on column v_nbur_3mx_DTL.KU is 'Код території';
comment on column v_nbur_3mx_DTL.T071 is 'Сума';
comment on column v_nbur_3mx_DTL.Q003_1 is 'Умовний номер рядка';
comment on column v_nbur_3mx_DTL.F091 is 'Код операції';
comment on column v_nbur_3mx_DTL.R030 is 'Код валюти';
comment on column v_nbur_3mx_DTL.F090 is 'Код мети надходження/переказу';
comment on column v_nbur_3mx_DTL.K040 is 'Код країни';
comment on column v_nbur_3mx_DTL.F089 is 'Ознака консолідації';
comment on column v_nbur_3mx_DTL.K020 is 'Код відправника/отримувача';
comment on column v_nbur_3mx_DTL.K021 is 'Код ознаки ідентифікаційного коду';
comment on column v_nbur_3mx_DTL.Q001_1 is 'Найменування клієнта';
comment on column v_nbur_3mx_DTL.B010 is 'Код іноземного банку';
comment on column v_nbur_3mx_DTL.Q033 is 'Назва іноземного банку';
comment on column v_nbur_3mx_DTL.Q001_2 is 'Найменування контрагента - бенефіціара';
comment on column v_nbur_3mx_DTL.Q003_2 is 'Номер контракту/договору, кредитного договору/договору позики';
comment on column v_nbur_3mx_DTL.Q007_1 is 'Дата контракту/договору, кредитного договору/договору позики';
comment on column v_nbur_3mx_DTL.F027 is 'Код індикатора';
comment on column v_nbur_3mx_DTL.F02D is 'Код за деякими операціями';
comment on column v_nbur_3mx_DTL.Q006 is 'Відомості про операцію';
comment on column v_nbur_3mx_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column v_nbur_3mx_DTL.ACC_ID is 'Ід. рахунка';
comment on column v_nbur_3mx_DTL.ACC_NUM is 'Номер рахунка';
comment on column v_nbur_3mx_DTL.KV is 'Ід. валюти';
comment on column v_nbur_3mx_DTL.CUST_ID is 'Ід. клієнта';
comment on column v_nbur_3mx_DTL.REF is 'Ід. платіжного документа';
comment on column v_nbur_3mx_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_3mx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
