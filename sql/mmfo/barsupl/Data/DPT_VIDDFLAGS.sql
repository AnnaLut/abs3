
prompt barsupl - insert sql for DPT_VIDDFLAGS

declare
l_proc_text clob := to_clob( q'{ begin execute immediate 'begin barsupl.bars_upload_usr.tuda; end;'; exception when others then if sqlcode = -6550 then null; else raise; end if; end; }');

l_sql_text clob := to_clob(q'{
SELECT d.id, d.name, d.description, d.main_tt, d.only_one, d.mod_proc,
       d.activity, d.request_typecode, d.used_ebp
FROM   bars.dpt_vidd_flags d
       --where  SYS_CONTEXT ('bars_context', 'user_mfo')   =  nvl(sys_context ('BARS_CONTEXT','GLB_MFO') , '300465')
}');
l_descript varchar2(250) := '���� ���������� ���� (��) �� ��������� ��';
begin
    insert into upl_sql(sql_id, sql_text, BEFORE_PROC, descript, vers)
    values (226, l_sql_text, l_proc_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            BEFORE_PROC = l_proc_text,
            descript = l_descript,
            vers = '1.1'
        where sql_id = 226;
end;

/ 

prompt barsupl - insert file DPT_VIDDFLAGS

begin

INSERT INTO barsupl.upl_files (FILE_ID,SQL_ID,FILE_CODE,FILENAME_PRFX,EQVSPACE,DELIMM,DEC_DELIMM,ENDLINE,HEAD_LINE,DESCRIPT,ORDER_ID,NULLVAL,DATA_TYPE,DOMAIN_CODE,ISACTIVE,SEQ_CASHE,GK_INDICATOR,MASTER_CKGK,CRITICAL_FLG,PARTITIONED) 
VALUES(226,226,'DPT_VIDDFLAGS','dpt_vidd_flags',0,'09',NULL,'10',0,'���� ���������� ���� (��) �� ��������� ��',226,'null','DELTA','ARR',1,NULL,1,null,0,0);
exception 
    when dup_val_on_index then
        null;
end;

/

prompt barsupl - insert upl_columns for DPT_VIDDFLAGS
 
delete from barsupl.upl_columns   where file_id = 226;

INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,1,'ID','������������� ��','NUMBER',15,0,NULL,'Y','N',NULL,NULL,'0',1,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,2,'NAME','����� ��','VARCHAR2',100,NULL,NULL,NULL,'Y',NULL,NULL,'N/A',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,3,'DESCRIPTION','���� ��','VARCHAR2',254,NULL,NULL,NULL,'Y',NULL,NULL,'N/A',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,4,'MAIN_TT','��. ��������','CHAR',3,NULL,NULL,NULL,'Y',NULL,NULL,'-',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,5,'ONLY_ONE','���� ������������ ��','NUMBER',1,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,6,'MOD_PROC','��������� ����������� ���������� �������� � ����� � ����� ��','VARCHAR2',60,NULL,NULL,NULL,'Y',NULL,NULL,'N/A',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,7,'ACTIVITY','������ ��������� ��','NUMBER',1,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,8,'REQUEST_TYPECODE','������������� ��� ���� �������','VARCHAR2',30,NULL,NULL,NULL,'Y',NULL,NULL,'N/A',NULL,NULL);
INSERT INTO barsupl.upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(226,9,'USED_EBP','������ ������������ �� ��� ����� �� ��� (��������): 1 - ���.�����/2 - ���.䳿','NUMBER',1,0,NULL,NULL,'Y',NULL,NULL,'0',NULL,NULL);

prompt barsupl -link to groups DPT_VIDDFLAGS

delete from upl_filegroups_rln where file_id = 226;

INSERT INTO upl_filegroups_rln (GROUP_ID,FILE_ID,SQL_ID) 
VALUES(10,226,226);


commit;

 