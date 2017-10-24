-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- Файли вивантаженн€ даних дл€ DWH
-- ======================================================================================


delete
  from BARSUPL.UPL_FILES 
 where file_id in (171, 172, 547, 7171, 566);



--- ETL-19131 - ANL - выгрузку договоров по хозяйственной дебиторской задолженности
--- XOZ_REF(171) Картотека дебиторов (предназ по задумке для хоз.деб)
--- новый файл
prompt 171 договора ХДЗ XOZ_REF
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (171, 171, 'XOZ_REF', 'xoz_ref', 0, '09', '10', 0, 'Картотека дебиторов (предназ по задумке для хоз.деб)', 171, 'null', 'WHOLE', 'ARR', 1, 1, 'ar', 1, 1);

prompt 7171 договора ХДЗ XOZ_REF0
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (7171, 7171, 'XOZ_REF0', 'xoz_ref0', 0, '09', '10', 0, 'Картотека дебиторов (предназ по задумке для хоз.деб)', 547, 'null', 'WHOLE', 'ARR', 1, 1, 'ar', 1, 1);

--- ETL-19131 - ANL - выгрузку договоров по хозяйственной дебиторской задолженности
--- XOZ_PRG(172) Довідник проектів
--- новый файл
prompt 172 справочник XOZ_PRG
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (172, 172, 'XOZ_PRG', 'xoz_prg', 0, '09', '10', 0, 'Довідник проектів', 172, 'null', 'WHOLE', 'IP', 1, 1, 'xozprg', 1, 0);


--- ETL-19474 - UPL - добавить в выгрузку для T0 корректирующих проводок по договорам хоз.дебеторки отдельным файлом (по аналогии с MIR.SRC_PRFTADJTXN0)
--- новый файл
prompt 547 корректировки по счетам XOZ
Insert into BARSUPL.UPL_FILES  (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values   (547, 547, 'PROFIT_ADJ_TXOZ', 'prfxoz0', 0, '09', NULL, '10', 0, 'Коригуючі транзакції по рахунках XOZ (для FineVare)', 547, 'null', 'DELTA', 'GL', 1, NULL, 1, 'prfxoz0', 1, 1);

--
-- COBUSUPMMFO-212 Ѕарс ћћ‘ќ, в≥дсутн€ м≥грац≥€ функц≥оналу з Ѕарс ћ≥лен≥ум ¬игрузка протоколу формуванн€ файлу #A7ї.
--
prompt  566 выгрузка A7
Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (566, 566, 'A7_upl', 'a7_upl', 0, '09', NULL, '10', 0, 'Дані про структуру активів та пасивів за строками', 566, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'a7', 0, 1);


COMMIT;

--
-- FINISH
--