
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_alien_privs.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ALIEN_PRIVS is

  -- Author  : OLEG
  -- Created : 07.08.2007 18:22:31
  -- Purpose : Динамическая выдача прав на свои объекты другим пользователям

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.03 03/10/2007';

  -- глобальные переменные
  G_TAG     varchar2(5);
  G_VAL     operw.value%type;
  G_S       oper.s%type;
  G_S2      oper.s2%type;
  G_KVA     oper.kv%type;
  G_KVB     oper.kv2%type;
  G_NLSA    oper.nlsa%type;
  G_NLSB    oper.nlsb%type;
  G_MFOA    oper.mfoa%type;
  G_MFOB    oper.mfob%type;
  G_TT      oper.tt%type;

  ----
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- recompile_schema - перекомпиляция схемы BARS
  --
  procedure recompile_schema;

  ----
  -- grant_refsync_privs - устанавливает все необходимые привилегии на свои объекты
  --   для модуля синхронизации справочников
  --
  -- @p_table - имя таблицы для синхронизации
  -- @p_user - имя пользователя ORACLE которому выдать права
  --
  procedure grant_refsync_privs(p_user in varchar2, p_table in varchar2);

  ----
  -- revoke_refsync_privs - отбирает привилегии на свои объекты
  --   у модуля синхронизации справочников
  --
  -- @p_table - имя таблицы для синхронизации
  -- @p_user - имя пользователя ORACLE которому выдать права
  --
  procedure revoke_refsync_privs(p_user in varchar2, p_table in varchar2);

  ----
  -- add_supplemental_logging - выполняет инструкцию
  -- "alter table <p_table> add supplemental log group log_group_<p_table>(field_list) always"
  -- и переключает текущий лог в архивный
  procedure add_supplemental_logging(p_table in varchar2);

  ----
  -- drop_supplemental_logging - выполняет инструкцию
  -- "alter table <p_table> drop supplemental log group log_group_<p_table>"
  --
  procedure drop_supplemental_logging(p_table in varchar2);

  ----
  -- check_op_field - выполныет динамическую проверку значения доп.реквизита
  --
  function check_op_field(
        p_tag   in char,
        p_val   in varchar2     default null,
        p_s     in number       default null,
        p_s2    in number       default null,
        p_kva   in varchar2     default null,
        p_kvb   in varchar2     default null,
        p_nlsa  in varchar2     default null,
        p_nlsb  in varchar2     default null,
        p_mfoa  in varchar2     default null,
        p_mfob  in varchar2     default null,
        p_tt    in char         default null
  ) return number;

