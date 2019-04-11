PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_81x_dtl.sql ====*** Run *** ===
PROMPT ===================================================================================== 

create or replace view v_nbur_81X_dtl as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.KU
         , p.T020
         , p.R020
         , p.R030
         , p.K040
         , p.T070
         , p.T071
         , p.DESCRIPTION
         , p.ACC_ID
         , p.ACC_NUM
         , p.KV
         , p.CUST_ID
         , p.CUST_CODE
         , p.CUST_NAME
         , p.BRANCH
    from NBUR_LOG_F81X p
         join NBUR_REF_FILES f on (f.FILE_CODE = '81X' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED')
   order by EKP,R020,R030;

comment on table V_NBUR_81X_DTL			is 'Детальний протокол файлу 81X';
comment on column V_NBUR_81X_DTL.REPORT_DATE	is 'Звітна дата';
comment on column V_NBUR_81X_DTL.KF		is 'Код фiлiї (МФО)';
comment on column V_NBUR_81X_DTL.NBUC		is 'Код МФО';
comment on column V_NBUR_81X_DTL.VERSION_ID	is 'Ід. версії файлу';
comment on column V_NBUR_81X_DTL.EKP		is 'Код показника';
comment on column V_NBUR_81X_DTL.KU		is 'Код території';
comment on column V_NBUR_81X_DTL.T020		is 'Елемент рахунку';
comment on column V_NBUR_81X_DTL.R020		is 'Номер рахунку';
comment on column V_NBUR_81X_DTL.R030		is 'Код валюти';
comment on column V_NBUR_81X_DTL.K040		is 'Код країни';
comment on column V_NBUR_81X_DTL.T070		is 'Сума в гривневому еквіваленті';
comment on column V_NBUR_81X_DTL.T071		is 'Сума в гривневому номіналі';
comment on column V_NBUR_81X_DTL.DESCRIPTION	is 'Опис (коментар)';
comment on column V_NBUR_81X_DTL.ACC_ID		is 'Ід. рахунка';
comment on column V_NBUR_81X_DTL.ACC_NUM	is 'Номер рахунка';
comment on column V_NBUR_81X_DTL.KV		is 'Ід. валюти';
comment on column V_NBUR_81X_DTL.CUST_ID	is 'Ід. клієнта';
comment on column V_NBUR_81X_DTL.CUST_CODE	is 'Код клієнта';
comment on column V_NBUR_81X_DTL.CUST_NAME	is 'Назва клієнта';
comment on column V_NBUR_81X_DTL.BRANCH		is 'Код підрозділу';

   GRANT SELECT ON V_NBUR_81X TO UPLD;
   GRANT SELECT ON V_NBUR_81X TO BARS_ACCESS_DEFROLE;
   GRANT SELECT ON V_NBUR_81X TO BARSREADER_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_81x_dtl.sql =====*** End *** ===
PROMPT ===================================================================================== 
