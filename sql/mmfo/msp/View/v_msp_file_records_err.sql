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

comment on column v_msp_file_records_err.envelope_file_id is 'id файлу конверта';
comment on column v_msp_file_records_err.state_name is 'Назва статусу інформаційного рядка файлу';
comment on column v_msp_file_records_err.check_date is 'Дата зарахування';


PROMPT *** Create  grants  v_msp_file_records_err ***

grant select on v_msp_file_records_err to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_records_err.sql =========*** End *** =
PROMPT ===================================================================================== 
