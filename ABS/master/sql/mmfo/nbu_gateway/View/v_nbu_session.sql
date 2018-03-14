create or replace view v_nbu_session as
select s.id,
       o.id object_id,
       o.object_type_id,
       case when o.object_type_id = 1 then 'Գ����� �����'
            when o.object_type_id = 2 then '�������� �����'
            when o.object_type_id = 3 then '�������'
            when o.object_type_id = 4 then '������'
            else null
       end object_type_name,
       case when o.object_type_id in (1, 2) then c.customer_code
            when o.object_type_id = 3 then pl.pledge_number
            when o.object_type_id = 4 then cr.loan_number
            else null
       end object_code,
       case when o.object_type_id in (1, 2) then c.customer_name
            when o.object_type_id = 3 then '������ ������� � ' || pl.pledge_number || ' �� ' || to_char(pl.pledge_date, 'dd.mm.yyyy')
            when o.object_type_id = 4 then '������ � ' || cr.loan_number || ' �� ' || to_char(cr.loan_date, 'dd.mm.yyyy')
            else null
       end object_name,
       (select min(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_creation_time,
       (select max(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_activity_time,
       s.session_type_id,
       case when s.session_type_id = 1 then '����� ��''���'
            when s.session_type_id = 2 then '�����������'
            when s.session_type_id = 3 then '��������� ����� �� ���'
            when s.session_type_id = 4 then '��������� ��''����'
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
where s.state_id = 2 /*nbu_service_utl.SESSION_STATE_TO_SIGN*/;

grant all on v_nbu_session to bars_access_defrole;
