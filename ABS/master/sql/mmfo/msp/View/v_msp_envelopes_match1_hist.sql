PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_envelopes_match1_hist.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_envelopes_match1_hist ***

create or replace view v_msp_envelopes_match1_hist as
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
     inner join msp_envelope_state s on s.id = e.state
where e.code in ('payment_data')
      and e.state in (9,11,12,13,14,15)
;

PROMPT *** Create comments on v_msp_envelopes_match1_hist ***
comment on table v_msp_envelopes_match1_hist is '������ ����������� �������� ��������� 1, ��� �������� � ��������� ��������';
comment on column v_msp_envelopes_match1_hist.id is 'id ��������';
comment on column v_msp_envelopes_match1_hist.id_msp_env is '�������� ��� ������ � ���';
comment on column v_msp_envelopes_match1_hist.code is '��� ������ �� ���';
comment on column v_msp_envelopes_match1_hist.sender is '³�������� ������';
comment on column v_msp_envelopes_match1_hist.recipient is '��������� ������';
comment on column v_msp_envelopes_match1_hist.partnumber is '���������� ����� ������� ��������';
comment on column v_msp_envelopes_match1_hist.parttotal is '�������� �-�� ������ ��������';
comment on column v_msp_envelopes_match1_hist.comm is '�������� ������� ��������';
comment on column v_msp_envelopes_match1_hist.create_date is '���� ��������� ��������';
comment on column v_msp_envelopes_match1_hist.total_sum is '�������� ���� ��������';
comment on column v_msp_envelopes_match1_hist.total_sum_to_pay is '�������� ���� ��� ������';
comment on column v_msp_envelopes_match1_hist.state_id is 'id ����� ��������';
comment on column v_msp_envelopes_match1_hist.state_name is '����� ����� ��������';
comment on column v_msp_envelopes_match1_hist.state_code is '���� ��������';

PROMPT *** Create  grants  v_msp_envelopes_match1_hist ***

grant select on v_msp_envelopes_match1_hist to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_envelopes_match1_hist.sql =========*** End *** =
PROMPT ===================================================================================== 
