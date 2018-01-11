
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_sync_dbf.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NBUR_SYNC_DBF 
is

  --
  -- Constants
  --
  g_header_version   constant varchar2(64) := 'version 1.05  2017.05.10';

    --
  -- HEADER_VERSION
  --
  function header_version return varchar2;

  --
  -- BODY_VERSION
  --
  function body_version return varchar2;

  --
  --
  --
  function GET_TABID
  ( p_tbl_nm   meta_tables.tabname%type
  ) return     meta_tables.tabid%type;

  --
  -- Повертає повний шлях до фалу
  --
  function GET_FULL_FILE_NAME
  ( p_tbl_id        in     dbf_sync_tabs.TABID%type
  ) return varchar2;

  ---
  --
  ---
  function EXPORT
  ( p_tbl_nm     meta_tables.tabname%type
  , p_dbf_nm     dbf_sync_tabs.file_name%type
  , p_sel_stmt   dbf_sync_tabs.s_select%type
  , p_ins_stmt   dbf_sync_tabs.s_insert%type
  , p_upd_stmt   dbf_sync_tabs.s_update%type
  , p_del_stmt   dbf_sync_tabs.s_delete%type
  , p_encode     dbf_sync_tabs.encode%type
  ) return varchar;

  --
  -- Повертає дату оновлення DBF файлу для довідника
  --
  function GET_DBF_CHANGE_DATE
  ( p_tbl_id        in     dbf_sync_tabs.TABID%type
  ) return date;

  ---
  --
  ---
  procedure EXPORT
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  , p_script           out clob
  );

  --
  -- вставка / оновлення запису
  --
  procedure SET_ROW
  ( p_tbl_id        in out dbf_sync_tabs.TABID%type
  , p_sel_stmt      in     dbf_sync_tabs.s_select%type
  , p_ins_stmt      in     dbf_sync_tabs.s_insert%type
  , p_upd_stmt      in     dbf_sync_tabs.s_update%type
  , p_del_stmt      in     dbf_sync_tabs.s_delete%type
  , p_encode        in     dbf_sync_tabs.encode%type
  , p_dbf_nm        in     dbf_sync_tabs.file_name%type
  );

  --
  -- Видалення запису
  --
  procedure DEL_ROW
  ( p_tbl_id        in     dbf_sync_tabs.TABID%type
  );

  --
  -- Імпорт DBF файлe в проміжну таблицю
  --
  procedure IMPORT_DBF
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  , p_dbf_data      in     blob
  , p_dbf_dt        in     date
  , p_err_msg          out varchar2   -- текст помилки
  );

  --
  -- Синхронізація даних основної та проміжної таблиць
  --
  procedure SYNC_TBL
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  , p_err_msg          out varchar2   -- текст помилки
  );

  --
  --
  --
  procedure SYNC_NEW
  ( p_err_msg          out varchar2   -- текст помилки
  );

