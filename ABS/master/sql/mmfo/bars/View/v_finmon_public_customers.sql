PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/view/v_finmon_public_customers.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view bars.v_finmon_public_customers as
select c.id, 
       c.rnk, 
       c.nmk, 
       c.crisk, 
       c.cust_risk, 
       c.check_date,
       c.rnk_reel, 
       c.nmk_reel, 
       c.num_reel, 
       c.comments, 
       c.kf,
       to_char(p.bday, 'dd.mm.yyyy')  as person_birth,
       to_char(r.birth, 'dd.mm.yyyy') as public_rels_birth,
       pep_code,
       d.date_of_birth as pep_birth
from finmon_public_customers c
     left join person p on p.rnk = c.rnk
     left join finmon_public_rels r on r.id = c.num_reel
     left join finmon_pep_dict d on c.pep_code = d.id;

comment on table V_FINMON_PUBLIC_CUSTOMERS is 'Перелік виявлени клієнтів - публічних діячів';
comment on column V_FINMON_PUBLIC_CUSTOMERS.ID is 'Номер в списке КИС';
comment on column V_FINMON_PUBLIC_CUSTOMERS.RNK is 'Реєстраційний номер клієнта в БД';
comment on column V_FINMON_PUBLIC_CUSTOMERS.NMK is 'Найменування клієнта в БД';
comment on column V_FINMON_PUBLIC_CUSTOMERS.CRISK is 'Категорія ризику клієнта на дату перевірки';
comment on column V_FINMON_PUBLIC_CUSTOMERS.CUST_RISK is 'Критерії ризику клієнта на дату перевірки';
comment on column V_FINMON_PUBLIC_CUSTOMERS.CHECK_DATE is 'Дата перевірки клієнта на відповідність переліку публічних діячів';
comment on column V_FINMON_PUBLIC_CUSTOMERS.RNK_REEL is 'RNK пов`язаної особи';
comment on column V_FINMON_PUBLIC_CUSTOMERS.NMK_REEL is 'ПІБ/Назва пов`язаної особи';
comment on column V_FINMON_PUBLIC_CUSTOMERS.NUM_REEL is '№ пов`яз. особи в переліку публічних осіб (КІС)';
comment on column V_FINMON_PUBLIC_CUSTOMERS.COMMENTS is 'Коментар';
comment on column V_FINMON_PUBLIC_CUSTOMERS.KF is 'МФО';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PERSON_BIRTH is 'Дата народження клієнта';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PUBLIC_RELS_BIRTH is 'Дата народження особи з переліку КІС';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PEP_CODE is 'Номер в списке ПЕП (pep.org.ua)';
comment on column V_FINMON_PUBLIC_CUSTOMERS.PEP_BIRTH is 'Дата народження особи з переліку ПЕП';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_finmon_public_customers.sql =========*** End *** =
PROMPT ===================================================================================== 
