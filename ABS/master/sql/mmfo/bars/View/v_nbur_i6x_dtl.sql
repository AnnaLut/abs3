PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_I6X_dtl.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view v_nbur_I6X_dtl ***

create or replace view v_nbur_I6X_dtl as
select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.EKP
     , p.KU
     , p.T020
     , p.R020
     , p.R011
     , p.R030
     , p.K040
     , p.K072
     , p.K111
     , p.S183
     , p.S241
     , p.F048
     , p.T070
     , p.T090
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.MATURITY_DATE
     , p.CUST_ID
     , p.ND
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.BRANCH
  from NBUR_LOG_FI6X p
       join NBUR_REF_FILES f on (f.FILE_CODE = 'I6X')
       join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                and (v.KF = p.KF)
                                and (v.VERSION_ID = p.VERSION_ID)
                                and (v.FILE_ID = f.ID )
       LEFT JOIN CUSTOMER c on (p.KF = c.KF)
                               and (p.CUST_ID = c.RNK )
 where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );
   
comment on table V_NBUR_I6X_DTL              is 'Детальний протокол файлу I6X';
comment on column V_NBUR_I6X_DTL.REPORT_DATE is 'Звітна дата';
comment on column V_NBUR_I6X_DTL.KF          is 'Код фiлiалу (МФО)';
comment on column V_NBUR_I6X_DTL.KU          is 'Код регіону';
comment on column V_NBUR_I6X_DTL.VERSION_ID  is 'Ід. версії файлу';
comment on column V_NBUR_I6X_DTL.NBUC        is 'Код розрізу даних у звітному файлі';
comment on column V_NBUR_I6X_DTL.EKP         is 'Код показника';
comment on column V_NBUR_I6X_DTL.KU          is 'Код областi розрiзу юридичної особи';
comment on column V_NBUR_I6X_DTL.T020        is 'Елемент рахунку';
comment on column V_NBUR_I6X_DTL.R020        is 'Номер рахунку';
comment on column V_NBUR_I6X_DTL.R011        is 'Код за параметром розподілу аналітичного рахунку R011';
comment on column V_NBUR_I6X_DTL.R030        is 'Код валюти';
comment on column V_NBUR_I6X_DTL.K040        is 'Код країни';
comment on column V_NBUR_I6X_DTL.K072        is 'Код сектору економіки';
comment on column V_NBUR_I6X_DTL.K111        is 'Код роздiлу виду економiчної дiяльностi';
comment on column V_NBUR_I6X_DTL.S183        is 'Узагальнений код початкових строків погашення';
comment on column V_NBUR_I6X_DTL.S241        is 'Узагальнений код строків до погашення';
comment on column V_NBUR_I6X_DTL.F048        is 'Код типу процентної ставки';
comment on column V_NBUR_I6X_DTL.T070        is 'Сума';
comment on column V_NBUR_I6X_DTL.T090        is 'Процентна ставка';
comment on column V_NBUR_I6X_DTL.ACC_ID      is 'Ід. рахунка';
comment on column V_NBUR_I6X_DTL.ACC_NUM     is 'Номер рахунка';
comment on column V_NBUR_I6X_DTL.MATURITY_DATE is 'Дата Погашення';
comment on column V_NBUR_I6X_DTL.KV          is 'Ід. валюти';
comment on column V_NBUR_I6X_DTL.ND          is 'Ід. договору';
comment on column V_NBUR_I6X_DTL.CUST_ID     is 'Ід. клієнта';
comment on column V_NBUR_I6X_DTL.CUST_CODE   is 'Код клієнта';
comment on column V_NBUR_I6X_DTL.CUST_NAME   is 'Назва клієнта';
comment on column V_NBUR_I6X_DTL.BRANCH      is 'Код підрозділу';


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_I6X_dtl.sql =========*** End *** =
PROMPT ===================================================================================== 