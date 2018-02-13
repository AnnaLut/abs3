prompt barsupl ���� ��������: CUSTOMER_EXTERN_CRM
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select -cus.ID, 
        cus.NAME, 
        cus.DOC_TYPE, 
        cus.DOC_SERIAL,
        cus.DOC_NUMBER, 
        cus.DOC_DATE, 
        cus.DOC_ISSUER, 
        cus.BIRTHDAY,
        cus.BIRTHPLACE, 
        cus.SEX, 
        cus.ADR, 
        cus.TEL, 
        cus.EMAIL,
        case
            when cus.CUSTTYPE = 1 then 2
            when cus.CUSTTYPE = 2 then 3
            else cus.CUSTTYPE
        end as CUSTTYPE,
        cus.OKPO, 
        cus.COUNTRY, 
        cus.REGION, 
        cus.FS, 
        cus.VED, 
        cus.SED,
        cus.ISE, 
        cus.kf
  from BARS.CUSTOMER_EXTERN_UPDATE cus
 where cus.idupd in ( select max(idupd)
                        from BARS.CUSTOMER_EXTERN_UPDATE c0
                       where c0.chgdate between to_date(:param1,'dd/mm/yyyy')
                                               and to_date(:param1,'dd/mm/yyyy') + 1
                       group by c0.id)
]');
l_descript varchar2(250) := q'[��-������� ����� (CRM) - ������]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (10, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.0'
        where sql_id = 10;
end;
/
prompt full
declare
l_sql_text clob := to_clob(q'[
select -cus.ID, 
        cus.NAME, 
        cus.DOC_TYPE, 
        cus.DOC_SERIAL,
        cus.DOC_NUMBER, 
        cus.DOC_DATE, 
        cus.DOC_ISSUER, 
        cus.BIRTHDAY,
        cus.BIRTHPLACE, 
        cus.SEX, 
        cus.ADR, 
        cus.TEL, 
        cus.EMAIL,
        case
            when cus.CUSTTYPE = 1 then 2
            when cus.CUSTTYPE = 2 then 3
            else cus.CUSTTYPE
        end as CUSTTYPE,
        cus.OKPO, 
        cus.COUNTRY, 
        cus.REGION, 
        cus.FS, 
        cus.VED, 
        cus.SED,
        cus.ISE, 
        cus.kf
  from BARS.CUSTOMER_EXTERN cus
]');
l_descript varchar2(250) := q'[��-������� ����� (CRM) - ������ ��������]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (11, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.0'
        where sql_id = 11;
end;
/
prompt file
begin
    insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (10, 10, 'CUSTOMER_EXTERN_CRM', 'custext', 0, '09', null, '10', 0, '�� ������� ����� (CRM)', 87, 'null', 'DELTA', 'IP', 1, null, 1, 'IP', 0, 1);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 10;
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 1, 'ID', '��� ���������', 'NUMBER', 15, 0, null, 'Y', 'N', null, null, '0', 1, 'TRUNC_E2');

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 2, 'NAME', '������������/���', 'VARCHAR2', 70, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 3, 'DOC_TYPE', '��� ���������', 'NUMBER', 5, 0, null, null, 'Y', null, null, '0', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 4, 'DOC_SERIAL', '����� ���������', 'VARCHAR2', 30, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 5, 'DOC_NUMBER', '����� ���������', 'VARCHAR2', 5, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 6, 'DOC_DATE', '���� ������ ���������', 'DATE', 8, null, 'ddmmyyyy', null, 'Y', null, null, '31.12.9999', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 7, 'DOC_ISSUER', '����� ������ ���������', 'VARCHAR2', 70, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 8, 'BIRTHDAY', '���� ��������', 'DATE', 8, null, 'ddmmyyyy', null, 'Y', null, null, '31.12.9999', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 9, 'BIRTHPLACE', '����� ��������', 'VARCHAR2', 70, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 10, 'SEX', '���', 'CHAR', 1, null, null, null, 'N', null, null, '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 11, 'ADR', '�����', 'VARCHAR2', 100, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 12, 'TEL', '�������', 'VARCHAR2', 100, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 13, 'EMAIL', 'E_mail', 'VARCHAR2', 100, null, null, null, 'Y', null, '09,13,10|32,32,32', '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 14, 'CUSTTYPE', '������� (1-��, 2-��)', 'NUMBER', 5, 0, null, null, 'Y', null, null, '0', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 15, 'OKPO', '����', 'VARCHAR2', 14, null, null, null, 'Y', null, null, '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 16, 'COUNTRY', '��� ������', 'NUMBER', 5, 0, null, null, 'Y', null, null, '0', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 17, 'REGION', '��� �������', 'VARCHAR2', 2, null, null, null, 'Y', null, null, '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 18, 'FS', '����� ������������� (K081)', 'CHAR', 2, null, null, null, 'Y', null, null, '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 19, 'VED', '��� ��. ����-�� (K110)', 'CHAR', 5, null, null, null, 'Y', null, null, '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 20, 'SED', '���.-�������� ����� (K051)', 'CHAR', 4, null, null, null, 'Y', null, null, '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 21, 'ISE', '����. ������ ��������� (K070)', 'CHAR', 5, null, null, null, 'Y', null, null, '-', null, null);

    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (10, 22, 'KF', '������', 'VARCHAR2', 6, null, null, 'Y', 'N', null, null, '-', 2, null);
end;
/
prompt upl_filegroups_rln (10, 11)
begin
    delete from barsupl.upl_filegroups_rln
    where group_id in (10, 11) and sql_id in (120, 1120, 10, 11);
    insert into barsupl.upl_filegroups_rln (file_id, sql_id, group_id)
    values (10, 10, 10);
    insert into barsupl.upl_filegroups_rln (file_id, sql_id, group_id)
    values (10, 11, 11);
end;
/
commit;