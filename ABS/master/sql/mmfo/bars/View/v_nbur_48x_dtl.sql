PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_48x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_48x_dtl ***

create or replace view v_nbur_48x_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.Q003 as FIELD_CODE
         , p.EKP
         , p.Q003
         , p.Q001
         , p.Q002
         , p.Q008
         , p.Q029
         , p.K020
         , p.K021
         , p.K040
         , p.K110
         , p.T070
         , p.T080
         , p.T090_1
         , p.T090_2
         , p.T090_3
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.MATURITY_DATE
         , p.CUST_ID
         , c.CUST_CODE
         , c.CUST_NAME
         , p.ND
         , a.AGRM_NUM
         , a.BEG_DT
         , a.END_DT
         , p.REF
         , p.BRANCH
    from NBUR_LOG_F48X p
         join NBUR_REF_FILES f on (f.FILE_CODE = '48X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         left join V_NBUR_DM_CUSTOMERS c on (p.REPORT_DATE = c.REPORT_DATE)
                                            and (p.KF = c.KF)
                                            and (p.CUST_ID    = c.CUST_ID)
         left  join V_NBUR_DM_AGREEMENTS a on (p.REPORT_DATE = a.REPORT_DATE)
                                              and (p.KF = a.KF)
                                              and (p.nd = a.AGRM_ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table V_NBUR_48X_DTL is 'Детальний протокол файлу 48X';
comment on column V_NBUR_48X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_48X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_48X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_48X_DTL.FIELD_CODE is 'Зведений код показника';
comment on column V_NBUR_48X_DTL.EKP is 'Код показника';
comment on column V_NBUR_48X_DTL.Q003 is 'Умовний порядковий номер учасника банку';
comment on column V_NBUR_48X_DTL.Q001 is 'Повне найменування юридичної особи або прізвище, ім’я, по батькові фізичної особи учасника банку';
comment on column V_NBUR_48X_DTL.Q002 is 'Адреса юридичної особи або адреса постійного місця проживання фізичної особи';
comment on column V_NBUR_48X_DTL.Q008 is 'Платіжні реквізити юридичної особи або паспортні дані фізичної особи';
comment on column V_NBUR_48X_DTL.Q029 is 'Код учасника банку нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини';
comment on column V_NBUR_48X_DTL.K020 is 'Код учаснику банку';
comment on column V_NBUR_48X_DTL.K021 is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column V_NBUR_48X_DTL.K040 is 'Код країни учасника банку';
comment on column V_NBUR_48X_DTL.K110 is 'Код виду економічної діяльності учасника банку';
comment on column V_NBUR_48X_DTL.T070 is 'Вартість акцій (паїв)';
comment on column V_NBUR_48X_DTL.T080 is 'Кількість акцій (паїв)';
comment on column V_NBUR_48X_DTL.T090_1 is 'Відсоток прямої участі у статутному капіталі';
comment on column V_NBUR_48X_DTL.T090_2 is 'Відсоток опосередкованої участі у статутному капіталі';
comment on column V_NBUR_48X_DTL.T090_3 is 'Відсоток загальної участі у статутному капіталі';
comment on column V_NBUR_48X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_48X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_48X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_48X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_48X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_48X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_48X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_48X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_48X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_48X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_48X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_48X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_48X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_48X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_48x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 