
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_lob.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_LOB authid current_user is

  g_headerVersion constant varchar2(64) := 'version 1.04 26.12.2011';
  g_headerDefs    constant varchar2(512) := '';

  -- Размеры частей для BLOB, CLOB
  BLOB_PIECE_SIZE constant number := 2000;
  CLOB_PIECE_SIZE constant number := 2000;

  -----------------------------------------------------------------
  -- CLEAR_TEMPORARY()
  --
  --
  --  Процедура очищает временную таблицу
  --
  --
  procedure clear_temporary;

  -----------------------------------------------------------------
  -- READ_BLOB()
  --
  --
  --  Процедура выполняет чтение большого объекта (BLOB), его
  --  разбивку на части и помещение частей во временную таблицу
  --
  --  Параметры:
  --
  --    p_tabname      Имя таблицы, в которую будет производиться
  --                   вставка данных
  --
  --    p_colkey       Имя столбца первичного ключа
  --
  --    p_colval       Имя столбца с данными
  --
  --    p_keyval1      Значение для столбца первичного ключа (число)
  --
  --    p_keyval2      Значение для столбца первичного ключа (строка)
  --
  --    p_fltstmt      Условие отбора строки из таблицы для вставки
  --
  --
  procedure read_blob(p_tabname in varchar2,
                      p_colkey  in varchar2,
                      p_colval  in varchar2,
                      p_keyval1 in number,
                      p_keyval2 in varchar2,
                      p_fltstmt in varchar2);

  procedure read_blob_ex(p_tabname         in varchar2,
                         p_colkey          in varchar2,
                         p_colval          in varchar2,
                         p_keyval1         in number,
                         p_keyval2         in varchar2,
                         p_fltstmt         in varchar2,
                         p_blob_piece_size in number default BLOB_PIECE_SIZE);

  -----------------------------------------------------------------
  -- WRITE_BLOB()
  --
  --
  --  Процедура выполняет сбор частей объекта из временной таблицы
  --  TMP_BLOB и запись полного объекта в указанную таблицу.
  --
  --  Параметры:
  --
  --    p_tabname      Имя таблицы, в которую будет производиться
  --                   вставка данных
  --
  --    p_colkey       Имя столбца первичного ключа
  --
  --    p_colval       Имя столбца с данными
  --
  --    p_keyval1      Значение для столбца первичного ключа (число)
  --
  --    p_keyval2      Значение для столбца первичного ключа (строка)
  --
  --    p_fltstmt      Условие отбора строки из таблицы для вставки
  --
  --    p_introw       Признак вставки новой строки в таблицу (1/0)
  --
  --
  procedure write_blob(p_tabname in varchar2,
                       p_colkey  in varchar2,
                       p_colval  in varchar2,
                       p_keyval1 in number,
                       p_keyval2 in varchar2,
                       p_fltstmt in varchar2,
                       p_insrow  in number);

  -----------------------------------------------------------------
  -- READ_СLOB()
  --
  --
  --  Процедура выполняет чтение большого объекта (СLOB), его
  --  разбивку на части и помещение частей во временную таблицу
  --
  --  Параметры:
  --
  --    p_tabname      Имя таблицы, в которую будет производиться
  --                   вставка данных
  --    p_colkey       Имя столбца первичного ключа
  --    p_colval       Имя столбца с данными
  --    p_keyval1      Значение для столбца первичного ключа (число)
  --    p_keyval2      Значение для столбца первичного ключа (строка)
  --    p_fltstmt      Условие отбора строки из таблицы для вставки
  --    p_clob_piece_size  Размеры частей для СLOB
  --
  --
  procedure read_clob(p_tabname in varchar2,
                      p_colkey  in varchar2,
                      p_colval  in varchar2,
                      p_keyval1 in number,
                      p_keyval2 in varchar2,
                      p_fltstmt in varchar2);

  procedure read_clob_ex(p_tabname         in varchar2,
                         p_colkey          in varchar2,
                         p_colval          in varchar2,
                         p_keyval1         in number,
                         p_keyval2         in varchar2,
                         p_fltstmt         in varchar2,
                         p_clob_piece_size in number default CLOB_PIECE_SIZE);

  -----------------------------------------------------------------
  -- WRITE_СLOB()
  --
  --
  --  Процедура выполняет сбор частей объекта из временной таблицы
  --  TMP_BLOB и запись полного объекта в указанную таблицу.
  --
  --  Параметры:
  --
  --    p_tabname      Имя таблицы, в которую будет производиться
  --                   вставка данных
  --
  --    p_colkey       Имя столбца первичного ключа
  --
  --    p_colval       Имя столбца с данными
  --
  --    p_keyval1      Значение для столбца первичного ключа (число)
  --
  --    p_keyval2      Значение для столбца первичного ключа (строка)
  --
  --    p_fltstmt      Условие отбора строки из таблицы для вставки
  --
  --    p_introw       Признак вставки новой строки в таблицу (1/0)
  --
  --
  procedure write_clob(p_tabname in varchar2,
                       p_colkey  in varchar2,
                       p_colval  in varchar2,
                       p_keyval1 in number,
                       p_keyval2 in varchar2,
                       p_fltstmt in varchar2,
                       p_insrow  in number);

  -----------------------------------------------------------------
  -- EXPORT_BLOB()
  --
  --  Процедура выполняет разбиение переданного большого объекта
  --  (BLOB) на части и помещение частей во временную таблицу для
  --  дальнейшего экспорта
  --
  --  Параметры:
  --
  --    p_blob         Объект для экспорта
  --    p_blob_piece_size Размеры частей для BLOB
  --
  --
  procedure export_blob(p_blob in blob);

  procedure export_blob_ex(p_blob            in blob,
                           p_blob_piece_size in number default BLOB_PIECE_SIZE);

  -----------------------------------------------------------------
  -- EXPORT_CLOB()
  --
  --  Процедура выполняет разбиение переданного большого объекта
  --  (CLOB) на части и помещение частей во временную таблицу для
  --  дальнейшего экспорта
  --
  --  Параметры:
  --
  --    p_clob         Объект для экспорта
  --    p_сlob_piece_size Размеры частей для СLOB
  --
  --
  procedure export_clob(p_clob in clob);

  procedure export_clob_ex(p_clob            in clob,
                           p_clob_piece_size in number default CLOB_PIECE_SIZE);

  -----------------------------------------------------------------
  -- IMPORT_BLOB()
  --
  --  Процедура выполняет сборку из tmp_lob большого объекта
  --  из поля blobdata  и отдает этот объект
  --
  --  Параметры:
  --
  --    p_blob         Объект в который сформировать ответ
  --
  procedure import_blob(p_blob out blob);

  -----------------------------------------------------------------
  -- IMPORT_BLOB_FROM_RAW()
  --
  --  Процедура выполняет сборку из tmp_lob большого объекта
  --  из поля rawdata + rawlen и отдает этот объект
  --
  --  Параметры:
  --
  --    p_blob         Объект в который сформировать ответ
  --
  procedure import_blob_from_raw(p_blob out blob);

  -----------------------------------------------------------------
  -- IMPORT_CLOB()
  --
  --  Процедура выполняет сборку из tmp_lob большого объекта
  --  из поля strdata и отдает этот объект
  --
  --  Параметры:
  --
  --    p_clob         Объект в который сформировать ответ
  --
  procedure import_clob(p_clob out clob);

  -----------------------------------------------------------------
  -- HEADER_VERSION()
  --
  --     Функция возвращает строку с версией заголовка пакета
  --
  --
  --
  function header_version return varchar2;

  -----------------------------------------------------------------
  -- BODY_VERSION()
  --
  --     Функция возвращает строку с версией тела пакета
  --
  --
  --
  function body_version return varchar2;

