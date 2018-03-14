create or replace view v_nbu_reported_pledge as
select o.id,
       p.person_code,
       p.person_name,
       p.loan_amount / 100 loan_amount,
       case when o.state_id = 1 then 'Новий'
            when o.state_id = 2 then 'Модифікований'
            when o.state_id = 3 then 'Передача даних до НБУ'
            when o.state_id = 4 then 'Помилка передачі даних'
            when o.state_id = 5 then 'Переданий до НБУ'
            when o.state_id = 6 then 'Відкликаний'
            else to_char(o.state_id)
       end object_state,
       cast(null as varchar2(4000 byte))/*nbu_data_service.get_reported_object_comment(o.id)*/ object_comment
from   nbu_reported_object o
join   nbu_reported_pledge pl on pl.id = o.id
join   nbu_reported_person p on p.id = o.;

comment on column v_nbu_reported_person.id is 'Ідентифікатор об''єкта для передачі до НБУ';
comment on column v_nbu_reported_person.person_code is 'Код ІПН';
comment on column v_nbu_reported_person.person_name is 'Ім''я позичальника';
comment on column v_nbu_reported_person.loan_amount is 'Загальна сума заборгованості';
comment on column v_nbu_reported_person.object_state is 'Стан обробки';
comment on column v_nbu_reported_person.object_comment is 'Коментар обробки';

grant select on v_nbu_reported_person to bars_access_defrole;
