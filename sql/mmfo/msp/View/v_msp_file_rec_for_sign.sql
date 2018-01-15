create or replace view msp.v_msp_file_rec_for_sign as
select mfr."ID",mfr."FILE_ID",mfr."DEPOSIT_ACC",mfr."FILIA_NUM",mfr."DEPOSIT_CODE",mfr."PAY_SUM",mfr."FULL_NAME",mfr."NUMIDENT",mfr."PAY_DAY",mfr."DISPLACED",mfr."STATE_ID",mfr."BLOCK_TYPE_ID",mfr."BLOCK_COMMENT",mfr."REC_NO",mfr."COMM",mfr."REF",mf.receiver_mfo "MFO" 
    from msp_file_records mfr,
         msp_files mf
   where mfr.state_id = 19
     and mf.id = mfr.file_id;