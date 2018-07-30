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

comment on table v_msp_file_records is 'Інформаційні рядки реєстрів';

comment on column v_msp_file_records.id is 'id інформаційного рядка реєстра';
comment on column v_msp_file_records.file_id is 'id файлу';
comment on column v_msp_file_records.check_date is 'Дата зарахування';
comment on column v_msp_file_records.branch_code is 'Код МФО';
comment on column v_msp_file_records.deposit_acc is 'Номер рахунку вкладника';
comment on column v_msp_file_records.filia_num is 'Номер фiлiї';
comment on column v_msp_file_records.deposit_code is 'Код вкладу';
comment on column v_msp_file_records.pay_sum is 'Сума (в коп.)';
comment on column v_msp_file_records.full_name is 'Прiзвище, iм`я, по батьковi';
comment on column v_msp_file_records.numident is 'Ідентифікаційний номер';
comment on column v_msp_file_records.pay_day is 'День виплати';
comment on column v_msp_file_records.displaced is 'Ознака ВПО';
comment on column v_msp_file_records.state_id is 'id стану інформаційного рядка файлу';
comment on column v_msp_file_records.state_name is 'Назва статусу інформаційного рядка файлу';
comment on column v_msp_file_records.block_type_id is 'Тип блокування';
comment on column v_msp_file_records.block_comment is 'Коментар блокування';
comment on column v_msp_file_records.envelope_file_id is 'id конверта';
comment on column v_msp_file_records.mfo is 'МФО банку-одержувача';
comment on column v_msp_file_records.ref is 'Референс созданного документа';
comment on column v_msp_file_records.fact_pay_date is 'Дата фактичного зарахування коштів на рахунки';


PROMPT *** Create  grants  v_msp_file_records ***

grant select on v_msp_file_records to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_records.sql =========*** End *** =
PROMPT ===================================================================================== 
