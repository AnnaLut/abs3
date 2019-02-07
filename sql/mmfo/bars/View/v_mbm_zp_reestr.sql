PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/view/v_mbm_zp_reestr.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view bars.v_mbm_zp_reestr as
select a.acc          as rn,
       z.id,
       z.deal_id,
       z.rnk          as rnk,
       c.nmk          as nmk, 
       c.okpo         as okpo, 
       p.passp        as doc_type,
       case when p.passp not in (7) then p.ser else null end    as pass_serial, 
       case when p.passp not in (7) then p.numdoc else null end as pass_num, 
       case p.passp when 7 then p.numdoc else null end          as eddr_num, 
       case p.passp when 7 then p.eddr_id else null end         as eddr_id,
       case p.passp when 7 then p.actual_date else null end     as eddr_actual_date, 
       c.kf           as kf,
       a.nls          as nls,
       a.dazs         as dazs,
       c.date_off     as date_off,
       ap.status      as acc_pk_status,
       c.rnk          as staff_rnk
from zp_deals z
     inner join zp_acc_pk ap on ap.id = z.id
     inner join accounts a on a.acc = ap.acc_pk
     inner join customer c on c.rnk = a.rnk
     left join person p on p.rnk = c.rnk;

PROMPT *** Create comments on bars.v_mbm_zp_reestr ***

comment on table bars.v_mbm_zp_reestr is 'Закріплені рахунки 2625 по ЗП договорам';

comment on column bars.v_mbm_zp_reestr.rn               is 'Якесь унікальне поле (в даному випадку acc)';
comment on column bars.v_mbm_zp_reestr.id               is 'id зп договора';
comment on column bars.v_mbm_zp_reestr.deal_id          is 'Номер зп договора';
comment on column bars.v_mbm_zp_reestr.rnk              is 'RNK';
comment on column bars.v_mbm_zp_reestr.nmk              is 'ПІБ';
comment on column bars.v_mbm_zp_reestr.okpo             is 'ІПН';
comment on column bars.v_mbm_zp_reestr.doc_type         is 'Тип документа (bars.passp)';
comment on column bars.v_mbm_zp_reestr.pass_serial      is 'Серія';
comment on column bars.v_mbm_zp_reestr.pass_num         is 'Номер';
comment on column bars.v_mbm_zp_reestr.eddr_num         is 'Номер паспорту нового зразка (ід картка)';
comment on column bars.v_mbm_zp_reestr.eddr_id          is 'Унікальний номер ід картки';
comment on column bars.v_mbm_zp_reestr.eddr_actual_date is 'Строк дії паспорту нового зразка';
comment on column bars.v_mbm_zp_reestr.kf               is 'Код банку (мфо банку)';
comment on column bars.v_mbm_zp_reestr.nls              is 'Номер рахунку (який привязано до зкп)';
comment on column bars.v_mbm_zp_reestr.dazs             is 'Дата закриття рахунка';
comment on column bars.v_mbm_zp_reestr.date_off         is 'Дата закриття клієнта банку (2625)';
comment on column bars.v_mbm_zp_reestr.acc_pk_status    is 'Ознака блокування працівника в зкп';
comment on column bars.v_mbm_zp_reestr.staff_rnk        is 'RNK працівника';

PROMPT *** Create  grants  v_mbm_zp_reestr ***

grant select on bars.v_mbm_zp_reestr to upld;
grant select on bars.v_mbm_zp_reestr to barsreader_role;
grant select on bars.v_mbm_zp_reestr to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_mbm_zp_reestr.sql =========*** End *** =
PROMPT ===================================================================================== 
