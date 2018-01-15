PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_files.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_files ***

create or replace view v_msp_files as
select f.id,
       substr(fi.filename, 25, 2) payment_type,
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

comment on column v_msp_files.envelope_file_id is 'id файлу конверта';
comment on column v_msp_files.file_path is 'Назва папки в конверті';
comment on column v_msp_files.file_name is 'Назва файлу в конверті';
comment on column v_msp_files.envelope_file_name is 'Назва файлу архіва конверта';
comment on column v_msp_files.envelope_file_state is 'Статус файлу конверта';
comment on column v_msp_files.envelope_comment is 'Коментар до файлу конверта';
comment on column v_msp_files.state_id is 'id стану файлу';
comment on column v_msp_files.state_code is 'Код стану файлу';
comment on column v_msp_files.state_name is 'Назва стану файлу';
comment on column v_msp_files.payment_type is 'Тип виплати';


PROMPT *** Create  grants  v_msp_files ***

grant select on v_msp_files to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_files.sql =========*** End *** =
PROMPT ===================================================================================== 
