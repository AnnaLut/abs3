PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_envelopes.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_envelopes ***

create or replace view v_msp_envelopes as
select e.id, 
       e.id_msp_env, 
       e.code, 
       e.sender, 
       e.recipient, 
       e.partnumber, 
       e.parttotal, 
       e.comm, 
       cast(e.create_date as date) create_date,
       -- (select sum(f.pay_sum)*0.01 from msp_file_records fr where fr.file_id = f.id and fr.state_id in (0)) sum_to_pay, --total_sum
       null total_sum,
       null total_sum_to_pay,
       e.state state_id, 
       s.name  state_name,
       s.state state_code
from msp_envelopes e
     inner join msp_envelope_state s on s.id = e.state;

PROMPT *** Create comments on v_msp_envelopes ***
comment on table v_msp_envelopes is '������ �������� �� ���';
comment on column v_msp_envelopes.id is 'id ��������';
comment on column v_msp_envelopes.id_msp_env is '�������� ��� ������ � ���';
comment on column v_msp_envelopes.code is '��� ������ �� ���';
comment on column v_msp_envelopes.sender is '³�������� ������';
comment on column v_msp_envelopes.recipient is '��������� ������';
comment on column v_msp_envelopes.partnumber is '���������� ����� ������� ��������';
comment on column v_msp_envelopes.parttotal is '�������� �-�� ������ ��������';
comment on column v_msp_envelopes.comm is '�������� ������� ��������';
comment on column v_msp_envelopes.create_date is '���� ��������� ��������';
comment on column v_msp_envelopes.total_sum is '�������� ���� ��������';
comment on column v_msp_envelopes.total_sum_to_pay is '�������� ���� ��� ������';
comment on column v_msp_envelopes.state_id is 'id ����� ��������';
comment on column v_msp_envelopes.state_name is '����� ����� ��������';
comment on column v_msp_envelopes.state_code is '���� ��������';

PROMPT *** Create  grants  v_msp_envelopes ***

grant select on v_msp_envelopes to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_envelopes.sql =========*** End *** =
PROMPT ===================================================================================== 
