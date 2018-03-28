PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_rec_for_match.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_file_rec_for_match ***

create or replace view v_msp_file_rec_for_match as
select fr.id,
       fr.file_id,
       fr.deposit_acc,
       fr.filia_num,
       fr.deposit_code,
       fr.pay_sum*0.01 pay_sum,
       fr.full_name,
       fr.numident,
       fr.pay_day,
       fr.displaced,
       fr.state_id,
       rs.name as state_name,
       fr.block_type_id,
       fr.block_comment,
       fi.id as envelope_file_id,
       fr.fact_pay_date
from msp_envelope_files_info fi
     inner join msp_files f on f.envelope_file_id = fi.id
     inner join msp_file_records fr on fr.file_id = f.id
     inner join msp_file_record_state rs on rs.id = fr.state_id;


PROMPT *** Create comments on v_msp_file_rec_for_match ***

comment on column v_msp_file_rec_for_match.envelope_file_id is 'id файлу конверта';
comment on column v_msp_file_rec_for_match.state_name is 'Назва статусу інформаційного рядка файлу';
comment on column v_msp_file_rec_for_match.fact_pay_date is 'Фактична дата зарахування коштів';


PROMPT *** Create  grants  v_msp_file_rec_for_match ***

grant select on v_msp_file_rec_for_match to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_rec_for_match.sql =========*** End *** =
PROMPT ===================================================================================== 