end NBUR_SYNC_DBF;
/
CREATE OR REPLACE PACKAGE BODY BARS.NBUR_SYNC_DBF 
is

  --
  -- constants
  --
  g_body_version     constant varchar2(64)  := 'version 1.05  2017.04.28';

  --
  -- variables
  --
  v_row              DBF_SYNC_TABS%rowtype;

  --
  -- повертає версію заголовка пакета
  --
  function header_version
    return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' header '||g_header_version;
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' body '||g_body_version;
  end body_version;

  --
  --
  --
  function GET_TABID
  ( p_tbl_nm   meta_tables.tabname%type
  ) return     meta_tables.tabid%type
  is
    l_tbl_id   meta_tables.tabid%type;
  BEGIN

    begin
      select TABID
        into l_tbl_id
        from META_TABLES
       where TABNAME = p_tbl_nm;
    exception
      when NO_DATA_FOUND
      then
        l_tbl_id := Null;
    end;

    return l_tbl_id;

  END GET_TABID;

  --
  --
  --
  function GET_TBL_NM
  ( p_tbl_id   meta_tables.tabid%type
  ) return     meta_tables.tabname%type
  is
    l_tbl_nm   meta_tables.tabname%type;
  begin

    begin
      select TABNAME
        into l_tbl_nm
        from META_TABLES
       where TABID  = p_tbl_id;
    exception
      when NO_DATA_FOUND
      then
        l_tbl_nm := Null;
    end;

    return l_tbl_nm;

  end GET_TBL_NM;

  --
  --
  --
  procedure GET_ROW
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  ) is
  begin

    begin
      select *
        into v_row
        from DBF_SYNC_TABS
       where TABID = p_tbl_id;
    exception
      when NO_DATA_FOUND then
        v_row := null;
    end;

  end GET_ROW;

  --
  --
  --
  function GET_FULL_FILE_NAME
  ( p_tbl_id        in     dbf_sync_tabs.TABID%type
  ) return varchar2
  is
    l_dbf_nm               varchar2(512);
  begin

    if ( v_row.TABID = p_tbl_id )
    then null;
    else GET_ROW( p_tbl_id );
    end if;

    l_dbf_nm := BRANCH_ATTRIBUTE_UTL.GET_ATTRIBUTE_VALUE( '/', 'KL_NBU', 0, 0, 0, 'C:\' ) || '\' || v_row.FILE_NAME || '.DBF';

    l_dbf_nm := replace(l_dbf_nm,'\\','\');

    bars_audit.trace( '%s.GET_FULL_FILE_NAME: Exit with "%s".', $$PLSQL_UNIT, l_dbf_nm );

    return l_dbf_nm;

  end GET_FULL_FILE_NAME;

  --
  -- Отримати останню дату оновлення довідника
  --
  function GET_DBF_CHANGE_DATE
  ( p_tbl_id        in     dbf_sync_tabs.TABID%type
  ) return date
  is
  begin

    if ( v_row.TABID = p_tbl_id )
    then null;
    else GET_ROW( p_tbl_id );
    end if;

    bars_audit.trace( '%s.GET_DBF_CHANGE_DATE: Exit with %s.', $$PLSQL_UNIT, to_char(v_row.FILE_DATE,'dd/mm/yyyy hh24:mi:ss') );

    return v_row.FILE_DATE;

  end GET_DBF_CHANGE_DATE;

  --
  --
  --
  function EXPORT
  ( p_tbl_nm     meta_tables.tabname%type
  , p_dbf_nm     dbf_sync_tabs.file_name%type
  , p_sel_stmt   dbf_sync_tabs.s_select%type
  , p_ins_stmt   dbf_sync_tabs.s_insert%type
  , p_upd_stmt   dbf_sync_tabs.s_update%type
  , p_del_stmt   dbf_sync_tabs.s_delete%type
  , p_encode     dbf_sync_tabs.encode%type
  ) return varchar
  is -- Экспорт синхр. таблицы в сценарий
    l_stmt  varchar(32767);
  begin

    l_stmt := 'SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED' || chr(10);
    l_stmt := l_stmt || 'SET FEEDBACK  OFF' || chr(10);
    l_stmt := l_stmt || 'SET TRIMSPOOL ON' || chr(10);
    l_stmt := l_stmt || 'SET LINES 1000' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || 'declare' || chr(10);
    l_stmt := l_stmt || '  NEW_TABID_  dbf_sync_tabs.TABID%type;' || chr(10);
    l_stmt := l_stmt || '  STR_SELECT  dbf_sync_tabs.s_select%type;' || chr(10);
    l_stmt := l_stmt || '  STR_INSERT  dbf_sync_tabs.s_insert%type;' || chr(10);
    l_stmt := l_stmt || '  STR_UPDATE  dbf_sync_tabs.s_update%type;' || chr(10);
    l_stmt := l_stmt || '  STR_DELETE  dbf_sync_tabs.s_delete%type;' || chr(10);
    l_stmt := l_stmt || '  STR_FNAME   dbf_sync_tabs.file_name%type;' || chr(10);
    l_stmt := l_stmt || '  STR_ENCODE  dbf_sync_tabs.encode%type;' || chr(10);
    l_stmt := l_stmt || 'begin' || chr(10);
    l_stmt := l_stmt || '  -- Поиск кода таблицы' || chr(10);
    l_stmt := l_stmt || '  NEW_TABID_ := NBUR_SYNC_DBF.GET_TABID('''|| p_tbl_nm || ''');' || chr(10);
    l_stmt := l_stmt || '  IF NEW_TABID_ IS NULL THEN' || chr(10);
    l_stmt := l_stmt || '    DBMS_OUTPUT.PUT_LINE(''Таблица ' || p_tbl_nm || ' не описана в БМД!'');' || chr(10);
    l_stmt := l_stmt || '  ELSE' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    -- Присвоение переменных' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    STR_SELECT := q''[' || p_sel_stmt || ']'';' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    STR_INSERT := q''[' || p_ins_stmt || ']'';' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    STR_UPDATE := q''[' || p_upd_stmt || ']'';' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    STR_DELETE := q''[' || p_del_stmt || ']'';' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    STR_FNAME := '''  || p_dbf_nm || ''';' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    STR_ENCODE := ''' || p_encode || ''';' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    -- Обновление выражений в DBF_SYNC_TABS' || chr(10);
    l_stmt := l_stmt || '    UPDATE DBF_SYNC_TABS' || chr(10);
    l_stmt := l_stmt || '       SET S_SELECT  = STR_SELECT' || chr(10);
    l_stmt := l_stmt || '         , S_INSERT  = STR_INSERT' || chr(10);
    l_stmt := l_stmt || '         , S_UPDATE  = STR_UPDATE' || chr(10);
    l_stmt := l_stmt || '         , S_DELETE  = STR_DELETE' || chr(10);
    l_stmt := l_stmt || '         , FILE_NAME = STR_FNAME'  || chr(10);
    l_stmt := l_stmt || '         , ENCODE    = STR_ENCODE' || chr(10);
    l_stmt := l_stmt || '    WHERE TABID = NEW_TABID_;' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    IF ( SQL%ROWCOUNT = 0 )' || chr(10);
    l_stmt := l_stmt || '    THEN' || chr(10);
    l_stmt := l_stmt || '        INSERT INTO DBF_SYNC_TABS (TABID, S_SELECT, S_INSERT, S_UPDATE, S_DELETE, FILE_NAME, ENCODE)' || chr(10);
    l_stmt := l_stmt || '        VALUES (NEW_TABID_, STR_SELECT, STR_INSERT, STR_UPDATE, STR_DELETE, STR_FNAME, STR_ENCODE);'  || chr(10);
    l_stmt := l_stmt || '    END IF;' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '    DBMS_OUTPUT.PUT_LINE(''Таблица ' || p_tbl_nm || ' внесена/обновлена в редактировании синхронизируемых таблиц'');' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || '  END IF;' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || 'end;' || chr(10);
    l_stmt := l_stmt || '/' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || 'COMMIT;' || chr(10);
    l_stmt := l_stmt || chr(10);
    l_stmt := l_stmt || 'SET FEEDBACK  ON' || chr(10);

    return l_stmt;

  end EXPORT;

  ---
  --
  ---
  procedure EXPORT
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  , p_script           out clob
  ) is
    title     constant     varchar2(64) := $$PLSQL_UNIT||'.EXPORT';
    l_tbl_nm               meta_tables.tabname%type;
    l_dbf_nm               dbf_sync_tabs.file_name%type;
    l_sel_stmt             dbf_sync_tabs.s_select%type;
    l_ins_stmt             dbf_sync_tabs.s_insert%type;
    l_upd_stmt             dbf_sync_tabs.s_update%type;
    l_del_stmt             dbf_sync_tabs.s_delete%type;
    l_encode               dbf_sync_tabs.encode%type;
  begin

    bars_audit.info(title||': Entry with ( p_tbl_id='||to_char(p_tbl_id)||' ).');

    begin

      select mt.TABNAME, st.FILE_NAME, st.S_SELECT, st.S_INSERT, st.S_UPDATE, st.S_UPDATE, st.ENCODE
        into l_tbl_nm, l_dbf_nm, l_sel_stmt, l_ins_stmt, l_upd_stmt, l_del_stmt, l_encode
        from DBF_SYNC_TABS st
        join META_TABLES   mt
          on ( mt.TABID = st.TABID )
       where st.TABID = p_tbl_id;

      p_script := EXPORT( p_tbl_nm   => l_tbl_nm
                        , p_dbf_nm   => l_dbf_nm
                        , p_sel_stmt => l_sel_stmt
                        , p_ins_stmt => l_ins_stmt
                        , p_upd_stmt => l_upd_stmt
                        , p_del_stmt => l_del_stmt
                        , p_encode   => l_encode );

    exception
      when NO_DATA_FOUND then
        p_script := null;
    end;

  end EXPORT;

  --
  --
  --
  procedure SET_ROW
  is
    title     constant     varchar2(64) := $$PLSQL_UNIT||'.SET_ROW';
  begin

    bars_audit.trace( '%s: Entry.', title );

    update DBF_SYNC_TABS
       set ROW = v_row
     where TABID = v_row.TABID;

    if ( sql%rowcount > 0 )
    then

      bars_audit.trace( '%s: row updated.', title );

    else

      insert
        into DBF_SYNC_TABS
      values v_row;

      bars_audit.trace( '%s: row inserted.', title );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SET_ROW;

  --
  --
  --
  procedure SET_ROW
  ( p_tbl_id        in out dbf_sync_tabs.TABID%type
  , p_sel_stmt      in     dbf_sync_tabs.s_select%type
  , p_ins_stmt      in     dbf_sync_tabs.s_insert%type
  , p_upd_stmt      in     dbf_sync_tabs.s_update%type
  , p_del_stmt      in     dbf_sync_tabs.s_delete%type
  , p_encode        in     dbf_sync_tabs.encode%type
  , p_dbf_nm        in     dbf_sync_tabs.file_name%type
  ) is
    title     constant     varchar2(64) := $$PLSQL_UNIT||'.SET_ROW';
  begin

    bars_audit.trace( '%s: Entry with ( p_tbl_id=%s, p_encode=%s, p_dbf_nm=%s ).'
                    , title, to_char(p_tbl_id), p_encode, p_dbf_nm );

    update DBF_SYNC_TABS
       set S_SELECT  = p_sel_stmt
         , S_INSERT  = p_ins_stmt
         , S_UPDATE  = p_upd_stmt
         , S_DELETE  = p_del_stmt
         , ENCODE    = p_encode
         , FILE_NAME = p_dbf_nm
--       , FILE_DATE = case when FILE_NAME = p_dbf_nm then FILE_DATE else null end
--       , SYNC_FLAG = case when FILE_NAME = p_dbf_nm then SYNC_FLAG else null end
--       , SYNC_DATE = case when FILE_NAME = p_dbf_nm then SYNC_DATE else null end
     where TABID     = p_tbl_id;

    if ( sql%rowcount > 0 )
    then

      bars_audit.trace( '%s: row updated.', title );

    else

      insert
        into DBF_SYNC_TABS
           ( TABID, S_SELECT, S_INSERT, S_UPDATE, S_DELETE, ENCODE, FILE_NAME )
      values
           ( p_tbl_id, p_sel_stmt, p_ins_stmt, p_upd_stmt, p_del_stmt, p_encode, p_dbf_nm );

      bars_audit.trace( '%s: row inserted.', title );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SET_ROW;

  --
  --
  --
  procedure DEL_ROW
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  ) is
    title     constant     varchar2(64) := $$PLSQL_UNIT||'.DEL_ROW';
  begin

    bars_audit.info(title||': Entry with ( p_tbl_id='||to_char(p_tbl_id)||' ).');

    delete DBF_SYNC_TABS
     where TABID = p_tbl_id;

    bars_audit.info(title||': '||to_char(sql%rowcount)||' row(s) deleted.');

  end DEL_ROW;

  --
  -- Імпорт DBF файлe в проміжну таблицю ( pbImport -> InsertDbfDataToTable )
  --
  procedure IMPORT_DBF
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  , p_dbf_data      in     blob
  , p_dbf_dt        in     date
  , p_err_msg          out varchar2   -- текст помилки
  ) is
    title     constant     varchar2(64) := $$PLSQL_UNIT||'.IMPORT_DBF';
    l_force                number(1);
  begin

    bars_audit.info( title||': Entry with ( p_tbl_id='||to_char(p_tbl_id)
                          ||', p_dbf_dt='||to_char(p_dbf_dt,'dd/mm/yyyy hh24:mi:ss')||' ).');

    begin

      if ( v_row.TABID = p_tbl_id )
      then null;
      else GET_ROW( p_tbl_id );
      end if;

      -- Перевірка на на наявність таблиці в БД
      BARS_IES.TAB_EXISTS( v_row.FILE_NAME, l_force );

      if ( l_force = 1 )
      then -- таблиця не перестворюється (видаляєм попередні дані)
        l_force := 2;
      else -- створити нову або перестворити таблицю
        l_force := 1;
      end if;

--    case
--    when ( p_dbf_dt < v_row.FILE_DATE )
--    then p_err_msg := 'Дата створення обраного файлу менша від дати створення вже імпортованого файлу!';
--    when ( p_dbf_dt = v_row.FILE_DATE )
--    then p_err_msg := 'Дата створення обраного файлу збігається з датою створення вже імпортованого файлу!';
--    else null;
--    end case

      -- ImportDbf
      BARS_DBF.LOAD_DBF( p_dbfblob    => p_dbf_data
                       , p_tabname    => v_row.FILE_NAME
                       , p_createmode => l_force
                       , p_srcencode  => v_row.ENCODE
                       , p_destencode => 'WIN' );

      bars_audit.info( title||': Імпортовано дані з файлу '||lower(v_row.FILE_NAME)||'.dbf в таблицю '||v_row.FILE_NAME );

      v_row.FILE_DATE := p_dbf_dt;
      v_row.SYNC_FLAG := 0;

      update DBF_SYNC_TABS
         set FILE_DATE = v_row.FILE_DATE
           , SYNC_FLAG = v_row.SYNC_FLAG
       where TABID     = v_row.TABID;

    exception
      when others then
        p_err_msg := dbms_utility.format_error_stack();
    end;

    bars_audit.trace( '%s: Exit with p_err_msg=%s.', title, p_err_msg );

  end IMPORT_DBF;

  --
  -- Синхронізувати дані основної та проміжної таблиць ( pbSync -> DoSync )
  --
  procedure SYNC_TBL
  ( p_err_msg          out varchar2   -- текст помилки
  ) is
    title     constant     varchar2(64) := $$PLSQL_UNIT||'.SYNC_TBL';
    e_exec_dml_err         exception;
    ---
    procedure EXEC_DML
    ( p_ddl_stmt varchar2
    ) is
    begin
      begin
        execute immediate p_ddl_stmt;
      exception
        when others then
          p_err_msg := dbms_utility.format_error_stack();
      end;
    end EXEC_DML;
    ---
  begin

    bars_audit.trace( '%s: Entry with ( TABID=%s ).', title, to_char(v_row.TABID) );

    begin

      if ( v_row.S_DELETE Is Not Null )
      then
        EXEC_DML( v_row.S_DELETE );
        if ( p_err_msg Is Not Null )
        then
          p_err_msg := 'Помилка при видаленні даних довідника: ' || p_err_msg;
          raise e_exec_dml_err;
        end if;
      end if;

      if ( v_row.S_UPDATE Is Not Null )
      then
        EXEC_DML( v_row.S_UPDATE );
        if ( p_err_msg Is Not Null )
        then
          p_err_msg := 'Помилка при оновлені даних довідника: ' || p_err_msg;
          raise e_exec_dml_err;
        end if;
      end if;

      if ( v_row.S_INSERT Is Not Null )
      then
        EXEC_DML( v_row.S_INSERT );
        if ( p_err_msg Is Not Null )
        then
          p_err_msg := 'Помилка при внесенні даних у довідник: ' || p_err_msg;
          raise e_exec_dml_err;
        end if;
      end if;

      v_row.SYNC_FLAG := 1;

      update DBF_SYNC_TABS
         set SYNC_FLAG = v_row.SYNC_FLAG
       where TABID = v_row.TABID;

      bars_audit.info( title || ': Синхронізацію таблиці ' || GET_TBL_NM( v_row.TABID )
                             || ' з ' || lower(v_row.FILE_NAME) || '.dbf завершено.' );

    exception
      when E_EXEC_DML_ERR then
        null;
      when OTHERS then
        p_err_msg := dbms_utility.format_error_stack();
    end;

    bars_audit.trace( '%s: Exit with ( p_err_msg=%s ).', title, p_err_msg );

  end SYNC_TBL;

  --
  --
  --
  procedure SYNC_TBL
  ( p_tbl_id        in     dbf_sync_tabs.tabid%type
  , p_err_msg          out varchar2   -- текст помилки
  ) is
  begin

    bars_audit.trace( $$PLSQL_UNIT||'.SYNC_TBL: Entry with ( p_tbl_id=%s ).', to_char(p_tbl_id) );

    if ( v_row.TABID = p_tbl_id )
    then null;
    else GET_ROW( p_tbl_id );
    end if;

    SYNC_TBL( p_err_msg );

  end SYNC_TBL;

  --
  -- Синхронізувати всі таблиці ( pbCheckNew -> SyncNew )
  --
  procedure SYNC_NEW
  ( p_err_msg          out varchar2   -- текст помилки
  ) is
    title     constant     varchar2(64) := $$PLSQL_UNIT||'.SYNC_NEW';
  begin

    bars_audit.info( title||': Entry.' );

    <<SYNC_LOOP>>
    for f in ( SELECT st.*
                 from DBF_SYNC_TABS st
                where lnnvl( st.SYNC_FLAG = 1 ) -- Завантажені, але не синхронізовані
    ) loop

      v_row := f;

      SYNC_TBL( p_err_msg );

      exit when p_err_msg Is Not Null;

      commit;

    end loop SYNC_LOOP;

    bars_audit.trace( '%s: Exit with ( p_err_msg=%s ).', title, p_err_msg );

  end SYNC_NEW;



begin
  null;
end NBUR_SYNC_DBF;
/
 show err;
 
PROMPT *** Create  grants  NBUR_SYNC_DBF ***
grant EXECUTE                                                                on NBUR_SYNC_DBF   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nbur_sync_dbf.sql =========*** End *
 PROMPT ===================================================================================== 
 