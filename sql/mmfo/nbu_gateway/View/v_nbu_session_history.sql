create or replace view v_nbu_session_history as
select s.id,
       s.report_id,
       o.id object_id,
       o.object_type_id,
       case when o.object_type_id = 1 then 'Фізична особа'
            when o.object_type_id = 2 then 'Юридична особа'
            when o.object_type_id = 3 then 'Застава'
            when o.object_type_id = 4 then 'Кредит'
            else null
       end object_type_name,
       case when o.object_type_id = 1 then c.core_customer_kf
            when o.object_type_id = 2 then c.core_customer_kf
            when o.object_type_id = 3 then pl.core_pledge_kf
            when o.object_type_id = 4 then cr.core_loan_kf
            else null
       end object_kf,
       case when o.object_type_id in (1, 2) then c.customer_code
            when o.object_type_id = 3 then pl.pledge_number
            when o.object_type_id = 4 then cr.loan_number
            else null
       end object_code,
       case when o.object_type_id in (1, 2) then c.customer_name
            when o.object_type_id = 3 then 'Договір застави № ' || pl.pledge_number || ' від ' || to_char(pl.pledge_date, 'dd.mm.yyyy')
            when o.object_type_id = 4 then 'Договір № ' || cr.loan_number || ' від ' || to_char(cr.loan_date, 'dd.mm.yyyy')
            else null
       end object_name,
       (select min(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_creation_time,
       (select max(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_activity_time,
       s.session_type_id,
       case when s.session_type_id = 1 then 'Новий об''єкт'
            when s.session_type_id = 2 then 'Модифікація'
            when s.session_type_id = 3 then 'Отримання даних від НБУ'
            when s.session_type_id = 4 then 'Видалення об''єкта'
            else null
       end session_type_name,
       s.state_id,
       bars.list_utl.get_item_name('NBU_601_SESSION_STATE', s.state_id) session_state,
       (select min(st.tracking_comment) keep (dense_rank last order by st.id) from nbu_session_tracking st where st.session_id = s.id) session_details
from   nbu_session s
join   nbu_reported_object o on o.id = s.object_id
left join nbu_reported_customer c on c.id = s.object_id
left join nbu_reported_pledge pl on pl.id = s.object_id
left join nbu_reported_loan cr on cr.id = s.object_id
order by s.last_activity_at desc, s.id desc;

grant select on v_nbu_session_history to BARS_ACCESS_DEFROLE;