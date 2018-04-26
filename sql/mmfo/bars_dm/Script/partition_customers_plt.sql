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

prompt copy data to temp table
begin
    for rec in (select distinct per_id from bars_dm.CUSTOMERS_PLT order by per_id)
        loop
            execute immediate 'alter table bars_dm.test_CUSTOMERS_PLT add partition P'||rec.per_id||' values ('||rec.per_id||')';
            insert into bars_dm.test_CUSTOMERS_PLT select * from bars_dm.CUSTOMERS_PLT where per_id = rec.per_id;
            commit;
        end loop;
end;
/

prompt drop original table and rename temp to original
declare
l_orig_cnt number;
l_tmp_cnt number;
begin
    select count(*) into l_orig_cnt from bars_dm.CUSTOMERS_PLT;
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
