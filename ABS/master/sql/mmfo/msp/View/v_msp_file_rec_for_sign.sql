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
