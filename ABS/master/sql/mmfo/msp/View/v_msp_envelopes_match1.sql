PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_envelopes_match1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_envelopes_match1 ***

create or replace view v_msp_envelopes_match1 as
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
      and e.state in (0)
      and 0 = (select sum(case when f.state_id in (0) then 0 else 1 end) from msp_files f where f.envelope_file_id = e.id);

PROMPT *** Create comments on v_msp_envelopes_match1 ***
comment on column v_msp_envelopes_match1.total_sum is '�������� ���� ��������';
comment on column v_msp_envelopes_match1.total_sum_to_pay is '�������� ���� ��� ������';
comment on column v_msp_envelopes_match1.state_id is 'id ����� ��������';
comment on column v_msp_envelopes_match1.state_name is '����� ����� ��������';
comment on column v_msp_envelopes_match1.state_code is '���� ��������';

PROMPT *** Create  grants  v_msp_envelopes_match1 ***

grant select on v_msp_envelopes_match1 to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_envelopes_match1.sql =========*** End *** =
PROMPT ===================================================================================== 
