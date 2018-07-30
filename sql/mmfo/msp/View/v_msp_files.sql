PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_files.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_files ***

create or replace view v_msp_files as
select f.id,
       case when instr(fi.filename,'.')>37 then substr(fi.filename, 30, 2) end payment_type,
       substr(fi.filepath, 1, instr(fi.filepath, '\')-1) file_path,
       substr(filepath, instr(filepath, '\')+1, length(filepath)-instr(filepath, '\')) file_name,
       --lpad(f.file_filia_num, 5, '0') || lpad(f.file_pay_day, 2, '0') || f.file_separator || lpad(f.file_upszn_code, 3, '0') file_name,
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
       fi.comm     as envelope_comment
from msp_envelope_files_info fi
     inner join msp_files f on f.envelope_file_id = fi.id
     inner join msp_file_state fs on fs.id = f.state_id;

PROMPT *** Create comments on v_msp_files ***

comment on table v_msp_files is '������';
comment on column v_msp_files.id is 'id ������';
comment on column v_msp_files.file_bank_num is '����� ���������� ��볿 �����';
comment on column v_msp_files.file_filia_num is '����� ������� ��볿 �����';
comment on column v_msp_files.file_pay_day is '���� �������';
comment on column v_msp_files.file_separator is '������-��������� ����� � ���������� �����- �.�';
comment on column v_msp_files.file_upszn_code is '��� ����� ����';
comment on column v_msp_files.header_lenght is '������� ���������';
comment on column v_msp_files.file_date is '���� ��������� �����';
comment on column v_msp_files.rec_count is '�i���i��� i�������i���� ����i�';
comment on column v_msp_files.payer_mfo is '��� �����-��������';
comment on column v_msp_files.payer_acc is '������� ��������';
comment on column v_msp_files.receiver_mfo is '��� �����-����������';
comment on column v_msp_files.receiver_acc is '������� ����������';
comment on column v_msp_files.debit_kredit is '������ "�����/������" �������';
comment on column v_msp_files.pay_sum is '���� (� ���.) �������';
comment on column v_msp_files.pay_type is '��� �������';
comment on column v_msp_files.pay_oper_num is '����� (������i����) �������';
comment on column v_msp_files.attach_flag is '������ ��������i ������� �� �������';
comment on column v_msp_files.payer_name is '������������ ��������';
comment on column v_msp_files.receiver_name is '������������ ����������';
comment on column v_msp_files.payment_purpose is '����������� �������';
comment on column v_msp_files.filia_num is '����� �i�i�';
comment on column v_msp_files.deposit_code is '��� ������';
comment on column v_msp_files.process_mode is '������ �������';
comment on column v_msp_files.checksum is '�� ��� ��';
comment on column v_msp_files.envelope_file_id is 'id ��������';
comment on column v_msp_files.file_path is '����� ����� � �������';
comment on column v_msp_files.file_name is '����� ����� � �������';
comment on column v_msp_files.envelope_file_name is '����� ����� ������ ��������';
comment on column v_msp_files.envelope_file_state is '������ ����� ��������';
comment on column v_msp_files.envelope_comment is '�������� �� ����� ��������';
comment on column v_msp_files.state_id is 'id ����� �����';
comment on column v_msp_files.state_code is '��� ����� �����';
comment on column v_msp_files.state_name is '����� ����� �����';
comment on column v_msp_files.payment_type is '��� �������';


PROMPT *** Create  grants  v_msp_files ***

grant select on v_msp_files to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_files.sql =========*** End *** =
PROMPT ===================================================================================== 
