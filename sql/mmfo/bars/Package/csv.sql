
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/csv.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CSV 
IS
  --
  -- Constants
  --
  g_header_version  constant varchar2(64)  := 'version 1.01 24.02.2016';

  --
  -- Subtype
  --
  SUBTYPE handler_name_subtype IS VARCHAR2(30)  NOT NULL;
  SUBTYPE handler_desc_subtype IS VARCHAR2(100) NOT NULL;

  --
  -- Types
  --
  TYPE t_csv_file_rows_type IS TABLE OF varchar2(1000);

  TYPE t_handler_list_type IS TABLE OF handler_desc_subtype
  INDEX BY handler_name_subtype;

  TYPE handler_list_rowtype IS RECORD ( handler_name  VARCHAR2(30)
                                      , handler_desc  VARCHAR2(100) );

  TYPE handler_list_tabtype IS TABLE OF handler_list_rowtype;

  --
  -- Variables
  --

  --
  -- повертає масив із списком обробників
  --
  function GET_HANDLER_LIST
    return handler_list_tabtype
  PIPELINED;

  --
  -- Наповнення внутрішнього масиву рядками із CSV файлу
  --
  PROCEDURE FILL_INTERNAL_ARRAY
  ( p_file_row      in  varchar2 );

  --
  -- CLEANUP
  --
  PROCEDURE PURGE_INTERNAL_ARRAY
  ( p_input_par     in  number );

  --
  -- обробка даних файлу
  --
  PROCEDURE FILE_PROCESSING
  ( p_handler_name  in  handler_name_subtype
  , p_delimiter     in  number );


END CSV;
/
CREATE OR REPLACE PACKAGE BODY BARS.CSV 
IS
  --
  -- constants
  --
  g_body_version  CONSTANT VARCHAR2(100) := 'version 1.03 14.03.2016';
  g_modcode       CONSTANT VARCHAR2(3)   := 'CSV';
  nlchr           CONSTANT CHAR(2)       := chr(13)||chr(10);

  --
  -- variables
  --
  t_handler_list  t_handler_list_type;  -- список обробників для імпортованого CSV файлу
  t_file_rows     t_csv_file_rows_type; -- масив рядків імпортованого CSV файлу

  l_err_count     pls_integer;          -- к-ть помилок при імпорті
  l_row_num       pls_integer;
  l_pos1          pls_integer;
  l_pos2          pls_integer;
  l_delim         varchar2(1);

  -- COBUMMFO-9690 Begin
  g_module        varchar2(64);
  g_action        varchar2(64);
  -- COBUMMFO-9690 End

  --
  --
  --
  function get_StrFieldVal
    return varchar2
  is
    l_ret  varchar2(1000);
  begin

    l_pos1 := l_pos2 + 1;
    l_pos2 := Instr(t_file_rows(l_row_num), l_delim, l_pos1, 1);

    if (l_pos2 = 0)
    then
      l_pos2 := length(t_file_rows(l_row_num))+1;
    end if;

    begin
      l_ret := Trim( Replace( SubStr( t_file_rows(l_row_num), l_pos1, (l_pos2-l_pos1) ), '"' ) );
    exception
      when OTHERS then
        l_err_count := (l_err_count + 1);
        l_ret := null;
    end;

    RETURN l_ret;

  end get_StrFieldVal;

  --
  -- Конвертація строки в дату
  --
  function get_DatFieldVal
    return date
  is
    l_ret  date;
  begin
    begin
      l_ret := to_date( get_StrFieldVal, 'dd/mm/yyyy');
    exception
      when OTHERS then
        l_err_count := (l_err_count + 1);
        l_ret := null;
     -- bars_audit.info( 'ImportCSV.get_DatFieldVal: помилка в рядку #'||to_char(p_NumLine)||
     --                  ', pos: '||to_char(l_pos1)||'-'||to_char(l_pos2)||' =>> '||t_file_rows(l_row_num)||chr(10)||sqlerrm );
    end;

    RETURN l_ret;

  end get_DatFieldVal;

  --
  -- Конвертація строки в число
  --
  function get_NumFieldVal
  return number
  is
    l_ret  number;
  begin
    begin
      l_ret := to_number( Replace(get_StrFieldVal, ',') );
    exception
      when OTHERS then
        l_err_count := (l_err_count + 1);
        l_ret := null;
     -- bars_audit.info( 'ImportCSV.get_field: помилка в рядку #'||to_char(p_NumLine)||
     --                  ', pos: '||to_char(l_pos1)||'-'||to_char(l_pos2)||' =>> '||t_file_rows(l_row_num)||chr(10)||sqlerrm );
    end;

    RETURN l_ret;

  end get_NumFieldVal;

  --
  -- повертає масив із списком обробників
  --
  function GET_HANDLER_LIST
    return handler_list_tabtype
  PIPELINED
  is
    l_row  handler_list_rowtype;
    l_name varchar2(30);
  BEGIN

    l_name := t_handler_list.first;

    loop
   -- PIPE ROW( csv.handler_list_rowtype( 'idx', 'name' ) ); -- work only with schema types
      exit when ( l_name is Null );
      l_row.handler_name := l_name;
      l_row.handler_desc := t_handler_list(l_name);
      PIPE ROW( l_row );
      l_name := t_handler_list.NEXT(l_name);
    end loop;

    RETURN;

  END GET_HANDLER_LIST;

