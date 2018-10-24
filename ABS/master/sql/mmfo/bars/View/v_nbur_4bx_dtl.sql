
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_4bx_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_4bx_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.F058
         , d.TXT    as F058_TXT
         , p.Q003_2
         , p.T070
    from NBUR_LOG_F4BX p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#4B' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
         join F058 d on (d.f058 = p.f058)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_4bx_DTL is 'Детальний протокол файлу 4BX';
comment on column v_nbur_4bx_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_4bx_DTL.KF is 'Код фiлiалу (МФО)';
comment on column v_nbur_4bx_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_4bx_DTL.EKP    is 'Код показника';
comment on column v_nbur_4bx_DTL.F058   is 'Код підгрупи банківської групи';
comment on column v_nbur_4bx_DTL.Q003_2 is 'Порядковий номер підгрупи';
comment on column v_nbur_4bx_DTL.T070   is 'Сума';
comment on column v_nbur_4bx_DTL.F058_TXT   is 'Назва пiдгрупи';

--comment on column v_nbur_4bx_DTL.DESCRIPTION is 'Опис (коментар)';
--comment on column v_nbur_4bx_DTL.KV is 'Ід. валюти';
--comment on column v_nbur_4bx_DTL.CUST_ID is 'Ід. клієнта';
--comment on column v_nbur_4bx_DTL.CUST_CODE is 'Код клієнта';
--comment on column v_nbur_4bx_DTL.CUST_NAME is 'Назва клієнта';
--comment on column v_nbur_4bx_DTL.BRANCH is 'Код підрозділу';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_4bx_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
