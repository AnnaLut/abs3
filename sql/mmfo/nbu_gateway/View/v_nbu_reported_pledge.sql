create or replace view v_nbu_reported_pledge as
select o.id,
       p.person_code,
       p.person_name,
       p.loan_amount / 100 loan_amount,
       case when o.state_id = 1 then '�����'
            when o.state_id = 2 then '�������������'
            when o.state_id = 3 then '�������� ����� �� ���'
            when o.state_id = 4 then '������� �������� �����'
            when o.state_id = 5 then '��������� �� ���'
            when o.state_id = 6 then '³���������'
            else to_char(o.state_id)
       end object_state,
       cast(null as varchar2(4000 byte))/*nbu_data_service.get_reported_object_comment(o.id)*/ object_comment
from   nbu_reported_object o
join   nbu_reported_pledge pl on pl.id = o.id
join   nbu_reported_person p on p.id = o.;

comment on column v_nbu_reported_person.id is '������������� ��''���� ��� �������� �� ���';
comment on column v_nbu_reported_person.person_code is '��� ���';
comment on column v_nbu_reported_person.person_name is '��''� ������������';
comment on column v_nbu_reported_person.loan_amount is '�������� ���� �������������';
comment on column v_nbu_reported_person.object_state is '���� �������';
comment on column v_nbu_reported_person.object_comment is '�������� �������';

grant select on v_nbu_reported_person to bars_access_defrole;
