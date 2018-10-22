prompt ... =========================================
prompt ... === deinitialization v0.1 11.10.2018
prompt ... =========================================

set serveroutput on size 1000000
col cur_time new_value g_cur_time
select to_char(sysdate, 'yyyymmddhh24mi') as cur_time from dual;
spool log\100_deinitialization_&g_cur_time.log
set lines 3000
set time on
set timing on


timing start exec_duration


prompt ... === rebuild unusable indexes start

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

prompt ... === rebuild unusable indexes finished

prompt ... === enable constraints and triggers start

declare
cursor cur is
    select upper(table_name) tab_name from all_tables
    where owner = 'BARS'
    /*and not lower(table_name) in
    ('cim_f36')*/;
    type t_cur_ut is table of user_tables.table_name%type index by pls_integer;
    l_cur_ut t_cur_ut;
    v_counter pls_integer := 0;
procedure enable_table_obj
  is
    begin
        for rec in cur loop
        v_counter := v_counter + 1;
        l_cur_ut(v_counter) := rec.tab_name;
         mgr_utl.p_constraints_chk_en_novalid  (l_cur_ut(v_counter));
         --mgr_utl.p_constraints_pk_en_novalid   (l_cur_ut(v_counter));
         mgr_utl.p_constraints_fk_en_novalid   (l_cur_ut(v_counter));
         --mgr_utl.p_ref_constraints_en_novalid  (l_cur_ut(v_counter));
         mgr_utl.p_triggers_enable             (l_cur_ut(v_counter));
    end loop;
    exception when others then
        raise;
    mgr_utl.save_error();
end enable_table_obj;
begin
 enable_table_obj();
end;
/

begin
  for rec in (select t.stmt from tmp_disabled_objects t)
  loop
    begin
      execute immediate rec.stmt;
      exception
        when others then dbms_output.put_line(sqlerrm);
    end;
  end loop;  
end;  
/
prompt ... === enable constraints and triggers finished


begin
  for rec in (select t.OBJECT_OWNER, t.OBJECT_NAME from tmp_disabled_policies t where rownum = 1)
  loop
    begin
      execute immediate 'call bars_policy_adm.disable_policies('''||rec.OBJECT_OWNER||''', '''||rec.OBJECT_NAME||''')';
      --dbms_output.put_line('call bars_policy_adm.disable_policies('''||rec.OBJECT_OWNER||''', '''||rec.OBJECT_NAME||''')');
      exception
        when others then dbms_output.put_line(sqlerrm);
    end;
  end loop;  
end;  
/


begin
  for rec in (select distinct t.OBJECT_OWNER, t.OBJECT_NAME
                from all_policies t
               where t.OBJECT_OWNER = 'BARS'
                 and t.ENABLE = 'NO'
               minus
              select t.OBJECT_OWNER, t.OBJECT_NAME from tmp_disabled_policies t)
  loop
    begin
      execute immediate 'call bars_policy_adm.enable_policies('''||rec.OBJECT_OWNER||''', '''||rec.OBJECT_NAME||''')';
      --dbms_output.put_line('call bars_policy_adm.enable_policies('''||rec.OBJECT_OWNER||''', '''||rec.OBJECT_NAME||''')');
      exception
        when others then dbms_output.put_line(sqlerrm);
    end;
  end loop;  
end;  
/

prompt ... === drop package depersonalization;
drop package body depersonalization;
drop package depersonalization;


prompt ... === recompile start
exec sys.utl_recomp.recomp_serial('BARS');
prompt ... === recompile finished

begin
  for rec in (select owner, table_name from all_tab_statistics t
               where t.OWNER = 'BARS'
                 and t.TABLE_NAME in (  'CUSTOMER', 'CUSTOMER_UPDATE', 'CUSTOMER_REL', 'CUSTOMER_REL_UPDATE', 'CUSTOMER_ADDRESS', 'CUSTOMER_ADDRESS_UPDATE'
                                      , 'PERSON', 'PERSON_UPDATE', 'CUSTOMERW', 'CUSTOMERW_UPDATE', 'ACCOUNTS', 'ACCOUNTS_UPDATE', 'ARC_RRP', 'OPER', 'OPLDOK', 'OPERW'
                                      , 'EAD_DOCS', 'CUSTOMER_IMAGES')
                 and t.PARTITION_NAME is null)
  loop
    dbms_stats.delete_table_prefs(ownname => rec.owner, tabname => rec.table_name, pname => 'STALE_PERCENT');
  end loop;
end;
/

timing stop

spool off
quit