end bars_lob;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_LOB is

  g_bodyVersion constant varchar2(64) := 'version 1.05 19.06.2013';
  g_bodyDefs    constant varchar2(512) := '';

  MODCODE constant varchar2(3) := 'SVC';

  -- Максимальный размер SQL-выражения
  subtype t_sqlstmt is varchar2(4000);

  -----------------------------------------------------------------
  -- CHECK_READ_PARAMS()
  --
  --
  --  Процедура проверки параметров переданных для чтения объекта
  --
  --
  --
  procedure check_read_params(p_tabname in varchar2,
                              p_colkey  in varchar2,
                              p_colval  in varchar2,
                              p_keyval1 in number,
                              p_keyval2 in varchar2,
                              p_fltstmt in varchar2) is
  begin

    if (p_tabname is null) then
      -- '\001 Неверно задан параметр 1 (имя таблицы)');
      bars_error.raise_error(MODCODE, 20);
    end if;

    if (p_fltstmt is null and p_colkey is null) then
      -- '\001 Неверно задан параметр 2 (имя столбца ключа таблицы)');
      bars_error.raise_error(MODCODE, 21);
    end if;

    if (p_colval is null) then
      -- '\001 Неверно задан параметр 3 (имя столбца с LOB-объектом)');
      bars_error.raise_error(MODCODE, 22);
    end if;

    if (p_fltstmt is null and p_keyval1 is null and p_keyval2 is null) then
      -- '\002 Должен быть задан один из параметров 4 или 5');
      bars_error.raise_error(MODCODE, 23);
    end if;

  end check_read_params;

  -----------------------------------------------------------------
  -- CHECK_WRITE_PARAMS()
  --
  --
  --  Процедура проверки параметров переданных для чтения объекта
  --
  --
  --
  procedure check_write_params(p_tabname in varchar2,
                               p_colkey  in varchar2,
                               p_colval  in varchar2,
                               p_keyval1 in number,
                               p_keyval2 in varchar2,
                               p_fltstmt in varchar2,
                               p_insrow  in number) is
  begin

    -- Параметр p_insrow может быть 0/1
    if (p_insrow not in (0, 1) or p_insrow is null) then
      -- '\001 Неверно задан параметр 8 (допустимые значения 0/1)');
      bars_error.raise_error(MODCODE, 24);
    end if;

    -- Связка при вставке
    if (p_insrow = 1 and p_fltstmt is not null) then
      -- '\003 Невозможно применить режим вставки при пользовательском фильтре');
      bars_error.raise_error(MODCODE, 25);
    end if;

  end check_write_params;

  -----------------------------------------------------------------
  -- GET_SRC_OBJ()
  --
  --
  --  Процедура получения исходного объекта
  --
  --
  procedure get_src_obj(p_objtype in varchar2,
                        p_tabname in varchar2,
                        p_colkey  in varchar2,
                        p_colval  in varchar2,
                        p_keyval1 in number,
                        p_keyval2 in varchar2,
                        p_fltstmt in varchar2,
                        p_srcBlob out blob,
                        p_srcClob out clob) is

    l_stmtSel  t_sqlstmt; /* SQL-выражение получения объекта */
    l_roleList varchar2(2000); /*    список активных ролей сессии */

  begin

    bars_audit.trace('Read source object (type %s)...', p_objtype);
    bars_audit.trace('par[0]=>%s, par[1]=>%s, par[2]=>%s, par[3]=>%s, par[4]=>%s, par[5]=>%s, par[6]=>%s',
                     p_objtype,
                     p_tabname,
                     p_colkey,
                     p_colval,
                     to_char(p_keyval1),
                     p_keyval2,
                     p_fltstmt);

    -- показываем установленные роли
    for curs_role in (select role from session_roles) loop
      l_rolelist := substr(l_rolelist || ',' || curs_role.role, 1, 2000);
    end loop;

    bars_audit.trace('session roles=> %s', l_rolelist);

    --
    -- Формируем запрос на получение объекта
    --
    --
    l_stmtSel := 'select ' || lower(p_colval) || ' into :val from ' ||
                 lower(p_tabname) || ' where ';

    --
    -- Если указано полное условие отбора, применяем его
    --
    if (p_fltstmt is not null) then

      l_stmtSel := l_stmtSel || p_fltstmt;

      bars_audit.trace('Executing query with custom filter...');

      if (p_objtype = 'B') then
        execute immediate l_stmtSel
          into p_srcBlob;
      else
        execute immediate l_stmtSel
          into p_srcClob;
      end if;

    else

      --
      -- Конструируем условие отбора по значению поля
      --

      l_stmtSel := l_stmtSel || p_colkey || ' = :id';

      if (p_keyval1 is not null) then

        bars_audit.trace('Executing query with filter value 1...');

        if (p_objtype = 'B') then
          execute immediate l_stmtSel
            into p_srcBlob
            using p_keyval1;
        else
          execute immediate l_stmtSel
            into p_srcClob
            using p_keyval1;
        end if;

      else

        bars_audit.trace('Executing query with filter value 2...');

        if (p_objtype = 'B') then
          execute immediate l_stmtSel
            into p_srcBlob
            using p_keyval2;
        else
          execute immediate l_stmtSel
            into p_srcClob
            using p_keyval2;
        end if;

      end if;

    end if;

    bars_audit.trace('Read source object completed.');

  end get_src_obj;

  -----------------------------------------------------------------
  -- CLEAR_TEMPORARY()
  --
  --
  --  Процедура очищает временную таблицу
  --
  --
  procedure clear_temporary is
  begin

    bars_audit.trace('Clearing temporary table ...');
    delete from tmp_lob;
    bars_audit.trace('Temporary table successfully cleared.');

  end clear_temporary;

  -----------------------------------------------------------------
  -- STORE_SRC_LOB()
  --
  --  Процедура сохранения полученного объекта во временной
  --  таблице (по частям)
  --  p_objtype - тип С - clob, B - blob
  --  p_srcblob - входящий blob
  --  p_srcclob - входящий clob
  --  p_blob_piece_size - размеры частей для BLOB
  --  p_clob_piece_size - размеры частей для СLOB

  procedure store_src_lob(p_objtype         in varchar2,
                          p_srcblob         in blob,
                          p_srcclob         in clob,
                          p_blob_piece_size in number,
                          p_clob_piece_size in number) is

    l_srcLen number; /*              размер исходного объекта */

    l_partBlob tmp_lob.rawdata%type; /*    выделенная часть бинарного объекта */
    l_partClob tmp_lob.strdata%type; /*  выделенная часть символьного объекта */
    l_partNum  tmp_lob.id%type; /*                номер выделенной части */
    l_partLen  number; /*              размер ивыделенной части */
    l_partPos  number; /*      позиция части в исходном объекте */

  begin

    --
    -- Получаем размер исходного объекта
    --
    if (p_objtype = 'B') then
      l_srcLen := dbms_lob.getlength(p_srcBlob);
    else
      l_srcLen := dbms_lob.getlength(p_srcClob);
    end if;

    bars_audit.trace('Object length is %s', to_char(l_srcLen));

    --
    -- Инициализируем переменные
    --
    l_partNum := 1;
    l_partPos := 1;

    --
    -- Очищаем временную таблицу
    --
    clear_temporary();

    --
    -- Если объект не заполнен (NULL), то просто выходим -
    -- делать ничего не нужно
    --
    if (l_srcLen is null) then
      return;
    end if;

    --
    -- В цикле разбиваем объект на части по определенному размеру
    --
    loop

      --
      -- Определяем размер текущей части
      --

      if (p_objtype = 'B') then

        if (l_srcLen - l_partPos + 1 <= p_blob_piece_size) then
          l_partLen := l_srcLen - l_partPos + 1;
        else
          l_partLen := p_blob_piece_size;
        end if;

      else

        if (l_srcLen - l_partPos + 1 <= p_clob_piece_size) then
          l_partLen := l_srcLen - l_partPos + 1;
        else
          l_partLen := p_clob_piece_size;
        end if;

      end if;

      bars_audit.trace('partnum is %s, partsize is %s',
                       to_char(l_partNum),
                       to_char(l_partLen));

      --
      -- Выделяем текущую часть и вставляем ее
      --
      if (p_objtype = 'B') then

        l_partBlob := dbms_lob.substr(p_srcBlob, l_partLen, l_partPos);

        insert into tmp_lob
          (id, rawdata, rawlen)
        values
          (l_partNum, l_partBlob, l_partLen);

      else

        l_partClob := dbms_lob.substr(p_srcClob, l_partLen, l_partPos);

        insert into tmp_lob (id, strdata) values (l_partNum, l_partClob);

      end if;

      --
      -- Увеличиваем номер части и ее позицию
      --
      l_partNum := l_partNum + 1;
      l_partPos := l_partPos + l_partLen;

      bars_audit.trace('new partnum is %s, new partpos is %s',
                       to_char(l_partNum),
                       to_char(l_partPos));

      --
      -- Условие выхода: позиция больше длины объекта
      --
      if (l_srcLen < l_partPos) then
        bars_audit.trace('End detected.');
        exit;
      end if;

    end loop;

    bars_audit.trace('Object transferred to temporary table.');

  end store_src_lob;

  -----------------------------------------------------------------
  -- READ_LOB()
  --
  --
  --
  procedure read_lob(p_objtype         in varchar2,
                     p_tabname         in varchar2,
                     p_colkey          in varchar2,
                     p_colval          in varchar2,
                     p_keyval1         in number,
                     p_keyval2         in varchar2,
                     p_fltstmt         in varchar2,
                     p_blob_piece_size in number,
                     p_clob_piece_size in number) is

    l_srcBlob blob; /*              исходный бинарный объект */
    l_srcClob clob; /*            исходный символьный объект */

  begin

    bars_audit.trace('Reading LOB (type %s) from table %s...',
                     p_objtype,
                     p_tabname);

    --
    -- Выполняем проверку параметров
    --
    check_read_params(p_tabname,
                      p_colkey,
                      p_colval,
                      p_keyval1,
                      p_keyval2,
                      p_fltstmt);

    --
    -- Получаем исходный объект
    --
    get_src_obj(p_objtype => p_objtype,
                p_tabname => p_tabname,
                p_colkey  => p_colkey,
                p_colval  => p_colval,
                p_keyval1 => p_keyval1,
                p_keyval2 => p_keyval2,
                p_fltstmt => p_fltstmt,
                p_srcblob => l_srcBlob,
                p_srcclob => l_srcClob);

    --
    -- Сохраняем полученный объект во временной таблице
    --
    if (p_objtype = 'B') then
      store_src_lob(p_objtype,
                    l_srcBlob,
                    null,
                    p_blob_piece_size,
                    p_clob_piece_size);
    else
      store_src_lob(p_objtype,
                    null,
                    l_srcClob,
                    p_blob_piece_size,
                    p_clob_piece_size);
    end if;

  end read_lob;

  -----------------------------------------------------------------
  -- READ_BLOB()
  --
  --
  --
  procedure read_blob(p_tabname in varchar2,
                      p_colkey  in varchar2,
                      p_colval  in varchar2,
                      p_keyval1 in number,
                      p_keyval2 in varchar2,
                      p_fltstmt in varchar2) is
  begin
    read_blob_ex(p_tabname,
                 p_colkey,
                 p_colval,
                 p_keyval1,
                 p_keyval2,
                 p_fltstmt,
                 BLOB_PIECE_SIZE);
  end read_blob;

  procedure read_blob_ex(p_tabname         in varchar2,
                         p_colkey          in varchar2,
                         p_colval          in varchar2,
                         p_keyval1         in number,
                         p_keyval2         in varchar2,
                         p_fltstmt         in varchar2,
                         p_blob_piece_size in number default BLOB_PIECE_SIZE) is
  begin
    read_lob(p_objtype         => 'B',
             p_tabname         => p_tabname,
             p_colkey          => p_colkey,
             p_colval          => p_colval,
             p_keyval1         => p_keyval1,
             p_keyval2         => p_keyval2,
             p_fltstmt         => p_fltstmt,
             p_blob_piece_size => p_blob_piece_size,
             p_clob_piece_size => CLOB_PIECE_SIZE);
  end read_blob_ex;

  -----------------------------------------------------------------
  -- READ_СLOB()
  --
  --
  --  Процедура выполняет чтение большого объекта (СLOB), его
  --  разбивку на части и помещение частей во временную таблицу
  --
  --  Параметры:
  --
  --    p_tabname      Имя таблицы, в которую будет производиться
  --                   вставка данных
  --    p_colkey       Имя столбца первичного ключа
  --    p_colval       Имя столбца с данными
  --    p_keyval1      Значение для столбца первичного ключа (число)
  --    p_keyval2      Значение для столбца первичного ключа (строка)
  --    p_fltstmt      Условие отбора строки из таблицы для вставки
  --    p_clob_piece_size  Размеры частей для СLOB
  --
  --
  procedure read_clob(p_tabname         in varchar2,
                      p_colkey          in varchar2,
                      p_colval          in varchar2,
                      p_keyval1         in number,
                      p_keyval2         in varchar2,
                      p_fltstmt         in varchar2) is
  begin

    read_clob_ex(p_tabname,
                 p_colkey,
                 p_colval,
                 p_keyval1,
                 p_keyval2,
                 p_fltstmt,
                 CLOB_PIECE_SIZE);

  end read_clob;

  procedure read_clob_ex(p_tabname         in varchar2,
                         p_colkey          in varchar2,
                         p_colval          in varchar2,
                         p_keyval1         in number,
                         p_keyval2         in varchar2,
                         p_fltstmt         in varchar2,
                         p_clob_piece_size in number default CLOB_PIECE_SIZE) is
  begin

    read_lob(p_objtype         => 'C',
             p_tabname         => p_tabname,
             p_colkey          => p_colkey,
             p_colval          => p_colval,
             p_keyval1         => p_keyval1,
             p_keyval2         => p_keyval2,
             p_fltstmt         => p_fltstmt,
             p_blob_piece_size => BLOB_PIECE_SIZE,
             p_clob_piece_size => p_clob_piece_size);

  end read_clob_ex;

  -----------------------------------------------------------------
  -- WRITE_LOB()
  --
  --
  --
  procedure write_lob(p_objtype in varchar2,
                      p_tabname in varchar2,
                      p_colkey  in varchar2,
                      p_colval  in varchar2,
                      p_keyval1 in number,
                      p_keyval2 in varchar2,
                      p_fltstmt in varchar2,
                      p_insrow  in number) is

    l_objBlob blob; /*                       бинарный объект */
    l_objClob clob; /*                     символьный объект */

    l_stmtIns t_sqlstmt; /*       SQL-выражение на вставку данных */
    l_stmtUpd t_sqlstmt; /*   SQL-выражение для обновления данных */
    l_stmtSel t_sqlstmt; /*   SQL-выражение для блокировки строки */

    l_roleList varchar2(2000); /*          список активных ролей сессии */

  begin

    bars_audit.trace('Writing LOB (type %s) to table %s...',
                     p_objtype,
                     p_tabname);

    --
    -- Выполняем проверку параметров
    --
    check_write_params(p_tabname,
                       p_colkey,
                       p_colval,
                       p_keyval1,
                       p_keyval2,
                       p_fltstmt,
                       p_insrow);

    -- показываем установленные роли
    for curs_role in (select role from session_roles) loop
      l_rolelist := substr(l_rolelist || ',' || curs_role.role, 1, 2000);
    end loop;

    bars_audit.trace('session roles=> %s', l_rolelist);

    --
    -- Вставляем запись, если это необходимо
    --
    if (p_insrow = 1) then

      bars_audit.trace('Inserting new row into table %s...', p_tabname);

      --
      -- Формируем запрос
      --
      l_stmtIns := 'insert into ' || lower(p_tabname) || '(' ||
                   lower(p_colkey) || ',' || lower(p_colval) ||
                   ') values (:id, ';

      if (p_objtype = 'B') then
        l_stmtIns := l_stmtIns || 'empty_blob())';
      else
        l_stmtIns := l_stmtIns || 'empty_clob())';
      end if;

      --
      -- Выполняем вставку
      --
      if (p_keyval1 is not null) then
        execute immediate l_stmtIns
          using p_keyval1;
      else
        execute immediate l_stmtIns
          using p_keyval2;
      end if;

      bars_audit.trace('New row successfully inserted into table %s',
                       p_tabname);

    else

      --
      -- Если строка не вставлялась нами, то очищаем объект
      --
      bars_audit.trace('Clearing lob field...');

      l_stmtUpd := 'update ' || lower(p_tabname) || ' set ' ||
                   lower(p_colval) || ' = ';

      if (p_objtype = 'B') then
        l_stmtUpd := l_stmtUpd || 'empty_blob()';
      else
        l_stmtUpd := l_stmtUpd || 'empty_clob()';
      end if;

      l_stmtUpd := l_stmtUpd || ' where ';

      if (p_fltstmt is not null) then

        -- Выполняем, бинды не нужны
        l_stmtUpd := l_stmtUpd || p_fltstmt;
        execute immediate l_stmtUpd;

      else

        l_stmtUpd := l_stmtUpd || lower(p_colkey) || ' = :id';

        if (p_keyval1 is not null) then
          execute immediate l_stmtUpd
            using p_keyval1;
        else
          execute immediate l_stmtUpd
            using p_keyval2;
        end if;

      end if;

      bars_audit.trace('LOB field successfully cleared.');

    end if;

    --
    -- Формируем запрос для блокировки строки
    --
    bars_audit.trace('Blocking table %s row...', p_tabname);

    l_stmtSel := 'select ' || lower(p_colval) || ' into :val from ' ||
                 lower(p_tabname) || ' where ';

    if (p_fltstmt is not null) then
      l_stmtSel := l_stmtSel || p_fltstmt;
    else
      l_stmtSel := l_stmtSel || lower(p_colkey) || ' = :id';
    end if;

    l_stmtSel := l_stmtSel || ' for update';

    --
    -- Выполняем блокировку данных
    --
    if (p_fltstmt is not null) then

      if (p_objtype = 'B') then
        execute immediate l_stmtSel
          into l_objBlob;
      else
        execute immediate l_stmtSel
          into l_objClob;
      end if;

    else
      if (p_keyval1 is not null) then

        if (p_objtype = 'B') then
          execute immediate l_stmtSel
            into l_objBlob
            using p_keyval1;
        else
          execute immediate l_stmtSel
            into l_objClob
            using p_keyval1;
        end if;

      else

        if (p_objtype = 'B') then
          execute immediate l_stmtSel
            into l_objBlob
            using p_keyval2;
        else
          execute immediate l_stmtSel
            into l_objClob
            using p_keyval2;
        end if;

      end if;

    end if;

    bars_audit.trace('Row in table %s successfully locked.', p_tabname);

    --
    -- Читаем части из временной таблицы и формируем объект
    --
    for i in (select id, blobdata, strdata from tmp_lob order by id) loop

      if (p_objtype = 'B') then
        dbms_lob.append(l_objBlob, i.blobdata);
      else
        dbms_lob.append(l_objClob, i.strdata);
      end if;

      dbms_output.put_line('Part ' || to_char(i.id) ||
                           ' successfully added to temporary lob.');

    end loop;

    bars_audit.trace('All parts successfully added to temporary lob.');

    --
    -- Формируем запрос на сохранение объекта
    --

    l_stmtUpd := 'update ' || lower(p_tabname) || ' set ' ||
                 lower(p_colval) || ' = :val where ';

    if (p_fltstmt is not null) then
      l_stmtUpd := l_stmtUpd || p_fltstmt;
    else
      l_stmtUpd := l_stmtUpd || lower(p_colkey) || ' = :id';
    end if;

    --
    -- Выполняем обновление
    --
    if (p_fltstmt is not null) then

      if (p_objtype = 'B') then
        execute immediate l_stmtUpd
          using l_objBlob;
      else
        execute immediate l_stmtUpd
          using l_objClob;
      end if;

    else

      if (p_keyval1 is not null) then

        if (p_objtype = 'B') then
          execute immediate l_stmtUpd
            using l_objBlob, p_keyval1;
        else
          execute immediate l_stmtUpd
            using l_objClob, p_keyval1;
        end if;

      else

        if (p_objtype = 'B') then
          execute immediate l_stmtUpd
            using l_objBlob, p_keyval2;
        else
          execute immediate l_stmtUpd
            using l_objClob, p_keyval2;
        end if;

      end if;

    end if;

    bars_audit.trace('LOB object successfully stored in table %s',
                     p_tabname);

  end write_lob;

  -----------------------------------------------------------------
  -- WRITE_BLOB()
  --
  --
  --
  procedure write_blob(p_tabname in varchar2,
                       p_colkey  in varchar2,
                       p_colval  in varchar2,
                       p_keyval1 in number,
                       p_keyval2 in varchar2,
                       p_fltstmt in varchar2,
                       p_insrow  in number) is
  begin

    write_lob(p_objtype => 'B',
              p_tabname => p_tabname,
              p_colkey  => p_colkey,
              p_colval  => p_colval,
              p_keyval1 => p_keyval1,
              p_keyval2 => p_keyval2,
              p_fltstmt => p_fltstmt,
              p_insrow  => p_insrow);

  end write_blob;

  -----------------------------------------------------------------
  -- WRITE_СLOB()
  --
  --
  --  Процедура выполняет сбор частей объекта из временной таблицы
  --  TMP_BLOB и запись полного объекта в указанную таблицу.
  --
  --  Параметры:
  --
  --    p_tabname      Имя таблицы, в которую будет производиться
  --                   вставка данных
  --
  --    p_colkey       Имя столбца первичного ключа
  --
  --    p_colval       Имя столбца с данными
  --
  --    p_keyval1      Значение для столбца первичного ключа (число)
  --
  --    p_keyval2      Значение для столбца первичного ключа (строка)
  --
  --    p_fltstmt      Условие отбора строки из таблицы для вставки
  --
  --    p_introw       Признак вставки новой строки в таблицу (1/0)
  --
  --
  procedure write_clob(p_tabname in varchar2,
                       p_colkey  in varchar2,
                       p_colval  in varchar2,
                       p_keyval1 in number,
                       p_keyval2 in varchar2,
                       p_fltstmt in varchar2,
                       p_insrow  in number) is
  begin

    write_lob(p_objtype => 'C',
              p_tabname => p_tabname,
              p_colkey  => p_colkey,
              p_colval  => p_colval,
              p_keyval1 => p_keyval1,
              p_keyval2 => p_keyval2,
              p_fltstmt => p_fltstmt,
              p_insrow  => p_insrow);

  end write_clob;

  -----------------------------------------------------------------
  -- IMPORT_BLOB()
  --
  --  Процедура выполняет сборку из tmp_lob большого объекта
  --  из поля blobdata  и отдает этот объект
  --
  --  Параметры:
  --
  --    p_blob         Объект в который сформировать ответ
  --
  procedure import_blob(p_blob out blob) is
    l_blob   blob;
    l_rowcnt number;
  begin

    bars_audit.trace('in  import_blob');
    dbms_lob.createtemporary(l_blob, FALSE);

    select count(*) into l_rowcnt from tmp_lob;
    bars_audit.trace('Before import_blob, there are ' || l_rowcnt ||
                     ' int tmp_lob table');

    for c in (select blobdata from tmp_lob order by id) loop
      dbms_lob.writeappend(l_blob,
                           dbms_lob.getlength(c.blobdata),
                           c.blobdata);
    end loop;
    p_blob := l_blob;

  end;

  -----------------------------------------------------------------
  -- IMPORT_BLOB_FROM_RAW()
  --
  --  Процедура выполняет сборку из tmp_lob большого объекта
  --  из поля rawdata + rawlen и отдает этот объект
  --
  --  Параметры:
  --
  --    p_blob         Объект в который сформировать ответ
  --
  procedure import_blob_from_raw(p_blob out blob) is
    l_blob   blob;
    l_rowcnt number;
  begin

    bars_audit.trace('in  import_blob_from_raw');
    dbms_lob.createtemporary(l_blob, FALSE);

    select count(*) into l_rowcnt from tmp_lob;
    bars_audit.trace('Before import_blob_from_raw, there are ' || l_rowcnt ||
                     ' int tmp_lob table');

    for cur in (select tl.* from tmp_lob tl order by tl.id) loop
      dbms_lob.writeappend(l_blob, cur.rawlen, cur.rawdata);
    end loop;
    p_blob := l_blob;

  end import_blob_from_raw;

  -----------------------------------------------------------------
  -- IMPORT_CLOB()
  --
  --  Процедура выполняет сборку из tmp_lob большого объекта
  --  из поля strdata и отдает этот объект
  --
  --  Параметры:
  --
  --    p_clob         Объект в который сформировать ответ
  --
  procedure import_clob(p_clob out clob) is
    l_clob clob;
  begin
    dbms_lob.createtemporary(l_clob, FALSE);

    for c in (select strdata from tmp_lob where strdata is not null order by id) loop
      dbms_lob.writeappend(l_clob, length(c.strdata), c.strdata);
    end loop;
    p_clob := l_clob;

  end;

  -----------------------------------------------------------------
  -- EXPORT_BLOB()
  --
  --  Процедура выполняет разбиение переданного большого объекта
  --  (BLOB) на части и помещение частей во временную таблицу для
  --  дальнейшего экспорта
  --
  --  Параметры:
  --
  --    p_blob         Объект для экспорта
  --    p_blob_piece_size Размеры частей для BLOB
  --
  --
  procedure export_blob(p_blob in blob) is
  begin
    export_blob_ex(p_blob, BLOB_PIECE_SIZE);
  end export_blob;

  procedure export_blob_ex(p_blob            in blob,
                           p_blob_piece_size in number default BLOB_PIECE_SIZE) is
  begin
    store_src_lob('B', p_blob, null, p_blob_piece_size, CLOB_PIECE_SIZE);
  end export_blob_ex;

  -----------------------------------------------------------------
  -- EXPORT_CLOB()
  --
  --  Процедура выполняет разбиение переданного большого объекта
  --  (CLOB) на части и помещение частей во временную таблицу для
  --  дальнейшего экспорта
  --
  --  Параметры:
  --
  --    p_blob         Объект для экспорта
  --    p_сlob_piece_size Размеры частей для СLOB
  --
  --
  procedure export_clob(p_clob in clob) is
  begin
    export_clob_ex(p_clob, CLOB_PIECE_SIZE);
  end export_clob;

  procedure export_clob_ex(p_clob            in clob,
                           p_clob_piece_size in number default CLOB_PIECE_SIZE) is
  begin
    store_src_lob('C', null, p_clob, BLOB_PIECE_SIZE, p_clob_piece_size);
  end export_clob_ex;

  -----------------------------------------------------------------
  -- HEADER_VERSION()
  --
  --     Функция возвращает строку с версией заголовка пакета
  --
  --
  --
  function header_version return varchar2 is
  begin
    return 'package header BARS_LOB ' || g_headerVersion || chr(10) || 'package header definition(s):' || chr(10) || g_headerDefs;
  end header_version;

  -----------------------------------------------------------------
  -- BODY_VERSION()
  --
  --     Функция возвращает строку с версией тела пакета
  --
  --
  --
  function body_version return varchar2 is
  begin
    return 'package body BARS_LOB ' || g_bodyVersion || chr(10) || 'package body definition(s):' || chr(10) || g_bodyDefs;
  end body_version;

end bars_lob;
/
 show err;
 
PROMPT *** Create  grants  BARS_LOB ***
grant EXECUTE                                                                on BARS_LOB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_LOB        to CC_DOC;
grant EXECUTE                                                                on BARS_LOB        to CUST001;
grant EXECUTE                                                                on BARS_LOB        to OPER000;
grant EXECUTE                                                                on BARS_LOB        to OW;
grant EXECUTE                                                                on BARS_LOB        to PYOD001;
grant EXECUTE                                                                on BARS_LOB        to RPBN001;
grant EXECUTE                                                                on BARS_LOB        to START1;
grant EXECUTE                                                                on BARS_LOB        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_lob.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 