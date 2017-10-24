-- ======================================================================================
-- Module : UPL
-- Date   : 20.04.2017
-- ======================================================================================
-- Файли вивантаження даних для DWH
-- ======================================================================================


delete
  from BARSUPL.UPL_FILES 
 where file_id in (525, 182, 235, 181);


Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, 
    delimm, dec_delimm, endline, head_line, descript, 
    order_id, nullval, data_type, domain_code, isactive, 
    seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (525, 2525, 'CP_MANY', 'cpmany', 0, 
    '09', NULL, '10', 0, 'Грошові потоки по договорам з ЦП', 
    168, 'null', 'WHOLE', 'EVENT', 1, 
    NULL, 1, 'cpmany', 0, 1);

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, 
    DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, 
    SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (182, 182, 'STAFF_AD', 'staffad', 0, 
    '09', NULL, '10', 0, 'Справочник персонала банка + AD ', 
    9, 'null', 'WHOLE', 'IP', 1, 
    NULL, 1, 'STAFF', 1, 0);

--MASTER_CKGK=AR
Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, 
    delimm, dec_delimm, endline, head_line, descript, 
    order_id, nullval, data_type, domain_code, isactive, 
    seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (235, 235, 'SKRYNKA_ND', 'skrynd', 0, 
    '09', NULL, '10', 0, 'Угоди оренди депозитних сейфів', 
    235, 'null', 'DELTA', 'ARR', 1, 
    NULL, 1, 'AR', 1, 1);

--PARTITIONED=0
Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, 
    delimm, dec_delimm, endline, head_line, descript, 
    order_id, nullval, data_type, domain_code, isactive, 
    seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (181, 181, 'STAFF', 'staff', 0, 
    '09', NULL, '10', 0, 'Справочник персонала банка', 
    8, 'null', 'WHOLE', 'IP', 1, 
    NULL, 1, 'STAFF', 1, 0);


COMMIT;

--
-- FINISH
--