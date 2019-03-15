CREATE OR REPLACE PROCEDURE P_JOB_FM_DOCCHECK_INT is
-- parallel stuff
c_task_name  constant varchar2(32) := 'FINMON_JOB_INT_SLAVE';
l_chunk_stmt varchar2(128) := q'[select kf as START_ID, kf as END_ID from bars.mv_kf]';
l_mfo_cnt    number;
/*l_task_statement varchar2(4000) := q'[
begin
    bars_login.login_user(sys_guid, 1, null, null);
    bars.bc.go(:START_ID);
    bars.bc.go(:END_ID);
    bars.fm_utl.ref_block;
    commit;
    bars.bars_login.logout_user;
end;
]';*/

l_task_statement varchar2(4000) := q'[
begin
    bars_login.login_user(sys_guid, 1, null, null);
    bars.bc.go(:START_ID);
    bars.bc.go(:END_ID);
    bars.p_fm_intdoccheck(null);
    commit;
    bars.bars_login.logout_user;
end;
]';
task_doesnt_exist exception;
pragma exception_init(task_doesnt_exist, -29498);

begin
    select count(*) into l_mfo_cnt from mv_kf;
    -- удаляем предыдущую задачу
    begin
        DBMS_PARALLEL_EXECUTE.DROP_TASK (c_task_name);
    exception
        when task_doesnt_exist then null;
    end;
    dbms_parallel_execute.create_task(c_task_name);
    -- создаем чанки по МФО
    dbms_parallel_execute.create_chunks_by_sql(task_name => c_task_name,
                                               sql_stmt  => l_chunk_stmt,
                                               by_rowid  => false);
    -- запуск задачи по всем МФО
    dbms_parallel_execute.run_task(task_name      => c_task_name,
                                   sql_stmt       => l_task_statement,
                                   language_flag  => dbms_sql.native,
                                   parallel_level => l_mfo_cnt);
    commit;
exception
    when others then
        bars_audit.error('FM. job: error during execution procedure P_JOB_FM_DOCCHECK_INT: ' ||
                         dbms_utility.format_error_stack() || chr(10) ||
                         dbms_utility.format_error_backtrace());
end;
/