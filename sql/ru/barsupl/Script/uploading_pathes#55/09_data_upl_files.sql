-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- Файли вивантаження даних для DWH
-- ======================================================================================

/*
--**********************************
prompt дублирование файла 535 agrmchg0
prompt ТОЛЬКО ДЛЯ ТЕСТА
delete from BARSUPL.UPL_FILES where file_id in (7535);

insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM,
                               ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE,
                               ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 select 7535, SQL_ID, FILE_CODE || '0', FILENAME_PRFX || '0', EQVSPACE, DELIMM, DEC_DELIMM,
        ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE,
        ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED
   from barsupl.upl_files
  where file_id = 535;
--**********************************
*/
delete from BARSUPL.UPL_FILE_COUNTERS where file_id in (7535);

delete
  from BARSUPL.UPL_FILES 
 where file_id in (7535, 566,567);


--
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
--
prompt  566 выгрузка A7
Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (566, 566, 'A7_upl', 'a7_upl', 0, '09', NULL, '10', 0, 'Дані про структуру активів та пасивів за строками', 566, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'a7', 0, 1);

prompt  567 file name for #A7
Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (567, 567, 'A7_upl_file', 'a7_upl_file', 0, '09', NULL, '10', 0, 'Файл-Дані про структуру активів та пасивів за строками', 565, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'a7file', 0, 1);

COMMIT;

--
-- FINISH
--