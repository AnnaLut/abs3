
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/refsync_export.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.REFSYNC_EXPORT (p_tablename in varchar2) return clob is
    --
    -- refsync_export - возвращает скрипт для экспорта и синхронизации таблицы-справочника
    --
    -- ВАЖНО! Предполагается, что структура одноименных таблиц на разных базах одинаковая
    --
    ----------------------------------------------------------------------------
    -- маска формата для преобразования char <--> number
    g_number_format     constant varchar2(128) := 'FM999999999999999999999999999990.0999999999999999999999999999999';
    -- маска формата для преобразования char <--> number
    g_integer_format     constant varchar2(128) := 'FM999999999999999999999999999990';
    -- параметры преобразования char <--> number
    g_number_nlsparam   constant varchar2(30)  := 'NLS_NUMERIC_CHARACTERS = ''. ''';
    -- маска формата для преобразования char <--> date
    g_date_format       constant varchar2(30)  := 'DD.MM.YYYY HH24:MI:SS';

    l_script        clob;
    l_table         varchar2(30);
    l_refsync       varchar2(30);
    l_temp          varchar2(4000);
    l_table_fields  varchar2(4000);
    l_pk_fields     varchar2(4000);
    l_cursor        integer;
    l_d             integer;
    l_rectab        dbms_sql.desc_tab3;
    l_colcnt        number;
    l_prefix        varchar2(4000);
    l_suffix        varchar2(4000);
    --
    l_number        number;
    l_date          date;
    l_varchar2      varchar2(4000);
    ----------------------------------------------------------------------------
    -- wrap_stmt - оболочка для динамического выполнения sql-выражений
    -- @param p_stmt - выражение
    -- @param p_errcode - игнорируемый код ошибки
    -- @return выражение-оболочка
    function wrap_stmt(p_stmt in varchar2, p_errcode in number) return varchar2 is
    begin
        return
            'declare'||chr(10)||
            '  err    exception;'||chr(10)||
            '  pragma exception_init(err, '||p_errcode||');'||chr(10)||
            'begin'||chr(10)||
            '  execute immediate '''||replace(p_stmt,'''','''''')||''';'||chr(10)||
            'exception when err then'||chr(10)||
            '  null;'||chr(10)||
            'end;'||chr(10)||
            '/'||chr(10);
    end wrap_stmt;
    ----------------------------------------------------------------------------
    -- get_table_fields  - возвращает список полей таблицы через запятую
    --
    function get_table_fields(p_table in varchar2) return varchar2 is
    l_fields varchar2(4000);
    begin
        select max( sys_connect_by_path(column_name, ',')) into l_fields
        from (
               select column_name, row_number() over (order by column_id) as num
               from user_tab_columns where table_name=p_table
             )
        connect by  prior num = num-1
        start with num = 1;
        return substr(l_fields, 2);
    end get_table_fields;
    ----------------------------------------------------------------------------
    -- get_pk_fields  - возвращает список полей первичного ключа через запятую
    --
    function get_pk_fields(p_table in varchar2) return varchar2 is
    l_fields varchar2(4000);
    begin
        select max( sys_connect_by_path(column_name, ',')) into l_fields
        from (
               select k.column_name, row_number() over (order by position) as num
               from user_cons_columns k, user_constraints c
                where k.table_name=p_table and k.table_name=c.table_name
                and k.constraint_name=c.constraint_name and c.constraint_type='P'
                order by position
             )
        connect by  prior num = num-1
        start with num = 1;
        return substr(l_fields, 2);
    end get_pk_fields;
    ----------------------------------------------------------------------------
    -- make_pk_eq  - порождает связку по первичному ключу для инструкции update
    --
    function make_pk_eq(p_pk_fields in varchar2) return varchar2 is
    l_fields varchar2(4000);
    l_result varchar2(4000) := '';
    l_col    varchar2(30);
    i  int := 1;
    p  int;
    begin
        l_fields := p_pk_fields||',';
        loop
            p := instr(l_fields, ',', i);
            if p=0 then
                exit;
            end if;
            l_col := substr(l_fields, i, p-i);
            if i>1 then
                l_result := l_result||' and ';
            end if;
            l_result := l_result||l_col||'=t.'||l_col;
            i := p+1;
        end loop;
        return l_result;
    end make_pk_eq;
begin
    l_table := upper(p_tablename);
    -- проверки
    begin
        select table_name into l_temp from user_tables where table_name=l_table;
    exception when no_data_found then
        raise_application_error(-20000, 'Таблица "'||l_table||'" не найдена', true);
    end;
    -- создаем пустой скрипт
    dbms_lob.createTemporary(l_script, true, dbms_lob.call);
    -- озаглавим скрипт
    l_temp := 'prompt'||chr(10)
            ||'prompt Синхронзация таблицы-справочника "'||l_table||'"'||chr(10)
            ||'prompt Дата+время экспорта: '||to_char(sysdate, g_date_format)||chr(10)
            ||'prompt'||chr(10)||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- пишем в журнал аудита на принимающей стороне
    l_temp := replace(l_temp, 'prompt'||chr(10), '');
    l_temp := replace(l_temp, 'prompt ', ''); l_temp := replace(l_temp, chr(10), ' ');
    l_temp := 'exec bars_audit.info('''||l_temp||''');'||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- задаем формат даты и числа
    l_temp := 'alter session set nls_date_format='''||g_date_format||''';'||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    l_temp := 'alter session set '||g_number_nlsparam||';'||chr(10)||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- формируем имя промежуточной таблицы
    l_refsync := substr('REFSYNC_'||l_table,1,30);
    -- предварительно удалим промежуточную таблицу, если она существует
    l_temp := wrap_stmt('drop table '||l_refsync, -942);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- создаем пустую промежуточную таблицу для синхронизации
    l_temp := wrap_stmt('create table '||l_refsync||' as select * from '||l_table||' where 1=0', -1);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    l_temp := chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- узнаем перечень полей первичного ключа
    l_pk_fields := get_pk_fields(l_table);
    if l_pk_fields is null then
        raise_application_error(-20000, 'Обратитесь к разработчику! Таблица '||l_table||' не содержит первичного ключа. Синхронизация не поддерживается.', true);
    end if;
    -- формируем список полей синхронизируемой таблицы
    l_table_fields := get_table_fields(l_table);
    -- подготовим курсор по базовой таблице
    l_temp := 'select '||l_table_fields||' from '||l_table;
    l_cursor := dbms_sql.open_cursor();
    dbms_sql.parse(l_cursor, l_temp, dbms_sql.native);
    l_d := dbms_sql.execute(l_cursor);
    dbms_sql.describe_columns3(l_cursor, l_colcnt, l_rectab);
    -- определим типы колонок
    for i in 1..l_colcnt loop
        case l_rectab(i).col_type
        when 1 --'VARCHAR2'
        then dbms_sql.define_column(l_cursor, i, l_varchar2, l_rectab(i).col_max_len);
        when 2 --'NUMBER'
        then dbms_sql.define_column(l_cursor, i, l_number);
        when 12 --'DATE'
        then dbms_sql.define_column(l_cursor, i, l_date);
        when 96 --'CHAR'
        then dbms_sql.define_column_char(l_cursor, i, l_varchar2, l_rectab(i).col_max_len);
        else raise_application_error(-20000, 'Обратитесь к разработчику! Неподдерживаемый тип колонки: '||l_rectab(i).col_type||'.', true);
        end case;
    end loop;
    -- наполняем промежуточную таблицу данными
    l_prefix := 'insert into '||l_refsync||'('||l_table_fields||')'||chr(10)
              ||'values(';
    l_suffix := ');'||chr(10);
    loop
        if dbms_sql.fetch_rows(l_cursor)=0 then
            exit;
        end if;
        dbms_lob.writeAppend(l_script, length(l_prefix), l_prefix);
        for i in 1..l_colcnt loop
            case l_rectab(i).col_type
            when 1 --'VARCHAR2'
            then
                dbms_sql.column_value(l_cursor, i, l_varchar2);
                l_temp := case when l_varchar2 is null then 'null' else ''''||replace(l_varchar2,'''','''''')||'''' end;
            when 2 --'NUMBER'
            then
                dbms_sql.column_value(l_cursor, i, l_number);
                l_temp := case when l_number is null then 'null' else to_char(l_number, case when l_rectab(i).col_scale=0 then g_integer_format else g_number_format end, g_number_nlsparam) end;
            when 12 --'DATE'
            then
                dbms_sql.column_value(l_cursor, i, l_date);
                l_temp := case when l_date is null then 'null' else 'to_date('''||to_char(l_date, g_date_format)||''','''||g_date_format||''')' end;
            when 96 --'CHAR'
            then
                dbms_sql.column_value_char(l_cursor, i, l_varchar2);
                l_temp := case when rtrim(l_varchar2) is null then 'null' else ''''||replace(rtrim(l_varchar2),'''','''''')||'''' end;
            else raise_application_error(-20000, 'Обратитесь к разработчику! Неподдерживаемый тип колонки: '||l_rectab(i).col_type||'.', true);
            end case;
            if i>1 then
                l_temp := ', '||l_temp;
            end if;
            dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
        end loop;
        dbms_lob.writeAppend(l_script, length(l_suffix), l_suffix);
    end loop;
    dbms_sql.close_cursor(l_cursor);
    l_temp := 'commit;'||chr(10)||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- синхронизируем основную таблицу
    -- delete
    l_temp := 'delete from '||l_table||chr(10)
            ||'where ('||l_pk_fields||') not in (select '||l_pk_fields||' from '||l_refsync||');'||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    l_temp := 'commit;'||chr(10)||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- update
    l_temp := 'update '||l_table||' t set ('||l_table_fields||')='||chr(10)
            ||'(select '||l_table_fields||' from '||l_refsync||chr(10)
            ||'where '||make_pk_eq(l_pk_fields)||');'||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    l_temp := 'commit;'||chr(10)||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- insert
    l_temp := 'insert into '||l_table||'('||l_table_fields||')'||chr(10)
            ||'select '||l_table_fields||' from '||l_refsync||chr(10)
            ||'where ('||l_pk_fields||') not in (select '||l_pk_fields||' from '||l_table||');'||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    l_temp := 'commit;'||chr(10)||chr(10);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- чистим после себя
    l_temp := wrap_stmt('drop table '||l_refsync, -942);
    dbms_lob.writeAppend(l_script, length(l_temp), l_temp);
    -- вроди все
    return l_script;
end refsync_export;
 
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/refsync_export.sql =========*** End
 PROMPT ===================================================================================== 
 