
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_refsync.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_REFSYNC is

  ------------------------------------------------------
  -- Copyryight : UNITY-BARS
  -- Author  : Oleg
  -- Created : �������, 13.07.2007 14:56:15
  -- Purpose : ����� �������� ��� ���������� ������������� ������������
  -- l_evaluation_context := 'SYS.STREAMS$_EVALUATION_CONTEXT';
  ------------------------------------------------------

   g_awk_header_defs constant varchar2(512) := '';


  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 3.1  03.06.2009';

  -- ��������� ����������� ���������
  GROUP_ALL_TRANSACTIONS       constant pls_integer := 0;
  GROUP_SINGLE_TRANSACTION     constant pls_integer := 1;

  -- session vars
  g_tmp_data            sys.anydata;
  g_row_lcr             sys.lcr$_row_record;
  g_que_msg_prop        sys.dbms_aq.message_properties_t; -- ��������� ���������

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  ----
  -- add_table - ��������� ������� � ������ ������ ��� �������������
  --
  -- @p_table - ��� �������
  --
  procedure add_table(p_table in varchar2);

  ----
  -- recreate_table - ����������� �������������� ��� �������
  --
  -- @p_table - ��� �������
  --
  procedure recreate_table(p_table in varchar2);

  ----
  -- remove_table - ������� ������� �� ������ ���������������� ������
  --
  -- @p_table - ��� �������
  --
  procedure remove_table(p_table in varchar2);



  ----
  -- alter_subscriber - ������������ ���������� �� ���������� �� ����������
  --
  -- @p_name - ���������� ��� (� ������ �������)
  -- @p_table_list - ������ ������ ����� �������, ������ ��� � ��������: 'BANKS','SW_BANKS','CUR_RATES'
  --
  procedure alter_subscriber(p_name in varchar2, p_table_list in varchar2 default null);

  ----
  -- remove_subscriber - ������� ���������� �� ���������� �� ����������
  --
  -- @p_name - ���������� ��� ����������(� ������ �������)
  --
  procedure remove_subscriber(p_name in varchar2);

  ----
  -- get_all_changed_data - �������������� ������ ��� ������������� �� ���� ��������
  --
  -- @p_subscriber - ��� ����������
  -- @p_message_grouping - ������ ����������� ���������
  --    0 - GROUP_ALL_TRANSACTIONS   - ��������� �� ���� �����������
  --    1 - GROUP_SINGLE_TRANSACTION - ��������� �� ����� ����������
  procedure get_all_changed_data(p_subscriber in varchar2,
                                 p_message_grouping in number default bars_refsync.GROUP_ALL_TRANSACTIONS);

  ----
  -- show_subscribers - ���������� c ������� DBMS_OUTPUT ������ �����������
  --
  --
  procedure show_subscribers;


  -------------------------------------------
  --   DML_HANDLER
  --
  --   ���������� dml: �������� LCR �� ������� STREAMS_QUEUE � �������� � AQ_REFSYNC
  --
  --   @p_obj - �������� LCR
  --
  procedure dml_handler(p_obj in sys.anydata);



  -------------------------------------------
  --   SUBSCR_ACC
  --
  --   �������� ������� ������� acc � �����������
  --
  --   return  1 - �� 0-���, �� ��������
  --
  function subscr_acc(p_acc number) return smallint;



  -------------------------------------------
  --  ADD_SUBSCRIBER
  --
  --  ��������� ������ ���������� �� ���������� �� ����������
  --
  -- @p_name         - ���������� ��� (� ������ �������)
  -- @p_table_list   - ������ ������ ����� �������, ������ ��� � ��������: 'BANKS','SW_BANKS','CUR_RATES'
  -- @p_description  - �������
  --
  procedure add_subscriber(
                  p_name         in varchar2,
                  p_table_list   in varchar2  default null,
                  p_description  in varchar2  default null);




  ---------------------------------------------------
  --  RULE_TABLES
  --
  --  ������ ������ ������ � ������, ������� ��������� ������� ��� appply ��������
  --  barsaq.is_suitable_lcr(tab.user_data,'''BANKS$BASE'',''DPT_VIDD''')=1
  --  ���� ����� ������ ������� � ��������� ������������� �������
  --
  function refsync_rule_tables return t_rule_table_list pipelined;




  ----------------------------------------------
  --  ADD_REF_TO_SUBSCRIBER
  --
  --  ��������� ���������� � ������ ���������������� ��� ����������
  --
  --
  procedure add_ref_to_subscriber(
                  p_username  varchar2,
                  p_refname   varchar2);


  ----------------------------------------------
  --  REMOVE_REF_FROM_SUBSCRIBER
  --
  --  ������� ���������� �� ������ ���������������� ��� ����������
  --
  --
  procedure remove_ref_from_subscriber(
                  p_username  varchar2,
                  p_refname   varchar2);


  ------------------------------------------
  -- PROC_OPLDOK_CHANGES
  --
  -- ��������� ��������� �� ���������
  --
  --
  procedure proc_opldok_changes;