--function GET_HANDLER_LIST
--  return handler_list_tabtype
--RESULT_CACHE
--is
--  t_handlers   handler_list_tabtype;
--begin
--  t_handlers := handler_list_tabtype();
--  for nm in t_handler_list.first .. t_handler_list.last
--  loop
--    t_handlers.EXTEND;
--    t_handlers(t_handlers.last).handler_name := nm;
--    t_handlers(t_handlers.last).handler_desc := t_handler_list(nm);
--  end loop;
--  RETURN t_handlers;
--END GET_HANDLER_LIST;


--  --
--  -- повертає масив із списком обробників
--  --
--  procedure ADD_CUSTOM_HANDLER
--  ( p_handler_name  in  handler_name_subtype
--  , p_handler_desc  in  handler_desc_subtype
--  ) is
--    title  constant  varchar2(60) := 'csv.add_custom_handler';
--  begin
--    t_handler_list(p_handler_name) := p_handler_desc;
--  END ADD_CUSTOM_HANDLER;

  --
  --
  --
  PROCEDURE FILL_INTERNAL_ARRAY
  ( p_file_row      in  varchar2
  ) is
    /**
    <b>FILL_INTERNAL_ARRAY</b> - Наповнення внутрішнього масиву рядками із CSV файлу
    %param

    %version 1.0
    %usage   Наповнення внутрішнього масиву рядками із CSV файлу
    */
  BEGIN

    if (p_file_row Is not Null)
    then
      t_file_rows.EXTEND;
      t_file_rows(t_file_rows.LAST) := p_file_row;
    end if;

  END FILL_INTERNAL_ARRAY;

  --
  -- CLEANUP
  --
  PROCEDURE CLEANUP
  IS
    title  constant  varchar2(60) := 'csv.cleanup';
  BEGIN

    bars_audit.trace( '%s: Start running.', title );

    t_file_rows.delete();

    DBMS_SESSION.FREE_UNUSED_USER_MEMORY();

    dbms_application_info.set_module(g_module, g_action /*NULL,NULL -- COBUMMFO-9690*/);
    dbms_application_info.set_client_info(NULL);

    bars_audit.trace( '%s: Exit.', title );

  END CLEANUP;

  --
  -- Для дибільної CENTURA яка не розуміє виклик процедури без параметру
  --
  PROCEDURE PURGE_INTERNAL_ARRAY
  ( p_input_par    in  number
  ) is
  BEGIN
    CLEANUP();
  end PURGE_INTERNAL_ARRAY;

  --
  -- Завантаження сегментації клієнтів ЮО та ФОП
  --
  procedure LOAD_CUSTOMER_SEGMENTATION
  ( p_file_rows    IN OUT NOCOPY t_csv_file_rows_type   -- Масив рядкыв файлу
  , p_delim_cod    in            pls_integer            -- код смволу розділювача
  , p_max_err_qty  in            pls_integer  default 0 -- Макс. допустима к-ть помилок при розборі даних файлу
  ) is
    /**
    <b>LOAD_CUSTOMER_SEGMENTATION</b> - Завантаження сегментації клієнтів ЮО та ФОП
                                        з даних CSV файлу перенесених в масив t_csv_file_rows_type
    %param

    %version 1.0
    %usage   Завантаження даних по сегментації клієнтів ЮО та ФОП з CSV файлу.
    */

    title  constant  varchar2(60) := 'csv.load_customer_segmentation';

    type t_custw_type is table of BARS.CUSTOMERW%rowtype;

    FORALL_ERROR   exception;
    pragma exception_init(FORALL_ERROR, -24381);

    t_biz_line     t_custw_type; -- business line
    t_biz_sector   t_custw_type; -- business sector
    l_rows_qty     pls_integer;  -- К-ть записів у вхідному масиві даних
    l_max_err_qty  pls_integer;  -- Макс. допустима к-ть помилок при розборі даних файлу
    l_bank_code    varchar2(6);  -- Код банку вказаний у файлі
    l_mfo          varchar2(6) := gl.amfo;
  BEGIN

    bars_audit.trace( '%s: Start running with delimiter_code = %s, max_error_qty = %s.',
                      title, to_char(p_delim_cod), to_char(p_max_err_qty) );

    dbms_application_info.set_module( g_modcode, 'LOAD_CUSTOMER_SEGMENTATION' );

    l_err_count := 0;

    l_rows_qty := p_file_rows.count();

    bars_audit.trace( '%s: array contains %s rows.', title, to_char(l_rows_qty) );

    if ( l_rows_qty > 0 )
    then

      dbms_application_info.set_client_info( 'Entered in Loop.' );

      -- дефолтний розділювач символ табуляції
      l_delim := chr(nvl(p_delim_cod, 9));

      --
      l_max_err_qty := nvl(p_max_err_qty,0);

      -- initialize collection
      t_biz_line   := t_custw_type();
      t_biz_sector := t_custw_type();

      -- extend collection
      --t_biz_line.EXTEND(l_rows_qty);
      --t_biz_sector.EXTEND(l_rows_qty);

      -- парсим рядок CSV файлу
      FOR k IN p_file_rows.first .. p_file_rows.last
      LOOP

        l_pos2    := 0;
        l_row_num := k;

        dbms_application_info.set_client_info( 'Processed '|| to_char(l_row_num) || ' of ' || to_char(l_rows_qty) );

        l_bank_code := get_StrFieldVal(); -- Код РУ

        if ( l_bank_code = l_mfo )
        then -- Якщо наще МФО

          t_biz_line.EXTEND;
          t_biz_sector.EXTEND;

          -- RNK контрагента
          t_biz_line(k).RNK   := get_NumFieldVal();
          t_biz_sector(k).RNK := t_biz_line(k).RNK;

          t_biz_line(k).VALUE   := get_StrFieldVal;
          t_biz_sector(k).VALUE := get_StrFieldVal;

          t_biz_line(k).TAG   := 'BUSSL';
          t_biz_sector(k).TAG := 'BUSSS';

          t_biz_line(k).ISP   := 0;
          t_biz_sector(k).ISP := 0;

        else
          null;
          -- l_err_count := (l_err_count + 1);
          -- bars_audit.error( title || ': Код РУ в ' || to_char(l_row_num) || ' рядку файла не відповідає поточному РУ!');
        end if;

        if ( l_err_count > l_max_err_qty )
        then
          bars_audit.error( title || ': К-ть помилок при розборі даних перевищує допутиму - імпорт скасовано!' );
          raise_application_error( -20666, 'К-ть помилок перевищує допутиме значення - імпорт скасовано!' );
        end if;

      END LOOP;

      bars_audit.trace( '%s: Parsing file rows completed.', title );
      dbms_application_info.set_client_info( 'Parsing file rows completed.' );

      dbms_application_info.set_client_info( 'Inserting rows into table (1 stage).' );

      BEGIN

        bars_audit.info( title || ': К-ть помилок при вставці даних ' || to_char(l_err_count) );

