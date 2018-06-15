PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_2kx_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_2kx_dtl ***

create or replace view v_nbur_2kx_dtl as
select
     p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , substr(p.FIELD_CODE, 1, 14) as FIELD_CODE
     , substr(p.Field_Code, 15) as FIELD_CD
     , case substr(p.Field_Code, 15)
         when 'EKP' then 'Код показника'
         when 'Q003_1' then 'Умовний порядковий номер запису у звітному файлі'
         when 'Q001_1' then 'Найменування / ПІБ санкційної особи, зазначеної в додатку до рішення РНБО України'
         when 'Q002' then 'Місцезнаходження/місце проживання, перебування санкційної особи'
         when 'K020_1' then 'Код за ЄДРПОУ/ІПН'
         when 'K021_1' then 'Ознака коду за ЄДРПОУ/ІПН'
         when 'Q003_2' then 'Номер позиції згідно із відповідним додатком до рішення РНБО України'
         when 'Q003_3' then 'Номер указу Президента України, згідно з яким введено в дію рішення РНБО України'
         when 'Q030' then 'Санкція відповідно до рішення РНБО України'
         when 'Q006' then 'Примітка'
         when 'F086' then 'Стан рахунку санкційної особи'
         when 'Q003_4' then 'Номер рахунку санкційної особи'
         when 'R030_1' then 'Код валюти рахунку санкційної особи'
         when 'Q007_1' then 'Дата відкриття рахунку санкційної особи'
         when 'Q007_2' then 'Дата закриття рахунку санкційної особи'
         when 'Q031_1' then 'Стан застосування санкції щодо рахунку санкційної особи'
         when 'T070_1' then 'Залишок коштів на рахунку санкційної особи станом на дату введення в дію рішення РНБО України'
         when 'T070_2' then 'Залишок коштів на рахунку санкційної особи станом на звітну дату'
         when 'F088' then 'Код виду фінансової операції, яку мали намір провести'
         when 'Q007_3' then 'Дата спроби проведення фінансової операції'
         when 'Q003_5' then 'Номер рахунку отримувача / платника'
         when 'Q001_2' then 'Найменування / прізвище, ім’я, по батькові отримувача / платника'
         when 'K020_2' then 'Код за ЄДРПОУ / код ІПН отримувача / платника'
         when 'K021_2' then 'Ознака коду за ЄДРПОУ/ІПН'
         when 'Q001_3' then 'Найменування банку отримувача / платника'
         when 'T070_3' then 'Сума фінансової операції'
         when 'R030_2' then 'Код валюти фінансової операції при спробі проведення фінансової операції'
         when 'Q032' then 'Призначення платежу при спробі проведення фінансової операції'
         when 'Q031_2' then 'Дії банку при спробі проведення фінансової операції'
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
                                and (v.FILE_ID = f.ID)
       left join CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
       left join CC_DEAL a on  (p.KF = a.KF)
                               and (p.nd = a.ND )
 where p.REPORT_CODE = '2KX'
       and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
 order by
       FIELD_CODE;
comment on table V_NBUR_2KX_DTL is 'Детальний протокол файлу 2KX';
comment on column V_NBUR_2KX_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_2KX_DTL.KF is 'Код фiлiалу (МФО)';
comment on column V_NBUR_2KX_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column V_NBUR_2KX_DTL.NBUC is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_2KX_DTL.FIELD_CODE is 'Код показника';
comment on column V_NBUR_2KX_DTL.FIELD_CD is 'Код показника у файлі';
comment on column V_NBUR_2KX_DTL.FIELD_NAME is 'Назва показника';
comment on column V_NBUR_2KX_DTL.FIELD_VALUE is 'Значення показника';
comment on column V_NBUR_2KX_DTL.DESCRIPTION is 'Опис (коментар)';
comment on column V_NBUR_2KX_DTL.ACC_ID is 'Ід. рахунка';
comment on column V_NBUR_2KX_DTL.ACC_NUM is 'Номер рахунка';
comment on column V_NBUR_2KX_DTL.KV is 'Ід. валюти';
comment on column V_NBUR_2KX_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_2KX_DTL.CUST_ID is 'Ід. клієнта';
comment on column V_NBUR_2KX_DTL.CUST_CODE is 'Код клієнта';
comment on column V_NBUR_2KX_DTL.CUST_NAME is 'Назва клієнта';
comment on column V_NBUR_2KX_DTL.ND is 'Ід. договору';
comment on column V_NBUR_2KX_DTL.AGRM_NUM is 'Номер договору';
comment on column V_NBUR_2KX_DTL.BEG_DT is 'Дата початку договору';
comment on column V_NBUR_2KX_DTL.END_DT is 'Дата закінчення договору';
comment on column V_NBUR_2KX_DTL.REF is 'Ід. платіжного документа';
comment on column V_NBUR_2KX_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_2kx_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 