end bars_refsync;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_REFSYNC is

   g_awk_body_defs constant varchar2(512) := '';



  ----------------------------------------------------
  -- global consts
  ----------------------------------------------------
  G_BODY_VERSION    constant varchar2(64)   := 'version 2.14 20/06/2009';
  G_MODULE_NAME     constant varchar2(3)    := 'SYN';
  G_SOURCE_SCHEMA   constant varchar2(4)    := 'BARS';
  G_AQ_SCHEMA       constant varchar2(6)    := 'BARSAQ';
  G_TRACE           constant varchar2(20)   := 'bars_refsync.';


  ----------------------------------------------------
  -- global variables
  ----------------------------------------------------
  g_database_name   global_name.global_name%type;





  ----------------------------------------------------
  --  HEADER_VERSION
  --
  --  ���������� ������ ��������� ������
  --
  ----------------------------------------------------
  function header_version return varchar2 is
  begin
    return 'Package header vers:'||G_HEADER_VERSION||'. awk: '||g_awk_header_defs;
  end header_version;



  ----------------------------------------------------
  -- BODY_VERSION
  --
  -- ���������� ������ ���� ������
  --
  ----------------------------------------------------
  function body_version return varchar2 is
  begin
    return 'Package body vers:'||G_BODY_VERSION||'. awk: '||g_awk_body_defs;
  end body_version;





  ------------------------------------------------------
  -- private members
  ------------------------------------------------------


  --
  -- init - ������������� ������
  --
  procedure init is
  begin
    --if bars.bars_audit.get_log_level()>=bars.bars_audit.LOG_LEVEL_TRACE then
    --    bars.bars_audit.trace('bars_refsync.init()');
    --end if;
    select global_name into g_database_name from global_name;
  end init;

  ----
  -- get_table_fields  - ���������� ������ ����� ������� ����� �������
  --
  function get_table_fields(p_owner in varchar2, p_table in varchar2) return varchar2 is
    l_fields varchar2(4000);
  begin
    select max( sys_connect_by_path(column_name, ',')) into l_fields
    from (
           select column_name, row_number() over (order by column_id) as num
           from dba_tab_columns where owner=p_owner and table_name=p_table
         )
    connect by  prior num = num-1
    start with num = 1;
    return substr(l_fields, 2);
  end get_table_fields;



  ----------------------------------------------
  --  GET_REFLIST_FROM_RULE
  --
  --  �� ������� ����������, �������� ������ ������ �������������
  --  ������ ������ ������ � ��������, ����� �������.
  --
  --  ���� ����� ������ ������� � ��������� ������������� �������
  --  ������ ����:
  --  barsaq.is_suitable_lcr(tab.user_data,'''BANKS$BASE'',''DPT_VIDD''')=1
  --
  --
  function get_reflist_from_rule(p_ruledesc varchar2 ) return varchar2
  is
     l_res varchar2(8000);
     l_trace      varchar2(1000):= G_TRACE||'get_reflist_from_rule: ';
  begin
      if p_ruledesc is null then return '';
      end if;

      l_res := substr(p_ruledesc,
                      instr(p_ruledesc,',') + 1,
                      instr(p_ruledesc,')') - instr(p_ruledesc,',') - 1
                     );
      -- �������������� � �������. �������
      l_res :=  substr(l_res, 2 , length(l_res) - 2);
      -- ������ ������� �������
      l_res := replace (l_res,'''''','''');

      return l_res;
  end;



  ---------------------------------------------------------
  --  REFSYNC_RULE_TABLES
  --
  --  ������ ������ ���������������� ������ � ���� �������
  --
  --
  function refsync_rule_tables return t_rule_table_list pipelined
  is
     l_val      varchar2(1000);
     l_purelist varchar2(1000);
     l_sql      varchar2(1000);
     i          number;
     l_cur      sys_refcursor;
     l_name     varchar2(1000);
     l_rule     varchar2(1000);
  begin

     l_sql :=  ' select s.name,r.rule '||
               ' from barsaq.aq$aq_refsync_tbl_s s, barsaq.aq$aq_refsync_tbl_r r '||
               ' where s.queue=r.queue(+) and s.name=r.name(+) and s.queue= ''AQ_REFSYNC'' ';

     open l_cur for l_sql;
     loop
        fetch l_cur into l_name, l_rule;
        exit when l_cur%NOTFOUND;

         /*  for c in ( select s.name,r.rule
                 from barsaq.aq$aq_refsync_tbl_s s,
                      barsaq.aq$aq_refsync_tbl_r r
                 where s.queue=r.queue(+) and s.name=r.name(+) and s.queue= 'AQ_REFSYNC') loop
         */

         l_purelist := get_reflist_from_rule(l_rule);
         l_purelist := replace (l_purelist,'''','');
         l_val := l_purelist;
         i := length(l_purelist);

         while i > 0 loop
            if instr(l_val,',')>0 then
               pipe row ( t_rule_table(l_name, substr(l_val,1,instr(l_val,',')-1), l_rule)   ) ;
               l_val:=substr(l_val,instr(l_val,',')+1);
            else
               pipe row (  t_rule_table(l_name, l_val, l_rule ) );
               i:=0;
            end if;
         end loop;


     end loop;



     return;
  end;



  ------------------------------------
  --   SUBSCR_ACC
  --
  --   �������� ������� acc �� ���������� � �������� ��� �������
  --
  --   return  1 - �� 0-���, �� ��������
  --
  function subscr_acc(p_acc number) return smallint
  is
     l_chk  smallint;
     l_nls  varchar2(14);
  begin

     --bars.p_testlog('test_log:-----------');
     --bars.p_testlog('test_log: acc='||p_acc);
     --bars.p_testlog('test_log: user='||user);

     bars.bars_context.set_context;

     select min(column_value) into l_chk
     from bars.v_klbx_active_branch v, bars.accounts a, table(bars.sec.getAgrp(p_acc)) t
     where  a.acc = p_acc
           and ( -- LOCAL ������ ��������������� ����
                  a.branch like v.branch||'%'   and   t.column_value = bars.bars_xmlklb_ref.syncgrp_local
               );

     --bars.p_testlog('test_log: l_chk ='||l_chk);

     return sign(nvl(l_chk,0));

  end;





  --------------------------------------
  -- CREATE_TMP_TABLE
  --
  --  ������� ��������� ������� ��� ��������� ���� ������������ ������
  --
  -- @p_table - ��� �������
  --
  procedure create_tmp_table(p_table in varchar2) is
    l_tabname refsync_list.tabname%type;
  begin

    l_tabname := 'tmp_refsync_'||p_table;

    -- ������� �������
    begin
      execute immediate
        'create global temporary table '||l_tabname||' '||
        'on commit delete rows as (select * from '||G_SOURCE_SCHEMA||'.'||p_table||' where 1=0)';
    exception when others then
      if sqlcode = -955 then bars.bars_audit.error(SQLERRM); else raise; end if;
    end;

    -- �������� ���� constraint-��
    begin
       for c in ( select constraint_name from user_constraints
                  where table_name  = l_tabname)
       loop
           execute immediate 'alter table '||l_tabname||' drop constraint '||c.constraint_name;
       end loop;
    end;


    -- �������� � ������� ���� action
    begin
      execute immediate 'alter table '||l_tabname||' add action char';
    exception when others then
      if sqlcode = -1430 then bars.bars_audit.error(SQLERRM); else raise; end if;
    end;

    -- �������� � ������� ���� change_date
    begin
      execute immediate 'alter table '||l_tabname||' add change_date date';
    exception when others then
      if sqlcode = -1430 then bars.bars_audit.error(SQLERRM); else raise; end if;
    end;

    -- �������� � ������� ���� change_number
    begin
      execute immediate 'alter table '||l_tabname||' add change_number number';
    exception when others then
      if sqlcode = -1430 then bars.bars_audit.error(SQLERRM); else raise; end if;
    end;

    -- �������� � ������� ���� system_change_number
    begin
      execute immediate 'alter table '||l_tabname||' add system_change_number number';
    exception when others then
      if sqlcode = -1430 then bars.bars_audit.error(SQLERRM); else raise; end if;
    end;

    -- ����������� ������� tmp_refsync_<p_table> ��� ������������ ������������
    execute immediate 'begin sys.dbms_stats.gather_table_stats(''BARSAQ'','''||l_tabname||'''); end;';

    -- ���� ��� ������� SALDOA, ������� ������������� �������������
    if p_table='SALDOA' then
        begin
          execute immediate 'create or replace view v_saldoa_changes as
          select
            a.acc, a.nls, a.kv, a.nms,
            s.fdat, s.pdat, s.ostf ost, s.dos, s.kos,
            bars.gl.p_icurval(a.kv, s.ostf, s.fdat) ostq,
            bars.gl.p_icurval(a.kv, s.dos, s.fdat) dosq,
            bars.gl.p_icurval(a.kv, s.kos, s.fdat) kosq,
            s.trcn,
            s.action,
            s.change_date,
            s.change_number,
            s.system_change_number
            from accounts a, tmp_refsync_saldoa s
            where a.acc=s.acc
          ';
          -- ����������� � �������������
          execute immediate 'comment on table v_saldoa_changes is ''��������� �������� � �������� �� ������''';
          execute immediate 'comment on column v_saldoa_changes.acc is ''���������� ����� �����''';
          execute immediate 'comment on column v_saldoa_changes.nls is ''����� �������� �����''';
          execute immediate 'comment on column v_saldoa_changes.kv is ''��� ������''';
          execute immediate 'comment on column v_saldoa_changes.nms is ''������������ �����''';
          execute immediate 'comment on column v_saldoa_changes.fdat is ''���� �������� �� �����''';
          execute immediate 'comment on column v_saldoa_changes.pdat is ''���� ����������� �������� �� �����''';
          execute immediate 'comment on column v_saldoa_changes.ost is ''������� �������� � �������� �� ����� �� ���� fdat''';
          execute immediate 'comment on column v_saldoa_changes.dos is ''������� ��������� � ��������''';
          execute immediate 'comment on column v_saldoa_changes.kos is ''������� ���������� � ��������''';
          execute immediate 'comment on column v_saldoa_changes.ostq is ''������� �������� � �����������''';
          execute immediate 'comment on column v_saldoa_changes.dosq is ''������� ��������� � �����������''';
          execute immediate 'comment on column v_saldoa_changes.kosq is ''������� ���������� � �����������''';
          execute immediate 'comment on column v_saldoa_changes.trcn is ''���������� ���������� �� ����� �� ����''';
          execute immediate 'comment on column v_saldoa_changes.action is ''��������: I,U,D''';
          execute immediate 'comment on column v_saldoa_changes.change_date is ''���� ���������''';
          execute immediate 'comment on column v_saldoa_changes.change_number is ''����� ���������''';
          execute immediate 'comment on column v_saldoa_changes.system_change_number is ''��������� ����� ���������''';
          -- ����� �� ������ �� �������������
          execute immediate 'grant select on v_saldoa_changes to refsync_usr';
        exception when others then
          if sqlcode = -1430 then bars.bars_audit.error(SQLERRM); else raise; end if;
        end;
    end if;

    -- ����� ��� ������ �� ��������� ������� � �����������
    execute immediate 'grant select on '||l_tabname||' to refsync_usr';

    execute immediate 'grant select on '||l_tabname||' to bars';

  end create_tmp_table;



  --------------------------------------------
  -- drop_tmp_table - ������� ��������� ������� ������������ ������
  --
  -- @p_table - ��� �������
  --
  procedure drop_tmp_table(p_table in varchar2) is
     l_tabname refsync_list.tabname%type;
     l_trace      varchar2(1000):= G_TRACE||'drop_tmp_table: ';
  begin

    bars.bars_audit.info(l_trace||'�������� ��������� ������� tmp_refsync*');

    -- �� ���� OPLDOK ���� ������ � ������ - ��� ������� �� �������
    if p_table = 'OPLDOK' or p_table = 'XML_DOCPAYED' then
       bars.bars_audit.info(l_trace||'��� ������ OPLDOK � XML_DOCPAYED �������� ��������� �� ����������');
       return;
    end if;

    l_tabname := 'tmp_refsync_'||p_table;

    -- ���� ��� ������� SALDOA, ������� �������������� �������������
    if p_table='SALDOA' then
        begin
          bars.bars_audit.info(l_trace||'�������� view v_saldoa_changes');
          execute immediate 'drop view v_saldoa_changes';
        exception when others then
          if sqlcode = -942 then bars.bars_audit.error(SQLERRM); else raise; end if;
        end;
    end if;

    -- ������� ���� ��������� �������
    begin
        bars.bars_audit.info(l_trace||'���������� ���������� '||'drop table '||l_tabname);
        execute immediate 'drop table '||l_tabname;
    exception when others then
        if sqlcode = -942 then
           bars.bars_audit.info(l_trace||'�� ��������� ��-�� ������: '||sqlerrm);
        else raise; end if;
    end;

  end drop_tmp_table;


  ---------------------------------------------------
  -- create_dynamic_stmt - ������� PL/SQL ���� ��� ��������� ������ ���������
  --
  ---------------------------------------------------
  function create_dynamic_stmt(p_table in varchar2) return varchar2 is
    l_stmt          varchar2(32767);
    l_put_comma     boolean;
  begin
    if bars.bars_audit.get_log_level()>=bars.bars_audit.LOG_LEVEL_TRACE then
        bars.bars_audit.trace('create_dynamic_stmt('||p_table||')');
    end if;

    l_stmt :=
    'declare' || chr(10) ||
    '   l_ret           number;' || chr(10) ||
    '   l_action        char(1);' || chr(10) ||
    '   l_value_type    varchar2(3);' || chr(10) ||
    'begin' || chr(10) ||
    '   if bars.bars_audit.get_log_level()>=bars.bars_audit.LOG_LEVEL_TRACE then' || chr(10) ||
    '       bars.bars_audit.trace(''apply lcr():''||chr(10)||substr(f_row_lcr_to_char(barsaq.bars_refsync.g_row_lcr),1,3900));' || chr(10) ||
    '   end if;' || chr(10) ||
    '   l_action := substr(barsaq.bars_refsync.g_row_lcr.get_command_type(),1,1);' || chr(10) ||
    '   if l_action=''D'' then ' || chr(10) ||
    '       l_value_type := ''OLD'';' || chr(10) ||
    '   else' || chr(10) ||
    '       l_value_type := ''NEW'';' || chr(10) ||
    '   end if;' || chr(10) ||
    '   insert into TMP_REFSYNC_'||p_table||'('||get_table_fields(G_AQ_SCHEMA,'TMP_REFSYNC_'||p_table)||')'|| chr(10) ||
    '   values('|| chr(10);
    l_put_comma := false;
    for c in (select column_name, data_type from dba_tab_columns
              where owner=G_AQ_SCHEMA and table_name='TMP_REFSYNC_'||p_table order by column_id
              )
    loop
        if l_put_comma then
            l_stmt := l_stmt || ',' ||chr(10);
        else
            l_put_comma := true;
        end if;
        if    c.column_name='ACTION' then
            l_stmt := l_stmt || 'l_action';
        elsif c.column_name='CHANGE_DATE' then
            l_stmt := l_stmt || 'barsaq.bars_refsync.g_que_msg_prop.enqueue_time';
        elsif c.column_name='CHANGE_NUMBER' then
            l_stmt := l_stmt || 's_tmp_refsync.nextval';
        elsif c.column_name='SYSTEM_CHANGE_NUMBER' then
            l_stmt := l_stmt || 'barsaq.bars_refsync.g_row_lcr.get_scn()';
        else
            l_stmt := l_stmt || 'barsaq.bars_refsync.g_row_lcr.get_value(l_value_type,'''||c.column_name||''').access'||c.data_type||'()';
        end if;
    end loop;
    l_stmt := l_stmt || ');' || chr(10) ||
    'end;';
    if bars.bars_audit.get_log_level()>=bars.bars_audit.LOG_LEVEL_TRACE then
        bars.bars_audit.trace('create_dynamic_stmt: '||chr(10)||substr(l_stmt,1,3900));
    end if;
    return l_stmt;
  end create_dynamic_stmt;



  --------------------------------
  --  CREATE_CAPTURE_RULE
  --
  --  ������� ������� ��� ������� ��������� �� �������
  --
  --
  procedure create_capture_rule(p_table in varchar2) is
    l_evaluation_context    varchar2(61);
    l_user_procedure        varchar2(92);
    l_add_stmt              varchar2(4000);
  begin
    l_evaluation_context := 'SYS.STREAMS$_EVALUATION_CONTEXT';

    bars_audit.info('����� ��������� �dd_supplemental_logging');
    -- �������� supplemental_logging
    bars.bars_alien_privs.add_supplemental_logging(p_table);
    bars_audit.info('����� ��������� ');

    -- ������������� ������� SCN ��� ��������������� �������
    dbms_apply_adm.set_table_instantiation_scn(
        source_object_name      => G_SOURCE_SCHEMA||'.'||p_table,
        --source_database_name    => substr(g_database_name,1,instr(g_database_name, '.')-1),
        source_database_name    => g_database_name,
        instantiation_scn       => dbms_flashback.get_system_change_number);

    -- ������������� ����������� ��� INSERT,UPDATE,DELETE
    l_user_procedure := 'barsaq.bars_refsync.dml_handler';
    -- insert
    dbms_apply_adm.set_dml_handler(
        object_name         => G_SOURCE_SCHEMA||'.'||p_table,
        object_type         => 'TABLE',
        operation_name      => 'INSERT',
        error_handler       => false,
        user_procedure      => l_user_procedure,
        apply_database_link => NULL,
        apply_name          => 'BARS_APPLY');
    -- update
    dbms_apply_adm.set_dml_handler(
        object_name         => G_SOURCE_SCHEMA||'.'||p_table,
        object_type         => 'TABLE',
        operation_name      => 'UPDATE',
        error_handler       => false,
        user_procedure      => l_user_procedure,
        apply_database_link => NULL,
        apply_name          => 'BARS_APPLY');
    -- delete
    dbms_apply_adm.set_dml_handler(
        object_name         => G_SOURCE_SCHEMA||'.'||p_table,
        object_type         => 'TABLE',
        operation_name      => 'DELETE',
        error_handler       => false,
        user_procedure      => l_user_procedure,
        apply_database_link => NULL,
        apply_name          => 'BARS_APPLY');

    if p_table in ('SALDOA','SALDOA2') then
        l_add_stmt :=
           ' :dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''), ''ACC'') is not null'
         ||' and barsaq.bars_refsync.subscr_acc(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ACC'').AccessNumber()) = 1'
                    --||' and exists (select acc from barsaq.aq_subscribers_acc where acc = :dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ACC'').AccessNumber() )'
                    --||' and barsaq.f_trace(''f_trace:''||chr(10)||substr(barsaq.f_row_lcr_to_char(:dml),1,3900))=1'
                    ;
    elsif p_table in ('ACCOUNTS') then
        l_add_stmt := ' :dml.get_command_type() = ''INSERT'' ';


    elsif p_table in ('OPLDOK') then
        l_add_stmt := ' :dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''), ''ACC'') is not null'
                    ||' and ( (:dml.get_command_type() = ''UPDATE''  and  :dml.get_value(''NEW'', ''SOS'').AccessNumber() = 5) '
                    ||'        or '
                    ||'       (:dml.get_command_type() = ''DELETE'') '
                    ||'     ) '
                    ||' and barsaq.bars_refsync.subscr_acc(:dml.get_value(decode(:dml.get_command_type(),''DELETE'',''OLD'',''NEW''),''ACC'').AccessNumber() ) = 1 '
                    ;

    elsif p_table in ('XML_DOCPAYED') then
        l_add_stmt := ' :dml.get_command_type() = ''INSERT'' '
                    ;
    else
        l_add_stmt := null;
    end if;


    --
    -- ������� ������� ��� ������� ��������� �������
    --

    -- ������ 9
    if dbms_db_version.ver_le_9_1 = true or
       dbms_db_version.ver_le_9_2 = true or
       dbms_db_version.ver_le_9     then


       if l_add_stmt is not null then
          l_add_stmt := ' and '||l_add_stmt;
       end if;

       dbms_rule_adm.create_rule(
          rule_name           => substr('RULE_BARS_'||p_table,1,30),
          condition           => '('
                                  ||':dml.get_object_name() = '''||p_table||''' and :dml.get_object_owner() = '''||G_SOURCE_SCHEMA||''''
                                  ||' and :dml.is_null_tag() = ''Y'' and :dml.get_source_database_name() = '''||g_database_name||''''
                                  ||l_add_stmt
                                  ||')',
          evaluation_context  => l_evaluation_context,
          action_context      => NULL,
          rule_comment        => 'This is rule for capturing changes of '||G_SOURCE_SCHEMA||'.'||p_table||' table'
       );
       -- �������� ������� � �����
       dbms_rule_adm.add_rule(
          rule_name           => substr('RULE_BARS_'||p_table,1,30),
          rule_set_name       => 'RULE_SET_BARS_CAPTURE',
          evaluation_context  => l_evaluation_context,
          rule_comment        => 'This is rule for capturing changes of '||G_SOURCE_SCHEMA||'.'||p_table||' table'
       );

    -- ������ 10
    else
       begin
          DBMS_STREAMS_ADM.ADD_TABLE_RULES(
          table_name     => G_SOURCE_SCHEMA||'.'||p_table,
          streams_type   => 'capture',
          streams_name   => 'bars_capture',
          include_ddl    => FALSE,
          and_condition  => l_add_stmt);
       end;

   end if;



  end create_capture_rule;


  -------------------------------------------
  --  DROP_RULE
  --
  --  ������� �������
  --
  --
  procedure drop_rule(p_rulename varchar2)
  is
     l_evaluation_context    varchar2(61);
     l_trace                 varchar2(1000):= G_TRACE||'drop_rule: ';
  begin
     -- ������� ������� �� ������
     bars.bars_audit.info(l_trace||'������� ������� '||p_rulename);

     begin
        dbms_rule_adm.remove_rule(
            rule_name           => p_rulename,
            rule_set_name       => 'RULE_SET_BARS_CAPTURE',
            evaluation_context  => l_evaluation_context
        );
     exception when others then
        -- ORA-24147: rule BARSAQ.RULE_BARS_<p_table> does not exist
        --    -24155 rule BARSAQ.RULE_BARS_<p_table> not in rule set BARSAQ.RULE_SET_BARS_CAPTURE
        if sqlcode in (-24147, -24155)  then bars.bars_audit.error(SQLERRM); else raise; end if;
     end;

     -- ������� ���� �������
     begin
         dbms_rule_adm.drop_rule(
            rule_name  => p_rulename,
            force      => true
         );

     exception when others then
        -- ORA-24147: rule BARSAQ.RULE_BARS_<p_table> does not exist
        if sqlcode=-24147 then bars.bars_audit.error(SQLERRM); else raise; end if;
     end;

  end;



  -------------------------------------------
  --  DROP_CAPTURE_RULE
  --
  --  ������� ������� ��� ������� ��������� �� �������
  --
  --
  procedure drop_capture_rule(p_table in varchar2) is
     l_trace                 varchar2(1000):= G_TRACE||'drop_capture_rule: ';
  begin

     bars.bars_audit.info(l_trace||'������� ������� ������� ��� capture ');
     -- ������ 9
     if dbms_db_version.ver_le_9_1 = true or
        dbms_db_version.ver_le_9_2 = true or
        dbms_db_version.ver_le_9     then

        -- ������� ������� ������� �� ������
        drop_rule(substr('RULE_BARS_'||p_table,1,30));

     -- ������ 10 � ����
     else
        for c in (select  r.rule_name
                  from  dba_rule_set_rules rs, dba_rules r
                  where rule_set_owner='BARSAQ'
                    and r.rule_name = rs.rule_name
                    and rule_set_name = 'RULE_SET_BARS_CAPTURE'
                    and substr(r.rule_name, 1, length(p_table)) = p_table )
        loop
           drop_rule(c.rule_name);
        end loop;
     end if;




    -------
    -- ������� ����������� ��� INSERT,UPDATE,DELETE
    --
    -- insert

    bars.bars_audit.info(l_trace||'������� dml handler-�� ��� apply ��������');

    dbms_apply_adm.set_dml_handler(
        object_name         => G_SOURCE_SCHEMA||'.'||p_table,
        object_type         => 'TABLE',
        operation_name      => 'INSERT',
        error_handler       => false,
        user_procedure      => NULL
    );
    -- update
    dbms_apply_adm.set_dml_handler(
        object_name         => G_SOURCE_SCHEMA||'.'||p_table,
        object_type         => 'TABLE',
        operation_name      => 'UPDATE',
        error_handler       => false,
        user_procedure      => NULL
    );
    -- delete
    dbms_apply_adm.set_dml_handler(
        object_name         => G_SOURCE_SCHEMA||'.'||p_table,
        object_type         => 'TABLE',
        operation_name      => 'DELETE',
        error_handler       => false,
        user_procedure      => NULL
    );
    -- ������� supplemental log group

    bars.bars_audit.info(l_trace||'������� ��� ������');
    bars.bars_alien_privs.drop_supplemental_logging(p_table);

  end drop_capture_rule;





  ----------------------------------------------------------------------
  -- public members
  ----------------------------------------------------------------------



  -----------------------------------------
  --  ADD_TABLE
  --
  --  ��������� ������� � ������ ������ ��� �������������
  --
  --  @p_table - ��� �������
  --
  procedure add_table(p_table in varchar2) is
    l_tabname       refsync_list.tabname%type;
    l_table         varchar2(30);
    l_cnt           number;
  begin

    l_table := upper(p_table);

    if l_table not in ('SALDOA','OPLDOK') then
        execute immediate
        'begin '||G_SOURCE_SCHEMA||'.bars_alien_privs.grant_refsync_privs(user,'''||l_table||'''); '||'end;';
    end if;


    -- �������� ����������� � ������� ����� ���������������� �����
    begin
        select 1 into l_cnt
        from all_tab_columns
        where table_name = l_table
          and owner = G_SOURCE_SCHEMA
          and data_type in ('CLOB', 'BLOB','BFILE')
          and rownum=1;
        -- ����� ������ ����� ������, ����������� ������
        bars.bars_error.raise_error(G_MODULE_NAME, 18006,l_table);
    exception when no_data_found then
        null;  -- Ok
    end;


    -- �������� ������������� ������� � �����
    execute immediate 'select * from '||G_SOURCE_SCHEMA||'.'||l_table||' where 0=1';



    -- �������� ������������� ������� � ������
    begin
      select tabname into l_tabname from refsync_list where tabname = l_table;
      --������� %s ��� ��������� � ������ ������ ��� �������������
      bars.bars_error.raise_error(G_MODULE_NAME, 18004, l_table);
    exception when no_data_found then
      null;
    end;


    -- ������� ������� ��� ������� ���������
    create_capture_rule(l_table);


    if l_table not in ('SALDOA','OPLDOK') then
        -- ������� private synonym � ������ ��� � ����
        execute immediate 'create or replace synonym  '||l_table||' for '||G_SOURCE_SCHEMA||'.'||l_table;
        -- ����� ��� ������ ��������
        execute immediate 'grant select on '||l_table||' to refsync_usr';

        -- ����� ��� ���������� � ������ � execute immediate
        execute immediate 'grant select on '||l_table||' to bars';

    end if;


    -- ������� ��������� �������(��� �� ������ ����)
    create_tmp_table(l_table);


    -- ��������� ��� �������
    insert into refsync_list(tabname) values (l_table);

    commit;

    -- �������������� ����� BARS
    bars.bars_alien_privs.recompile_schema;

    -- �������������� ����� BARSAQ
    bars_audit.info('����������� �������������� ����� BARSAQ');
    sys.utl_recomp.recomp_serial('BARSAQ');
    select count(*) into l_cnt from user_objects where status='INVALID';
    bars_audit.info('�������������� ����� BARSAQ ���������. ���-�� ���������� ��������: '||l_cnt);

    bars.bars_audit.info('bars_refsync: � ������ ���������������� ��������� ����� ������� �������:'||l_table);

  end;

  ----
  -- recreate_table - ����������� �������������� ��� �������
  --
  -- @p_table - ��� �������
  --
  procedure recreate_table(p_table in varchar2) is
  begin
    remove_table(p_table);
    add_table(p_table);
    bars.bars_audit.info('bars_refsync: � ������ ���������������� ����������� ������� �������:'||p_table);
  end;



  ----------------------------
  --  REMOVE_TABLE
  --
  --  ������� ������� �� ������ ���������������� ������
  --
  -- @p_table - ��� �������
  --
  procedure remove_table(p_table in varchar2) is
     l_table  varchar2(30);
     l_cnt    number;
     l_trace  varchar2(1000) := G_TRACE||'remove_table: ';
  begin

    l_table := upper(p_table);

    -- ������� ������
    delete from refsync_list where tabname=l_table;

    if sql%rowcount=0 then
        bars.bars_audit.info(l_trace||'������� ������� '||l_table||' �� ������� � ������ ����������������');
    else
        bars.bars_audit.info(l_trace||'�� ������ ���������������� ������� ������� �������:'||l_table);
    end if;

    commit;

    -- ������� ������� ��� ������� ���������
    bars.bars_audit.info(l_trace||'�������� ������ ������� ��������� ��� capture');
    drop_capture_rule(l_table);


    if l_table not in ('SALDOA','OPLDOK') then
        -- ������ ����� �� ����
        bars.bars_audit.info(l_trace||'�������� ������� �� ���� refsync_usr: '||'revoke select on bars.'||l_table||' from refsync_usr');
        begin
            execute immediate 'revoke select on bars.'||l_table||' from refsync_usr';
        exception when others then
            if sqlcode in (-942,-1927) then
               bars.bars_audit.error(l_trace||'�� ������� �� ������� ������: '||sqlerrm);
            else raise; end if;
        end;
        -- ������� ��������� �������
        bars.bars_audit.info(l_trace||'�������� ��������: '||'drop synonym '||l_table);
        begin
            execute immediate 'drop synonym '||l_table;
        exception when others then
            if sqlcode = -1434 then
               bars.bars_audit.error(l_trace||'�� ������� �� ������� ������: '||sqlerrm);
            else raise; end if;
        end;
    end if;

    -- ������� ��������� �������
    bars_audit.info(l_trace||'�������� ��������� ������� ��� '||l_table);
    drop_tmp_table(l_table);

    -- ������ ����� �� �������� �������
    bars_audit.info(l_trace||'�������� ���� �� �������� ������ '||l_table);
    if l_table not in ('SALDOA','OPLDOK') then
        execute immediate 'begin '||G_SOURCE_SCHEMA||'.bars_alien_privs.revoke_refsync_privs(user,'''||l_table||'''); '||'end;';
    end if;

    -- �������������� ����� BARSAQ
    bars_audit.info(l_trace||'����������� �������������� ����� BARSAQ');
    sys.utl_recomp.recomp_serial('BARSAQ');

    select count(*) into l_cnt from user_objects where status='INVALID';
    bars_audit.info(l_trace||'�������������� ����� BARSAQ ���������. ���-�� ���������� ��������: '||l_cnt);

  end;


  -------------------------------------------
  --  ADD_SUBSCRIBER
  --
  --  ��������� ������ ���������� �� ���������� �� ����������
  --
  -- @p_name         - ���������� ��� (� ������ �������)
  -- @p_table_list   - ������ ������ ����� �������, ������ ��� � ��������: 'BANKS','SW_BANKS','CUR_RATES'
  -- @p_description  - �������
  --
  procedure add_subscriber(
                  p_name         in varchar2,
                  p_table_list   in varchar2  default null,
                  p_description  in varchar2  default null)
  is
     l_name      varchar2(30);
     subscriber  sys.aq$_agent;
  begin

    l_name := upper(p_name);

    -- ������ ���� ������������ ��� ������ ����������
    execute immediate 'grant refsync_usr to '||l_name;

    -- �������� � ������ �����������
    begin
        insert into aq_subscribers(name, description)
        values(p_name, nvl(p_description,p_name));
    exception when dup_val_on_index then null;
    end;

    -- ������� ������
    dbms_aqadm.create_aq_agent(agent_name => l_name);

    -- ���������
    subscriber := sys.aq$_agent (l_name, null, null);

    -- �������� ����������
    dbms_aqadm.add_subscriber(
      queue_name  => 'barsaq.aq_refsync',
      subscriber  => subscriber,
      rule        => case
                     when p_table_list is null then null
                     else 'barsaq.is_suitable_lcr(tab.user_data,'''||replace(p_table_list,'''','''''')||''')=1'
                     end
    );

    -- ����������� ������������ � �������
    dbms_aqadm.enable_db_access(
      agent_name  => l_name,
      db_username => l_name
    );

    bars.bars_audit.info('bars_refsync: �������� ����� ���������:'||upper(p_name));

  end;






  -----
  -- alter_subscriber - ������������ ���������� �� ���������� �� ����������
  --
  -- @p_name - ���������� ��� (� ������ �������)
  -- @p_table_list - ������ ������ ����� �������, ������ ��� � ��������: 'BANKS','SW_BANKS','CUR_RATES'
  --
  procedure alter_subscriber(p_name in varchar2, p_table_list in varchar2 default null) is
    subscriber  sys.aq$_agent;
  begin

    -- ���������
    subscriber := sys.aq$_agent (upper(p_name), null, null);

    -- �������� ����������
    dbms_aqadm.alter_subscriber(
      queue_name  => 'barsaq.aq_refsync',
      subscriber  =>  subscriber,
      rule        => case
                     when p_table_list is null then null
                     else 'barsaq.is_suitable_lcr(tab.user_data,'''||replace(p_table_list,'''','''''')||''')=1'
                     end
    );

    bars.bars_audit.info('bars_refsync: ������������� ���������:'||upper(p_name));
  end;








  ----------------------------------------------
  --  ADD_REF_TO_SUBSCRIBER
  --
  --  ��������� ���������� � ������ ���������������� ��� ����������
  --
  --
  procedure add_ref_to_subscriber(
                  p_username  varchar2,
                  p_refname   varchar2)
  is
     l_existlist  varchar2(1000);
     l_reflist    varchar2(1000);
     l_trace      varchar2(1000):= G_TRACE||'add_ref_to_subscriber: ';
  begin

     -- ���������� �� ����. � ������ ����������������
     begin
        select tabname
        into l_reflist
        from refsync_list
        where tabname  = upper(p_refname);
        l_reflist := '';
    exception when no_data_found then
       bars.bars_error.raise_error(G_MODULE_NAME, 18008, p_refname);
    end;



    -- ���������� �� ����. � ��� ����������� ��� ������� ������������
    begin
       select t.table_name
       into l_reflist
       from (table(refsync_rule_tables)) t
       where t.user_name = upper(p_username) and t.table_name = upper(p_refname);

       bars.bars_audit.info(l_trace||'������� '||p_refname||' ��� ��������� ��� '||p_username);
       return;

    exception when no_data_found then null;
    end;



    begin
        select unique substr(to_char(t.rule_name),1,1000)
        into l_reflist
        from (table(refsync_rule_tables)) t
        where t.user_name = upper(p_username);

        l_reflist := get_reflist_from_rule(l_reflist);
        l_reflist := l_reflist||',';
    exception when no_data_found then null;
    end;


    dbms_output.put_line(l_trace||'������ ������:'||l_reflist);
    l_reflist := l_reflist||''''||p_refname||'''';

    alter_subscriber(p_username, l_reflist);
    dbms_output.put_line(l_trace||'����� ������:'||l_reflist);

  end;




  ----------------------------------------------
  --  REMOVE_REF_FROM_SUBSCRIBER
  --
  --  ������� ���������� �� ������ ���������������� ��� ����������
  --
  --
  procedure remove_ref_from_subscriber(
                  p_username  varchar2,
                  p_refname   varchar2)
  is
     l_existlist  varchar2(1000);
     l_reflist    varchar2(1000);
     l_strtpos    number;
     l_stoppos    number;
     l_trace      varchar2(1000):= G_TRACE||'remove_ref_from_subscriber: ';
  begin

     -- ���������� �� ����. � ������ ����������������
     begin
        select tabname
        into l_reflist
        from refsync_list
        where tabname  = upper(p_refname);

     exception when no_data_found then
        return;
     end;



     begin
        select t.table_name
        into l_reflist
        from (table(refsync_rule_tables)) t
        where t.user_name = upper(p_username) and t.table_name = upper(p_refname);

     exception when no_data_found then
        bars.bars_audit.info(l_trace||'������� '||p_refname||' �� ��������� ��� '||p_username);
        return;
     end;



     l_reflist := '';
     for c in (select t.table_name
               from (table(refsync_rule_tables)) t
               where t.user_name = upper(p_username) ) loop


           if c.table_name<>p_refname then
              if length(l_reflist) > 1 then
                 l_reflist := l_reflist||',';
              end if;

              l_reflist := l_reflist||''''||c.table_name||'''';
           end if;


     end loop;

     dbms_output.put_line(l_trace||'����� ������:'||l_reflist);

     alter_subscriber(p_username, l_reflist);

  end;



  ----------------------------------------------
  -- REMOVE_SUBSCRIBER
  --
  -- ������� ���������� �� ���������� �� ����������
  --
  -- @p_name - ���������� ��� ����������(� ������ �������)
  --
  procedure remove_subscriber(p_name in varchar2) is
     l_name      varchar2(30);
     subscriber  sys.aq$_agent;
     l_trace     varchar2(1000) := G_TRACE||'remove_subscriber: ';
  begin

    bars.bars_audit.info(l_trace||'�������� ���������� '||p_name);
    l_name := upper(p_name);

    -- ���������
    subscriber := sys.aq$_agent (l_name, null, null);

    begin
       -- ������� ����������
       dbms_aqadm.remove_subscriber(
         queue_name  => 'barsaq.aq_refsync',
         subscriber  =>  subscriber);
         bars.bars_audit.info(l_trace||'������ �� ����������� ������� aq_refsync');
    exception when others then
        case
          when sqlcode=-24035 then
                bars.bars_audit.info(l_trace||'������������ �� �������� �� ������� aq_refsync');
          when sqlcode=-24010 then
                bars.bars_audit.info(l_trace||'������� barsaq.aq_refsync - �� ����������');
          else
              raise;
        end case;
    end;


    begin
        -- ��������� ������ ������
       dbms_aqadm.disable_db_access(
         agent_name  => l_name,
         db_username => l_name);
    exception when others then
        if sqlcode=-24088 then
           bars.bars_audit.info(l_trace||'������������ �� �������� AQ �������');
           null; --: AQ Agent <...> does not exist
        else raise;
        end if;
    end;



    -- ������� ������
    begin
       dbms_aqadm.drop_aq_agent(
           agent_name => l_name
       );
    exception when others then
        if sqlcode=-24088 then
           bars.bars_audit.info(l_trace||'������������ �� �������� AQ �������');
           null; --: AQ Agent <...> does not exist
        else raise;
        end if;
    end;


    -- ������� ���� ������������ ��� ������ ����������
    begin
       execute immediate 'revoke refsync_usr from '||l_name;
    exception when others then
        if sqlcode=-01951  then -- : ROLE 'REFSYNC_USR' not granted to <..>
           bars.bars_audit.info(l_trace||'���� REFSYNC_USR �� ���� ������');
           null;
        else raise;
        end if;
    end;

    -- ��������
    begin
       -- �������� ���������� ������ aq_subscribers_acc
       delete from aq_subscribers_acc where name = l_name;
       delete from aq_subscribers where name = p_name;
    end;

 bars.bars_audit.info(l_trace||'��������� ������');

  exception when others then
     bars.bars_audit.error(l_trace||'������: '||sqlerrm);
     raise;
  end;



  ------------------------------------------
  -- PROC_OPLDOK_CHANGES
  --
  -- ��������� ��������� �� ���������
  --
  procedure proc_opldok_changes is
    type t_aka_opldok is record (
        action  char(1),
        ref     number,
        stmt    number,
        tt      char(3),
        dk      number,
        acc     number,
        fdat    date,
        s       number,
        sq      number,
        txt     varchar2(70),
        sos     number,
        scn     number
    );
    l_opl_other   bars.opldok%rowtype;
    l_tmp         number;
    l_oper        bars.oper%rowtype;
    l_acc         bars.accounts%rowtype;
    l_acc_other   bars.accounts%rowtype;
    l_cust        bars.customer%rowtype;
    l_cust_other  bars.customer%rowtype;
    c             sys_refcursor;
    l_opl         t_aka_opldok;
    l_opl_prev    t_aka_opldok;
    l_has_opldok  boolean;
    l_nazn        varchar2(160);
  begin
    if bars.bars_audit.get_log_level()>=bars.bars_audit.LOG_LEVEL_TRACE then
        bars.bars_audit.trace('������ ��������� ��������');
    end if;
    l_opl       := null;
    l_opl_prev  := null;
    l_oper      := null;
    open c for 'select action,ref,stmt,tt,dk,acc,fdat,s,sq,txt,sos, system_change_number from barsaq.tmp_refsync_opldok order by ref, action desc, stmt, s, txt';
    while true loop
        fetch c into l_opl;
        exit when c%notfound;

        bars_audit.trace('dual: ------ acc = '||l_opl.acc);
        bars_audit.trace('dual: l_opl_prev.ref='||l_opl_prev.ref||'  l_opl.ref='||l_opl.ref||' l_opl_prev.stmt='||l_opl_prev.stmt||'  l_opl.stmt='||l_opl.stmt||' sos='||l_opl.sos||' action='||l_opl.action||' acc='||l_opl.acc);

        if l_opl_prev.ref is not null and l_opl_prev.ref=l_opl.ref and l_opl_prev.stmt=l_opl.stmt then
            -- ���������� �������� ��������, ���� ������ ������������ ������ �� �����
            null;
        else
            --l_opl.sos < 5 -  ���� ������ �������� ����� ������������� ������� xml_docpayed
            --���� action='D' - �� ����� �������..  � ������ ����� ���������� ������ �� sos
            if l_opl.action='D' or l_opl.sos < 5 then
                bars_audit.trace('dual: ������ �������� ���= '||l_opl.ref);
                -- �������������� ��������, ����� ������ ��������������
                insert into tmp_dual_opldok(action, ref, stmt, system_cn)
                values('D',  l_opl.ref, l_opl.stmt, l_opl.scn);
            else
                -- ������ ������ �� ������� OPER

                if l_oper.ref is null or l_oper.ref<>l_opl.ref then

                    select * into l_oper from bars.oper where ref=l_opl.ref;
                    bars_audit.trace('dual: ������ ������ �� ������� OPER');
                end if;
                if l_oper.tt=l_opl.tt and l_oper.s is not null and l_oper.kv is not null
                   and l_oper.mfoa is not null and l_oper.mfob is not null
                   and l_oper.nlsa is not null and l_oper.nlsb is not null
                   and l_oper.kv = l_oper.kv2
                   and l_opl.txt not like '������ %'
                then
                    -- ��� ������� � ������������ �������� � ��������� ��������� => ����� ������ �� OPER'a
                    bars_audit.trace('dual: ��� ������� � ������������ �������� �������� l_oper.nd = '||l_oper.nd||' l_oper.vob='||l_oper.vob);
                    insert into tmp_dual_opldok(
                          action, ref, stmt, fdat, tt, s, kv, sq, pdat, vdat, datd, datp, nd,
                          dk, vob, branch, system_cn,
                          mfo_a, nls_a, id_a, name_a, mfo_b, nls_b, id_b, name_b, narrative)
                    values(l_opl.action, l_opl.ref, l_opl.stmt, l_opl.fdat,
                          l_oper.tt, l_oper.s, l_oper.kv, l_oper.sq, l_oper.pdat, l_oper.vdat,
                          l_oper.datd, l_oper.datp,
                          l_oper.nd, l_oper.dk, l_oper.vob, l_oper.branch, l_opl.scn ,l_oper.mfoa, l_oper.nlsa, l_oper.id_a, l_oper.nam_a,
                          l_oper.mfob, l_oper.nlsb, l_oper.id_b, l_oper.nam_b, l_oper.nazn);
                else
                    -- �������� (��� �������������) => ������ ������ �������� ��������
                    --bars_audit.trace('dual: ��� �������� ��������');

                    begin
                        select * into l_opl_other from bars.opldok where ref=l_opl.ref and stmt=l_opl.stmt and tt=l_opl.tt and dk=1-l_opl.dk
                        -- �������������� ������� ��� "�������" �����
                        and s=l_opl.s and txt=l_opl.txt and rownum=1;
                        l_has_opldok := true;
                        --bars_audit.trace('dual: l_has_opldok := true');
                    exception when no_data_found then
                        -- ������ � OPLDOK �� �����, ������ �� ��� ������ �������
                        l_has_opldok := false;
                        --bars_audit.trace('dual: l_has_opldok := false');
                    end;
                    if l_has_opldok then

                        -- ������� �� �������������
                        if  l_oper.kv <> l_oper.kv2 and l_oper.tt=l_opl.tt then
                            l_nazn := l_oper.nazn;
                        else
                            l_nazn := l_opl.txt;
                        end if;

                        -- ������ ������������ ������
                       -- bars_audit.trace('dual: l_has_opldok := true -- ������ ������������ ������ ');
                        select * into l_acc        from bars.accounts where acc=l_opl.acc;
                        select * into l_acc_other  from bars.accounts where acc=l_opl_other.acc;
                        -- ������ ���������� �� ��������
                        select * into l_cust       from  bars.customer where rnk=l_acc.rnk;
                        select * into l_cust_other from  bars.customer where rnk=l_acc_other.rnk;
                        if l_opl.dk=0 then
                            insert into tmp_dual_opldok(
                                action, ref, stmt, fdat, tt, s, kv, sq, pdat, vdat, datd, datp, nd, dk, vob,  branch, system_cn,
                                mfo_a, mfo_b,
                                nls_a, id_a, name_a,  nls_b, id_b, name_b, narrative)
                            values(l_opl.action, l_opl.ref, l_opl.stmt, l_opl.fdat, l_opl.tt, l_opl.s, l_acc.kv, l_opl.sq,
                                l_oper.pdat, l_oper.vdat, l_oper.datd, l_oper.datp, l_oper.nd, 1, l_oper.vob,l_oper.branch, l_opl.scn,
                                bars.f_ourmfo_g, bars.f_ourmfo_g,
                                l_acc.nls, l_cust.okpo, substr(l_acc.nms,1,38),
                                l_acc_other.nls, l_cust_other.okpo, substr(l_acc_other.nms,1,38),
                                l_nazn);
                        else
                            insert into tmp_dual_opldok(
                                action, ref, stmt, fdat, tt, s, kv, sq, pdat, vdat, datd, datp, nd, dk,  vob,  branch, system_cn,
                                mfo_a, mfo_b, nls_a, id_a, name_a,  nls_b, id_b, name_b, narrative)
                            values(l_opl.action, l_opl.ref, l_opl.stmt, l_opl.fdat, l_opl.tt, l_opl.s, l_acc.kv, l_opl.sq,
                                l_oper.pdat, l_oper.vdat, l_oper.datd, l_oper.datp, l_oper.nd, 1, l_oper.vob,l_oper.branch, l_opl.scn,
                                bars.f_ourmfo_g, bars.f_ourmfo_g,
                                l_acc_other.nls, l_cust_other.okpo, substr(l_acc_other.nms,1,38),
                                l_acc.nls, l_cust.okpo, substr(l_acc.nms,1,38),
                                l_nazn);
                        end if;
                    end if;
                end if;
            end if;
        end if;
        l_opl_prev := l_opl;
    end loop;
    close c;
    if bars.bars_audit.get_log_level()>=bars.bars_audit.LOG_LEVEL_TRACE then
        bars.bars_audit.trace('���������� ��������� ��������');
    end if;
  exception when others then
      bars_audit.error('dual: ������ ����������� ������� �� ���������� �������');
      bars_audit.error(sqlerrm);
      raise;
  end proc_opldok_changes;





  ----
  -- get_all_changed_data - �������������� ������ ��� ������������� �� ���� ��������
  --
  -- @p_subscriber - ��� ����������
  -- @p_message_grouping - ������ ����������� ���������
  --    0 - GROUP_ALL_TRANSACTIONS   - ��������� �� ���� �����������
  --    1 - GROUP_SINGLE_TRANSACTION - ��������� �� ����� ����������
  procedure get_all_changed_data(p_subscriber in varchar2,
                                 p_message_grouping in number default bars_refsync.GROUP_ALL_TRANSACTIONS)
  is
    -- type declaration
    type t_cursor_rec is record(m_cursor integer,m_stmt varchar2(32767));
    type t_cursor_tab is table of t_cursor_rec index by varchar2(30);
    -- variable declaration
    l_index             varchar2(30);
    l_cursor_tab        t_cursor_tab;
    l_que_msg_deq       sys.dbms_aq.dequeue_options_t;    -- ��������� ���������� �������
    l_que_msg_id        raw(16);                      -- ������������� ���������
    l_is_msg_exists     boolean  := true;             -- ������� ������� ���������
    l_que_msg           sys.anydata;
    l_table             varchar2(30);
    l_cursor            integer;
    l_needless          integer;
    l_res               number;
    l_stmt              varchar2(32767);
    no_messages         exception;
    end_of_group        exception;
    pragma exception_init (no_messages,  -25228);
    pragma exception_init (end_of_group, -25235);
  begin

    -- ������������� ��������� �������� ��������� �������
    l_que_msg_deq.wait          := sys.dbms_aq.no_wait;
    l_que_msg_deq.navigation    := sys.dbms_aq.first_message;
    l_que_msg_deq.dequeue_mode  := sys.dbms_aq.remove;
    l_que_msg_deq.consumer_name := p_subscriber;

    while (l_is_msg_exists)
    loop
        begin

          -- �������� ��������� �� �������
          l_que_msg_id                := null;
          sys.dbms_aq.dequeue(
            queue_name         => 'barsaq.aq_refsync',
            dequeue_options    => l_que_msg_deq,
            message_properties => g_que_msg_prop,
            payload            => g_tmp_data,
            msgid              => l_que_msg_id );

          -- ������� �� ��� ����������� ���������, ���� LCR �� ������, ������������
          if g_tmp_data.getTypeName()='SYS.LCR$_ROW_RECORD' then

            l_res   := g_tmp_data.getObject(g_row_lcr);
            l_table := g_row_lcr.get_object_name();

            bars.bars_audit.info('��������� ������� '||l_table);

            begin
              -- ���� ������ � ������� l_cursor_tab
              l_cursor := l_cursor_tab(l_table).m_cursor;
            exception when no_data_found then
              -- ������� ��������� ��� ������������ ��������� ������ ���������
              l_stmt   := create_dynamic_stmt(l_table);
              -- ������� ���������� �������
              l_cursor := dbms_sql.open_cursor;
              -- ������ ���������
              dbms_sql.parse(l_cursor, l_stmt, dbms_sql.native);
              -- ��������� ������������� ������� � ���� ���������
              l_cursor_tab(l_table).m_cursor    := l_cursor;
              l_cursor_tab(l_table).m_stmt      := l_stmt;
            end;

            -- ��������� ��������� ��� ��������� ������ ���������
            l_needless := dbms_sql.execute(l_cursor);

          end if;

          -- ������������� ��������� ����������� ��������� �������
          l_que_msg_deq.navigation   := sys.dbms_aq.next_message;

        exception
            when end_of_group then
                if    p_message_grouping = GROUP_ALL_TRANSACTIONS then
                    l_que_msg_deq.navigation := dbms_aq.next_transaction;
                elsif p_message_grouping = GROUP_SINGLE_TRANSACTION then
                    l_is_msg_exists := false;
                else
                    raise;
                end if;
            when no_messages  then l_is_msg_exists := false;
        end;
    end loop;
    -- ��������� �������
    l_index := l_cursor_tab.first;
    while l_index is not null loop
      dbms_sql.close_cursor(l_cursor_tab(l_index).m_cursor);
      insert into tmp_changed_tables(table_name) values(l_index);
      l_index := l_cursor_tab.next(l_index);
    end loop;
    bars.bars_audit.info('�� ������� �������� ��� ��������� ��� ���������� '||p_subscriber);

   -- ��� ��-����� - ��� ����������� ��������

  end get_all_changed_data;



  --------------------------------------
  -- show_subscribers
  -- ���������� c ������� DBMS_OUTPUT ������ �����������
  --
  --
  procedure show_subscribers  is
  begin
     null;
   /*  dbms_output.put_line(rpad('NAME',30)||' RULE');
    dbms_output.put_line('------------------------------ ----------------------------------------');
    for c in (select s.name, r.rule from aq$aq_refsync_tbl_s s, aq$aq_refsync_tbl_r r
              where s.queue=r.queue(+) and s.name=r.name(+)
              order by s.name)
    loop
      dbms_output.put_line(rpad(c.name,30)||' '||c.rule);
    end loop;
   */
  end;



  ---------------------------------------------------
  --  DML_HANDLER
  --
  --  ���������� dml: �������� LCR �� �������
  --  STREAMS_QUEUE � �������� � AQ_REFSYNC
  --
  --  @p_obj - �������� LCR
  --
  procedure dml_handler(p_obj in sys.anydata) is
    l_que_msg_enq   sys.dbms_aq.enqueue_options_t;      -- ����� ���������� � �������
    l_que_msg_prop  sys.dbms_aq.message_properties_t;   -- ����� ���������
    l_que_msg_id    raw(16);                            -- ������������� ��������� � �������
    --
    no_recipients_found    exception;
    pragma exception_init (no_recipients_found, -24033);
    --
    l_res           number;
    l_table         varchar2(30);
    l_lcr           sys.lcr$_row_record;
  begin
    if bars.bars_audit.get_log_level()>=bars.bars_audit.LOG_LEVEL_TRACE then
        null;
        --bars.bars_audit.trace('dml_handler():'||chr(10)||substr(f_lcr_to_char(p_obj),1,3900));
    end if;

    --bars.p_testlog('apply.dml_handler: post to barsaq.aq_refsync');

    begin
        l_que_msg_prop.sender_id := sys.aq$_agent (G_AQ_SCHEMA, null, null);
        dbms_aq.enqueue(
            queue_name         => 'barsaq.aq_refsync',
            enqueue_options    => l_que_msg_enq,
            message_properties => l_que_msg_prop,
            payload            => p_obj,
            msgid              => l_que_msg_id);
    exception when no_recipients_found then
        null;
        --bars.p_testlog('apply.dml_handler: no recipients');
        --bars.bars_audit.error('dml_handler(): ����������� ���������� �� ������:'||chr(10)||substr(f_lcr_to_char(p_obj),1,3900));
    end;

  end dml_handler;





begin
  -- Initialization
  init;
	end bars_refsync; 
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/bars_refsync.sql =========*** End 
 PROMPT ===================================================================================== 
 