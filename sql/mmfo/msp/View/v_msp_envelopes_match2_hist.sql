PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_envelopes_match2_hist.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_envelopes_match2_hist ***

create or replace view v_msp_envelopes_match2_hist as
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
       s.state state_code,
       case when e.state in (0,11,13,14,15) and (select coalesce(max(case when f.state_id in (9) then 0 else 1 end),1) from msp_files f where f.envelope_file_id = e.id) = 0
            then 0 else 1 end not_can_send,
       case when instr(filename,'.')>37 then substr(filename, 30, 2) end payment_type,
       case when instr(filename,'.')>37 then substr(filename, 32, 2) end || '-' || 
         case when instr(filename,'.')>37 then substr(filename, 36, 2) end || '-' ||
         case when instr(filename,'.')>37 then substr(filename, 38, 4) end payment_period
from msp_envelopes e
     inner join msp_envelope_state s on s.id = e.state
where e.code in ('payment_data')
      and e.state in (10,16,17,18,19,20)
;
PROMPT *** Create comments on v_msp_envelopes_match2_hist ***
comment on table v_msp_envelopes_match2_hist is '������ ����������� �������� ��������� 2, ��� �������� � ��������� ��������';
comment on column v_msp_envelopes_match2_hist.id is 'id ��������';
comment on column v_msp_envelopes_match2_hist.id_msp_env is '�������� ��� ������ � ���';
comment on column v_msp_envelopes_match2_hist.code is '��� ������ �� ���';
comment on column v_msp_envelopes_match2_hist.sender is '³�������� ������';
comment on column v_msp_envelopes_match2_hist.recipient is '��������� ������';
comment on column v_msp_envelopes_match2_hist.partnumber is '���������� ����� ������� ��������';
comment on column v_msp_envelopes_match2_hist.parttotal is '�������� �-�� ������ ��������';
comment on column v_msp_envelopes_match2_hist.comm is '�������� ������� ��������';
comment on column v_msp_envelopes_match2_hist.create_date is '���� ��������� ��������';
comment on column v_msp_envelopes_match2_hist.total_sum is '�������� ���� ��������';
comment on column v_msp_envelopes_match2_hist.total_sum_to_pay is '�������� ���� ��� ������';
comment on column v_msp_envelopes_match2_hist.state_id is 'id ����� ��������';
comment on column v_msp_envelopes_match2_hist.state_name is '����� ����� ��������';
comment on column v_msp_envelopes_match2_hist.state_code is '���� ��������';
comment on column v_msp_envelopes_match2_hist.not_can_send is '������ �� ���������� ���������� ��������� 2 �� ��������';
comment on column v_msp_envelopes_match2_hist.payment_type is '��� �������';
comment on column v_msp_envelopes_match2_hist.payment_period is '����� �������';

PROMPT *** Create  grants  v_msp_envelopes_match2_hist ***

grant select on v_msp_envelopes_match2_hist to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_envelopes_match2_hist.sql =========*** End *** =
PROMPT ===================================================================================== 