end bars_alien_privs;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ALIEN_PRIVS is

  ----
  -- global consts
  --
  G_BODY_VERSION constant varchar2(64)  := 'version 1.07 20/06/2009';
  G_MODULE       constant varchar2(3)   := 'SYN';
  G_TRACE        constant varchar2(50)  := 'alien_privs.';

  ------------------------------------------
  -- global types
  ------------------------------------------

  type t_cursor_rec is record(m_cursor integer,m_stmt varchar2(32767));
  type t_cursor_tab is table of t_cursor_rec index by varchar2(5);

  g_cursor_tab    t_cursor_tab;


  ------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  ------------------------------------------
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION;
  end header_version;


  ------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  ------------------------------------------
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION;
  end body_version;



  ----------------------------------------------------
  -- ORA_VERSION
  --
  -- Получить версию оракла
  --
  ----------------------------------------------------
  function ora_version return varchar2
  is
     l_vers varchar2(5);
  begin

     select decode(instr(banner,'11.'),0,
                 decode(instr(banner,'10.'),0,
                      '9','10'),'11' )
     into l_vers
     from v$version
     where rownum = 1;
     bars_audit.info('версия oracle: <'||l_vers||'>');
     return l_vers;
  end;



  --------------------------------------------------
  -- recompile_schema - перекомпиляция схемы BARS
  --
  --------------------------------------------------
  procedure recompile_schema is
    l_cnt     number;
    l_trace   varchar2(1000) := G_TRACE||'recompile_schema:';
  begin
    -- перекомпиляция схемы BARS
    bars_audit.info(l_trace||'Выполняется перекомпиляция схемы BARS');
    sys.utl_recomp.recomp_serial('BARS');
    select count(*) into l_cnt from user_objects where status='INVALID';
    bars_audit.info(l_trace||'Перекомпиляция схемы BARS выполнена. Кол-во инвалидных объектов: '||l_cnt);
  end recompile_schema;




  --------------------------------------------------
  -- get_table_fields  - возвращает список полей таблицы через запятую
  --
  --------------------------------------------------
  function get_table_fields(p_table in varchar2) return varchar2 is
    l_fields varchar2(4000);
  begin
    select max( sys_connect_by_path(column_name, ',')) into l_fields
    from (
           select column_name, row_number() over (order by column_name) as num
           from user_tab_columns where table_name=p_table
         )
    connect by  prior num = num-1
    start with num = 1;
    return substr(l_fields, 2);
  end get_table_fields;




  --------------------------------------------------
  -- grant_refsync_privs - устанавливает все необходимые привилегии на свои объекты
  --   для модуля синхронизации справочников
  --
  -- @p_table - имя таблицы для синхронизации
  -- @p_user - имя пользователя ORACLE которому выдать права
  --
  --------------------------------------------------
  procedure grant_refsync_privs(p_user in varchar2, p_table in varchar2) is
     l_stmt  varchar2(4000);
     l_trace   varchar2(1000) := G_TRACE||'grant_refsync_privs:';
  begin
     l_stmt := 'grant select on '||p_table||' to '||p_user||' with grant option';
     execute immediate l_stmt;
     bars_audit.info(l_trace||'Выполнена инструкция: '||l_stmt);
  end grant_refsync_privs;




  --------------------------------------------------
  -- revoke_refsync_privs - устанавливает все необходимые привилегии на свои объекты
  --   для модуля синхронизации справочников
  --
  -- @p_table - имя таблицы для синхронизации
  -- @p_user - имя пользователя ORACLE которому выдать права
  --
  --------------------------------------------------
  procedure revoke_refsync_privs(p_user in varchar2, p_table in varchar2) is
     l_stmt    varchar2(4000);
     l_trace   varchar2(1000) := G_TRACE||'revoke_refsync_privs:';
  begin
     --l_stmt := 'revoke select on bars.'||p_table||' from '||p_user;
     --bars_audit.info(l_trace||'выполнение инструкции: '||l_stmt);
     --execute immediate l_stmt;
     null;
  exception when others then
     if sqlcode=-1927 then
        bars_audit.error(SQLERRM);
     else
        raise;
     end if;
  end revoke_refsync_privs;



  ------------------------------------------------
  --  ADD_SUPPLEMENTAL_LOGGING
  --
  --  выполняет инструкцию
  --   для 9i  "alter table <p_table> add supplemental log group log_group_<p_table>(field_list) always"
  --   для 10i "alter table <p_table> add supplemental log data (all) columns;
  --  и переключает текущий лог в архивный
  --
  ------------------------------------------------
  procedure add_supplemental_logging(p_table in varchar2) is
     l_stmt  varchar2(4000);
  begin


     -- включить supplemental logging для всех полей таблицы
     -- 10g
     if ora_version in ('10','11') then
        l_stmt := 'alter table '||p_table||' add supplemental log data (all) columns';
     -- 9i
     else
        l_stmt := 'alter table '||p_table||' add supplemental log group '||substr('LOG_GROUP_'||p_table,1,30)
                  ||'('||get_table_fields(p_table)||') always';
     end if;

     bars_audit.info('Перед выполнением инструкции: '||l_stmt);

     begin
        execute immediate l_stmt;
     exception when OTHERS then
        if sqlcode=-32588 then  null;  --supplemental logging attribute all column exists
        end if;
     end;


      -- сделать текущий redo-лог архивным, чтобы изменения по supplemental logging вступили в силу
      l_stmt := 'alter system archive log current';
      execute immediate l_stmt;
      bars_audit.info('Выполнена инструкция: '||l_stmt);
      recompile_schema;

  exception when others then
      if sqlcode=-30567 then
        bars_audit.error('LOG_GROUP_'||p_table||': '||SQLERRM);
      else raise;
      end if;

  end add_supplemental_logging;



  -----------------------------------
  --  ADD_LST
  --
  --
  --
  function add_lst(p_dest varchar2, p_src varchar2) return varchar2
  is
  begin
     if length(p_dest)>0 then
        return  p_dest||','||p_src;
     else
        return p_src;
     end if;

  end;



  -----------------------------------------------
  --  DROP_SULEMENTAL_LOGGING()
  --
  --   выполняет инструкцию
  --   "alter table <p_table> drop supplemental log group log_group_<p_table>"
  --
  -----------------------------------------------
  procedure drop_supplemental_logging(p_table in varchar2) is
     l_stmt  varchar2(4000);
     l_vers  number;
     l_cnt   number := 0;
     l_trace   varchar2(1000) := G_TRACE||'drop_supplemental_logging:';
  begin

     bars_audit.info(l_trace||'Удаление групп логирования для '||p_table);
     -- 10g
     if ora_version in ('10','11')  then
           for c in ( select log_group_type from  all_log_groups
                      where table_name = p_table ) loop

               bars_audit.info(l_trace||'Удаление групы '||c.log_group_type);
               l_cnt := 1;
               case
                  when instr(c.log_group_type, 'ALL')     > 0 then l_stmt := 'ALL';
                  when instr(c.log_group_type, 'FOREIGN') > 0 then l_stmt := add_lst(l_stmt,'FOREIGN KEY');
                  when instr(c.log_group_type, 'PRIMARY') > 0 then l_stmt := add_lst(l_stmt,'PRIMARY KEY');
                  when instr(c.log_group_type, 'UNIQUE')  > 0 then l_stmt := add_lst(l_stmt,'UNIQUE');
                  else null;
               end case;

            end loop;

            l_stmt := 'alter table '||p_table||' drop supplemental log data ('||l_stmt||') columns';

     -- 9i
     else
        l_stmt := 'alter table '||p_table||' drop supplemental log group LOG_GROUP_'||p_table;
     end if;

     if l_cnt > 0 then
        bars_audit.info(l_trace||'Перед выполнением инструкции: '||l_stmt);
        execute immediate l_stmt;
     else
        bars_audit.info(l_trace||'Для данной таблицы не существует лог групп');
     end if;




    -- перекомпиляция схемы BARS
     bars_audit.info(l_trace||'Выполняется перекомпиляция схемы BARS');
     recompile_schema;
  exception when others then
    -- ORA-32587: Cannot drop nonexistent all column supplemental logging
    if sqlcode in (-30568, -32587)  then
        if sqlcode =-30568 then
          bars_audit.error('LOG_GROUP_'||p_table||': '||SQLERRM);
        else
          bars_audit.error(p_table||': '||SQLERRM);
        end if;
    else
        raise;
    end if;
  end drop_supplemental_logging;




  -----------------------------------------------
  -- check_op_field - выполныет динамическую проверку значения доп.реквизита
  --
  -----------------------------------------------
  function check_op_field(
        p_tag   in char,
        p_val   in varchar2     default null,
        p_s     in number       default null,
        p_s2    in number       default null,
        p_kva   in varchar2     default null,
        p_kvb   in varchar2     default null,
        p_nlsa  in varchar2     default null,
        p_nlsb  in varchar2     default null,
        p_mfoa  in varchar2     default null,
        p_mfob  in varchar2     default null,
        p_tt    in char         default null
  ) return number is
    l_chkr          op_field.chkr%type;
    l_result        number;
    l_cursor        integer;
    l_needless      number;
    l_tag           varchar2(5);
  begin

    l_tag := trim(p_tag);
    select chkr into l_chkr from op_field where tag=p_tag;
    -- если поле chkr не заполнено, считаем что значение доп. реквизита корректно
    if l_chkr is null then
        return 1;
    end if;
    -- поле chkr заполнено, необходимо обработать
    begin
        l_cursor := g_cursor_tab(l_tag).m_cursor;
        l_chkr   := g_cursor_tab(l_tag).m_stmt;
    exception when no_data_found then
        -- готовим выражение
        l_chkr := upper(l_chkr);
        l_chkr := replace(l_chkr, '#(TAG)',     'bars_alien_privs.G_TAG');
        l_chkr := replace(l_chkr, '#(VAL)',     'bars_alien_privs.G_VAL');
        l_chkr := replace(l_chkr, '#(S)',       'bars_alien_privs.G_S');
        l_chkr := replace(l_chkr, '#(S2)',      'bars_alien_privs.G_S2');
        l_chkr := replace(l_chkr, '#(KVA)',     'bars_alien_privs.G_KVA');
        l_chkr := replace(l_chkr, '#(KVB)',     'bars_alien_privs.G_KVB');
        l_chkr := replace(l_chkr, '#(NLSA)',    'bars_alien_privs.G_NLSA');
        l_chkr := replace(l_chkr, '#(NLSB)',    'bars_alien_privs.G_NLSB');
        l_chkr := replace(l_chkr, '#(MFOA)',    'bars_alien_privs.G_MFOA');
        l_chkr := replace(l_chkr, '#(MFOB)',    'bars_alien_privs.G_MFOB');
        l_chkr := replace(l_chkr, '#(TT)',      'bars_alien_privs.G_TT');
        l_chkr := 'begin :l_result := '||l_chkr||'; end;';
        -- создаем переменную курсора
        l_cursor := dbms_sql.open_cursor;
        -- парсим выражение
        dbms_sql.parse(l_cursor, l_chkr, dbms_sql.native);
        -- вяжем переменную результата
        dbms_sql.bind_variable(l_cursor, 'l_result', l_result);
        -- сохраняем само выражение и курсор в массиве
        g_cursor_tab(l_tag).m_stmt   := l_chkr;
        g_cursor_tab(l_tag).m_cursor := l_cursor;
    end;
    -- вяжем переменные
    G_TAG  := trim(p_tag);
    G_VAL  := p_val;
    G_S    := p_s;
    G_S2   := p_s2;
    G_KVA  := p_kva;
    G_KVB  := p_kvb;
    G_NLSA := p_nlsa;
    G_NLSB := p_nlsb;
    G_MFOA := p_mfoa;
    G_MFOB := p_mfob;
    G_TT   := p_tt;
    -- выполняем выражение
    l_needless := dbms_sql.execute(l_cursor);
    -- получим значение
    dbms_sql.variable_value(l_cursor, 'l_result', l_result);
    --
    return l_result;
  end check_op_field;

begin
  -- Initialization
  null;
end bars_alien_privs;
/
 show err;
 
PROMPT *** Create  grants  BARS_ALIEN_PRIVS ***
grant EXECUTE                                                                on BARS_ALIEN_PRIVS to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_ALIEN_PRIVS to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_ALIEN_PRIVS to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_alien_privs.sql =========*** En
 PROMPT ===================================================================================== 
 