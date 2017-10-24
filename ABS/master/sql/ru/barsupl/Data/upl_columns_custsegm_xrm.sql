begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 1, ''kf'', ''МФО РУ'', ''VARCHAR2'', 6, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 2, ''rnk'', ''РНК клієнта'', ''NUMBER'', 15, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 3, ''segment_act'', ''Cегм. активності'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 4, ''segment_fin'', ''Cегм. фінансовий'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 5, ''segment_beh'', ''Cегм. поведінковий'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 6, ''social_vip'', ''Соціальний ВІП'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 7, ''segment_trans'', ''Кількість розрахунків карткою в ТСП'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 8, ''product_amount'', ''Продуктове навантаження'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 9, ''deposit_ammount'', ''Прод. навантаження депозит'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 10, ''credits_ammount'', ''Прод. навантаження кредит з забезпеченням'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 11, ''garantcredits_ammount'', ''Прод. навантаження кредит з БПК'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 12, ''cardcredits_ammount'', ''Прод. навантаження кредит під поруку'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 13, ''energycredits_ammount'', ''Прод. навантаження кредит Енергоефективність'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 14, ''cards_ammount'', ''Прод. навантаження платіжна картка (БПК)'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 15, ''accounts_ammount'', ''Прод. навантаження поточний рахунок'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 16, ''lastchangedt'', ''Дата останнього редагування картки клієнта'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/
commit;
/
