PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_file_rec_for_sign.sql =========*** Run *** =
PROMPT ===================================================================================== 

CREATE OR REPLACE FORCE VIEW msp.v_msp_file_rec_for_sign
(
   id
 , file_id
 , deposit_acc
 , filia_num
 , deposit_code
 , pay_sum
 , full_name
 , numident
 , pay_day
 , displaced
 , state_id
 , block_type_id
 , block_comment
 , rec_no
 , comm
 , REF
 , mfo
)
AS
   SELECT mfr."ID"
        , mfr."FILE_ID"
        , mfr."DEPOSIT_ACC"
        , mfr."FILIA_NUM"
        , mfr."DEPOSIT_CODE"
        , mfr."PAY_SUM"
        , mfr."FULL_NAME"
        , mfr."NUMIDENT"
        , mfr."PAY_DAY"
        , mfr."DISPLACED"
        , mfr."STATE_ID"
        , mfr."BLOCK_TYPE_ID"
        , mfr."BLOCK_COMMENT"
        , mfr."REC_NO"
        , mfr."COMM"
        , mfr."REF"
        , mf.receiver_mfo "MFO"
     FROM msp_file_records mfr, msp_files mf
    WHERE mfr.state_id = 19 and mfr.ref is null AND mf.id = mfr.file_id;

comment on table v_msp_file_rec_for_sign is 'Інформаційні рядки реєстра, що очікують оплати';

comment on column v_msp_file_rec_for_sign.id is 'id інформаційного рядка реєстра';
comment on column v_msp_file_rec_for_sign.file_id is 'id файлу';
comment on column v_msp_file_rec_for_sign.deposit_acc is 'Номер рахунку вкладника';
comment on column v_msp_file_rec_for_sign.filia_num is 'Номер фiлiї';
comment on column v_msp_file_rec_for_sign.deposit_code is 'Код вкладу';
comment on column v_msp_file_rec_for_sign.pay_sum is 'Сума (в коп.)';
comment on column v_msp_file_rec_for_sign.full_name is 'Прiзвище, iм`я, по батьковi';
comment on column v_msp_file_rec_for_sign.numident is 'Ідентифікаційний номер';
comment on column v_msp_file_rec_for_sign.pay_day is 'День виплати';
comment on column v_msp_file_rec_for_sign.displaced is 'Ознака ВПО';
comment on column v_msp_file_rec_for_sign.state_id is 'id стану інформаційного рядка файлу';
comment on column v_msp_file_rec_for_sign.block_type_id is 'Тип блокування';
comment on column v_msp_file_rec_for_sign.block_comment is 'Коментар блокування';
comment on column v_msp_file_rec_for_sign.rec_no is 'Номер позиції в отриманому текстовому файлі';
comment on column v_msp_file_rec_for_sign.comm is 'Коментар';
comment on column v_msp_file_rec_for_sign.ref is 'Референс створеного документа';
comment on column v_msp_file_rec_for_sign.mfo is 'МФО банку-одержувача';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_file_rec_for_sign.sql =========*** End *** =
PROMPT ===================================================================================== 
