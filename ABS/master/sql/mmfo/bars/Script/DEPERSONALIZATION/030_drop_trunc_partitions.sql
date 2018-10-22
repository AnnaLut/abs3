prompt ... =====================================
prompt ... === drop_partitions v0.1 16.10.2018
prompt ... =====================================

set serveroutput on size 1000000
col cur_time new_value g_cur_time
select to_char(sysdate, 'yyyymmddhh24mi') as cur_time from dual;
spool log\030_drop_partitions_&g_cur_time.log
set lines 3000
set time on
set timing on

timing start exec_duration

prompt ... === cut points define start
-- define g_cut_point_date = trunc(sysdate, 'Q')
accept g_cut_point_date prompt 'Enter cut point date (dd.mm.yyyy): '
prompt ... g_cut_point_date defined = &g_cut_point_date
accept g_cut_point2_date prompt 'Enter cut point for report tables and datamarts date (dd.mm.yyyy): '
prompt ... g_cut_point2_date defined = &g_cut_point2_date
prompt ... === cut points define finished

prompt ... === drop partitions start

begin
  for rec in (select t.OWNER, t.TABLE_NAME 
                from all_tables t
                join (select tt.owner, tt.name, max(tt.column_name) as column_name
                        from all_part_key_columns tt 
                       group by tt.owner, tt.name 
                      having count(*) = 1) tt
                  on t.OWNER = tt.owner
                 and t.TABLE_NAME = tt.name
                join all_tab_columns ttt
                  on t.OWNER = ttt.OWNER
                 and t.TABLE_NAME = ttt.TABLE_NAME
                 and tt.column_name = ttt.COLUMN_NAME
               where t.OWNER = 'BARS'
                 and ttt.DATA_TYPE = 'DATE'
                 --and t.TABLE_NAME not like '%UPDATE'
                 and t.TABLE_NAME not like 'PRVN%'
                 and t.TABLE_NAME not in ('SALDOA')
               order by 1,2)
  loop
       p_drop_partitions(s_owner => rec.owner, s_table => rec.table_name, d_min_date => to_date('&g_cut_point_date', 'dd.mm.yyyy'));
  end loop;
end;
/

begin
  for rec in (select t.OWNER, t.TABLE_NAME 
                from all_tables t
                join (select tt.owner, tt.name, max(tt.column_name) as column_name
                        from all_part_key_columns tt 
                       group by tt.owner, tt.name 
                      having count(*) = 1) tt
                  on t.OWNER = tt.owner
                 and t.TABLE_NAME = tt.name
                join all_tab_columns ttt
                  on t.OWNER = ttt.OWNER
                 and t.TABLE_NAME = ttt.TABLE_NAME
                 and tt.column_name = ttt.COLUMN_NAME
               where t.OWNER = 'BARS'
                 and ttt.DATA_TYPE = 'DATE'
                 and t.TABLE_NAME like ('NBUR%')
                 --and t.TABLE_NAME not like '%UPDATE'
                 and t.TABLE_NAME not like 'PRVN%'
                 and t.TABLE_NAME not in ('SALDOA')
               order by 1,2)
  loop
       p_drop_partitions(s_owner => rec.owner, s_table => rec.table_name, d_min_date => to_date('&g_cut_point2_date', 'dd.mm.yyyy'));
  end loop;
end;
/
prompt ... === drop partitions finished

prompt ... === truncate partitions start

begin
  for rec in (select t.OWNER, t.TABLE_NAME 
                from all_tables t
                join (select tt.owner, tt.name, max(tt.column_name) as column_name
                        from all_part_key_columns tt 
                       group by tt.owner, tt.name 
                      having count(*) = 1) tt
                  on t.OWNER = tt.owner
                 and t.TABLE_NAME = tt.name
                join all_tab_columns ttt
                  on t.OWNER = ttt.OWNER
                 and t.TABLE_NAME = ttt.TABLE_NAME
                 and tt.column_name = ttt.COLUMN_NAME
               where t.OWNER = 'BARS'
                 and ttt.DATA_TYPE = 'DATE'
                 --and t.TABLE_NAME not like '%UPDATE'
                 and t.TABLE_NAME not like 'PRVN%'
                 and t.TABLE_NAME not in ('SALDOA')
               order by 1,2)
  loop
       p_trunc_partitions(s_owner => rec.owner, s_table => rec.table_name, d_min_date => to_date('&g_cut_point_date', 'dd.mm.yyyy'));
  end loop;
