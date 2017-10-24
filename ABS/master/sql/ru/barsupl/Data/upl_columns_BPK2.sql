prompt BPK2 columns
declare
l_file_id number;
begin
  select file_id into l_file_id from upl_files where file_code = 'BPK2';
  --������� ��� ������
  delete from upl_columns where file_id = l_file_id;
  --�������� ������
  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 1, 'branch', '³�������', 'CHAR', 30, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 2, 'kf', '��', 'CHAR', 12, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 3, 'rnk', '���', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 4, 'nd', '����� ��������', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 5, 'dat_begin', '���� ��������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 6, 'bpk_type', '��� ������� �����', 'VARCHAR2', 50, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 7, 'nls', '����� �������', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 8, 'daos', '���� �������� �������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 9, 'kv', '������ �������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 10, 'intrate', '³�������� ������', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 11, 'ostc', '�������� ������� �� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 12, 'date_lastop', '���� �������� ��������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 13, 'cred_line', '�������� ���', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 14, 'cred_lim', '���� ����������� ����.��', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 15, 'use_cred_sum', '����������� ���� ����.��', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 16, 'dazs', '���� �������� �������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 17, 'blkd', '��� ���������� ������� �� ������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 18, 'blkk', '��� ���������� ������� �� �������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 19, 'bpk_status', '������ �������� �� ������� (1-��������, 0-��������)', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 20, 'pk_okpo', '���������� ������, ������ ����������', 'VARCHAR2', 10, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 21, 'pk_name', '���������� ������, ����� ����������', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 22, 'pk_okpo_n', '���������� ������, ��� ������������ ��������', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 23, 'VID', '��� ������� (���)', 'VARCHAR2', 35, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 24, 'LIE_SUM', '����� �������. ���� ���������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 25, 'LIE_VAL', '����� �������. ������ ���������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 26, 'LIE_DATE', '����� �������. ���� ���������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 27, 'LIE_DOCN', '����� �������. ����� ���������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 28, 'LIE_ATRT', '����� �������. �����, ���� ����� ��������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 29, 'LIE_DOC', '����� �������. ����� ���������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 30, 'PK_TERM', '���. ʳ������ ������ 䳿 ������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 31, 'PK_OLDND', '���. ����� �������� �� ��', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 32, 'PK_WORK', '���. ̳��� ������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 33, 'PK_CNTRW', '���. ̳��� ������: �����', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 34, 'PK_OFAX', '���. ̳��� ������: FAX', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 35, 'PK_PHONE', '���. ̳��� ������: �������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 36, 'PK_PCODW', '���. ̳��� ������: �������� ������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 37, 'PK_ODAT', '���. ̳��� ������: � ����� ���� ������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 38, 'PK_STRTW', '���. ̳��� ������: ������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 39, 'PK_CITYW', '���. ̳��� ������: ����', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 40, 'PK_OFFIC', '���. ������', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 41, 'DKBO_DATE_OFF', '���� ��������� ����', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 42, 'DKBO_START_DATE', '���� ��������� �� ����', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 43, 'DKBO_DEAL_NUMBER', '� �������� ����', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 44, 'KOS', '������� ������', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 45, 'DOS', '������� �����', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 46, 'W4_ARSUM', 'Way4. ���������� ����', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 47, 'W4_KPROC', 'Way4. ³������ �� �������', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 48, 'W4_SEC', 'Way4. ����� �����', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
  values (l_file_id, 49, 'ACC', '��������� ������������� �������', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null);
end;
/
commit;
/