
prompt barsupl - insert sql for STAFF_ACT

declare
l_proc_text clob :=  null; --to_clob( q'{  }');

l_sql_text clob := to_clob(q'{
   select ID, FIO, LOGNAME , BRANCH from bars.staff$base sb 
   where sb.disable =0
}');
l_descript varchar2(250) := 'Довідник активних користувачiв';
begin
    insert into upl_sql(sql_id, sql_text, BEFORE_PROC, descript, vers)
    values (69, l_sql_text, l_proc_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            BEFORE_PROC = l_proc_text,
            descript = l_descript,
            vers = '1.1'
        where sql_id = 69;
end;

/ 

prompt barsupl - insert file STAFF_ACT

begin

INSERT INTO upl_files (FILE_ID,SQL_ID,FILE_CODE,FILENAME_PRFX,EQVSPACE,DELIMM,DEC_DELIMM,ENDLINE,HEAD_LINE,DESCRIPT,ORDER_ID,NULLVAL,DATA_TYPE,DOMAIN_CODE,ISACTIVE,SEQ_CASHE,GK_INDICATOR,MASTER_CKGK,CRITICAL_FLG,PARTITIONED) 
VALUES(69,69,'STAFF_ACT','staff_act',0,'09',NULL,'10',0,'Довідник активних користувачiв',69,'null','WHOLE',NULL,1,NULL,1,NULL,0,0);

exception 
    when dup_val_on_index then
        null;
end;

/

prompt barsupl - insert upl_columns for STAFF_ACT
 
delete from barsupl.upl_columns   where file_id = 69;

INSERT INTO upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(69,1,'ID','Код пользователя','NUMBER',38,0,NULL,NULL,'N',NULL,NULL,NULL,NULL,NULL);
INSERT INTO upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(69,2,'FIO','ФИО пользователя','VARCHAR2',60,NULL,NULL,NULL,'N',NULL,NULL,NULL,NULL,NULL);
INSERT INTO upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(69,3,'LOGNAME','Имя пользователя БД','VARCHAR2',30,NULL,NULL,NULL,'N',NULL,NULL,NULL,NULL,NULL);
INSERT INTO upl_columns (FILE_ID,COL_ID,COL_NAME,COL_DESC,COL_TYPE,COL_LENGTH,COL_SCALE,COL_FORMAT,PK_CONSTR,NULLABLE,NULL_VALUES,REPL_CHARS_WITH,SKELETON_VALUES,PK_CONSTR_ID,PREFUN) 
VALUES(69,4,'BRANCH','Код отделения','VARCHAR2',30,NULL,NULL,NULL,'N',NULL,NULL,NULL,NULL,NULL);

prompt barsupl -link to groups STAFF_ACT

delete from upl_filegroups_rln where file_id = 69;

INSERT INTO upl_filegroups_rln (GROUP_ID,FILE_ID,SQL_ID) 
VALUES(10,69,69);


commit;

 