end;
/

begin
  for rec in (select t.OWNER, t.TABLE_NAME 
                from all_tables t
                join (select tt.owner, tt.name, max(tt.column_name) as column_name
                        from all_part_key_columns tt 
                       group by tt.owner, tt.name 
                      having count(*) = 1) tt
                  on t.OWNER = tt.owner
                 and t.TABLE_NAME = tt.name
                join all_tab_columns ttt
                  on t.OWNER = ttt.OWNER
                 and t.TABLE_NAME = ttt.TABLE_NAME
                 and tt.column_name = ttt.COLUMN_NAME
               where t.OWNER = 'BARS'
                 and ttt.DATA_TYPE = 'DATE'
                 --and t.TABLE_NAME not like '%UPDATE'
                 and t.TABLE_NAME not like 'PRVN%'
                 and t.TABLE_NAME not in ('SALDOA')
                 and (   t.TABLE_NAME like ('NBUR%')
                      or t.TABLE_NAME in ('AGG_MONBALS', 'SEC_AUDIT', 'SEC_DDL_AUDIT', 'RNBU_TRACE_ARCH', 'RNBU_TRACE_INT_ARCH',  'SNAP_BALANCES')
                     )
               order by 1,2)
  loop
       p_trunc_partitions(s_owner => rec.owner, s_table => rec.table_name, d_min_date => to_date('&g_cut_point2_date', 'dd.mm.yyyy'));
  end loop;
end;
/

prompt ... === truncate partitions finished

prompt ... === rebuild unusable unique indexes start

begin

  execute immediate 'alter session enable parallel ddl';

  for rec in
    (select  t.TABLE_OWNER
           , t.TABLE_NAME
           , t.INDEX_NAME
           , tt.partition_name
           , ttt.subpartition_name

           , case when t.status = 'UNUSABLE' then
                       'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild parallel 24'
                  when tt.status = 'UNUSABLE' then
                       'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild partition '||tt.partition_name||' parallel 24'
                  when ttt.status = 'UNUSABLE' then
                       'alter index '||t.OWNER||'.'||t.INDEX_NAME||' rebuild subpartition '||ttt.subpartition_name||' parallel 24'
             end as statement_rebuild

      from all_indexes t
      left join all_ind_partitions tt
      on t.INDEX_NAME = tt.index_name
      left join all_ind_subpartitions ttt
      on t.INDEX_NAME = ttt.index_name
      and tt.partition_name = ttt.partition_name
      where t.TABLE_OWNER = 'BARS'
        and t.uniqueness = 'UNIQUE'
        and (t.status = 'UNUSABLE' or tt.status = 'UNUSABLE' or ttt.status = 'UNUSABLE')
                  order by 2,3,4,5)

  loop
    --
    logger.trace(rec.statement_rebuild, rec.TABLE_NAME);
    --
    execute immediate rec.statement_rebuild;
  end loop;

  execute immediate 'alter session disable parallel ddl';

end;
/

prompt ... === rebuild unusable unique indexes finished



prompt ... === insert saved refs from  bars.tmp_oper_cp_cim into bars.oper 

declare
procedure fill_oper_from_cim_p_b    
    is
    l_tab                   VARCHAR2(30) DEFAULT 'OPER';
    p                       CONSTANT VARCHAR2(62) := '.fill_oper_from_cp_cim';
    v_count                 PLS_INTEGER := 0;
    c_limit                 PLS_INTEGER := 50000;
    l_cur                   SYS_REFCURSOR;
    c_n                     PLS_INTEGER := 0;
    l_migration_start_time  date default sysdate;
    l_start_time            timestamp default current_timestamp;
    l_end_time              timestamp default current_timestamp;
    l_rowcount              number default 0;
    l_time_duration         interval day(3) to second(3);

   /* "Exceptions encountered in FORALL" exception... */
   bulk_exceptions   EXCEPTION;
   PRAGMA EXCEPTION_INIT (bulk_exceptions, -24381);

  /*
   * Source data record and associative array type. Needed to
   * enable LIMIT-based fetching...
  */

    TYPE t_oper_row IS TABLE OF oper%ROWTYPE;
    vv_cur_oper t_oper_row;
