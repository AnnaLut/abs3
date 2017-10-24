begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 1, ''branch'', ''Відділення'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 2, ''kf'', ''Регіональне управління'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 3, ''vidp_pers'', ''Відповідальна особа'', ''CHAR'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 4, ''phone'', ''Контактний номер телефону працівника'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 5, ''safenum'', ''Номер сейфу'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 6, ''stan'', ''Стан'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 7, ''height'', ''Висота, см'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 8, ''width'', ''Ширина, см'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 9, ''depth'', ''Глибина, см'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 10, ''price'', ''Вартість'', ''NUMBER'', 7, 2, ''99990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 11, ''cust_branch'', ''Клієнт, Відділення'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 12, ''cust_kf'', ''Клієнт, РУ'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 13, ''cust_rnk'', ''Клієнт, РНК'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 14, ''dat_begin'', ''Договір від'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 15, ''ndog'', ''№ договору'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 16, ''dat_end'', ''Дата закінчення договору'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/
commit;
/
