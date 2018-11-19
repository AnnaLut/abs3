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
       to_char(r.birth, 'dd.mm.yyyy') as public_rels_birth
from finmon_public_customers c
     left join person p on p.rnk = c.rnk
     left join finmon_public_rels r on r.id = c.num_reel;

PROMPT *** Create comments on bars.v_finmon_public_customers ***

comment on table bars.v_finmon_public_customers                    is 'Перелік виявлени клієнтів - публічних діячів';
comment on column bars.v_finmon_public_customers.id                is 'Унікальний код';
comment on column bars.v_finmon_public_customers.rnk               is 'Реєстраційний номер клієнта в БД';
comment on column bars.v_finmon_public_customers.nmk               is 'Найменування клієнта в БД';
comment on column bars.v_finmon_public_customers.crisk             is 'Категорія ризику клієнта на дату перевірки';
comment on column bars.v_finmon_public_customers.cust_risk         is 'Критерії ризику клієнта на дату перевірки';
comment on column bars.v_finmon_public_customers.check_date        is 'Дата перевірки клієнта на відповідність переліку публічних діячів';
comment on column bars.v_finmon_public_customers.rnk_reel          is 'RNK пов`язаної особи';
comment on column bars.v_finmon_public_customers.nmk_reel          is 'ПІБ/Назва пов`язаної особи';
comment on column bars.v_finmon_public_customers.num_reel          is '№ пов`яз. особи в переліку публічних осіб';
comment on column bars.v_finmon_public_customers.comments          is 'Коментар';
comment on column bars.v_finmon_public_customers.kf                is 'МФО';
comment on column bars.v_finmon_public_customers.person_birth      is 'Дата народження клієнта';
comment on column bars.v_finmon_public_customers.public_rels_birth is 'Дата народження особи з переліку ПЕП';

PROMPT *** Create  grants  v_finmon_public_customers ***

grant select on bars.v_finmon_public_customers to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_finmon_public_customers.sql =========*** End *** =
PROMPT ===================================================================================== 
