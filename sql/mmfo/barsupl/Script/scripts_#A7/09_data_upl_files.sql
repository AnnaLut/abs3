-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- ����� ������������ ����� ��� DWH
-- ======================================================================================


delete
  from BARSUPL.UPL_FILES 
 where file_id in (566);



--- 
--- UPL - ETL-18729 - ��������� ���������� S080_FIN � ��������� ��������������� ������ �� nbu23rez
--- 
prompt 134 ���������� S080_FIN

Insert into BARSUPL.UPL_FILES
   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, 
    DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, 
    ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, 
    SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (566, 566, '#A7', '#a7', 0, 
    '09', NULL, '10', 0, '��� ��� ��������� ������ �� ������ �� ��������', 
    600, 'null', 'WHOLE', 'GL', 1, 
    NULL, 1, NULL, 0, NULL);


COMMIT;

--
-- FINISH
--