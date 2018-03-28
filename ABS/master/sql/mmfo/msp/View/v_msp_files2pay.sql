PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_files2pay.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_files2pay ***

create or replace view v_msp_files2pay as
select f.id,
       fi.filepath file_path,
       fi.payment_type,
       lpad(f.file_filia_num, 5, '0') || lpad(f.file_pay_day, 2, '0') || f.file_separator || lpad(f.file_upszn_code, 3, '0') file_name,
       (select count(1) from msp_file_records fr where fr.file_id = f.id and fr.state_id in (0)) count_to_pay,
       (select sum(fr.pay_sum)*0.01 from msp_file_records fr where fr.file_id = f.id and fr.state_id in (0)) sum_to_pay,
       (select a.ostc*0.01 from bars.accounts a where a.nls = acc2.acc_num and a.kf = '300465' and a.kv = 980) balance_2909,
       rest.rest*0.01 balance_2560,
       rest.restdate last_balance_req,
       f.send_pay_date fact_payment_date,
       null fact_payment_sum,
       null return_payment_sum,
       f.file_bank_num,
       f.file_filia_num,
       f.file_pay_day,
       f.file_separator,
       f.file_upszn_code,
       f.header_lenght,
       f.file_date,
       to_date(f.file_date, 'dd.mm.yy') file_datetime,
       f.rec_count,
       f.payer_mfo,
       f.payer_acc,
       f.receiver_mfo,
       f.receiver_acc,
       acc.acc_num acc_num_2560,
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
       fi.comm     as envelope_comment,
       es.id       as envelope_state_id,
       es.name     as envelope_state_name
from msp_envelope_files_info fi
     inner join msp_envelopes e on e.id = fi.id
     inner join msp_envelope_state es on es.id = e.state
     inner join msp_files f on f.envelope_file_id = fi.id
     inner join msp_file_state fs on fs.id = f.state_id
     left join msp_acc_trans_2560 acc on acc.kf = f.receiver_mfo
     left join msp_acc_trans_2909 acc2 on acc2.kf = f.receiver_mfo
     left join msp_acc_rest rest on rest.fileid = f.id
;
comment on column V_MSP_FILES2PAY.FILE_PATH is 'Назва папки в конверті';
comment on column V_MSP_FILES2PAY.PAYMENT_TYPE is 'Тип виплати';
comment on column V_MSP_FILES2PAY.FILE_NAME is 'Назва файлу в конверті';
comment on column V_MSP_FILES2PAY.COUNT_TO_PAY is 'Кількість рядків для сплати';
comment on column V_MSP_FILES2PAY.SUM_TO_PAY is 'Сума для сплати';
comment on column V_MSP_FILES2PAY.STATE_ID is 'id стану файлу';
comment on column V_MSP_FILES2PAY.STATE_CODE is 'Код стану файлу';
comment on column V_MSP_FILES2PAY.STATE_NAME is 'Назва стану файлу';
comment on column V_MSP_FILES2PAY.ENVELOPE_FILE_ID is 'id файлу конверта';
comment on column V_MSP_FILES2PAY.ENVELOPE_FILE_NAME is 'Назва файлу архіва конверта';
comment on column V_MSP_FILES2PAY.ENVELOPE_FILE_STATE is 'Статус файлу конверта';
comment on column V_MSP_FILES2PAY.ENVELOPE_COMMENT is 'Коментар до файлу конверта';
comment on column V_MSP_FILES2PAY.FACT_PAYMENT_DATE is 'Фактична дата передачі реєстру на оплату';

grant select on v_msp_files2pay to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_files2pay.sql =========*** End *** =
PROMPT ===================================================================================== 
