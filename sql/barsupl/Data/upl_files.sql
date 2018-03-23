prompt BPK2 file
begin
    insert into upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (4, 4, 'BPK2', 'Bpk2', 0, '35', null, '13||10', 0, 'Вивантаження даних по платіжним карткам(2)', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
  when dup_val_on_index then null;
end;
/

prompt CLIENTFO2 file
begin
    insert into upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (10054, 99442, 'CLIENTFO2', 'Clientfo2', 0, '35', null, '13||10', 0, 'CRM, Фізичні особи (основна інформація)', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
  when dup_val_on_index then null;
end;
/

prompt CLIENTADDRESS file
begin
     insert into upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (10055, 99443, 'CLIENTADDRESS', 'Clientaddress', 0, '35', null, '13||10', 0, 'CRM, Фізичні особи (коди адрес)', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
  when dup_val_on_index then null;
end;
/

prompt DEPOSITS2 file
begin
     insert into upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
	 values (10052, 10053, 'DEPOSITS_PLT', 'Deposits_plt', 0, '35', null, '13||10', 0, 'Вивантаження даних по депозитах для CRM(пілот)', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
  when dup_val_on_index then 
  update upl_files
  set sql_id = 10053,
	  file_code = 'DEPOSITS2',
	  filename_prfx = 'Deposits2',
	  descript = 'Вивантаження даних по депозитах2 для CRM'
  where file_id = 10052;
end;
/

prompt CUST_REL_S file
begin
    insert into upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (6, 6, 'CUST_REL_S', 'Cust_rel_s', 0, '35', null, '13||10', 0, 'CRM: Повязані особи (всі)', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
  when dup_val_on_index then null;
end;
/

prompt CREDITS_ZAL file
begin
    insert into upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (8, 8, 'CREDITS_ZAL', 'Credits_zal', 0, '35', null, '13||10', 0, 'CRM: Поручителі / заставодавці', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
  when dup_val_on_index then null;
end;
/
commit;
/