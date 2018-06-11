create or replace view v_nbu_core_data_request as
select s.id, d.kf, d.branch_name, d.data_type_name,
       bars.list_utl.get_item_name('NBU_601_CORE_REQUEST_STATE', nvl(s.state_id, 2 /*nbu_core_service.req_state_waiting_for_data*/)) request_state,
       s.reporting_time,
       s.reporting_person,
       (select min (tr.tracking_message) keep (dense_rank last order by tr.sys_time)
        from   nbu_core_data_request_tracking tr
        where  tr.request_id = s.id) tracking_message
from   (select b.kf, b.branch_name, t.id data_type_id, t.data_type_name,
               (select max(r.id)
                from   nbu_core_data_request r
                where  r.data_type_id = t.id and
                       r.kf = b.kf and
                       r.reporting_date = trunc(sysdate, 'mm')) last_request_id
        from   nbu_core_data_request_type t
        cross join nbu_core_branch b
        where  t.is_active = 1 and t.id not in (4,5)) d
left join nbu_core_data_request s on s.id = d.last_request_id
order by d.kf, d.data_type_id;

comment on column v_nbu_core_data_request.id is '������������� ������';
comment on column v_nbu_core_data_request.kf is '���';
comment on column v_nbu_core_data_request.branch_name is '����� ��볿';
comment on column v_nbu_core_data_request.data_type_name is '��� �����';
comment on column v_nbu_core_data_request.request_state is '���� �������� �����';
comment on column v_nbu_core_data_request.reporting_time is '���� �� ��� ������� ���������� �����';
comment on column v_nbu_core_data_request.reporting_person is '���������� ���� ������� �����';
comment on column v_nbu_core_data_request.tracking_message is '�������� �������';
