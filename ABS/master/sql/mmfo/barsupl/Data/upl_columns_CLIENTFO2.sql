prompt CLIENTFO2 columns
declare
l_file_id number;
begin
  select file_id into l_file_id from upl_files where file_code = 'CLIENTFO2';
  --������� ��� ������
  delete from upl_columns where file_id = l_file_id;
  --�������� ������

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 1, 'LAST_NAME', '�������', 'VARCHAR2', 50, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 2, 'FIRST_NAME', '��''�', 'VARCHAR2', 50, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 3, 'MIDDLE_NAME', '��-�������', 'VARCHAR2', 60, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 4, 'BDAY', '���� ����������', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 5, 'GR', '������������', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 6, 'PASSP', '��� ���������', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 7, 'SER', '����', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 8, 'NUMDOC', '����� ���������', 'VARCHAR2', 20, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 9, 'PDATE', '���� ������', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 10, 'ORGAN', '����� ������', 'VARCHAR2', 70, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 11, 'PASSP_EXPIRE_TO', '�������� ������ ��', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 12, 'PASSP_TO_BANK', '���� ����''������� ��������� �����', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 13, 'MFO', '���', 'VARCHAR2', 12, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 14, 'RNK', '���', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 15, 'OKPO', '���', 'VARCHAR2', 14, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 16, 'CUST_STATUS', '������ �볺��� � ����', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 17, 'CUST_ACTIVE', '��� ��������� �볺���', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 18, 'TELM', '�������� �������', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 19, 'TELW', '������� �������', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 20, 'TELD', '���������� �������', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 21, 'TELADD', '�������� ��������', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 22, 'EMAIL', '���������� �����', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 23, 'ADR_POST_COUNTRY', '�����', 'VARCHAR2', 55, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 24, 'ADR_POST_DOMAIN', '�������', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 25, 'ADR_POST_REGION', '�����', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 26, 'ADR_POST_LOC', '��������� �����', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 27, 'ADR_POST_ADR', '������, �������, ��������', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 28, 'ADR_POST_ZIP', '�������� ������', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 29, 'ADR_FACT_COUNTRY', '�����', 'VARCHAR2', 55, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 30, 'ADR_FACT_DOMAIN', '�������', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 31, 'ADR_FACT_REGION', '�����', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 32, 'ADR_FACT_LOC', '��������� �����', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 33, 'ADR_FACT_ADR', '������, �������, ��������', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 34, 'ADR_FACT_ZIP', '�������� ������', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 35, 'ADR_WORK_COUNTRY', '�����', 'VARCHAR2', 55, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 36, 'ADR_WORK_DOMAIN', '�������', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 37, 'ADR_WORK_REGION', '�����', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 38, 'ADR_WORK_LOC', '��������� �����', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 39, 'ADR_WORK_ADR', '������, �������, ��������', 'VARCHAR2', 55, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 40, 'ADR_WORK_ZIP', '�������� ������', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 41, 'BRANCH', '³�������', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 42, 'NEGATIV_STATUS', '���������� ������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 43, 'REESTR_MOB_BANK', '��������� � ��������� �������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 44, 'REESTR_INET_BANK', '��������� � ��������-�������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 45, 'REESTR_SMS_BANK', '��������� � ���-�������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 46, 'MONTH_INCOME', '�������� ������� �����', 'NUMBER', 22, 2, '99999990D00', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 47, 'SUBJECT_ROLE', '���� ��� ���''����', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 48, 'REZIDENT', '��������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 49, 'MERRIED', 'ѳ������ ����', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 50, 'EMP_STATUS', '������ ��������� �����', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 51, 'SUBJECT_CLASS', '������������ ���''����', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 52, 'INSIDER', '������ ������������ �� ���������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 53, 'SEX', '�����', 'CHAR', 1, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 54, 'VIPK', '�������� ��������� ²�', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 55, 'VIP_FIO_MANAGER', 'ϲ� ���������� �� ²�', 'VARCHAR2', 250, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 56, 'VIP_PHONE_MANAGER', '������� ���������� �� ²�', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 57, 'DATE_ON', '���� �������� �볺���', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 58, 'DATE_OFF', '���� �������� ��� �볺���', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 59, 'EDDR_ID', '����� ������ � ����', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 60, 'IDCARD_VALID_DATE', 'ĳ����� �� (������� ID-������)', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 61, 'IDDPL', '���� ������� �������������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);


  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 62, 'BPLACE', '̳��� ����������', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 63, 'SUBSD', '���� �����䳿', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 64, 'SUBSN', '����� �����䳿', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 65, 'ELT_N', 'ELT. ����� �������� �볺��-����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 66, 'ELT_D', 'ELT. ���� �������� �볺��-����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 67, 'GCIF', 'GCIF', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 68, 'NOMPDV', '����� � ����� ���', 'VARCHAR2', 9, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 69, 'NOM_DOG', '����� �������� �� �������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 70, 'SW_RN', '����� �볺��� ���������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 71, 'Y_ELT', '������������� ������ ���������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 72, 'ADM', '����. ����� ���������', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 73, 'FADR', '������ ����������� �����������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 74, 'ADR_ALT', '������������� ������', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 75, 'BUSSS', '������-������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 76, 'PC_MF', '���. ĳ���� ������� �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 77, 'PC_Z4', '���. �������������. ĳ� ��', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 78, 'PC_Z3', '���. �������������. ��� �������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 79, 'PC_Z5', '���. �������������. ���� �������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 80, 'PC_Z2', '���. �������������. �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 81, 'PC_Z1', '���. �������������. ����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 82, 'AGENT', '���. ��� ������ ���������� �� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 83, 'PC_SS', '���. ѳ������ ����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 84, 'STMT', '³� �������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 85, 'VIDKL', '³� �볺���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 86, 'VED', '��� ��������� ��������', 'CHAR', 5, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 87, 'TIPA', '��� ��������� ���� ��������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 88, 'PHKLI', '���� ������, ����� ����������� �볺��', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 89, 'AF1_9', '��� ��� ��������� �� ���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 90, 'IDDPD', '���� �������� � ������ ������� ���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 91, 'DAIDI', '���� ��������� �� ������ ������. �������� �볺���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 92, 'DATVR', '���� �������� ������� �������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 93, 'DATZ', ' ���� ���������� ���������� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 94, 'DATE_PHOTO', '���� �������� ����������', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 95, 'IDDPR', '���� ��������� �������.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 96, 'ISE', '������������� ������ ��������', 'CHAR', 5, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 97, 'OBSLU', '������ �������������� �볺���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 98, 'CRSRC', '������� ���������(DPT-���.������, CCK-����.���.)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 99, 'DJOTH', '�������. ����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 100, 'DJAVI', '�������. ��������� �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 101, 'DJ_TC', '�������. ����� �� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 102, 'DJOWF', '�������. ����� �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 103, 'DJCFI', '�������. ����� ��������� �� ��.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 104, 'DJ_LN', '�������. ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 105, 'DJ_FH', '�������. Գ������� ��������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 106, 'DJ_CP', '�������. ��', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 107, 'CHORN', '�����������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 108, 'CRISK_KL', '���� ������������', 'VARCHAR2', 1, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 109, 'BC', '�볺�� �����', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 110, 'SPMRK', '��� "������� ������" �����.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 111, 'K013', '��� ���� �볺���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 112, 'KODID', '��� ���������. �볺���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 113, 'COUNTRY', '��� �����', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 114, 'MS_FS', '���.-������� �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 115, 'MS_VD', '������ ���� ��������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 116, 'MS_GR', '��������� �� �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 117, 'LIM_KASS', '˳�� ����', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 118, 'LIM', '˳�� �� ������ ������.', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 119, 'LICO', '˳���糿 �� ���. ������ ����.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 120, 'UADR', '̳����������. ��. ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 121, 'MOB01', '�������� 1', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 122, 'MOB02', '�������� 2', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 123, 'MOB03', '�������� 3', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 124, 'SUBS', '�������� �����䳿', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 125, 'K050', '���������� ��� �050', 'CHAR', 3, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 126, 'DEATH', '������ �볺���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 127, 'NO_PHONE', '³�������� ���������', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 128, 'NSMCV', '��� �볺���(��/����/���/����)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 129, 'NSMCC', '��� �볺��� � ����. ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 130, 'NSMCT', '��� �볺���.�-������� �����, 2-����.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 131, 'NOTES', '������� �������', 'VARCHAR2', 140, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 132, 'SAMZ', '�������������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 133, 'OREP', '��������� �볺���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 134, 'OVIFS', '³��������� �������� ����� ���.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 135, 'AF6', '³������. �������� ��� � ������� �����.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 136, 'FSKRK', '����.����.���.�����.���.������� �� ��', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 137, 'FSOMD', '̳�. �����. ����� ��''�', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 138, 'FSVED', '���������������� ��������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 139, 'FSZPD', '������� ����. ��������(��)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 140, 'FSPOR', '�������� �� ���. ������. ��', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 141, 'FSRKZ', '����. ������.����.��������.�� �����.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 142, 'FSZOP', '������ �� ������� �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 143, 'FSKPK', '�-��� �������� �����������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 144, 'FSKPR', '�-��� ������� ����������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 145, 'FSDIB', '�������� �������� � ���. ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 146, 'FSCP', '�������� - ���� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 147, 'FSVLZ', '�������� - �������� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 148, 'FSVLA', '�������� - ����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 149, 'FSVLN', '�������� - ����������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 150, 'FSVLO', '�������� - ����������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 151, 'FSSST', '���������� ������(��)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 152, 'FSSOD', '���� ��������� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 153, 'FSVSN', '������ ��� ����� - �������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 154, 'DOV_P', '�������� ��� ����. �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 155, 'DOV_A', '������ ����. �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 156, 'DOV_F', '������� �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 157, 'NMKV', '����� ��''�(���)', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 158, 'SN_GC', '����� ��''�(���. ���.)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 159, 'NMKK', '����� ��''�(������.)', 'VARCHAR2', 38, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 160, 'PRINSIDER', '�������� ������ ���������', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 161, 'NOTESEC', '������� ��� ��', 'VARCHAR2', 256, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 162, 'MB', '��������� �� ������ ������', 'CHAR', 1, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 163, 'PUBLP', '��������� �� ����. �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 164, 'WORKB', '��������� �� ����. �����', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 165, 'C_REG', '������� ϲ', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 166, 'C_DST', '�������� ϲ', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 167, 'RGADM', '���. ����� � �����������', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 168, 'RGTAX', '���. ����� ϲ', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 169, 'DATEA', '���� �����. � ����.', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 170, 'DATET', '���� �����. � ϲ', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 171, 'RNKP', '������. ����� ��������', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 172, 'CIGPO', '������ ���������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 173, 'COUNTRY_NAME', '����� �����', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 174, 'TARIF', '��������� �����(��)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 175, 'AINAB', '������� � ����� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 176, 'TGR', '��� ���������� ������', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 177, 'CUSTTYPE', '��� �볺���', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 178, 'RIZIK', 'г���� ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 179, 'SNSDR', '������� ����, ���. ���. ����. �����.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 180, 'IDPIB', 'ϲ� ����., �����. �� �����. �� ������.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 181, 'FS', '����� ��������', 'CHAR', 2, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 182, 'SED', '����� ��������������(�051)', 'CHAR', 4, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 183, 'DJER', '�������������� ������ ����. ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 184, 'CODCAGENT', '�������������� �볺���(�010)', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 185, 'SUTD', '�������������� ��� ��������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 186, 'RVDBC', '���. DBCode', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 187, 'RVIBA', '���. ������ ���. ������ ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 188, 'RVIDT', '���. ���� ������ ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 189, 'RV_XA', '���. ��''� ����� ��', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 190, 'RVIBR', '���. ³������� ������ ������', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 191, 'RVIBB', '���. ³������� ������ ������(���)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 192, 'RVRNK', '���. ��� � ���', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 193, 'RVPH1', '���. �������-1', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 194, 'RVPH2', '���. �������-2', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 195, 'RVPH3', '���. �������-3', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 196, 'SAB', '����������� ��� �볺���', 'VARCHAR2', 6, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 197, 'VIP_ACCOUNT_MANAGER', '������� vip-��������� � AD', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);
end;
/
commit;
/
