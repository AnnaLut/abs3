begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 1, ''mfo'', ''МФО'', ''VARCHAR2'', 6, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 2, ''rnk'', ''РНК клієнта'', ''NUMBER'', 24, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 3, ''branch'', ''бранч'', ''VARCHAR2'', 24, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 4, ''ref'', ''Реф. документа'', ''NUMBER'', 24, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 5, ''nls'', ''номер рахунку'', ''VARCHAR2'', 14, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 6, ''pdat'', ''pdat'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 7, ''s'', ''Suma'', ''NUMBER'', 15, 2, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 8, ''kv'', ''kv'', ''NUMBER'', 3, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 9, ''tt'', ''TT'', ''VARCHAR2'', 4, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 10, ''dk'', ''DK'', ''NUMBER'', 1, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/
commit;
/
