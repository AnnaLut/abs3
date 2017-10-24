-- ======================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ======================================================================================
-- ����� ������������ ����� ��� DWH
-- ======================================================================================


delete
  from BARSUPL.UPL_FILES 
 where file_id in (134, 139, 353);



--- 
--- �������� �������� DOMAIN_CODE, MASTER_CKGK
--- 
prompt 134 ���������� S080_FIN

Insert into BARSUPL.UPL_FILES    (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values    (134, 134, 'S080_FIN', 's080fin', 0, '09', NULL, '10', 0, '������� ����������� s080 �� ���.�����(�.351)', 134, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'stanfin23', 0, 0);


--
-- 139 (accpardeb) ETL-18831 UPL -��������� � MIR ����� �������������� ��������� ������ (������������� ����������� �������������)  
--
prompt  ���������� ������� 139 accpardeb

Insert into BARSUPL.UPL_FILES   (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
 Values
   (139, 139, 'SPECPARAM_INT', 'accpardeb', 0, '09', NULL, '10', 0, '�������� ��������� ������� ������������ ����������� �������������',  139, 'null', 'WHOLE', 'GL', 1, NULL, 1, 'accpardeb', 0, 1);

--- 
--- BR - �������� �������� �� ������ ������� ����� insobjecttype (file_id = 353) c insobjtyp �� kl_s031 (������ ������� kls031 file_id=393)
--- 
prompt 353 ���������� INS_OBJECT_TYPES

Insert into BARSUPL.UPL_FILES   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (353, 353, 'INS_OBJECT_TYPES', 'insobjecttype', 0, '09', NULL, '10', 0, '���� ����� �����������', 353, 'null', 'WHOLE', 'ARR', 1, NULL, 1, 'KL_S031', 0, 0);


COMMIT;

--
-- FINISH
--