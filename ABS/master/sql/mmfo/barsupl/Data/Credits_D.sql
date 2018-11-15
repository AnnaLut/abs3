prompt barsupl ���� ��������: CREDITS_D
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select
                           nd
                          ,rnk
                          ,kf
                          ,cc_id
                          ,sdate
                          ,branch
                          ,vidd
                          ,next_pay
                          ,probl_rozgl
                          ,probl_date
                          ,probl
                          ,cred_change
                          ,cred_datechange
                          ,borg
                          ,borg_tilo
                          ,borg_proc
                          ,prosr1
                          ,prosr2
                          ,prosrcnt
                          ,borg_prosr
                          ,borg_tilo_prosr
                          ,borg_proc_prosr
                          ,penja
                          ,shtraf
                          ,pay_tilo
                          ,pay_proc
                          ,cat_ryzyk
                          ,cred_to_prosr
                          ,borg_to_pbal
                          ,vart_majna
                          ,pog_finish
                          ,prosr_fact_cnt
                          ,next_pay_all
                          ,next_pay_tilo
                          ,next_pay_proc
                          ,sos
                          ,last_pay_date
                          ,last_pay_suma
                          ,prosrcnt_proc
                          ,tilo_prosr_uah
                          ,proc_prosr_uah
                          ,borg_tilo_uah
                          ,borg_proc_uah
                          ,pay_vdvs
                          ,amount_commission
                          ,amount_prosr_commission
                          ,ES000
                          ,ES003
                          ,VIDD_CUSTTYPE
						  ,stp_dat
                      from bars_dm.credits_dyn c
                      where c.per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
					  and kf = sys_context('bars_context', 'user_mfo')
]');
l_descript varchar2(250) := q'[������� ��� CRM (������� ���)]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (53, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.3'
        where sql_id = 53;
end;
/


prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 53;

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 1, 'nd', 'id ��������', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 2, 'rnk', '���', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 3, 'kf', '���������� ���������', 'CHAR', 6, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 4, 'cc_id', '� ��������', 'CHAR', 30, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 5, 'sdate', '���� ��������� ��������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 6, 'branch', '³�������, �� ���� ��������� ���������� �������', 'CHAR', 30, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 7, 'vidd', '��� ��������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 8, 'next_pay', '���� ��������� ���������� �������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 9, 'probl_rozgl', '�� ���䳿 �������� ������� ��� �������� ����������', 'CHAR', 50, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 10, 'probl_date', '���� �������� ������� ����������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 11, 'probl', '�������� ������� ����������', 'CHAR', 10, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 12, 'cred_change', '���� ���� ������������', 'CHAR', 50, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 13, 'cred_datechange', '���� ��������� ���� ���� ������������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 14, 'borg', '���� ������������� �� �������� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 15, 'borg_tilo', '���� ������������� �� ���� ������� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 16, 'borg_proc', '���� ������������� �� ��������� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 17, 'prosr1', '���� ���������� ����� ���������� �� ��������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 18, 'prosr2', '���� ���������� ����� ���������� �� ��������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 19, 'prosrcnt', 'ʳ������ ������������ �������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 20, 'borg_prosr', '���� ����������� ������������� �� �������� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 21, 'borg_tilo_prosr', '���� ����������� ������������� �� ���� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 22, 'borg_proc_prosr', '���� ����������� ������������� �� ���������� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 23, 'penja', '���� ��� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 24, 'shtraf', '���� ����������� ������� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 25, 'pay_tilo', '���� ���������� ����� �� ������� � ��������� ����, ���', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 26, 'pay_proc', '���� ���������� �������� �� �������� � ��������� ����, ���', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 27, 'cat_ryzyk', '�������� ������ �������� ��������', 'CHAR', 50, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 28, 'cred_to_prosr', '���� ��������� ������� �� ������� ����������� �������������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 29, 'borg_to_pbal', '���� ����������� ������������� �� ������������ �������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 30, 'vart_majna', '������� ���������� ����� �� ������, ���', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 31, 'pog_finish', '����� ���� ��������� ������� ����� � �������� ������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 32, 'prosr_fact_cnt', 'ʳ������ ����� ������ �� ���������', 'NUMBER', 4, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 33, 'next_pay_all', '���� ���������� �������, ������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 34, 'next_pay_tilo', '���� ���������� �������, ���', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 35, 'next_pay_proc', '���� ���������� �������, ��������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 36, 'sos', '���� ��������', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 37, 'last_pay_date', '���� ���������� �������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 38, 'last_pay_suma', '���� ���������� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 39, 'prosrcnt_proc', 'ʳ������ ����������� ������������ ������� �� ��������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 40, 'tilo_prosr_uah', '���� ���������� �� ��� � �����', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 41, 'proc_prosr_uah', '���� ���������� �� �������� � �����', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 42, 'borg_tilo_uah', '���� ������������� �� ���� � �����', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 43, 'borg_proc_uah', '���� ������������� �� ��������� � �����', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 44, 'pay_vdvs', '������ ������������ ����� �� ����, ���.', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 45, 'amount_commission', '���� ���� �� �� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 46, 'amount_prosr_commission', '���� ����������� ���� �� �� � ����� �������', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 47, 'es000', '������ �� � �����', 'VARCHAR2', 24, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 48, 'es003', '���� ��������� ������������', 'VARCHAR2', 24, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 49, 'vidd_custtype', '��� ������� �� ���� ��������: 3 - ���������� ����, 2 - ����������� ����, 1 - ����', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 50, 'stp_dat', '���� ���������� ����������� �������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);
end;
/
commit;