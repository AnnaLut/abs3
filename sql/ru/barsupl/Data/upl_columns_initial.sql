begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 1, ''last_name'', ''�������'', ''CHAR'', 50, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 2, ''first_name'', ''���'', ''CHAR'', 50, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 3, ''middle_name'', ''��-�������'', ''CHAR'', 60, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 4, ''bday'', ''���� ����������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 5, ''gr'', ''������������'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 6, ''passp'', ''��� ���������'', ''NUMBER'', 2, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 7, ''ser'', ''���� ���������'', ''CHAR'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 8, ''numdoc'', ''����� ���������'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 9, ''pdate'', ''���� ������ ���������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 10, ''organ'', ''̳��� ������ ���������'', ''CHAR'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 11, ''passp_expire_to'', ''�������� ������ ��'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 12, ''passp_to_bank'', ''���� ����������� ���������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 13, ''ru'', ''��'', ''CHAR'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 14, ''rnk'', ''��� �������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 15, ''okpo'', ''���'', ''CHAR'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 16, ''cust_status'', ''������ �볺���'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 17, ''cust_active'', ''��� ��������� �볺���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 18, ''telm'', ''�������� �������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 19, ''telw'', ''������� �������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 20, ''teld'', ''���������� (�������) �������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 21, ''teladd'', ''���������� �������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 22, ''email'', ''������ ���������� �����'', ''CHAR'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 23, ''adr_post_country'', ''������ ����������: �����'', ''CHAR'', 55, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 24, ''adr_post_domain'', ''������ ����������: �������'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 25, ''adr_post_region'', ''������ ����������: �����'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 26, ''adr_post_loc'', ''������ ����������: ��������� �����'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 27, ''adr_post_adr'', ''������ ����������: ������'', ''CHAR'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 28, ''adr_post_zip'', ''������ ����������: �������� ������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 29, ''adr_fact_country'', ''������ ���������: �����'', ''CHAR'', 55, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 30, ''adr_fact_domain'', ''������ ���������: �������'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 31, ''adr_fact_region'', ''������ ���������: �����'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 32, ''adr_fact_loc'', ''������ ���������: ��������� �����'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 33, ''adr_fact_adr'', ''������ ���������: ������'', ''CHAR'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 34, ''adr_fact_zip'', ''������ ���������: �������� ������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 35, ''adr_work_country'', ''̳��� ������: �����'', ''CHAR'', 55, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 36, ''adr_work_domain'', ''̳��� ������: �������'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 37, ''adr_work_region'', ''̳��� ������: �����'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 38, ''adr_work_loc'', ''̳��� ������: ��������� �����'', ''CHAR'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 39, ''adr_work_adr'', ''̳��� ������: ������, �������, ��������'', ''CHAR'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 40, ''adr_work_zip'', ''̳��� ������: �������� ������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 41, ''branch'', ''��� ���������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 42, ''negativ_status'', ''���������� ������ (D05)'', ''CHAR'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 43, ''reestr_mob_bank'', ''��������� � ��������� �������'', ''CHAR'', 3, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 44, ''reestr_inet_bank'', ''��������� � ��������-�������'', ''CHAR'', 3, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 45, ''reestr_sms_bank'', ''��������� � SMS �������'', ''CHAR'', 3, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 46, ''month_income'', ''�������� ������� �����'', ''NUMBER'', 10, 2, ''99999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 47, ''subject_role'', ''���� ��� ���`���� (D02)'', ''CHAR'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 48, ''rezident'', ''�������� (D03)'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 49, ''merried'', ''ѳ������ ���� (D08)'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 50, ''emp_status'', ''������ ��������� ����� (D09)'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 51, ''subject_class'', ''������������ ���`���� (D01)'', ''CHAR'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 52, ''insider'', ''������ ������������ �� ��������� �����'', ''CHAR'', 3, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 53, ''sex'', ''�����'', ''CHAR'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 54, ''vipk'', ''�������� ��������� VIP_K'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 55, ''vip_fio_manager'', ''ϲ� ���������� �� ²�'', ''VARCHAR2'', 250, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 56, ''vip_phone_manager'', ''������� ���������� �� ²�'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 57, ''date_on'', ''���� �������� �볺���'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 58, ''date_off'', ''���� �������� �볺���'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 59, ''eddr_id'', ''��������� ����� ������ � ����'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (50, 60, ''actual_date'', ''ĳ����� ��...'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 1, ''nd'', ''id ��������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 2, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 3, ''kf'', ''���������� ���������'', ''CHAR'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 4, ''okpo'', ''���'', ''CHAR'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 5, ''cc_id'', ''� ��������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 6, ''sdate'', ''���� ��������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 7, ''wdate'', ''���� ��������� �������� (���������)'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 8, ''wdate_fact'', ''���� ��������� �������� (��������)'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 9, ''vidd'', ''��� ��������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 10, ''prod'', ''��� ���������� ��������'', ''CHAR'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 11, ''prod_clas'', ''������������ ���������� ��������'', ''CHAR'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 12, ''pawn'', ''��� �������/��������������'', ''CHAR'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 13, ''sdog'', ''���� ������� (�������� ���� ��������)'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 14, ''term'', ''����� ������� (� ������)'', ''NUMBER'', 4, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 15, ''kv'', ''������ �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 16, ''pog_plan'', ''������� ���� ��������� �� ������� �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 17, ''pog_fact'', ''�������� ���� ��������� �� ������� �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 18, ''borg_sy'', ''���� ������� ������������� �� ������� ����, ���'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 19, ''borgproc_sy'', ''���� ������� ������������� �� ��������� �� ������� ����, ���.'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 20, ''bpk_nls'', ''����� ���������� �������(2625)'', ''CHAR'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 21, ''intrate'', ''³�������� ������'', ''NUMBER'', 5, 2, ''990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 22, ''ptn_name'', ''������������ ��������'', ''VARCHAR2'', 255, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 23, ''ptn_okpo'', ''��� ������ ��������'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 24, ''ptn_mother_name'', ''������������ ����������� ������'', ''VARCHAR2'', 255, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 25, ''open_date_bal22'', ''���� �������� ������� 2202/03 ��� 2232/33'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 26, ''es000'', ''������ �� � �����'', ''VARCHAR2'', 24, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 27, ''es003'', ''���� ��������� ������������'', ''VARCHAR2'', 24, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (52, 28, ''vidd_custtype'', ''��� ������� �� ���� ��������: 3 - ���������� ����, 2 - ����������� ����, 1 - ����'', ''NUMBER'', 1, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 1, ''nd'', ''id ��������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 2, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 3, ''kf'', ''���������� ���������'', ''CHAR'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 4, ''cc_id'', ''� ��������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 5, ''sdate'', ''���� ��������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 6, ''branch'', ''³�������, �� ���� ��������� ���������� �������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 7, ''vidd'', ''��� ��������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 8, ''next_pay'', ''���� ��������� ���������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 9, ''probl_rozgl'', ''�� ���䳿 �������� ������� ��� �������� ����������'', ''CHAR'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 10, ''probl_date'', ''���� �������� ������� ����������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 11, ''probl'', ''�������� ������� ����������'', ''CHAR'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 12, ''cred_change'', ''���� ���� ������������'', ''CHAR'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 13, ''cred_datechange'', ''���� ��������� ���� ���� ������������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 14, ''borg'', ''���� ������������� �� �������� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 15, ''borg_tilo'', ''���� ������������� �� ���� ������� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 16, ''borg_proc'', ''���� ������������� �� ��������� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 17, ''prosr1'', ''���� ���������� ����� ���������� �� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 18, ''prosr2'', ''���� ���������� ����� ���������� �� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 19, ''prosrcnt'', ''ʳ������ ������������ �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 20, ''borg_prosr'', ''���� ����������� ������������� �� �������� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 21, ''borg_tilo_prosr'', ''���� ����������� ������������� �� ���� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 22, ''borg_proc_prosr'', ''���� ����������� ������������� �� ���������� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 23, ''penja'', ''���� ��� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 24, ''shtraf'', ''���� ����������� ������� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 25, ''pay_tilo'', ''���� ���������� ����� �� ������� � ��������� ����, ���'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 26, ''pay_proc'', ''���� ���������� �������� �� �������� � ��������� ����, ���'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 27, ''cat_ryzyk'', ''�������� ������ �������� ��������'', ''CHAR'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 28, ''cred_to_prosr'', ''���� ��������� ������� �� ������� ����������� �������������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 29, ''borg_to_pbal'', ''���� ����������� ������������� �� ������������ �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 30, ''vart_majna'', ''������� ���������� ����� �� ������, ���'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 31, ''pog_finish'', ''����� ���� ��������� ������� ����� � �������� ������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 32, ''prosr_fact_cnt'', ''ʳ������ ����� ������ �� ���������'', ''NUMBER'', 4, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 33, ''next_pay_all'', ''���� ���������� �������, ������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 34, ''next_pay_tilo'', ''���� ���������� �������, ���'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 35, ''next_pay_proc'', ''���� ���������� �������, ��������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 36, ''sos'', ''���� ��������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 37, ''last_pay_date'', ''���� ���������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 38, ''last_pay_suma'', ''���� ���������� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 39, ''prosrcnt_proc'', ''ʳ������ ����������� ������������ ������� �� ��������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 40, ''tilo_prosr_uah'', ''���� ���������� �� ��� � �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 41, ''proc_prosr_uah'', ''���� ���������� �� �������� � �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 42, ''borg_tilo_uah'', ''���� ������������� �� ���� � �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 43, ''borg_proc_uah'', ''���� ������������� �� ��������� � �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 44, ''pay_vdvs'', ''������ ������������ ����� �� ����, ���.'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 45, ''amount_commission'', ''���� ���� �� �� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 46, ''amount_prosr_commission'', ''���� ����������� ���� �� �� � ����� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 47, ''es000'', ''������ �� � �����'', ''VARCHAR2'', 24, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 48, ''es003'', ''���� ��������� ������������'', ''VARCHAR2'', 24, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (53, 49, ''vidd_custtype'', ''��� ������� �� ���� ��������: 3 - ���������� ����, 2 - ����������� ����, 1 - ����'', ''NUMBER'', 1, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 2, ''kf'', ''��'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 3, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 4, ''nd'', ''� ��������'', ''CHAR'', 35, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 5, ''dat_begin'', ''������ ��'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 6, ''dat_end'', ''���� ��������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 7, ''nls'', ''����� �������'', ''CHAR'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 8, ''vidd'', ''��� ������'', ''NUMBER'', 5, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 9, ''term'', ''����� ������'', ''NUMBER'', 4, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 10, ''sdog'', ''���� ������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 11, ''massa'', ''���� ������'', ''NUMBER'', 8, 2, ''999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 12, ''kv'', ''������ ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 13, ''intrate'', ''³�������� ������'', ''NUMBER'', 5, 2, ''990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 14, ''sdog_begin'', ''��������� ���� ������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 15, ''last_add_date'', ''���� ��������� ����������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 16, ''last_add_suma'', ''���� ��������� ����������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 17, ''ostc'', ''�������� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 18, ''suma_proc'', ''������� ���� ����������� ����.'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 19, ''suma_proc_plan'', ''���� ������� �� ������� ���� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 20, ''deposit_id'', ''id ��������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 21, ''dpt_status'', ''������ ���.��������'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 22, ''suma_proc_payoff'', ''���� ���������� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 23, ''date_proc_payoff'', ''���� ������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 24, ''date_dep_payoff'', ''���� ������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 25, ''datz'', ''���� ���������� ������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 26, ''dazs'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 27, ''blkd'', ''��� ���������� ������� �� ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 28, ''blkk'', ''��� ���������� ������� �� �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 29, ''cnt_dubl'', ''������� �����������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (55, 30, ''archdoc_id'', ''������������� ����������� �������� � ���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 2, ''kf'', ''��'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 3, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 4, ''nls'', ''����� �������'', ''CHAR'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 5, ''vidd'', ''��� ������'', ''CHAR'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 6, ''daos'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 7, ''kv'', ''������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 8, ''intrate'', ''³�������� ������'', ''NUMBER'', 5, 2, ''990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 9, ''massa'', ''���� ������'', ''NUMBER'', 6, 2, ''9990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 10, ''count_zl'', ''ʳ������ ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 11, ''ostc'', ''�������� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 12, ''ob_mon'', ''������� �� ������� �� �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 13, ''last_add_date'', ''���� ���������� ����������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 14, ''last_add_suma'', ''���� ��������� ����������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 15, ''dazs'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 16, ''blkd'', ''��� ���������� ������� �� ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 17, ''blkk'', ''��� ���������� ������� �� �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (57, 18, ''acc_status'', ''������ ������� (1-��������, 0-��������)'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 2, ''kf'', ''��'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 3, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 4, ''nd'', ''����� ��������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 5, ''dat_begin'', ''���� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 6, ''bpk_type'', ''��� ������� �����'', ''CHAR'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 7, ''nls'', ''����� �������'', ''CHAR'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 8, ''daos'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 9, ''kv'', ''������ �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 10, ''intrate'', ''³�������� ������'', ''NUMBER'', 5, 2, ''990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 11, ''ostc'', ''�������� ������� �� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 12, ''date_lastop'', ''���� �������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 13, ''cred_line'', ''�������� ���'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 14, ''cred_lim'', ''���� ����������� ����.��'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 15, ''use_cred_sum'', ''����������� ���� ����.��'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 16, ''dazs'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 17, ''blkd'', ''��� ���������� ������� �� ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 18, ''blkk'', ''��� ���������� ������� �� �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 19, ''bpk_status'', ''������ �������� �� ������� (1-��������, 0-��������)'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 20, ''pk_okpo'', ''���������� ������, ������ ����������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 21, ''pk_name'', ''���������� ������, ����� ����������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (59, 22, ''pk_okpo_n'', ''���������� ������, ��� ������������ ��������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 2, ''kf'', ''���������� ���������'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 3, ''vidp_pers'', ''³���������� �����'', ''CHAR'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 4, ''phone'', ''���������� ����� �������� ����������'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 5, ''nominal'', ''������'', ''NUMBER'', 7, 2, ''99990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 6, ''kv'', ''������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 7, ''cnt'', ''ʳ������ ��������� ��� ��������� ������������� ����������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 8, ''cnt_sale'', ''ʳ������ �������� ������������� ���������� �� ����� ����'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (61, 9, ''zdate'', ''����� ����'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 2, ''kf'', ''���������� ���������'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 3, ''vidp_pers'', ''³���������� �����'', ''CHAR'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 4, ''phone'', ''���������� ����� �������� ����������'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 5, ''name_mon'', ''����� ������'', ''CHAR'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 6, ''kod'', ''��� ������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 7, ''country'', ''�����'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 8, ''vaga'', ''����'', ''NUMBER'', 7, 2, ''99990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 9, ''vymir_od'', ''������� �����'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 10, ''type_met'', ''��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 11, ''tema'', ''��������'', ''CHAR'', 70, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 12, ''carb'', ''����������'', ''CHAR'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 13, ''cina'', ''ֳ�� � �������'', ''NUMBER'', 10, 2, ''99999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 14, ''cnt'', ''ʳ������ ��������� ��� ��������� �����'', ''NUMBER'', 7, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 15, ''cnt_sale'', ''ʳ������ �������� ����� �� ����� ����'', ''NUMBER'', 7, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (62, 16, ''zdate'', ''����� ����'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 2, ''kf'', ''���������� ���������'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 3, ''vidp_pers'', ''³���������� �����'', ''CHAR'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 4, ''phone'', ''���������� ����� �������� ����������'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 5, ''safenum'', ''����� �����'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 6, ''stan'', ''����'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 7, ''height'', ''������, ��'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 8, ''width'', ''������, ��'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 9, ''depth'', ''�������, ��'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 10, ''price'', ''�������'', ''NUMBER'', 7, 2, ''99990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 11, ''cust_branch'', ''�볺��, ³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 12, ''cust_kf'', ''�볺��, ��'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 13, ''cust_rnk'', ''�볺��, ���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 14, ''dat_begin'', ''������ ��'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 15, ''ndog'', ''� ��������'', ''CHAR'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (63, 16, ''dat_end'', ''���� ��������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 1, ''kf'', ''��� ��'', ''VARCHAR2'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 2, ''rnk'', ''��� �볺���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 3, ''branch'', ''³������� �볺���'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 4, ''nmk'', ''����� ����� �볺���'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 5, ''nmkk'', ''����� �볺��� ���������'', ''VARCHAR2'', 38, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 6, ''ruk'', ''������� ���.�����'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 7, ''okpo'', ''���� �볺���'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 8, ''e_mail'', ''email'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 9, ''telr'', ''���������� �������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 10, ''telb'', ''����� �������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 11, ''tel_fax'', ''fax'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 12, ''date_on'', ''���� �������� �볺���'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 13, ''date_off'', ''���� �������� �볺���'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 14, ''au_country'', ''�����  (��. ������)
'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 15, ''au_zip'', ''�������� ������  (��. ������)'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 16, ''au_domain'', ''�������  (��. ������)'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 17, ''au_region'', ''�����  (��. ������)'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 18, ''au_loc_type'', ''��� ����������� ������ (��. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 19, ''au_locality'', ''���������� ����  (��. ������)'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 20, ''au_adress'', ''������ (������, �������, ��������) (��. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 21, ''au_street_type'', ''��� ������ (��. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 22, ''au_street'', ''������  (��. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 23, ''au_home_type'', ''��� ������� (��. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 24, ''au_home'', ''�������  (��. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 25, ''au_homepart_type'', ''��� ����� ������� (��. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 26, ''au_homepart'', ''� ���� ����� ������� (��. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 27, ''au_room_type'', ''��� ��������� ��������� (��. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 28, ''au_room'', ''� ��������� ��������� (��. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 29, ''af_country'', ''�����  (����. ������)'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 30, ''af_zip'', ''�������� ������  (����. ������)'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 31, ''af_domain'', ''�������  (����. ������)'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 32, ''af_region'', ''�����  (����. ������)'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 33, ''af_loc_type'', ''��� ����������� ������ (����. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 34, ''af_locality'', ''���������� ����  (����. ������)'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 35, ''af_adress'', ''������ (������, �������, ��������) (����. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 36, ''af_street_type'', ''��� ������ (����. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 37, ''af_street'', ''������  (����. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 38, ''af_home_type'', ''��� ������� (����. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 39, ''af_home'', ''�������  (����. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 40, ''af_homepart_type'', ''��� ����� ������� (����. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 41, ''af_homepart'', ''� ���� ����� ������� (����. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 42, ''af_room_type'', ''��� ��������� ��������� (����. ������)'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 43, ''af_room'', ''� ��������� ��������� (����. ������)'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 44, ''fsdry'', ''������ ����� �� ���������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 45, ''fskpr'', ''ʳ������ ����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 46, ''ved'', ''��� ����'', ''CHAR'', 5, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 47, ''idpib'', ''³�����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 48, ''uudv'', ''������� ����. ��������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 49, ''kvpkk'', ''��� ������������� ������������ �������� ����. �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 50, ''oe'', ''������'', ''CHAR'', 5, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 51, ''ise'', ''������ ��������'', ''CHAR'', 5, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 52, ''fs'', ''����� ��������'', ''CHAR'', 2, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 53, ''sed'', ''����� ��������������'', ''CHAR'', 4, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 54, ''rezid'', ''������������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 55, ''ainab'', ''� ������� � ����� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 56, ''fsved'', ''�������� ���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 57, ''kbfl'', ''��. ��� �볺��-�����'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 58, ''prinsider'', ''������ ���������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 59, ''country'', ''����� ���������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 60, ''custtype'', ''��� �볺���'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 61, ''lastchangedt'', ''���� ����������� �볺��� (���� ������ ���)'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (64, 62, ''gcif'', ''GCIF'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (66, 1, ''PSYS'', ''��� ��䳿'', ''NUMBER'', 5, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (66, 2, ''FDAT'', ''���� ��䳿 �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (66, 3, ''FACT_DATE'', ''���� ��䳿 ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (66, 4, ''RNK'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (66, 5, ''KF'', ''��� ��'', ''VARCHAR2'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (66, 6, ''ND'', ''� ��������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (66, 7, ''TXT'', ''��������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 1, ''kf'', ''���������� ���������'', ''CHAR'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 2, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 3, ''okpo'', ''���'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 4, ''nd'', ''id ��'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 5, ''vidd'', ''��� ��������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 6, ''ndz'', ''����� �������� �������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 7, ''datez'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 8, ''mpawn'', ''������, ��������������� ������������ �����'', ''VARCHAR2'', 35, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 9, ''pawnpawn'', ''��� ������ ������������ ����� � ������������� �����'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 10, ''pawn'', ''��� �������� �������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 11, ''ozn'', ''������ �������� �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 12, ''bvart'', ''�������� ������� ������������ �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 13, ''svart'', ''������������� ������� ������������ �����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 14, ''nree'', ''������������ ����� � ���������� ����� ��������'', ''VARCHAR2'', 45, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 15, ''ndstrah'', ''����� �������� ����������� ������������ �����'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 16, ''datestrah'', ''���� ��������� �������� ����������� ������������ �����'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 17, ''cntchk'', ''ʳ������ �������� �������� �� �� ��� �� ����������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 18, ''dlchk'', ''���� �������� �������� ������������ �����'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 19, ''nfact'', ''�������� �������, �� �������� �� ����'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 20, ''stzz'', ''���� ��������� ���������� �� �������� �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 21, ''acc_pawn'', ''acc ������� �������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 22, ''rnk_accpawn'', ''��� ������������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (68, 23, ''state_accpawn'', ''������ �������'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 1, ''BRANCH'', ''��� ���������'', ''VARCHAR2'', 22, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 2, ''NAME'', ''������������ �������������� ���������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 3, ''B040'', ''��� ������������� ����� �� ����������� ��� SPR_B040.dbf'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 4, ''DESCRIPTION'', ''�������� �������������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 5, ''IDPDR'', ''���������� ��. �������������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 6, ''DATE_OPENED'', ''���� �������� ���������'', ''DATE'', 8, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 7, ''DATE_CLOSED'', ''���� �������� ���������'', ''DATE'', 8, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 8, ''DELETED'', null, ''DATE'', 8, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (70, 9, ''SAB'', null, ''VARCHAR2'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (71, 1, ''COUNTRY'', ''��� �����'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (71, 2, ''NAME'', ''����� �����'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (72, 1, ''R020'', ''���������� �� ���'', ''CHAR'', 4, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (72, 2, ''OB22'', ''��� ��22'', ''CHAR'', 2, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (72, 3, ''TXT'', ''������������ �����'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (73, 1, ''PAWN'', ''��� ���� ������������'', ''NUMBER'', 5, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (73, 2, ''NAME'', ''������������ ���� ������������'', ''VARCHAR2'', 250, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (73, 3, ''D_CLOSE'', ''���� ��������� 䳿'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (74, 1, ''VIDD'', ''��� ���� ��'', ''NUMBER'', 5, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (74, 2, ''NAME'', ''��� ��������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (75, 1, ''PASSP'', ''��� ���������'', ''NUMBER'', 2, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (75, 2, ''NAME'', ''����� ���� ���������'', ''VARCHAR2'', 35, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (76, 1, ''CODE'', ''��� �����'', ''VARCHAR2'', 32, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (76, 2, ''PRODUCT_CODE'', ''��� ��������'', ''VARCHAR2'', 32, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (76, 3, ''SUB_CODE'', ''��� �����������'', ''VARCHAR2'', 32, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (77, 1, ''ID'', ''��� ��䳿'', ''NUMBER'', 5, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (77, 2, ''TXT'', ''����'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (78, 1, ''SOS'', ''��� ����� ��'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (78, 2, ''NAME'', ''������������ ����� ��'', ''VARCHAR2'', 35, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (79, 1, ''VIDD'', ''��� ���� ������'', ''NUMBER'', 9, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (79, 2, ''TYPE_NAME'', ''������������ ���� ������'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (80, 1, ''obj'', ''����'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (80, 2, ''start_time'', ''������� �������'', ''DATE'', 14, null, ''ddmmyyyyhh24miss'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (80, 3, ''stop_time'', ''���������� �������'', ''DATE'', 14, null, ''ddmmyyyyhh24miss'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (80, 4, ''rows_ok'', ''ʳ������ ������ ���������� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (80, 5, ''rows_err'', ''ʳ������ ������������ ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (80, 6, ''status'', ''������ �������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 1, ''mfo'', ''���'', ''VARCHAR2'', 6, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 2, ''rnk'', ''��� �볺���'', ''NUMBER'', 24, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 3, ''branch'', ''�����'', ''VARCHAR2'', 24, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 4, ''ref'', ''���. ���������'', ''NUMBER'', 24, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (83, 5, ''nls'', ''����� �������'', ''VARCHAR2'', 14, null, null, null, ''N'', null, null, null, null)'; 
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


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 1, ''last_name'', ''��i�����'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 2, ''first_name'', ''���'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 3, ''middle_name'', ''��-�������'', ''VARCHAR2'', 60, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 4, ''id_cla'', ''������������� �볺��� �'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 5, ''name_doc'', ''����� ���������'', ''VARCHAR2'', 40, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 6, ''ser'', ''���� ���������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 7, ''numdoc'', ''����� ���������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 8, ''organ'', ''̳��� ������ ���������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 9, ''bday'', ''���� ����������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 10, ''country_send'', ''��� ����� �����������'', ''VARCHAR2'', 3, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 11, ''rnk'', ''��� �������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 12, ''last_name_r'', ''��i����� ����������'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 13, ''first_name_r'', ''��� ����������'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 14, ''middle_name_r'', ''��-������� ����������'', ''VARCHAR2'', 60, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 15, ''country_r'', ''��� ����� ��������� ��������'', ''VARCHAR2'', 3, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 16, ''meta'', ''���� ��������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 17, ''mfo'', ''���'', ''VARCHAR2'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 18, ''branch'', ''�����'', ''VARCHAR2'', 24, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 19, ''tt'', ''TT'', ''VARCHAR2'', 4, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 20, ''bdate'', ''bdate'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 21, ''s'', ''���� � ������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 22, ''kv'', ''kv'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 23, ''curs_of'', ''��������� ����'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 24, ''curs_prod'', ''���� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 25, ''swift'', ''swift'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 26, ''kassa'', ''������ �������� ����� ����/���.���'', ''VARCHAR2'', 1, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 27, ''s_eq'', ''���� � ���������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 28, ''ref'', ''ref'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 29, ''mtsc'', ''����� ������� �������� ��������'', ''VARCHAR2'', 60, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 30, ''mtel'', ''�������� ������� ����������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (84, 31, ''mtel_r'', ''�������� ������� ����������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 1, ''mfo'', ''���'', ''VARCHAR2'', 6, null, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 2, ''branch'', ''³�������'', ''VARCHAR2'', 24, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 3, ''dogn'', ''� (��������) ��������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 4, ''dogstart'', ''���� ��������� ��������(����.���������)'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 5, ''dogend'', ''���� �������� ��������(����. ���������)'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 6, ''rnk'', ''��� �������� ������� ����������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 7, ''nls'', ''������� ���������� (2625'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 
 2620)'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 8, ''kv'', ''������ ����������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 9, ''branch_nls'', ''³������� ���������� �������'', ''VARCHAR2'', 24, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 10, ''nls_rec'', ''������� ����������'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 11, ''kv_rec'', ''������ ����������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 12, ''name_rec'', ''����� ����������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 13, ''okpo_rec'', ''okpo ����������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 14, ''bank_rec'', ''����� ����� ����������'', ''VARCHAR2'', 40, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 15, ''nazn'', ''����������� �������'', ''VARCHAR2'', 160, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 16, ''splat'', ''���� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 17, ''max_splat'', ''Max ���� �������'', ''NUMBER'', 15, 2, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 18, ''sumk'', ''���� ����'', ''NUMBER'', 15, 2, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 19, ''dates'', ''���� C'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 20, ''datepo'', ''���� ��'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 21, ''period'', ''�����������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 22, ''datecrt'', ''���� �� ��� ���������'', ''DATE'', 27, null, ''yyyy-mm-dd hh24:mi:ss.sssss'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 23, ''DK'', ''�/�'', ''NUMBER'', 1, 0, null, null, ''N'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 24, ''vidrp'', ''��� ���.����.'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 25, ''date_pl'', ''�������� ���� ���������� �������'', ''DATE'', 27, null, ''yyyy-mm-dd hh24:mi:ss.sssss'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (87, 26, ''state'', ''������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 1, ''kf'', ''��� ��'', ''VARCHAR2'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 2, ''rnk'', ''��� �볺���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 3, ''rel_id'', ''��� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 4, ''rel_rnk'', ''��� / id �������� �����'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 5, ''rel_intext'', ''��� �������� �����'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 6, ''name'', ''�����/ϲ�'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 7, ''okpo'', ''���� �볺���'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 8, ''vaga1'', ''���� ����� ����� � ��� ����'', ''NUMBER'', 8, 4, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 9, ''custtype'', ''������� (1-��, 2-��)'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 10, ''tel'', ''���������� �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 11, ''email'', ''email'', ''VARCHAR2'', 250, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 12, ''position'', ''������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 13, ''sed'', ''��� ���� ��.��������'', ''CHAR'', 4, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 14, ''bdate'', ''���� ������� 䳿 ���������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 15, ''edate'', ''���� ���������� 䳿 ��������� '', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (89, 16, ''sign_privs'', ''�� � � ������� ����� ����� ������ (0/1) '', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


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


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 2, ''kf'', ''��'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 3, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 4, ''nd'', ''����� ��������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 5, ''dat_begin'', ''���� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 6, ''bpk_type'', ''��� ������� �����'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 7, ''nls'', ''����� �������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 8, ''daos'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 9, ''kv'', ''������ �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 10, ''intrate'', ''³�������� ������'', ''NUMBER'', 5, 2, ''990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 11, ''ostc'', ''�������� ������� �� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 12, ''date_lastop'', ''���� �������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 13, ''cred_line'', ''�������� ���'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 14, ''cred_lim'', ''���� ����������� ����.��'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 15, ''use_cred_sum'', ''����������� ���� ����.��'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 16, ''dazs'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 17, ''blkd'', ''��� ���������� ������� �� ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 18, ''blkk'', ''��� ���������� ������� �� �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 19, ''bpk_status'', ''������ �������� �� ������� (1-��������, 0-��������)'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 20, ''pk_okpo'', ''���������� ������, ������ ����������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 21, ''pk_name'', ''���������� ������, ����� ����������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 22, ''pk_okpo_n'', ''���������� ������, ��� ������������ ��������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 23, ''VID'', ''��� ������� (���)'', ''VARCHAR2'', 35, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 24, ''LIE_SUM'', ''����� �������. ���� ���������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 25, ''LIE_VAL'', ''����� �������. ������ ���������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 26, ''LIE_DATE'', ''����� �������. ���� ���������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 27, ''LIE_DOCN'', ''����� �������. ����� ���������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 28, ''LIE_ATRT'', ''����� �������. �����, ���� ����� ��������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 29, ''LIE_DOC'', ''����� �������. ����� ���������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 30, ''PK_TERM'', ''���. ʳ������ ������ 䳿 ������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 31, ''PK_OLDND'', ''���. ����� �������� �� ��'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 32, ''PK_WORK'', ''���. ̳��� ������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 33, ''PK_CNTRW'', ''���. ̳��� ������: �����'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 34, ''PK_OFAX'', ''���. ̳��� ������: FAX'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 35, ''PK_PHONE'', ''���. ̳��� ������: �������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 36, ''PK_PCODW'', ''���. ̳��� ������: �������� ������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 37, ''PK_ODAT'', ''���. ̳��� ������: � ����� ���� ������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 38, ''PK_STRTW'', ''���. ̳��� ������: ������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 39, ''PK_CITYW'', ''���. ̳��� ������: ����'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 40, ''PK_OFFIC'', ''���. ������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 41, ''DKBO_DATE_OFF'', ''���� ��������� ����'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 42, ''DKBO_START_DATE'', ''���� ��������� �� ����'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 43, ''DKBO_DEAL_NUMBER'', ''� �������� ����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 44, ''KOS'', ''������� ������'', ''NUMBER'', 24, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 45, ''DOS'', ''������� �����'', ''NUMBER'', 24, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 46, ''W4_ARSUM'', ''Way4. ���������� ����'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 47, ''W4_KPROC'', ''Way4. ³������ �� �������'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10051, 48, ''W4_SEC'', ''Way4. ����� �����'', ''VARCHAR2'', 254, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 1, ''branch'', ''³�������'', ''CHAR'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 2, ''kf'', ''��'', ''CHAR'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 3, ''rnk'', ''���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 4, ''nd'', ''� ��������'', ''VARCHAR2'', 35, null, null, null, ''Y'', null, ''35,09,13,10|32,32,32,32'', null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 5, ''dat_begin'', ''������ ��'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 6, ''dat_end'', ''���� ��������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 7, ''nls'', ''����� �������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 8, ''vidd_name'', ''��� ������'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 9, ''term'', ''����� ������'', ''NUMBER'', 4, 2, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 10, ''sdog'', ''���� ������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 11, ''massa'', ''���� ������'', ''NUMBER'', 8, 2, ''999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 12, ''kv'', ''������ ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 13, ''intrate'', ''³�������� ������'', ''NUMBER'', 5, 2, ''990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 14, ''sdog_begin'', ''��������� ���� ������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 15, ''last_add_date'', ''���� ��������� ����������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 16, ''last_add_suma'', ''���� ��������� ����������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 17, ''ostc'', ''�������� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 18, ''suma_proc'', ''������� ���� ����������� ����.'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 19, ''suma_proc_plan'', ''���� ������� �� ������� ���� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 20, ''deposit_id'', ''id ��������'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 21, ''dpt_status'', ''������ ���.��������'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 22, ''suma_proc_payoff'', ''���� ���������� �������'', ''NUMBER'', 15, 2, ''9999999999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 23, ''date_proc_payoff'', ''���� ������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 24, ''date_dep_payoff'', ''���� ������� ��������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 25, ''datz'', ''���� ���������� ������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 26, ''dazs'', ''���� �������� �������'', ''DATE'', 10, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 27, ''blkd'', ''��� ���������� ������� �� ������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 28, ''blkk'', ''��� ���������� ������� �� �������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 29, ''cnt_dubl'', ''������� �����������'', ''NUMBER'', 3, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 30, ''archdoc_id'', ''������������� ����������� �������� � ���'', ''NUMBER'', 15, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 31, ''ncash'', ''����� �������� (���/������)'', ''VARCHAR2'', 128, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 32, ''name_d'', ''���������� ��������'', ''VARCHAR2'', 128, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 33, ''okpo_d'', ''��� ���������� ��������'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 34, ''NLS_D'', ''����� ����� ���������� ��������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 35, ''MFO_D'', ''��� ����� ���������� ��������'', ''VARCHAR2'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 36, ''NAME_P'', ''���������� ���������'', ''VARCHAR2'', 128, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 37, ''OKPO_P'', ''��� ����������  ���������'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 38, ''NLSB'', ''����� ����� ����������  ���������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 39, ''MFOB'', ''��� ����� ����������  ���������'', ''VARCHAR2'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 40, ''NLSP'', ''����� ����� ���������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 41, ''ROSP_M'', ''����� � ������ ����������� ����'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 42, ''MAL'', ''����� �� ��� ����������� ����'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 43, ''BEN'', ''����� �� �����������'', ''NUMBER'', 1, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10052, 44, ''vidd'', ''��� ��� ������'', ''NUMBER'', 5, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 1, ''LAST_NAME'', ''�������'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 2, ''FIRST_NAME'', ''��''''�'', ''VARCHAR2'', 50, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 3, ''MIDDLE_NAME'', ''��-�������'', ''VARCHAR2'', 60, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 4, ''BDAY'', ''���� ����������'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 5, ''GR'', ''������������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 6, ''PASSP'', ''��� ���������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 7, ''SER'', ''����'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 8, ''NUMDOC'', ''����� ���������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 9, ''PDATE'', ''���� ������'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 10, ''ORGAN'', ''����� ������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 11, ''PASSP_EXPIRE_TO'', ''�������� ������ ��'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 12, ''PASSP_TO_BANK'', ''���� ����''''������� ��������� �����'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 13, ''MFO'', ''���'', ''VARCHAR2'', 12, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 14, ''RNK'', ''���'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 15, ''OKPO'', ''���'', ''VARCHAR2'', 14, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 16, ''CUST_STATUS'', ''������ �볺��� � ����'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 17, ''CUST_ACTIVE'', ''��� ��������� �볺���'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 18, ''TELM'', ''�������� �������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 19, ''TELW'', ''������� �������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 20, ''TELD'', ''���������� �������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 21, ''TELADD'', ''�������� ��������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 22, ''EMAIL'', ''���������� �����'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 23, ''ADR_POST_COUNTRY'', ''�����'', ''VARCHAR2'', 55, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 24, ''ADR_POST_DOMAIN'', ''�������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 25, ''ADR_POST_REGION'', ''�����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 26, ''ADR_POST_LOC'', ''��������� �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 27, ''ADR_POST_ADR'', ''������, �������, ��������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 28, ''ADR_POST_ZIP'', ''�������� ������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 29, ''ADR_FACT_COUNTRY'', ''�����'', ''VARCHAR2'', 55, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 30, ''ADR_FACT_DOMAIN'', ''�������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 31, ''ADR_FACT_REGION'', ''�����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 32, ''ADR_FACT_LOC'', ''��������� �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 33, ''ADR_FACT_ADR'', ''������, �������, ��������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 34, ''ADR_FACT_ZIP'', ''�������� ������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 35, ''ADR_WORK_COUNTRY'', ''�����'', ''VARCHAR2'', 55, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 36, ''ADR_WORK_DOMAIN'', ''�������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 37, ''ADR_WORK_REGION'', ''�����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 38, ''ADR_WORK_LOC'', ''��������� �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 39, ''ADR_WORK_ADR'', ''������, �������, ��������'', ''VARCHAR2'', 55, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 40, ''ADR_WORK_ZIP'', ''�������� ������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 41, ''BRANCH'', ''³�������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 42, ''NEGATIV_STATUS'', ''���������� ������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 43, ''REESTR_MOB_BANK'', ''��������� � ��������� �������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 44, ''REESTR_INET_BANK'', ''��������� � ��������-�������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 45, ''REESTR_SMS_BANK'', ''��������� � ���-�������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 46, ''MONTH_INCOME'', ''�������� ������� �����'', ''NUMBER'', 22, 2, ''99999990D00'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 47, ''SUBJECT_ROLE'', ''���� ��� ���''''����'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 48, ''REZIDENT'', ''��������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 49, ''MERRIED'', ''ѳ������ ����'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 50, ''EMP_STATUS'', ''������ ��������� �����'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 51, ''SUBJECT_CLASS'', ''������������ ���''''����'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 52, ''INSIDER'', ''������ ������������ �� ���������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 53, ''SEX'', ''�����'', ''CHAR'', 1, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 54, ''VIPK'', ''�������� ��������� ²�'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 55, ''VIP_FIO_MANAGER'', ''ϲ� ���������� �� ²�'', ''VARCHAR2'', 250, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 56, ''VIP_PHONE_MANAGER'', ''������� ���������� �� ²�'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 57, ''DATE_ON'', ''���� �������� �볺���'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 58, ''DATE_OFF'', ''���� �������� ��� �볺���'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 59, ''EDDR_ID'', ''����� ������ � ����'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 60, ''BPLACE'', ''̳��� ����������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 61, ''SUBSD'', ''���� �����䳿'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 62, ''SUBSN'', ''����� �����䳿'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 63, ''ELT_N'', ''ELT. ����� �������� �볺��-����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 64, ''ELT_D'', ''ELT. ���� �������� �볺��-����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 65, ''GCIF'', ''GCIF'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 66, ''NOMPDV'', ''����� � ����� ���'', ''VARCHAR2'', 9, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 67, ''NOM_DOG'', ''����� �������� �� �������'', ''VARCHAR2'', 10, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 68, ''SW_RN'', ''����� �볺��� ���������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 69, ''Y_ELT'', ''������������� ������ ���������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 70, ''ADM'', ''����. ����� ���������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 71, ''FADR'', ''������ ����������� �����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 72, ''ADR_ALT'', ''������������� ������'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 73, ''BUSSS'', ''������-������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 74, ''PC_MF'', ''���. ĳ���� ������� �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 75, ''PC_Z4'', ''���. �������������. ĳ� ��'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 76, ''PC_Z3'', ''���. �������������. ��� �������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 77, ''PC_Z5'', ''���. �������������. ���� �������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 78, ''PC_Z2'', ''���. �������������. �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 79, ''PC_Z1'', ''���. �������������. ����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 80, ''AGENT'', ''���. ��� ������ ���������� �� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 81, ''PC_SS'', ''���. ѳ������ ����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 82, ''STMT'', ''³� �������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 83, ''VIDKL'', ''³� �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 84, ''VED'', ''��� ��������� ��������'', ''CHAR'', 5, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 85, ''TIPA'', ''��� ��������� ���� ��������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 86, ''PHKLI'', ''���� ������, ����� ����������� �볺��'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 87, ''AF1_9'', ''��� ��� ��������� �� ���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 88, ''IDDPD'', ''���� �������� � ������ ������� ���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 89, ''DAIDI'', ''���� ��������� �� ������ ������. �������� �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 90, ''DATVR'', ''���� �������� ������� �������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 91, ''DATZ'', '' ���� ���������� ���������� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 92, ''IDDPL'', ''���� ������� �������������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 93, ''DATE_PHOTO'', ''���� �������� ����������'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 94, ''IDDPR'', ''���� ��������� �������.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 95, ''ISE'', ''������������� ������ ��������'', ''CHAR'', 5, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 96, ''OBSLU'', ''������ �������������� �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 97, ''CRSRC'', ''������� ���������(DPT-���.������, CCK-����.���.)'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 98, ''DJOTH'', ''�������. ����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 99, ''DJAVI'', ''�������. ��������� �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 100, ''DJ_TC'', ''�������. ����� �� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 101, ''DJOWF'', ''�������. ����� �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 102, ''DJCFI'', ''�������. ����� ��������� �� ��.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 103, ''DJ_LN'', ''�������. ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 104, ''DJ_FH'', ''�������. Գ������� ��������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 105, ''DJ_CP'', ''�������. ��'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 106, ''CHORN'', ''�����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 107, ''CRISK_KL'', ''���� ������������'', ''VARCHAR2'', 1, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 108, ''BC'', ''�볺�� �����'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 109, ''SPMRK'', ''��� "������� ������" �����.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 110, ''K013'', ''��� ���� �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 111, ''KODID'', ''��� ���������. �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 112, ''COUNTRY'', ''��� �����'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 113, ''MS_FS'', ''���.-������� �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 114, ''MS_VD'', ''������ ���� ��������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 115, ''MS_GR'', ''��������� �� �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 116, ''LIM_KASS'', ''˳�� ����'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 117, ''LIM'', ''˳�� �� ������ ������.'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 118, ''LICO'', ''˳���糿 �� ���. ������ ����.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 119, ''UADR'', ''̳����������. ��. ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 120, ''MOB01'', ''�������� 1'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 121, ''MOB02'', ''�������� 2'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 122, ''MOB03'', ''�������� 3'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 123, ''SUBS'', ''�������� �����䳿'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 124, ''K050'', ''���������� ��� �050'', ''CHAR'', 3, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 125, ''DEATH'', ''������ �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 126, ''NO_PHONE'', ''³�������� ���������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 127, ''NSMCV'', ''��� �볺���(��/����/���/����)'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 128, ''NSMCC'', ''��� �볺��� � ����. ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 129, ''NSMCT'', ''��� �볺���.�-������� �����, 2-����.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 130, ''NOTES'', ''������� �������'', ''VARCHAR2'', 140, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 131, ''SAMZ'', ''�������������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 132, ''OREP'', ''��������� �볺���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 133, ''OVIFS'', ''³��������� �������� ����� ���.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 134, ''AF6'', ''³������. �������� ��� � ������� �����.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 135, ''FSKRK'', ''����.����.���.�����.���.������� �� ��'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 136, ''FSOMD'', ''̳�. �����. ����� ��''''�'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 137, ''FSVED'', ''���������������� ��������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 138, ''FSZPD'', ''������� ����. ��������(��)'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 139, ''FSPOR'', ''�������� �� ���. ������. ��'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 140, ''FSRKZ'', ''����. ������.����.��������.�� �����.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 141, ''FSZOP'', ''������ �� ������� �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 142, ''FSKPK'', ''�-��� �������� �����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 143, ''FSKPR'', ''�-��� ������� ����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 144, ''FSDIB'', ''�������� �������� � ���. ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 145, ''FSCP'', ''�������� - ���� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 146, ''FSVLZ'', ''�������� - �������� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 147, ''FSVLA'', ''�������� - ����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 148, ''FSVLN'', ''�������� - ����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 149, ''FSVLO'', ''�������� - ����������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 150, ''FSSST'', ''���������� ������(��)'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 151, ''FSSOD'', ''���� ��������� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 152, ''FSVSN'', ''������ ��� ����� - �������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 153, ''DOV_P'', ''�������� ��� ����. �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 154, ''DOV_A'', ''������ ����. �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 155, ''DOV_F'', ''������� �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 156, ''NMKV'', ''����� ��''''�(���)'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 157, ''SN_GC'', ''����� ��''''�(���. ���.)'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 158, ''NMKK'', ''����� ��''''�(������.)'', ''VARCHAR2'', 38, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 159, ''PRINSIDER'', ''�������� ������ ���������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 160, ''NOTESEC'', ''������� ��� ��'', ''VARCHAR2'', 256, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 161, ''MB'', ''��������� �� ������ ������'', ''CHAR'', 1, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 162, ''PUBLP'', ''��������� �� ����. �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 163, ''WORKB'', ''��������� �� ����. �����'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 164, ''C_REG'', ''������� ϲ'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 165, ''C_DST'', ''�������� ϲ'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 166, ''RGADM'', ''���. ����� � �����������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 167, ''RGTAX'', ''���. ����� ϲ'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 168, ''DATEA'', ''���� �����. � ����.'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 169, ''DATET'', ''���� �����. � ϲ'', ''DATE'', 7, null, ''dd/mm/yyyy'', null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 170, ''RNKP'', ''������. ����� ��������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 171, ''CIGPO'', ''������ ���������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 172, ''COUNTRY_NAME'', ''����� �����'', ''VARCHAR2'', 70, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 173, ''TARIF'', ''��������� �����(��)'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 174, ''AINAB'', ''������� � ����� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 175, ''TGR'', ''��� ���������� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 176, ''CUSTTYPE'', ''��� �볺���'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 177, ''RIZIK'', ''г���� ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 178, ''SNSDR'', ''������� ����, ���. ���. ����. �����.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 179, ''IDPIB'', ''ϲ� ����., �����. �� �����. �� ������.'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 180, ''FS'', ''����� ��������'', ''CHAR'', 2, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 181, ''SED'', ''����� ��������������(�051)'', ''CHAR'', 4, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 182, ''DJER'', ''�������������� ������ ����. ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 183, ''CODCAGENT'', ''�������������� �볺���(�010)'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 184, ''SUTD'', ''�������������� ��� ��������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 185, ''RVDBC'', ''���. DBCode'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 186, ''RVIBA'', ''���. ������ ���. ������ ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 187, ''RVIDT'', ''���. ���� ������ ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 188, ''RV_XA'', ''���. ��''''� ����� ��'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 189, ''RVIBR'', ''���. ³������� ������ ������'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 190, ''RVIBB'', ''���. ³������� ������ ������(���)'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 191, ''RVRNK'', ''���. ��� � ���'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 192, ''RVPH1'', ''���. �������-1'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 193, ''RVPH2'', ''���. �������-2'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 194, ''RVPH3'', ''���. �������-3'', ''VARCHAR2'', 500, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 195, ''SAB'', ''����������� ��� �볺���'', ''VARCHAR2'', 6, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 196, ''J_COUNTRY'', ''��. ���. �����'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 197, ''J_ZIP'', ''��. ���. ������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 198, ''J_DOMAIN'', ''��. ���. �������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 199, ''J_REGION'', ''��. ���. �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 200, ''J_LOCALITY'', ''��. ���. ���. �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 201, ''J_ADDRESS'', ''��. ���. ������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 202, ''J_TERRITORY_ID'', ''��. ���. ��� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 203, ''J_LOCALITY_TYPE'', ''��. ���. ��� ���. ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 204, ''J_STREET_TYPE'', ''��. ���. ��� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 205, ''J_STREET'', ''��. ���. ������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 206, ''J_HOME_TYPE'', ''��. ���. ��� �������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 207, ''J_HOME'', ''��. ���. �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 208, ''J_HOMEPART_TYPE'', ''��. ���. ��� ������� ���.'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 209, ''J_HOMEPART'', ''��. ���. ������� �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 210, ''J_ROOM_TYPE'', ''��. ���. ��� ����. �����.'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 211, ''J_ROOM'', ''��. ���. ����. ���������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 212, ''J_KOATUU'', ''��. ���. ��� ������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 213, ''J_REGION_ID'', ''��. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 214, ''J_AREA_ID'', ''��. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 215, ''J_SETTLEMENT_ID'', ''��. ���. ��� ���������� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 216, ''J_STREET_ID'', ''��. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 217, ''J_HOUSE_ID'', ''��. ���. ��� �������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 218, ''F_COUNTRY'', ''����. ���. �����'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 219, ''F_ZIP'', ''����. ���. ������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 220, ''F_DOMAIN'', ''����. ���. �������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 221, ''F_REGION'', ''����. ���. �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 222, ''F_LOCALITY'', ''����. ���. ���. �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 223, ''F_ADDRESS'', ''����. ���. ������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 224, ''F_TERRITORY_ID'', ''����. ���. ��� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 225, ''F_LOCALITY_TYPE'', ''����. ���. ��� ���. ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 226, ''F_STREET_TYPE'', ''����. ���. ��� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 227, ''F_STREET'', ''����. ���. ������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 228, ''F_HOME_TYPE'', ''����. ���. ��� �������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 229, ''F_HOME'', ''����. ���. �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 230, ''F_HOMEPART_TYPE'', ''����. ���. ��� ����. �������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 231, ''F_HOMEPART'', ''����. ���. ������� �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 232, ''F_ROOM_TYPE'', ''����. ���. ��� ����. �����.'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 233, ''F_ROOM'', ''����. ���. ����. �����.'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 234, ''F_KOATUU'', ''����. ���. ��� ������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 235, ''F_REGION_ID'', ''����. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 236, ''F_AREA_ID'', ''����. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 237, ''F_SETTLEMENT_ID'', ''����. ���. ��� ���������� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 238, ''F_STREET_ID'', ''����. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 239, ''F_HOUSE_ID'', ''����. ���. ��� �������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 240, ''P_COUNTRY'', ''����. ���. �����'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 241, ''P_ZIP'', ''����. ���. ������'', ''VARCHAR2'', 20, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 242, ''P_DOMAIN'', ''����. ���. �������'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 243, ''P_REGION'', ''����. ���. �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 244, ''P_LOCALITY'', ''����. ���. �����. �����'', ''VARCHAR2'', 30, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 245, ''P_ADDRESS'', ''����. ���. ������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 246, ''P_TERRITORY_ID'', ''����. ���. ��� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 247, ''P_LOCALITY_TYPE'', ''����. ���. ��� ���. ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 248, ''P_STREET_TYPE'', ''����. ���. ��� ������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 249, ''P_STREET'', ''����. ���. ������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 250, ''P_HOME_TYPE'', ''����. ���. ��� �������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 251, ''P_HOME'', ''����. ���. �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 252, ''P_HOMEPART_TYPE'', ''����. ���. ��� ������� �������'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 253, ''P_HOMEPART'', ''����. ���. ������� �������'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 254, ''P_ROOM_TYPE'', ''����. ���. ��� ����. �����.'', ''NUMBER'', 22, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 255, ''P_ROOM'', ''����. ���. ����. �����.'', ''VARCHAR2'', 100, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 256, ''P_KOATUU'', ''����. ���. ��� ������'', ''VARCHAR2'', 15, null, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 257, ''P_REGION_ID'', ''����. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 258, ''P_AREA_ID'', ''����. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 259, ''P_SETTLEMENT_ID'', ''����. ���. ��� ���������� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 260, ''P_STREET_ID'', ''����. ���. ��� ������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 


begin 
 execute immediate 'insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
values (10053, 261, ''P_HOUSE_ID'', ''����. ���. ��� �������'', ''NUMBER'', 10, 0, null, null, ''Y'', null, null, null, null)'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 

/
commit'; 
 exception 
 when dup_val_on_index then null; 
 end; 
 / 

/
