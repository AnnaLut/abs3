create or replace view v_nbu_credit_insurance_files as
select F.ID,
       F.NAME,
       to_char(F.DDATE,'mm.yy') DDATE,
       S.FIO,
       F.CHGDATE,
       --F.KF,
       case F.STATE when 0 then 'Завантажено' when 1 then 'Оброблено' when 2 then 'Завантажено з помилками' end state 
from NBU_CREDIT_INSURANCE_FILES F,
     STAFF$BASE                 S
where s.id = f.idupd
order by f.id desc;

comment on table V_NBU_CREDIT_INSURANCE_FILES is 'Завантажені файли';
comment on column V_NBU_CREDIT_INSURANCE_FILES.ID is 'Код файлу';
comment on column V_NBU_CREDIT_INSURANCE_FILES.NAME is 'Ім''я файлу';
comment on column V_NBU_CREDIT_INSURANCE_FILES.DDATE is 'Дата файлу';
comment on column V_NBU_CREDIT_INSURANCE_FILES.FIO is 'Користувач';
comment on column V_NBU_CREDIT_INSURANCE_FILES.CHGDATE is 'Системна дата';
--comment on column V_NBU_CREDIT_INSURANCE_FILES.KF is 'РУ';
comment on column V_NBU_CREDIT_INSURANCE_FILES.STATE is 'Статус';

grant SELECT on v_nbu_credit_insurance_files to BARS_ACCESS_DEFROLE;