--      FORALL i in 1 .. l_rows_qty
        FORALL i IN t_biz_line.first .. t_biz_line.last SAVE EXCEPTIONS
        INSERT /*+ APPEND_VALUES */
          INTO BARS.CUSTOMERW
        VALUES t_biz_line(i);

        bars_audit.info(title || ': Inserted '||sql%rowcount||' records.' );

      EXCEPTION
        WHEN FORALL_ERROR THEN

          l_err_count := SQL%BULK_EXCEPTIONS.COUNT;

          bars_audit.info( title || ': К-ть помилок при вставці даних ' || to_char(l_err_count) );

          FOR i IN 1 .. least(l_err_count,greatest(l_max_err_qty,10))
          LOOP
            bars_audit.info( title || ': ERROR ( RNK => ' || to_char(t_biz_line(SQL%BULK_EXCEPTIONS(i).error_index).RNK)
                                   || ', Message => ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) || ' ).' );
          END LOOP;

          if ( l_err_count > l_max_err_qty )
          then
            bars_audit.error( title || ': К-ть помилок при вставці перевищує допутиму - імпорт скасовано!' );
            raise_application_error( -20666, 'К-ть помилок перевищує допутиме значення - імпорт скасовано!' );
          end if;

      END;

      t_biz_line.delete();

      dbms_application_info.set_client_info( 'Inserting rows into table (2 stage).' );

      BEGIN

        FORALL i IN t_biz_sector.first .. t_biz_sector.last SAVE EXCEPTIONS
        INSERT /*+ APPEND_VALUES */
          INTO BARS.CUSTOMERW
        VALUES t_biz_sector(i);

        bars_audit.info(title || ': Inserted '||sql%rowcount||' records.' );

      EXCEPTION
        WHEN FORALL_ERROR THEN

          l_err_count := SQL%BULK_EXCEPTIONS.COUNT;

          bars_audit.info( title || ': К-ть помилок при вставці даних ' || to_char(l_err_count) );

          FOR i IN 1 .. least(l_err_count,greatest(l_max_err_qty,10))
          LOOP
            bars_audit.info( title || ': ERROR ( RNK => ' || to_char(t_biz_line(SQL%BULK_EXCEPTIONS(i).error_index).RNK)
                                   || ', Message => ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE) || ' ).' );
          END LOOP;

          if ( l_err_count > l_max_err_qty )
          then
            bars_audit.error( title || ': К-ть помилок при вставці перевищує допутиму - імпорт скасовано!' );
            raise_application_error( -20666, 'К-ть помилок перевищує допутиме значення - імпорт скасовано!' );
          end if;

      END;

      t_biz_sector.delete();

    else -- do nothing

      null;

    end if;

    bars_audit.trace( '%s: Exit.', title );

    dbms_application_info.set_client_info( Null );

  END LOAD_CUSTOMER_SEGMENTATION;

  --
  -- обробка даних файлу
  --
  PROCEDURE FILE_PROCESSING
  ( p_handler_name  in  handler_name_subtype -- Назва обробника
  , p_delimiter     in  number               -- Код смволу розділювача
  ) IS
    title     constant  varchar2(60) := 'csv.file_processing';
  BEGIN

    bars_audit.trace( '%s: Start running.', title );

    dbms_application_info.set_module( g_modcode, 'FILE_PROCESSING' );

    if ( t_handler_list.exists(p_handler_name) )
    then
      case p_handler_name
        when 'LOAD_CUSTOMER_SEGMENTATION'
        then
          LOAD_CUSTOMER_SEGMENTATION
          ( p_file_rows   => t_file_rows
          , p_delim_cod   => p_delimiter );

        else -- someone forgot to add here handler called "p_handler_name"
          null;
      end case;
    else -- external handler
      null;
      -- begin
      --   execute immediate 'begin ' || p_handler_name || '( :p_array, :p_delim ); end;' using t_file_rows, p_delimiter;
      -- end;
    end if;

    CLEANUP();

    bars_audit.trace( '%s: Exit.', title );

  EXCEPTION
    when OTHERS then
      CLEANUP();
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      RAISE;
  END FILE_PROCESSING;



BEGIN

  t_file_rows := t_csv_file_rows_type();

  Dbms_Application_Info.read_module(g_module, g_action); -- COBUMMFO-9690

  t_handler_list('LOAD_CUSTOMER_SEGMENTATION') := 'Завантаження сегментації клієнтів ЮО та ФОП';
--t_handler_list('LOAD_SOMETHING_ELSE')        := 'Завантаження';

END CSV;
/
 show err;
 
PROMPT *** Create  grants  CSV ***
grant EXECUTE                                                                on CSV             to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/csv.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 