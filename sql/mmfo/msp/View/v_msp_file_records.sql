PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_records.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_records ***

create or replace view v_msp_file_records as
select fr.id,
       fr.file_id,
       null check_date,
       null branch_code,
       fr.deposit_acc,
       fr.filia_num,
       fr.deposit_code,
       fr.pay_sum,
       fr.full_name,
       fr.numident,
       fr.pay_day,
       fr.displaced,
       fr.state_id,
       rs.name as state_name,
       fr.block_type_id,
       fr.block_comment,
       fi.id as envelope_file_id,
       f.receiver_mfo mfo,
       fr.ref,
       fr.fact_pay_date
from msp_envelope_files_info fi
     inner join msp_files f on f.envelope_file_id = fi.id
     inner join msp_file_records fr on fr.file_id = f.id
     inner join msp_file_record_state rs on rs.id = fr.state_id;


PROMPT *** Create comments on v_msp_file_records ***

comment on table v_msp_file_records is '����������� ����� ������';

comment on column v_msp_file_records.id is 'id �������������� ����� ������';
comment on column v_msp_file_records.file_id is 'id �����';
comment on column v_msp_file_records.check_date is '���� �����������';
comment on column v_msp_file_records.branch_code is '��� ���';
comment on column v_msp_file_records.deposit_acc is '����� ������� ���������';
comment on column v_msp_file_records.filia_num is '����� �i�i�';
comment on column v_msp_file_records.deposit_code is '��� ������';
comment on column v_msp_file_records.pay_sum is '���� (� ���.)';
comment on column v_msp_file_records.full_name is '��i�����, i�`�, �� �������i';
comment on column v_msp_file_records.numident is '���������������� �����';
comment on column v_msp_file_records.pay_day is '���� �������';
comment on column v_msp_file_records.displaced is '������ ���';
comment on column v_msp_file_records.state_id is 'id ����� �������������� ����� �����';
comment on column v_msp_file_records.state_name is '����� ������� �������������� ����� �����';
comment on column v_msp_file_records.block_type_id is '��� ����������';
comment on column v_msp_file_records.block_comment is '�������� ����������';
comment on column v_msp_file_records.envelope_file_id is 'id ��������';
comment on column v_msp_file_records.mfo is '��� �����-����������';
comment on column v_msp_file_records.ref is '�������� ���������� ���������';
comment on column v_msp_file_records.fact_pay_date is '���� ���������� ����������� ����� �� �������';


PROMPT *** Create  grants  v_msp_file_records ***

grant select on v_msp_file_records to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_records.sql =========*** End *** =
PROMPT ===================================================================================== 
