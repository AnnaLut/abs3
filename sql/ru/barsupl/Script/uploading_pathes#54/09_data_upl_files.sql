-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- ����� ������������ ����� ��� DWH
-- ======================================================================================


delete
  from BARSUPL.UPL_FILES 
 where file_id in (171, 172, 547, 7171, 566);



--- ETL-19131 - ANL - �������� ��������� �� ������������� ����������� �������������
--- XOZ_REF(171) ��������� ��������� (������� �� ������� ��� ���.���)
--- ����� ����
prompt 171 �������� ��� XOZ_REF
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (171, 171, 'XOZ_REF', 'xoz_ref', 0, '09', '10', 0, '��������� ��������� (������� �� ������� ��� ���.���)', 171, 'null', 'WHOLE', 'ARR', 1, 1, 'ar', 1, 1);

prompt 7171 �������� ��� XOZ_REF0
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (7171, 7171, 'XOZ_REF0', 'xoz_ref0', 0, '09', '10', 0, '��������� ��������� (������� �� ������� ��� ���.���)', 547, 'null', 'WHOLE', 'ARR', 1, 1, 'ar', 1, 1);

--- ETL-19131 - ANL - �������� ��������� �� ������������� ����������� �������������
--- XOZ_PRG(172) ������� �������
--- ����� ����
prompt 172 ���������� XOZ_PRG
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (172, 172, 'XOZ_PRG', 'xoz_prg', 0, '09', '10', 0, '������� �������', 172, 'null', 'WHOLE', 'IP', 1, 1, 'xozprg', 1, 0);


--- ETL-19474 - UPL - �������� � �������� ��� T0 �������������� �������� �� ��������� ���.��������� ��������� ������ (�� �������� � MIR.SRC_PRFTADJTXN0)
--- ����� ����
prompt 547 ������������� �� ������ XOZ
Insert into BARSUPL.UPL_FILES  (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values   (547, 547, 'PROFIT_ADJ_TXOZ', 'prfxoz0', 0, '09', NULL, '10', 0, '��������� ���������� �� �������� XOZ (��� FineVare)', 547, 'null', 'DELTA', 'GL', 1, NULL, 1, 'prfxoz0', 1, 1);

--
-- COBUSUPMMFO-212 ���� ����, ������� ������� ����������� � ���� ̳����� �������� ��������� ���������� ����� #A7�.
--
prompt  566 �������� A7
Insert into BARSUPL.UPL_FILES  (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (566, 566, 'A7_upl', 'a7_upl', 0, '09', NULL, '10', 0, '��� ��� ��������� ������ �� ������ �� ��������', 566, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'a7', 0, 1);


COMMIT;

--
-- FINISH
--