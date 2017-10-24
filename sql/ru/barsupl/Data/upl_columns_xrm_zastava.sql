begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 1, ''kf'', ''Регіональне управління'', ''CHAR'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 2, ''rnk'', ''РНК'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 3, ''okpo'', ''ІПН'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 4, ''nd'', ''id КД'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 5, ''vidd'', ''тип договору'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 6, ''ndz'', ''Номер договору застави'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 7, ''datez'', ''Дата договору застави'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 8, ''mpawn'', ''Індекс, місцезнаходження заставленого майна'', ''VARCHAR2'', 35, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 9, ''pawnpawn'', ''Код підвиду забезпечення згідно з класифікатору банку'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 10, ''pawn'', ''Код предмету застави'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 11, ''ozn'', ''ознаки предмету застави'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 12, ''bvart'', ''Договірна вартість заставленого майна'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 13, ''svart'', ''Рекомендована вартість заставленого майна'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 14, ''nree'', ''Реєстраційний номер в державному реєстрі обтяжень'', ''VARCHAR2'', 45, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 15, ''ndstrah'', ''Номер договору страхування заставленого майна'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 16, ''datestrah'', ''Дата укладання договору страхування заставленого майна'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 17, ''cntchk'', ''Кількість планових перевірок на рік або їх особливості'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 18, ''dlchk'', ''Дата останньої перевірки заставленого майна'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 19, ''nfact'', ''Негативні фактори, які вплинути на стан'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 20, ''stzz'', ''Стан виконання зобов’язань по договору застави'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 21, ''acc_pawn'', ''acc рахунку застави'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 22, ''rnk_accpawn'', ''РНК заставодавця'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 23, ''state_accpawn'', ''статус застави'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/
commit;
/
