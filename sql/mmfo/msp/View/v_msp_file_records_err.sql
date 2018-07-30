PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_records_err.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_records_err ***

create or replace view v_msp_file_records_err as
select fr.id,
       fr.file_id,
       null check_date,
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
       f.receiver_mfo,
       --
       p1.kf   kf_bank,    -- МФО АБС
       p1.nls  acc_bank,   -- счет АБС
       p2.nmk  nmk_bank,   -- ФИО АБС
       p2.okpo okpo_bank,  --ИНН АБС
       p2.rnk  rnk  --   РНК
from msp_envelope_files_info fi
     inner join msp_files f on f.envelope_file_id = fi.id
     inner join msp_file_records fr on fr.file_id = f.id
     inner join msp_file_record_state rs on rs.id = fr.state_id
     --left join pfu.v_pfu_pensacc p on (p.kf = f.receiver_mfo and p.nls = fr.deposit_acc)
     left join pfu.pfu_pensacc p1 on (p1.kf = to_char(f.receiver_mfo) and p1.nls = to_char(fr.deposit_acc))
     left join pfu.pfu_pensioner p2 on (p2.kf=p1.kf and p2.rnk=p1.rnk)
where fr.state_id not in (0,19,20);

PROMPT *** Create comments on v_msp_file_records_err ***

comment on table v_msp_file_records_err is 'Інформаційні рядки реєстрів з помилками - /barsroot/mcp/mcp/errorsrecords';

comment on column v_msp_file_records_err.id is 'id інформаційного рядка реєстра';
comment on column v_msp_file_records_err.file_id is 'id файлу';
comment on column v_msp_file_records_err.check_date is 'Дата зарахування';
comment on column v_msp_file_records_err.deposit_acc is 'Номер рахунку вкладника';
comment on column v_msp_file_records_err.filia_num is 'Номер фiлiї';
comment on column v_msp_file_records_err.deposit_code is 'Код вкладу';
comment on column v_msp_file_records_err.pay_sum is 'Сума (в коп.)';
comment on column v_msp_file_records_err.full_name is 'Прiзвище, iм`я, по батьковi';
comment on column v_msp_file_records_err.numident is 'Ідентифікаційний номер';
comment on column v_msp_file_records_err.pay_day is 'День виплати';
comment on column v_msp_file_records_err.displaced is 'Ознака ВПО';
comment on column v_msp_file_records_err.state_id is 'id стану інформаційного рядка файлу';
comment on column v_msp_file_records_err.state_name is 'Назва статусу інформаційного рядка файлу';
comment on column v_msp_file_records_err.block_type_id is 'Тип блокування';
comment on column v_msp_file_records_err.block_comment is 'Коментар блокування';
comment on column v_msp_file_records_err.envelope_file_id is 'id конверта';
comment on column v_msp_file_records_err.receiver_mfo is 'МФО банку-одержувача';
comment on column v_msp_file_records_err.kf_bank is 'МФО АБС';
comment on column v_msp_file_records_err.acc_bank is 'Рахунок АБС';
comment on column v_msp_file_records_err.nmk_bank is 'ПІБ АБС';
comment on column v_msp_file_records_err.okpo_bank is 'ІПН АБС';
comment on column v_msp_file_records_err.rnk is 'РНК';


PROMPT *** Create  grants  v_msp_file_records_err ***

grant select on v_msp_file_records_err to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_records_err.sql =========*** End *** =
PROMPT ===================================================================================== 