---------------------------------------------------------------------------------
      /*local procedure for save error to err$table*/
   PROCEDURE error_logging_oper IS
      /* Associative array type of the exceptions table... */
      TYPE t_cur_exception IS TABLE OF ERR$_OPER%ROWTYPE INDEX BY PLS_INTEGER;

      v_cur_exceptions   t_cur_exception;

      v_indx          PLS_INTEGER;

      /* Emulate DML error logging behaviour... */
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
         v_indx := SQL%BULK_EXCEPTIONS (i).ERROR_INDEX;

         /* Populate as many values as available... */
         v_cur_exceptions (i).ora_err_number$        := SQL%BULK_EXCEPTIONS (i).ERROR_CODE;
         v_cur_exceptions (i).ora_err_mesg$          := SQLERRM (SQL%BULK_EXCEPTIONS (i).ERROR_CODE * -1);
         v_cur_exceptions (i).ora_err_tag$           := 'FORALL ERROR LOGGING';
         v_cur_exceptions (i).ora_err_optyp$         := 'I';
         v_cur_exceptions (i).ref                    := vv_cur_oper (v_indx).ref;
         v_cur_exceptions (i).kf                     := vv_cur_oper (v_indx).kf;
         v_cur_exceptions (i).pdat                   := vv_cur_oper (v_indx).pdat;
      END LOOP;

      /* Load the exceptions into the exceptions table... */
      FORALL i IN INDICES OF v_cur_exceptions
         INSERT INTO ERR$_OPER
              VALUES v_cur_exceptions (i);

      COMMIT;
   END error_logging_oper;

    --
    BEGIN
    l_migration_start_time := sysdate;
    l_start_time := current_timestamp;

    mgr_utl.mantain_error_table(l_tab);
             --
             
   -- Enable/Disable primary, unique and foreign key constraints 
    --execute immediate 'alter table OPER  MODIFY constraint FK_OPER_OPER disable';
             
            BEGIN
            OPEN l_cur FOR
              'select *
                 from bars.TMP_OPER_CP_CIM op_kf 
                where not exists 
                          (select null 
                             from bars.oper op 
                            where op.ref = op_kf.ref)
              ';
                  --
           LOOP
             FETCH l_cur BULK COLLECT INTO vv_cur_oper LIMIT c_limit;
               EXIT WHEN vv_cur_oper.COUNT = 0;

           BEGIN
            FORALL indx IN INDICES OF vv_cur_oper SAVE EXCEPTIONS
              INSERT INTO bars.oper
                                        VALUES vv_cur_oper(indx);

            EXCEPTION
                   WHEN bulk_exceptions THEN
                      c_n := c_n + SQL%ROWCOUNT;
                      error_logging_oper ();
           END;
            COMMIT;
              v_count := v_count + c_limit;
            dbms_application_info.set_action('INS: ' || to_char(v_count)||'/'||to_char(sql%rowcount)||'/ TBL: '||l_tab||' ERR: ' || to_char(c_n));
            dbms_application_info.set_client_info('INS: ' || to_char(v_count)||'/'||to_char(sql%rowcount)||'/ TBL: '||l_tab||' ERR: ' || to_char(c_n));
           END LOOP;
           l_rowcount := l_cur%rowcount;           
           CLOSE l_cur;
         l_end_time := current_timestamp;
         l_time_duration:= (l_end_time - l_start_time);
        EXCEPTION
              WHEN OTHERS THEN
           -- Clear collection for vv_cur_oper
           vv_cur_oper.delete;
         END;
  
      --execute immediate 'alter table OPER  MODIFY constraint FK_OPER_OPER ENABLE NOVALIDATE';
             
  end fill_oper_from_cim_p_b;
  
  begin
      fill_oper_from_cim_p_b();  
  end;
/


prompt ... === insert saved refs from  bars.tmp_oper_cp_cim into bars.oper 

declare
procedure fill_oper_from_cim_p_b    
    is
    l_tab                   VARCHAR2(30) DEFAULT 'OPER';
    p                       CONSTANT VARCHAR2(62) := '.fill_oper_from_cp_cim';
    v_count                 PLS_INTEGER := 0;
    c_limit                 PLS_INTEGER := 50000;
    l_cur                   SYS_REFCURSOR;
    c_n                     PLS_INTEGER := 0;
    l_migration_start_time  date default sysdate;
    l_start_time            timestamp default current_timestamp;
    l_end_time              timestamp default current_timestamp;
    l_rowcount              number default 0;
    l_time_duration         interval day(3) to second(3);

   /* "Exceptions encountered in FORALL" exception... */
   bulk_exceptions   EXCEPTION;
   PRAGMA EXCEPTION_INIT (bulk_exceptions, -24381);

  /*
   * Source data record and associative array type. Needed to
   * enable LIMIT-based fetching...
  */

    TYPE t_oper_row IS TABLE OF oper%ROWTYPE;
    vv_cur_oper t_oper_row;
