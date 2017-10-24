-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- ����� ������������ ����� ��� DWH
-- ======================================================================================


delete
  from BARSUPL.UPL_FILES 
 where file_id in (134, 350, 351, 352, 353, 354, 355, 356, 385, 386, 546);



--- 
--- UPL - ETL-18729 - ��������� ���������� S080_FIN � ��������� ��������������� ������ �� nbu23rez
--- 
prompt 134 ���������� S080_FIN

Insert into BARSUPL.UPL_FILES    (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values    (134, 134, 'S080_FIN', 's080fin', 0, '09', NULL, '10', 0, '������� ����������� s080 �� ���.�����(�.351)', 134, 'null', 'WHOLE', 'IP', 1, NULL, 1, 'S080', 0, 0);

--
-- UPL - ETL-18652 ��������� ���������� KL_S250 � ��������� ��������������� ������ �� nbu23rez
--
Insert into BARSUPL.UPL_FILES    (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (385, 385, 'KL_S250', 'kls250', 0,  '09', NULL, '10', 0, '���: ��� ������������� �� ����������� ����������',  0, 'null', 'WHOLE', 'IP', 1, NULL, 1, 'KL_S250', 0, 0);

--
-- UPL - ETL-18654 ��������� ���������� GRP_PORTFEL � ��������� ��������������� ������ �� nbu23rez
--
Insert into BARSUPL.UPL_FILES    (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (386, 386, 'GRP_PORTFEL ', 'grpportfel', 0, '09', NULL, '10', 0, '������� ���� ��������� ���������� ������', 0, 'null', 'WHOLE', 'IP', 1, NULL, 1, 'GRP', 0, 0);


prompt FEEADJTXN0
-- FEEADJTXN0 (feeadjtxn0) / 546 ( ETL-18533 UPL - ��������� ����������� �� ��������� ���������� � �0 )
-- ����� ����
--
Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (546, 546, 'FEEADJTXN0', 'feeadjtxn0', 0, '09', NULL, '10', 0, '��������� ���������� �� �������� 60-� ����� (��� FineVare)', 538, 'null', 'DELTA', 'GL', 1, NULL, 1, 'feeadjtxn0', 1, 1);


---
--- ETL-18408 UPL - ��������� ����� �� ��������� ���������
---

prompt ������� �� ��������� ���������

Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (350, 350, 'INS_DEAL', 'insdeal', 0,  '09', NULL, '10', 0, '������� ��������', 350, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'AR', 0, 1);
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (351, 351, 'INS_PARTNERS', 'inspartners', 0,  '09', NULL, '10', 0, '����������� ������� ������', 351, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'INSPARTN', 0, 1);
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (352, 352, 'INS_TYPES', 'instypes', 0, '09', NULL, '10', 0, '���� �������i� �����������', 352, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'INSTYP', 0, 0);
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (353, 353, 'INS_OBJECT_TYPES', 'insobjecttype', 0, '09', NULL, '10', 0, '���� ����� �����������', 353, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'INSOBJTYP', 0, 0);
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (354, 354, 'INS_DEAL_STATUSES', 'insdealstatus', 0, '09', NULL, '10', 0, '������� �������� �����������', 354, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'INSDEALSTS', 0, 0);
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (355, 355, 'INS_ADD_AGREEMENTS', 'insaddagreeme', 0, '09', NULL, '10', 0, '���. ����� �� ��������� ��������', 355, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'INSADDAGR', 0, 1);
Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values   (356, 356, 'INS_PAYMENTS_SCHEDULE', 'inspaymentssc', 0, '09', NULL, '10', 0, '������ ������� �� ��������� ���������', 356, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'INSPAYSH', 0, 1);


COMMIT;

--
-- FINISH
--