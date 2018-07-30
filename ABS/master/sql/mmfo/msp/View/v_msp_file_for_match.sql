PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_for_match.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_for_match ***

create or replace view v_msp_file_for_match as
select f.id,
       case when instr(fi.filename,'.')>37 then substr(fi.filename, 30, 2) end payment_type,
       substr(fi.filepath, 1, instr(fi.filepath, '\')-1) file_path,
       substr(filepath, instr(filepath, '\')+1, length(filepath)-instr(filepath, '\')) file_name,
       f.file_bank_num,
       f.file_filia_num,
       f.file_pay_day,
       f.file_separator,
       f.file_upszn_code,
       f.header_lenght,
       f.file_date,
       f.rec_count,
       f.payer_mfo,
       f.payer_acc,
       f.receiver_mfo,
       f.receiver_acc,
       f.debit_kredit,
       f.pay_sum*0.01 pay_sum,
       (select sum(f.pay_sum)*0.01 from msp_file_records fr where fr.file_id = f.id and fr.state_id in (0)) sum_to_pay,
       f.pay_type,
       f.pay_oper_num,
       f.attach_flag,
       f.payer_name,
       f.receiver_name,
       f.payment_purpose,
       f.filia_num,
       f.deposit_code,
       f.process_mode,
       f.checksum,
       f.state_id,
       fs.state    as state_code,
       fs.name     as state_name,
       fi.id       as envelope_file_id,
       fi.filename as envelope_file_name,
       fi.state    as envelope_file_state,
       fi.comm     as envelope_comment,
       case when instr(fi.filename,'.')>37 then substr(fi.filename, 32, 2) end || '-' || 
         case when instr(fi.filename,'.')>37 then substr(fi.filename, 36, 2) end || '-' ||
         case when instr(fi.filename,'.')>37 then substr(fi.filename, 38, 4) end payment_period
from msp_envelope_files_info fi
     inner join msp_files f on f.envelope_file_id = fi.id
     inner join msp_file_state fs on fs.id = f.state_id;

PROMPT *** Create comments on v_msp_file_for_match ***

comment on table v_msp_file_for_match is '������ ������ ��������';
comment on column v_msp_file_for_match.id is 'id ������';
comment on column v_msp_file_for_match.file_bank_num is '����� ���������� ��볿 �����';
comment on column v_msp_file_for_match.file_filia_num is '����� ������� ��볿 �����';
comment on column v_msp_file_for_match.file_pay_day is '���� �������';
comment on column v_msp_file_for_match.file_separator is '������-��������� ����� � ���������� �����- �.�';
comment on column v_msp_file_for_match.file_upszn_code is '��� ����� ����';
comment on column v_msp_file_for_match.header_lenght is '������� ���������';
comment on column v_msp_file_for_match.file_date is '���� ��������� �����';
comment on column v_msp_file_for_match.rec_count is '�i���i��� i�������i���� ����i�';
comment on column v_msp_file_for_match.payer_mfo is '��� �����-��������';
comment on column v_msp_file_for_match.payer_acc is '������� ��������';
comment on column v_msp_file_for_match.receiver_mfo is '��� �����-����������';
comment on column v_msp_file_for_match.receiver_acc is '������� ����������';
comment on column v_msp_file_for_match.debit_kredit is '������ "�����/������" �������';
comment on column v_msp_file_for_match.pay_sum is '���� (� ���.) �������';
comment on column v_msp_file_for_match.sum_to_pay is '���� (� ���.) �� ������';
comment on column v_msp_file_for_match.pay_type is '��� �������';
comment on column v_msp_file_for_match.pay_oper_num is '����� (������i����) �������';
comment on column v_msp_file_for_match.attach_flag is '������ ��������i ������� �� �������';
comment on column v_msp_file_for_match.payer_name is '������������ ��������';
comment on column v_msp_file_for_match.receiver_name is '������������ ����������';
comment on column v_msp_file_for_match.payment_purpose is '����������� �������';
comment on column v_msp_file_for_match.filia_num is '����� �i�i�';
comment on column v_msp_file_for_match.deposit_code  is '��� ������';
comment on column v_msp_file_for_match.process_mode is '������ �������';
comment on column v_msp_file_for_match.checksum is '�� ��� ��';
comment on column v_msp_file_for_match.envelope_file_id is 'id ����� ��������';
comment on column v_msp_file_for_match.file_path is '����� ����� � �������';
comment on column v_msp_file_for_match.file_name is '����� ����� � �������';
comment on column v_msp_file_for_match.envelope_file_name is '����� ����� ������ ��������';
comment on column v_msp_file_for_match.envelope_file_state is '������ ����� ��������';
comment on column v_msp_file_for_match.envelope_comment is '�������� �� ����� ��������';
comment on column v_msp_file_for_match.state_id is 'id ����� �����';
comment on column v_msp_file_for_match.state_code is '��� ����� �����';
comment on column v_msp_file_for_match.state_name is '����� ����� �����';
comment on column v_msp_file_for_match.payment_type is '��� �������';
comment on column v_msp_file_for_match.payment_period is '����� �������';


PROMPT *** Create  grants  v_msp_file_for_match ***

grant select on v_msp_file_for_match to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_for_match.sql =========*** End *** =
PROMPT ===================================================================================== 