---------------------------------------------------------------------------------
      /*local procedure for save error to err$table*/
   PROCEDURE error_logging_oper IS
      /* Associative array type of the exceptions table... */
      TYPE t_cur_exception IS TABLE OF ERR$_OPER%ROWTYPE INDEX BY PLS_INTEGER;

      v_cur_exceptions   t_cur_exception;

      v_indx          PLS_INTEGER;

      /* Emulate DML error logging behaviour... */
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
         v_indx := SQL%BULK_EXCEPTIONS (i).ERROR_INDEX;

         /* Populate as many values as available... */
         v_cur_exceptions (i).ora_err_number$        := SQL%BULK_EXCEPTIONS (i).ERROR_CODE;
         v_cur_exceptions (i).ora_err_mesg$          := SQLERRM (SQL%BULK_EXCEPTIONS (i).ERROR_CODE * -1);
         v_cur_exceptions (i).ora_err_tag$           := 'FORALL ERROR LOGGING';
         v_cur_exceptions (i).ora_err_optyp$         := 'I';
         v_cur_exceptions (i).ref                    := vv_cur_oper (v_indx).ref;
         v_cur_exceptions (i).kf                     := vv_cur_oper (v_indx).kf;
         v_cur_exceptions (i).pdat                   := vv_cur_oper (v_indx).pdat;
      END LOOP;

      /* Load the exceptions into the exceptions table... */
      FORALL i IN INDICES OF v_cur_exceptions
         INSERT INTO ERR$_OPER
              VALUES v_cur_exceptions (i);

      COMMIT;
   END error_logging_oper;

    --
    BEGIN
    l_migration_start_time := sysdate;
    l_start_time := current_timestamp;

    mgr_utl.mantain_error_table(l_tab);
             --
             
         BEGIN
            OPEN l_cur FOR
              'select *
                 from bars.TMP_OPER_CP_CIM op_kf 
                where not exists 
                          (select null 
                             from bars.oper op 
                            where op.ref = op_kf.ref)
              ';
                  --
           LOOP
             FETCH l_cur BULK COLLECT INTO vv_cur_oper LIMIT c_limit;
               EXIT WHEN vv_cur_oper.COUNT = 0;

           BEGIN
            FORALL indx IN INDICES OF vv_cur_oper SAVE EXCEPTIONS
              INSERT INTO bars.oper
                                        VALUES vv_cur_oper(indx);

            EXCEPTION
                   WHEN bulk_exceptions THEN
                      c_n := c_n + SQL%ROWCOUNT;
                      error_logging_oper ();
           END;
            COMMIT;
              v_count := v_count + c_limit;
            dbms_application_info.set_action('INS: ' || to_char(v_count)||'/'||to_char(sql%rowcount)||'/ TBL: '||l_tab||' ERR: ' || to_char(c_n));
            dbms_application_info.set_client_info('INS: ' || to_char(v_count)||'/'||to_char(sql%rowcount)||'/ TBL: '||l_tab||' ERR: ' || to_char(c_n));
           END LOOP;
           l_rowcount := l_cur%rowcount;           
           CLOSE l_cur;
         l_end_time := current_timestamp;
         l_time_duration:= (l_end_time - l_start_time);
        EXCEPTION
              WHEN OTHERS THEN
           -- Clear collection for vv_cur_oper
           vv_cur_oper.delete;
         END;
             
  end fill_oper_from_cim_p_b;
  
  begin
      fill_oper_from_cim_p_b();  
  end;
/


prompt ... === insert saved refs from  bars.tmp_opldok_cp_cim into bars.opldok 

