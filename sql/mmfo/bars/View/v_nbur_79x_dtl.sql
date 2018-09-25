PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_79X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_79X_dtl ***

create or replace view v_nbur_79X_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.R030
     , p.K030
     , p.Q001
     , p.K020
     , p.K021
     , p.Q007_1
     , p.Q007_2
     , p.Q007_3
     , p.Q007_4
     , p.Q003_1
     , p.Q003_2
     , p.Q003_3
     , p.T070_1
     , p.T070_2
     , p.T070_3
     , p.T070_4
     , p.T090_1
     , p.T090_2
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_F79X p
       join NBUR_REF_FILES f on (f.FILE_CODE = '79X')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
   
comment on table V_NBUR_79X_DTL is 'Детальний протокол файлу 79X';
comment on column V_NBUR_79X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_79X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_79X_DTL.KU is 'Код регіону';
comment on column V_NBUR_79X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_79X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_79X_DTL.EKP    is 'Код показника';
comment on column V_NBUR_79X_DTL.R030   is 'Код валюти субординованого боргу';
comment on column V_NBUR_79X_DTL.K030   is 'Код резидентності інвестора';
comment on column V_NBUR_79X_DTL.Q001   is 'Повне найменування юридичної особи або прізвище, ім’я, по батькові фізичної особи інвестора';
comment on column V_NBUR_79X_DTL.K020   is 'Код інвестора';
comment on column V_NBUR_79X_DTL.K021   is 'Код ознаки ідентифікаційного/реєстраційного коду/номера';
comment on column V_NBUR_79X_DTL.Q007_1 is 'Дата укладення угоди про субординований борг';
comment on column V_NBUR_79X_DTL.Q007_2 is 'Дата закінчення дії угоди про субординований борг';
comment on column V_NBUR_79X_DTL.Q007_3 is 'Дата рішення Комітету з питань нагляду та регулювання діяльності банків про включення до капіталу';
comment on column V_NBUR_79X_DTL.Q007_4 is 'Дата реєстрації договору';
comment on column V_NBUR_79X_DTL.Q003_1 is 'Номер рішення Комітету з питань нагляду та регулювання діяльності банків про включення до капіталу';
comment on column V_NBUR_79X_DTL.Q003_2 is 'Номер реєстрації договору';
comment on column V_NBUR_79X_DTL.Q003_3 is 'Умовний порядковий номер боргу для конкретного інвестора';
comment on column V_NBUR_79X_DTL.T070_1 is 'Сума залученого субординованого боргу для врахування до капіталу банку за б/р 3660,3661';
comment on column V_NBUR_79X_DTL.T070_2 is 'Сума, на яку отримано дозвіл на врахування залучених коштів на умовах субординованого боргу до капіталу банку';
comment on column V_NBUR_79X_DTL.T070_3 is 'Сума субординованого боргу, яка враховується в розрахунку регулятивного капіталу банку';
comment on column V_NBUR_79X_DTL.T070_4 is 'Сума перевищення обмеження, установленого пунктом 3.10 глави 3 розділу III Інструкції № 368';
comment on column V_NBUR_79X_DTL.T090_1 is 'Процент, який береться до розрахунку суми субординованого боргу';
comment on column V_NBUR_79X_DTL.T090_2 is 'Розмір процентної ставки, яка встановлюється за субординованим боргом, згідно з угодою';
comment on column V_NBUR_79X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_79X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_79X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_79X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_79X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_79X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_79X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_79X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 