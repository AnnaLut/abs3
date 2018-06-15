PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_e8x_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_e8x_dtl ***

create or replace view v_nbur_e8x_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , substr(p.FIELD_CODE, 1, 10) as FIELD_CODE
     , substr(p.FIELD_CODE, 11) as FIELD_CD
     , case substr(p.FIELD_CODE, 11)
         when 'EKP' then 'Код показника'
         when 'Q003_12' then 'Умовний порядковий номер запису у звітному файлі'
         when 'Q001' then 'Найменування кредитора'
         when 'K020' then 'Код кредитора'
         when 'K021' then 'Код ознаки коду кредитора'
         when 'Q029' then 'Код кредитора - нерезидента або серія і номер свідоцтва про народження неповнолітньої дитини'
         when 'Q020' then 'Код типу пов''язаної з банком особи'
         when 'K040' then 'Код країни кредитора'
         when 'KU_1' then 'Код регіону, у якому зареєстрований кредитор'
         when 'K014' then 'Код типу клієнта банку'
         when 'K110' then 'Код виду економічної діяльності кредитора'
         when 'K074' then 'Код інституційного сектору економіки'
         when 'Q003_1' then 'Умовний порядковий номер договору у звітному файлі'
         when 'Q003_2' then 'Номер договору'
         when 'Q007_1' then 'Дата договору або дата першого руху коштів'
         when 'Q007_2' then 'Дата кінцевого погашення заборгованості'
         when 'R030' then 'Код валюти'
         when 'T090' then 'Розмір процентної ставки'
         when 'R020' then 'Номер балансового рахунку'
         when 'T070_1' then 'Основна сума боргу'
         when 'T070_2' then 'Неамортизовані дисконт/премія'
         when 'T070_3' then 'Нараховані витрати'
         when 'T070_4' then 'Переоцінка (дооцінка/уцінка)'
       else
         'Невідомий показник'
       end as FIELD_NAME
     , p.FIELD_VALUE
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.MATURITY_DATE
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.ND
     , a.CC_ID AGRM_NUM
     , a.SDATE BEG_DT
     , a.WDATE END_DT
     , p.REF
     , p.BRANCH
  from NBUR_DETAIL_PROTOCOLS_ARCH p
       join NBUR_REF_FILES f on (f.FILE_CODE = p.REPORT_CODE)
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
       LEFT JOIN CC_DEAL a  on (p.KF = a.KF)
                               and (p.nd = a.ND )
 where p.REPORT_CODE = 'E8X'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
comment on table V_NBUR_E8X_DTL is 'Детальний протокол файлу E8X';
comment on column V_NBUR_E8X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_E8X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_E8X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_E8X_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_E8X_DTL.FIELD_CODE is 'Код показника';
comment on column V_NBUR_E8X_DTL.FIELD_CD is 'Код показника у файлі';
comment on column V_NBUR_E8X_DTL.FIELD_NAME is 'Найменування показника';
comment on column V_NBUR_E8X_DTL.FIELD_VALUE is 'Значення показника';
comment on column V_NBUR_E8X_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_E8X_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_E8X_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_E8X_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_E8X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_E8X_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_E8X_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_E8X_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_E8X_DTL.ND is 'Ід. договору';
comment on column V_NBUR_E8X_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_E8X_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_E8X_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_E8X_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_E8X_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_e8x_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 