declare
procedure fill_opldok_from_cim_p_b    
    is
    l_tab                   VARCHAR2(30) DEFAULT 'OPLDOK';
    p                       CONSTANT VARCHAR2(62) := '.fill_opldok_from_cp_cim';
    v_count                 PLS_INTEGER := 0;
    c_limit                 PLS_INTEGER := 50000;
    l_cur                   SYS_REFCURSOR;
    c_n                     PLS_INTEGER := 0;
    l_migration_start_time  date default sysdate;
    l_start_time            timestamp default current_timestamp;
    l_end_time              timestamp default current_timestamp;
    l_rowcount              number default 0;
    l_time_duration         interval day(3) to second(3);

   /* "Exceptions encountered in FORALL" exception... */
   bulk_exceptions   EXCEPTION;
   PRAGMA EXCEPTION_INIT (bulk_exceptions, -24381);

  /*
   * Source data record and associative array type. Needed to
   * enable LIMIT-based fetching...
  */

    TYPE t_opldok_row IS TABLE OF opldok%ROWTYPE;
    vv_cur_opldok t_opldok_row;
---------------------------------------------------------------------------------
      /*local procedure for save error to err$table*/
   PROCEDURE error_logging_opldok IS
      /* Associative array type of the exceptions table... */
      TYPE t_cur_exception IS TABLE OF ERR$_opldok%ROWTYPE INDEX BY PLS_INTEGER;

      v_cur_exceptions   t_cur_exception;

      v_indx          PLS_INTEGER;

      /* Emulate DML error logging behaviour... */
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
         v_indx := SQL%BULK_EXCEPTIONS (i).ERROR_INDEX;

         /* Populate as many values as available... */
         v_cur_exceptions (i).ora_err_number$        := SQL%BULK_EXCEPTIONS (i).ERROR_CODE;
         v_cur_exceptions (i).ora_err_mesg$          := SQLERRM (SQL%BULK_EXCEPTIONS (i).ERROR_CODE * -1);
         v_cur_exceptions (i).ora_err_tag$           := 'FORALL ERROR LOGGING';
         v_cur_exceptions (i).ora_err_optyp$         := 'I';
         v_cur_exceptions (i).ref                    := vv_cur_opldok (v_indx).ref;
         v_cur_exceptions (i).kf                     := vv_cur_opldok (v_indx).kf;
         v_cur_exceptions (i).pdat                   := vv_cur_opldok (v_indx).pdat;
      END LOOP;

      /* Load the exceptions into the exceptions table... */
      FORALL i IN INDICES OF v_cur_exceptions
         INSERT INTO ERR$_opldok
              VALUES v_cur_exceptions (i);

      COMMIT;
   END error_logging_opldok;

    --
    BEGIN
    l_migration_start_time := sysdate;
    l_start_time := current_timestamp;

    mgr_utl.mantain_error_table(l_tab);
             --             
         BEGIN
            OPEN l_cur FOR
              'select *
                 from bars.TMP_opldok_CP_CIM op_kf 
                where not exists 
                          (select null 
                             from bars.opldok op 
                            where op.ref = op_kf.ref)
              ';
                  --
           LOOP
             FETCH l_cur BULK COLLECT INTO vv_cur_opldok LIMIT c_limit;
               EXIT WHEN vv_cur_opldok.COUNT = 0;

           BEGIN
            FORALL indx IN INDICES OF vv_cur_opldok SAVE EXCEPTIONS
              INSERT INTO bars.opldok
                                        VALUES vv_cur_opldok(indx);

            EXCEPTION
                   WHEN bulk_exceptions THEN
                      c_n := c_n + SQL%ROWCOUNT;
                      error_logging_opldok ();
           END;
            COMMIT;
              v_count := v_count + c_limit;
            dbms_application_info.set_action('INS: ' || to_char(v_count)||'/'||to_char(sql%rowcount)||'/ TBL: '||l_tab||' ERR: ' || to_char(c_n));
            dbms_application_info.set_client_info('INS: ' || to_char(v_count)||'/'||to_char(sql%rowcount)||'/ TBL: '||l_tab||' ERR: ' || to_char(c_n));
           END LOOP;
           l_rowcount := l_cur%rowcount;           
           CLOSE l_cur;
         l_end_time := current_timestamp;
         l_time_duration:= (l_end_time - l_start_time);
        EXCEPTION
              WHEN OTHERS THEN
           -- Clear collection for vv_cur_opldok
           vv_cur_opldok.delete;
         END;
             
  end fill_opldok_from_cim_p_b;
  
  begin
      fill_opldok_from_cim_p_b();  
  end;
/

timing stop

spool off
quit
