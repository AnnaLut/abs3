PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_for_match.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_for_match ***

create or replace view v_msp_file_for_match as
select f.id,
       substr(fi.filename, 25, 2) payment_type,
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
       fi.comm     as envelope_comment
from msp_envelope_files_info fi
     inner join msp_files f on f.envelope_file_id = fi.id
     inner join msp_file_state fs on fs.id = f.state_id;

PROMPT *** Create comments on v_msp_file_for_match ***

comment on column v_msp_file_for_match.envelope_file_id is 'id файлу конверта';
comment on column v_msp_file_for_match.file_path is 'Назва папки в конверті';
comment on column v_msp_file_for_match.file_name is 'Назва файлу в конверті';
comment on column v_msp_file_for_match.envelope_file_name is 'Назва файлу архіва конверта';
comment on column v_msp_file_for_match.envelope_file_state is 'Статус файлу конверта';
comment on column v_msp_file_for_match.envelope_comment is 'Коментар до файлу конверта';
comment on column v_msp_file_for_match.state_id is 'id стану файлу';
comment on column v_msp_file_for_match.state_code is 'Код стану файлу';
comment on column v_msp_file_for_match.state_name is 'Назва стану файлу';
comment on column v_msp_file_for_match.payment_type is 'Тип виплати';


PROMPT *** Create  grants  v_msp_file_for_match ***

grant select on v_msp_file_for_match to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_for_match.sql =========*** End *** =
PROMPT ===================================================================================== 
