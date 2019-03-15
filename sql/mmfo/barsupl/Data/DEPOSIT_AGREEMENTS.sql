prompt barsupl - insert sql for DEPOSIT_AGREEMENTS (DAY)

declare
l_proc_text clob := to_clob( q'{ begin execute immediate 'begin barsupl.bars_upload_usr.tuda; end;'; exception when others then if sqlcode = -6550 then null; else raise; end if; end; }');

l_sql_text clob := to_clob(q'{
SELECT agrmnt_id, agrmnt_date, agrmnt_num, agrmnt_type,
       dpt_id, branch, cust_id, bankdate,
       template_id, trustee_id, transfer_bank, transfer_account,
       amount_cash, amount_cashless, amount_interest, date_begin,
       date_end, denom_amount, denom_count, denom_ref,
       agrmnt_state, comiss_ref, undo_id,           -- transfdpt,transfint,  ,
       doc_ref,
       rate_reqid, comiss_reqid, rate_value, rate_date
FROM   bars.dpt_agreements dp
WHERE      branch LIKE '/' || SYS_CONTEXT ('bars_context', 'user_mfo') || '%'
       AND bankdate = TO_DATE (:param1, 'dd/mm/yyyy')
}');
l_descript varchar2(250) := '�������� ����� �� ��� �� ��� CRM, �����';
begin
    insert into upl_sql(sql_id, sql_text, BEFORE_PROC, descript, vers)
    values (12, l_sql_text, l_proc_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            BEFORE_PROC = l_proc_text,
            descript = l_descript,
            vers = '1.1'
        where sql_id = 12;
end;

/

prompt barsupl - insert sql ��� DEPOSIT_AGREEMENTS (MONTH)

declare
l_proc_text clob := to_clob( q'{ begin execute immediate 'begin barsupl.bars_upload_usr.tuda; end;'; exception when others then if sqlcode = -6550 then null; else raise; end if; end; }');

l_sql_text clob := to_clob(q'{
SELECT agrmnt_id, agrmnt_date, agrmnt_num, agrmnt_type,
       dpt_id, branch, cust_id, bankdate,
       template_id, trustee_id, transfer_bank, transfer_account,
       amount_cash, amount_cashless, amount_interest, date_begin,
       date_end, denom_amount, denom_count, denom_ref,
       agrmnt_state, comiss_ref, undo_id,           -- transfdpt,transfint,  ,
       doc_ref,
       rate_reqid, comiss_reqid, rate_value, rate_date
FROM   bars.dpt_agreements dp
WHERE      branch LIKE '/' || SYS_CONTEXT ('bars_context', 'user_mfo') || '%'
       AND bankdate between TO_DATE (:param1, 'dd/mm/yyyy')-6  and TO_DATE (:param1, 'dd/mm/yyyy')
}');

l_descript varchar2(250) := '�������� ����� �� ��� �� ��� CRM, �� 7 ���';
begin
    insert into upl_sql(sql_id, sql_text, BEFORE_PROC, descript, vers)
    values (13, l_sql_text, l_proc_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            BEFORE_PROC = l_proc_text,
            descript = l_descript,
            vers = '1.1'
        where sql_id = 13;
end;

/ 

prompt barsupl - insert file DEPOSIT_AGREEMENTS

begin

INSERT INTO barsupl.upl_files 
VALUES(12,12,'DEPOSIT_AGREEMENTS','dptagreements',0,'09',NULL,'10',0,'�������� ����� �� ��� �� ��� CRM',12,'null','DELTA',NULL,1,NULL,1,NULL,0,0);
exception 
    when dup_val_on_index then
        null;
end;

/

prompt barsupl - insert upl_columns for DEPOSIT_AGREEMENTS
 
delete from barsupl.upl_columns   where file_id = 12;

INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,1,'AGRMNT_ID','���������� ����� ��','NUMBER',15,0,NULL,'Y','N',NULL,NULL,NULL,2,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,2,'AGRMNT_DATE','���������� ���� �� ��� ���������� ��','DATE',14,NULL,'ddmmyyyyhh24miss',NULL,'N',NULL,NULL,'01.01.0001',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,3,'AGRMNT_NUM','����� ��','NUMBER',10,0,NULL,NULL,'N',NULL,NULL,'0',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,4,'AGRMNT_TYPE','��� ��','NUMBER',15,0,NULL,NULL,'N',NULL,NULL,'0',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,5,'DPT_ID','������������� ����������� ��������� ��','NUMBER',15,0,NULL,NULL,'N',NULL,NULL,'0',NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,6,'BRANCH','BRANCH','VARCHAR2',30,NULL,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,7,'CUST_ID','����.� ��������� ������','NUMBER',15,0,NULL,NULL,'N',NULL,NULL,'0',NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,8,'BANKDATE','���� ���������� �� (����������)','DATE',8,NULL,'ddmmyyyy',NULL,'N',NULL,NULL,'01.01.0001',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,9,'TEMPLATE_ID','������ ��','VARCHAR2',35,NULL,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,10,'TRUSTEE_ID','� �� � 3-�� �����','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,11,'TRANSFER_BANK','��� ����� ��� ������������ �������� � ���������','VARCHAR2',6,NULL,NULL,NULL,'Y',NULL,NULL,'N/A',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,12,'TRANSFER_ACCOUNT','����� ����� ��� ������������ �������� � ���������','VARCHAR2',14,NULL,NULL,NULL,'Y',NULL,NULL,'N/A',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,13,'AMOUNT_CASH','����� ��������� (�� �� ��������� ����� ������)','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,14,'AMOUNT_CASHLESS','����� ������������ (�� �� ��������� ����� ������)','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,15,'AMOUNT_INTEREST','����� ��������� � ������� (�� �� ��������� ����� ������)','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,16,'DATE_BEGIN','����� ���� ������ ������ (�� �� ��������� ������) ��� ���� ������ �������� ������������','DATE',8,NULL,'ddmmyyyy',NULL,'Y',NULL,NULL,'01.01.0001',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,17,'DATE_END','����� ���� ��������� ������ (�� �� ��������� ������) ��� ���� ��������� �������� ������������','DATE',8,NULL,'ddmmyyyy',NULL,'Y',NULL,NULL,'31.12.9999',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,18,'DENOM_AMOUNT','����� ����� ������ ����� (�� � ������ ������ �����)','NUMBER',38,0,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,19,'DENOM_COUNT','����� �������� ��� ��������� ����������� (�� � ������ ������ �����)','NUMBER',38,0,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,20,'DENOM_REF','���.���-�� �� ��������� ������� (�� � ������ ������ �����)','NUMBER',38,0,NULL,NULL,'Y',NULL,NULL,NULL,NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,21,'AGRMNT_STATE','������ ��: ������./�������.','NUMBER',1,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,22,'COMISS_REF','COMISS_REF �������� ��������� - �������� �� ���������� ��','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,23,'UNDO_ID','��. ���. ����������, ������� �������� ������','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,24,'DOC_REF','�������� ���������� ���������� / ���������� ������','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,25,'RATE_REQID','��� ������� �� ��������� ������','NUMBER',38,0,NULL,NULL,'Y',NULL,NULL,NULL,NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,26,'COMISS_REQID','��. ������ �� ����� ������ ���� �� ��','NUMBER',15,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,'TRUNC_E2');
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,27,'RATE_VALUE','����� �������� ���������� ������ (�� �� ��������� ������)','NUMBER',20,8,'999999999990D00000000',NULL,'Y',NULL,NULL,'0',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(12,28,'RATE_DATE','���� ������ �������� ���������� ������ (�� �� ��������� ������)','DATE',8,NULL,'ddmmyyyy',NULL,'Y',NULL,NULL,'01.01.0001',NULL,NULL);

prompt barsupl -link to groups DEPOSIT_AGREEMENTS

delete from upl_filegroups_rln where file_id = 12;

INSERT INTO upl_filegroups_rln (GROUP_ID,FILE_ID,SQL_ID) 
VALUES(10,12,12);

INSERT INTO upl_filegroups_rln (GROUP_ID,FILE_ID,SQL_ID) 
VALUES(11,12,13);

commit;

/