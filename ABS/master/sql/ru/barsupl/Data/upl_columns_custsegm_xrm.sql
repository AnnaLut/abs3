begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 1, ''kf'', ''��� ��'', ''VARCHAR2'', 6, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 2, ''rnk'', ''��� �볺���'', ''NUMBER'', 15, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 3, ''segment_act'', ''C���. ���������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 4, ''segment_fin'', ''C���. ����������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 5, ''segment_beh'', ''C���. �����������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 6, ''social_vip'', ''���������� ²�'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 7, ''segment_trans'', ''ʳ������ ���������� ������� � ���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 8, ''product_amount'', ''���������� ������������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 9, ''deposit_ammount'', ''����. ������������ �������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 10, ''credits_ammount'', ''����. ������������ ������ � �������������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 11, ''garantcredits_ammount'', ''����. ������������ ������ � ���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 12, ''cardcredits_ammount'', ''����. ������������ ������ �� ������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 13, ''energycredits_ammount'', ''����. ������������ ������ �����������������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 14, ''cards_ammount'', ''����. ������������ ������� ������ (���)'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 15, ''accounts_ammount'', ''����. ������������ �������� �������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10050, 16, ''lastchangedt'', ''���� ���������� ����������� ������ �볺���'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
/
commit;
/
