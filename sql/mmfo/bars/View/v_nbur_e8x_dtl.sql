PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_e8x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_e8x_dtl ***

create or replace view v_nbur_e8x_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.Q001
     , p.Q029
     , p.K074
     , p.K110
     , p.K040
     , p.KU_1
     , p.Q020
     , p.K020
     , p.K014
     , p.R020
     , p.R030
     , p.Q003_1
     , p.Q003_2
     , p.Q007_1
     , p.Q007_2
     , p.T070_1
     , p.T070_2
     , p.T070_3
     , p.T070_4
     , p.T090
     , p.Q003_12
     , p.K021
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_FE8X p
       join NBUR_REF_FILES f on (f.FILE_CODE = 'E8X')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
   
comment on table V_NBUR_E8X_DTL is 'Детальний протокол файлу E8X';
comment on column V_NBUR_E8X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_E8X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_E8X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_E8X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_E8X_DTL.EKP is 'Код показника';
comment on column V_NBUR_E8X_DTL.KU is 'Код області';
comment on column V_NBUR_E8X_DTL.T070_1 is 'Основна сума боргу';
comment on column V_NBUR_E8X_DTL.T070_2 is 'Неамортизовані дисконт/премія';
comment on column V_NBUR_E8X_DTL.T070_3 is 'Нараховані витрати';
comment on column V_NBUR_E8X_DTL.T070_4 is 'Переоцінка (дооцінка/уцінка)';
comment on column V_NBUR_E8X_DTL.T090 is 'Розмір процентної ставки';
comment on column V_NBUR_E8X_DTL.K040 is 'Код країни кредитора';
comment on column V_NBUR_E8X_DTL.KU_1 is 'Код регіону, у якому зареєстрований кредитор';
comment on column V_NBUR_E8X_DTL.K014 is 'Код типу клієнта банку';
comment on column V_NBUR_E8X_DTL.K110 is 'Код виду економічної діяльності кредитора';
comment on column V_NBUR_E8X_DTL.K074 is 'Код інституційного сектору економіки';
comment on column V_NBUR_E8X_DTL.R030 is 'Код валюти';
comment on column V_NBUR_E8X_DTL.R020 is 'Номер балансового рахунку';
comment on column V_NBUR_E8X_DTL.Q020 is 'Код типу пов''язаної з банком особи';
comment on column V_NBUR_E8X_DTL.Q003_12 is 'Умовний порядковий номер запису у звітному файлі';
comment on column V_NBUR_E8X_DTL.Q001 is 'Найменування кредитора';
comment on column V_NBUR_E8X_DTL.K020 is 'Ідентифікаційний код кредитора';
comment on column V_NBUR_E8X_DTL.Q029 is 'Код кредитора - нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини';
comment on column V_NBUR_E8X_DTL.Q003_1 is 'Умовний порядковий номер договору у звітному файлі';
comment on column V_NBUR_E8X_DTL.Q003_2 is 'Номер договору';
comment on column V_NBUR_E8X_DTL.Q007_1 is 'Дата договору або дата першого руху коштів';
comment on column V_NBUR_E8X_DTL.Q007_2 is 'Дата кінцевого погашення заборгованості';
comment on column V_NBUR_E8X_DTL.K021 is 'Код ознаки ідентифікаційного коду кредитора';
comment on column V_NBUR_E8X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_E8X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_E8X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_E8X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_E8X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_E8X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_E8X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_e8x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 