prompt  bars_dm/script/partition_customers_plt
prompt drop interim table if exists (in case of previous unsuccessfull installation)
begin
    execute immediate 'drop table bars_dm.test_customers_plt';
exception
    when others then
        if sqlcode = -942 then null; else raise; end if;
end;
/
prompt create temp table test_customers_plt
begin
    execute immediate '
create table BARS_DM.TEST_CUSTOMERS_PLT
tablespace BRSDMIMP
PARTITION BY LIST (PER_ID) SUBPARTITION by list (KF)
SUBPARTITION TEMPLATE
         (SUBPARTITION KF_300465 VALUES (''300465''),
            SUBPARTITION KF_302076 VALUES (''302076''),
            SUBPARTITION KF_303398 VALUES (''303398''),
            SUBPARTITION KF_304665 VALUES (''304665''),
            SUBPARTITION KF_305482 VALUES (''305482''),
            SUBPARTITION KF_311647 VALUES (''311647''),
            SUBPARTITION KF_312356 VALUES (''312356''),
            SUBPARTITION KF_313957 VALUES (''313957''),
            SUBPARTITION KF_315784 VALUES (''315784''),
            SUBPARTITION KF_322669 VALUES (''322669''),
            SUBPARTITION KF_323475 VALUES (''323475''),
            SUBPARTITION KF_324805 VALUES (''324805''),
            SUBPARTITION KF_325796 VALUES (''325796''),
            SUBPARTITION KF_326461 VALUES (''326461''),
            SUBPARTITION KF_328845 VALUES (''328845''),
            SUBPARTITION KF_331467 VALUES (''331467''),
            SUBPARTITION KF_333368 VALUES (''333368''),
            SUBPARTITION KF_335106 VALUES (''335106''),
            SUBPARTITION KF_336503 VALUES (''336503''),
            SUBPARTITION KF_337568 VALUES (''337568''),
            SUBPARTITION KF_338545 VALUES (''338545''),
            SUBPARTITION KF_351823 VALUES (''351823''),
            SUBPARTITION KF_352457 VALUES (''352457''),
            SUBPARTITION KF_353553 VALUES (''353553''),
            SUBPARTITION KF_354507 VALUES (''354507''),
            SUBPARTITION KF_356334 VALUES (''356334'')
          )
(PARTITION INITIAL_PARTITION VALUES (0))
as
select * from BARS_DM.CUSTOMERS_PLT
where 1 = 0';
exception
    when others then    
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt alter column MERRIED varchar2(500)
alter table bars_dm.test_customers_plt modify merried varchar2(500);

prompt alter column adr_work_adr modify varchar2(100)
alter table bars_dm.test_customers_plt modify ADR_WORK_ADR VARCHAR2(100);

prompt make partition with period
begin
    for rec in (select distinct per_id from bars_dm.CUSTOMERS_PLT where per_id>=1192 order by per_id)
        loop
            execute immediate 'alter table bars_dm.test_CUSTOMERS_PLT add partition P'||rec.per_id||' values ('||rec.per_id||')';
        end loop;
end;
/
prompt begin insert into table bars_dm.test_CUSTOMERS_PLT in parallels

declare
 task_doesnt_exist exception;
 pragma exception_init(task_doesnt_exist, -29498);
 l_errmsg    varchar2(512);
 l_mfo_cnt    number; 
 c_task_name  constant varchar2(32) := 'LOAD';
 l_chunk_stmt varchar2(128) := 'select kf as START_ID, kf as END_ID from bars.mv_kf';
 l_task_statement varchar2(4000) := '
 begin
      insert into bars_dm.test_CUSTOMERS_PLT select * from bars_dm.CUSTOMERS_PLT where per_id>=1192 and kf between :START_ID and :END_ID;
      commit;
 end; '; 
begin
     -- получаем число МФО для паралеллизма
     select count(*) into l_mfo_cnt from bars.mv_kf;      
     -- drop task if exists
     begin
          DBMS_PARALLEL_EXECUTE.DROP_TASK (c_task_name); 
     exception
              when task_doesnt_exist then 
              null;
     end;
     -- step 0
     dbms_parallel_execute.create_task(c_task_name);
     -- step 1
     dbms_parallel_execute.create_chunks_by_sql(task_name => c_task_name,
                                                sql_stmt  => l_chunk_stmt,
                                                by_rowid  => false);
     -- step 2                                         
     dbms_parallel_execute.run_task(task_name => c_task_name,
                                    sql_stmt  => l_task_statement,
                                    language_flag  => dbms_sql.native,
                                    parallel_level => l_mfo_cnt+1);
exception
     when others then
     -- если что-то случилось с паралеллизмом - удаляем задачу и логируем ошибку *  
     DBMS_PARALLEL_EXECUTE.DROP_TASK (c_task_name); 
     l_errmsg :=substr(' Error: '
                              ||dbms_utility.format_error_stack()||chr(10)
                              ||dbms_utility.format_error_backtrace()
                              , 1, 512);
     bars.bars_audit.error(l_errmsg);
end;
/

prompt end insert into table bars_dm.test_CUSTOMERS_PLT in parallels

prompt drop original table and rename temp to original
declare
l_orig_cnt number;
l_tmp_cnt number;
begin
    select count(*) into l_orig_cnt from bars_dm.CUSTOMERS_PLT where  per_id>=1192;
    select count(*) into l_tmp_cnt from bars_dm.test_CUSTOMERS_PLT;
    dbms_output.put_line('CUSTOMERS_PLT COUNT = ' || l_orig_cnt);
    dbms_output.put_line('TEST_CUSTOMERS_PLT COUNT = ' || l_tmp_cnt);
    if l_orig_cnt = l_tmp_cnt then
        execute immediate 'drop table bars_dm.CUSTOMERS_PLT';
        execute immediate 'rename test_CUSTOMERS_PLT to CUSTOMERS_PLT';
        execute immediate 'alter package bars_dm.dm_import compile';
    end if;
end;
/

prompt recreate grants
GRANT SELECT ON "BARS_DM"."CUSTOMERS_PLT" TO "BARSUPL";
GRANT SELECT ON "BARS_DM"."CUSTOMERS_PLT" TO "BARS_ACCESS_DEFROLE";
GRANT SELECT ON "BARS_DM"."CUSTOMERS_PLT" TO "BARS";

prompt nologging mode
alter table bars_dm.CUSTOMERS_PLT nologging;

prompt create errlog
begin
    dbms_errlog.create_error_log(dml_table_name => 'CUSTOMERS_PLT');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
