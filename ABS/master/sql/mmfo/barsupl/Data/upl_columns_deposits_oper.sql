prompt barsupl ���� ��������: deposits_oper
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
          select  
                 kf 
				,deposit_id
                ,nd_dep
                ,cnt_dubl 
                ,ref
                ,nd
                ,mfoa
                ,nlsa
                ,s
                ,kv
                ,vdat
                ,s2
                ,kv2
                ,mfob
                ,nlsb
                ,sk
                ,datd
                ,nazn
                ,tt
                ,tobo
                ,ida
                ,nama
                ,idb
                ,namb
                ,vob
                ,pdat
                ,odat
        from bars_dm.deposits_oper
        where per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
    and kf = sys_context('bars_context', 'user_mfo')
]');
l_descript varchar2(250) := q'[CRM, �������� �� ��������� DAY]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (100103, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.3'
        where sql_id = 100103;
end;
/
prompt full
declare
l_sql_text clob := to_clob(q'[
          select 
                 kf 		  
				,deposit_id
                ,nd_dep
                ,cnt_dubl  
                ,ref
                ,nd
                ,mfoa
                ,nlsa
                ,s
                ,kv
                ,vdat
                ,s2
                ,kv2
                ,mfob
                ,nlsb
                ,sk
                ,datd
                ,nazn
                ,tt
                ,tobo
                ,ida
                ,nama
                ,idb
                ,namb
                ,vob
                ,pdat
                ,odat
        from bars_dm.deposits_oper
        where per_id=bars_dm.dm_import.GET_PERIOD_ID('MONTH',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
    and kf = sys_context('bars_context', 'user_mfo')
]');
l_descript varchar2(250) := q'[CRM, �������� �� ��������� MONTH]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (100104, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.2'
        where sql_id = 100104;
end;
/
prompt file
begin
    insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (100103, 100103, 'DEPOSITS_OPER', 'DEPOSITS_OPER', 0, '35', null, '13||10', 0, '������������ ����� �� ���������� ���������', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 100103;

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 1, 'kf', '��', 'VARCHAR2', 6, null, null, null, 'Y', null, null, null, null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 2, 'deposit_id', 'ID ��������', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 3, 'nd_dep', '����� ��������', 'VARCHAR2', 35, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 4, 'cnt_dubl', '����� ������������', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);
	
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 5, 'ref', '�������� ���-��', 'NUMBER', 38, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');
	
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 6, 'nd', '����� ���������', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, 'TRUNC_E2');
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 7, 'mfoa', '��� ��������', 'VARCHAR2', 12, null, null, null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 8, 'nlsa', '������� ��������', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 9, 's', '����', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 10, 'kv', '��� ������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 11, 'vdat', '���� �����������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 12, 's2', '���� ����������', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null, null);
	
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 13, 'kv2', '��� ������ ����������', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);
	
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 14, 'mfob', '��� ����������', 'VARCHAR2', 12, null, null, null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 15, 'nlsb', '������� ����������', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 16, 'sk', '���', 'NUMBER', 2, 0, null, null, 'Y', null, null, null, null, null);
	
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 17, 'datd', '���� ���������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 18, 'nazn', '����������� �������', 'VARCHAR2', 160, null, null, null, 'Y', null, '09,13,10|32,32,32', 'N/A', null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 19, 'tt', '��� ��������', 'CHAR', 3, null, null, null, 'Y', null, null, 'N/A', null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 20, 'tobo', '��� ����. ��������', 'VARCHAR2', 30, null, null, null, 'Y', null, null, 'N/A', null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 21, 'ida', '������ ��������', 'VARCHAR2', 14, null, null, null, 'Y', null, null, '-', null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 22, 'nama', '����� ������� ��������', 'VARCHAR2', 38, null, null, null, 'Y', null, '09,13,10|32,32,32', 'N/A', null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 23, 'idb', '������ ����������', 'VARCHAR2', 14, null, null, null, 'Y', null, null, '-', null, null);
	
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 24, 'namb', '������ ����������', 'VARCHAR2', 38, null, null, null, 'Y', null, '09,13,10|32,32,32', 'N/A', null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 25, 'vob', '��� ���������', 'NUMBER', 4, 0, null, null, 'Y', null, null, 0, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 26, 'pdat', '���� ���������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (100103, 27, 'odat', '���� ������', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);  

end;
/
commit;