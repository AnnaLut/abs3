
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_nbur_f5x_dtl.sql =========*** Run ***
PROMPT ===================================================================================== 

create or replace view v_nbur_f5x_dtl
 as
select p.REPORT_DATE
         , p.KF
         , p.NBUC
         , p.VERSION_ID
         , p.EKP
         , p.Z230
         , p.Z350
         , p.K045
         , p.Z130
         , p.Z140
         , p.Z150
         , p.KU
--         , d.TXT    as F058_TXT
         , p.T070
         , p.T080
    from NBUR_LOG_FF5X p
         join NBUR_REF_FILES f on (f.FILE_CODE = '#F5' )
         join NBUR_LST_FILES v on (v.REPORT_DATE = p.REPORT_DATE)
                                  and (v.KF = p.KF)
                                  and (v.VERSION_ID = p.VERSION_ID)
                                  and (v.FILE_ID = f.ID)
--         join F058 d on (d.f058 = p.f058)
   where v.FILE_STATUS IN ('FINISHED', 'BLOCKED');

comment on table  v_nbur_F5X_DTL is 'Детальний протокол файлу F5X';
comment on column v_nbur_F5X_DTL.REPORT_DATE is 'Звітна дата';
comment on column v_nbur_F5X_DTL.KF is 'Код фiлiалу (МФО)';
comment on column v_nbur_F5X_DTL.VERSION_ID is 'Ід. версії файлу';
comment on column v_nbur_F5X_DTL.EKP    is 'Код показника';
comment on column v_nbur_F5X_DTL.Z230    IS 'Код платіжної системи';
comment on column v_nbur_F5X_DTL.Z350    IS 'Код емітента платіжної картки';
comment on column v_nbur_F5X_DTL.K045    IS 'Код території, де здійснена незаконна дія/сумнівна операція';
comment on column v_nbur_F5X_DTL.Z130    IS 'Тип незаконної дії або сумнівної операції з платіжними картками';
comment on column v_nbur_F5X_DTL.Z140    IS 'Код учасника операцій з платіжними картками';
comment on column v_nbur_F5X_DTL.Z150    IS 'Код місця здійснення операції з платіжною карткою';
comment on column v_nbur_F5X_DTL.KU      IS 'Код адміністративно-територіальної одиниці України розташування платіжного пристрою';
comment on column v_nbur_F5X_DTL.T070    IS 'Сума збитків від незаконних дій з платіжними картками';
comment on column v_nbur_F5X_DTL.T080    IS 'Кількість сумнівних операцій з платіжними картками';
--comment on column v_nbur_F5X_DTL.F058_TXT   is 'Назва пiдгрупи';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_nbur_f5x_dtl.sql =========*** End ***
PROMPT ===================================================================================== 
