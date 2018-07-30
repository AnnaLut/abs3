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

comment on table v_msp_files is 'Реєстри';
comment on column v_msp_files.id is 'id реєстра';
comment on column v_msp_files.file_bank_num is 'Номер центральної філії банку';
comment on column v_msp_files.file_filia_num is 'Номер підзвітної філії банку';
comment on column v_msp_files.file_pay_day is 'День виплати';
comment on column v_msp_files.file_separator is 'Символ-роздільник назви і розширення файлу- «.»';
comment on column v_msp_files.file_upszn_code is 'Код райну УПФУ';
comment on column v_msp_files.header_lenght is 'Довжина заголовка';
comment on column v_msp_files.file_date is 'Дата створення файлу';
comment on column v_msp_files.rec_count is 'Кiлькiсть iнформацiйних рядкiв';
comment on column v_msp_files.payer_mfo is 'МФО банку-платника';
comment on column v_msp_files.payer_acc is 'Рахунок платника';
comment on column v_msp_files.receiver_mfo is 'МФО банку-одержувача';
comment on column v_msp_files.receiver_acc is 'Рахунок одержувача';
comment on column v_msp_files.debit_kredit is 'Ознака "дебет/кредит" платежу';
comment on column v_msp_files.pay_sum is 'Сума (в коп.) платежу';
comment on column v_msp_files.pay_type is 'Вид платежу';
comment on column v_msp_files.pay_oper_num is 'Номер (операцiйний) платежу';
comment on column v_msp_files.attach_flag is 'Ознака наявностi додатку до платежу';
comment on column v_msp_files.payer_name is 'Найменування платника';
comment on column v_msp_files.receiver_name is 'Найменування одержувача';
comment on column v_msp_files.payment_purpose is 'Призначення платежу';
comment on column v_msp_files.filia_num is 'Номер фiлiї';
comment on column v_msp_files.deposit_code is 'Код вкладу';
comment on column v_msp_files.process_mode is 'Режими обробки';
comment on column v_msp_files.checksum is 'КС або ЕП';
comment on column v_msp_files.envelope_file_id is 'id конверта';
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
