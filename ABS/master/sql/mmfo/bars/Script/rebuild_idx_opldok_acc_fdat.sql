PROMPT *** Create  index IDX_OPLDOK_ACC_FDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_OPLDOK_ACC_FDAT ON BARS.OPLDOK (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  NOLOGGING 
  TABLESPACE BRSOPLDOKI  LOCAL UNUSABLE';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
end;
/

PROMPT *** Rebuild  index IDX_OPLDOK_ACC_FDAT ***  
DECLARE
  l_chunk_sql  VARCHAR2(1000);
  l_sql_stmt   VARCHAR2(1000);
  l_status     NUMBER;
  l_paralel    int := 16;
  l_task_name  varchar2(30) := 'rebuild_index';
BEGIN
  begin
   DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_name );
  exception
     when DBMS_PARALLEL_EXECUTE.task_not_found 
       then null;
   end;
        
  DBMS_PARALLEL_EXECUTE.CREATE_TASK (l_task_name);
 
  l_chunk_sql := 'select level-1 start_id, level-1 en_id from dual connect by level <= '||to_char(l_paralel);
  DBMS_PARALLEL_EXECUTE.create_chunks_by_SQL(l_task_name, l_chunk_sql, false);
 
  l_sql_stmt := q'{begin
                 for cur in
                   (
                      select subpartition_name, rn
                      from(
                            select u.subpartition_name,  u.num_rows, mod(row_number() over (order by u.num_rows desc, u.subpartition_name ),}'||to_char(l_paralel)||q'{) rn      
                            from user_tab_subpartitions u,
                                 user_ind_subpartitions i
                            where u.table_name = 'OPLDOK'
                              and i.index_name = 'IDX_OPLDOK_ACC_FDAT'
                              and i.subpartition_name = u.subpartition_name
                              and i.status = 'UNUSABLE'
                          )
                     where rn between :start_id and :end_id
                   )
                 loop   
                   execute immediate 'ALTER INDEX IDX_OPLDOK_ACC_FDAT REBUILD SUBPARTITION '|| cur.subpartition_name ||' ONLINE';
                 end loop;
                end;}';
  DBMS_PARALLEL_EXECUTE.RUN_TASK(l_task_name, l_sql_stmt, DBMS_SQL.NATIVE, parallel_level => l_paralel);
 
  L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS(l_task_name);
  if  L_status != DBMS_PARALLEL_EXECUTE.FINISHED then 
      raise_application_error(-20001,'Error during rebuild local indexes for table OPLDOK');
  end if;
 
  -- Done with processing; drop the task
  DBMS_PARALLEL_EXECUTE.DROP_TASK(l_task_name); 
end;
/

PROMPT *** gather stats index IDX_OPLDOK_ACC_FDAT ***  
DECLARE
  l_chunk_sql  VARCHAR2(1000);
  l_sql_stmt   VARCHAR2(1000);
  l_status     NUMBER;
  l_paralel    int := 16;
  l_task_name  varchar2(30) := 'gather_stats';
BEGIN
  begin
   DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_name );
  exception
     when DBMS_PARALLEL_EXECUTE.task_not_found 
       then null;
   end;
        
  DBMS_PARALLEL_EXECUTE.CREATE_TASK (l_task_name);
 
  l_chunk_sql := 'select level-1 start_id, level-1 en_id from dual connect by level <= '||to_char(l_paralel);
  DBMS_PARALLEL_EXECUTE.create_chunks_by_SQL(l_task_name, l_chunk_sql, false);
 
  l_sql_stmt := q'{begin
                 for cur in
                   (
                      select partition_name, rn
                      from(
                            select u.partition_name,  u.num_rows, mod(row_number() over (order by u.num_rows desc, u.partition_name ),}'||to_char(l_paralel)||q'{) rn      
                            from user_tab_partitions u
                            where u.table_name = 'OPLDOK'             
                          )
                     where rn between :start_id and :end_id
                   )
                 loop   
                   dbms_stats.gather_index_stats(ownname => 'BARS',indname => 'IDX_OPLDOK_ACC_FDAT',partname => cur.partition_name, estimate_percent => 5, granularity => 'PARTITION');
                 end loop;
                end;}';
  DBMS_PARALLEL_EXECUTE.RUN_TASK(l_task_name, l_sql_stmt, DBMS_SQL.NATIVE, parallel_level => l_paralel);
 
  L_status := DBMS_PARALLEL_EXECUTE.TASK_STATUS(l_task_name);
  if  L_status != DBMS_PARALLEL_EXECUTE.FINISHED then 
      raise_application_error(-20001,'Error during gather stats on IDX_OPLDOK_ACC_FDAT');
  end if;
 
  -- Done with processing; drop the task
  DBMS_PARALLEL_EXECUTE.DROP_TASK(l_task_name); 
end;
/
