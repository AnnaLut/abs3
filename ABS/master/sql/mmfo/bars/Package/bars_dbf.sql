
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dbf.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DBF IS
-----------------------------------------------------------
--
--  Работа с DBF файлами
--
--  1. Выгрузка в DBF файл:
--     Если при выгрузке не указывается явно структура DBF файла (при выгрузке функой
--     DBF_FROM_TABLE и DBF_FROM_SQL(без структуры)), формат исходящих dbf файлов формируется
--     по правилам Centura DBase Driver
--
-----------------------------------------------------------

  G_HEADER_VERSION      constant varchar2(64)  := 'version 4.0 18.11.2010';

  WIN_TBL   varchar(75) :='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЪЫЭЮЯІЇЄабвгдеёжзийклмнопрстуфхцчшщьъыэюяіїє№Ґґ';
  UKG_TBL   varchar(75) :='ЂЃ‚ѓ„…р†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—™њљ›ќћџцшф ЎўЈ¤Ґс¦§Ё©Є«¬­®Їабвгдежзиймклнопчщхьту';




    ----------------------------------------
    -- IS_MEMO_EXISTS_CNT()
    --
    --    Существуют ли поля MEMO
    --    предполагается что файл был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB_DBF
    --
    --    p_exists =0 - не существует, =1 - существует
    ----------------------------------------
    procedure is_memo_exists_cnt(
                p_exists  out smallint);


    ----------------------------------------
    --  GET_MEMO_FIELD()
    --
    --    Получить клоб - для текста MEMO поля
    --    Вля FoxBase - это файл DBT, конец текста определяется наличием символа 1A
    --
    --    p_mblob     - мемо файл
    --    p_blocknbr  - номер блока
    --    p_srcencode - исходная кодировка memo
    ----------------------------------------

    /*procedure  get_memo_field(
                  p_mblob     BLOB,
                  p_blocknbr  number,
                  p_srcencode varchar2 );*/



    ----------------------------------------------------
    --  SET_BUFFER()
    --
    --    Инициализировать или добавить в буффер глоб. переменную
    --
    --    p_buff       - кусок буффера
    --    p_bufftype   - тип загружаемого файла (DBF, DBT)
    --    p_bufflen    - Длинна буффера с данными
    --
    ----------------------------------------------------
    procedure set_buffer(
                  p_buff     varchar2,
                  p_bufftype varchar2,
                  p_bufflen  number );




    ----------------------------------------------------
    --  GET_BUFFER()
    --
    --    Взять часть из буффера пакета
    --
    --
    ----------------------------------------------------
    procedure get_buffer(
                  p_buff     out varchar2,
                  p_bufflen  out number,
                  p_offset       number,
                  p_amount       number);


    ----------------------------------------------------
    --  GET_EXPORTED_ROWSCOUNT()
    --
    --    кол-во выгруженных строк в DBF
    --
    ----------------------------------------------------
    procedure get_exported_rowscount(p_rowscount out number);



    ----------------------------------------
    --  DBF_FROM_TABLE()
    --
    --    Выгрузка таблицы в DBF формат без указания формата файла DBF -
    --    по правилам Centura DBase Driver
    --    Как результат в переменную p_blobdbf помещается созданный dbf
    --
    --    p_tabnam        - имя таблицы для выгрузки
    --    p_where_clause  - WHERE условие выборки данных из таблицы (без слова WHERE)
    --    p_encode        - кодировка
    --    p_blobdbf       - переменная в которую помещаем результирующий blob DBF-а.
    --
    ----------------------------------------
    procedure dbf_from_table (
                     p_tabname           varchar2,
                     p_where_clause      varchar2 default '',
                     p_encode            varchar2 default 'WIN',
                     p_blobdbf       out blob );






    ----------------------------------------
    --  DBF_FROM_TABLE()
    --
    --    Выгрузка таблицы в DBF формат без указания формата файла DBF - по правилам
    --    Centura DBase Driver
    --    Как результат во временную таблицу tmp_lob (колонка rawdata)
    --    помещаем тело созданого DBF. Это для дальнейшей работы с
    --    blob-ами в Centure, через функции PutLoadedDBFToFile (absapi.apl)
    --
    --    p_tabnam        - имя таблицы для выгрузки
    --    p_where_clause  - WHERE условие выборки данных из таблицы (без слова WHERE)
    --    p_encode        - кодировка
    --
    ----------------------------------------
    procedure dbf_from_table (
                     p_tabname       varchar2,
                     p_where_clause varchar2 default '',
                     p_encode       varchar2 default 'WIN');





    ----------------------------------------
    -- DBF_FROM_SQL ()
    --
    --    Выгрузка в DBF структуру c указанием SQL-я,
    --    с указанием структуры DBF файла.
    --    Как результат во временную таблицу tmp_lob (колонка rawdata)
    --    помещаем тело созданого DBF. Это для дальнейшей работы с
    --    blob-ами в Centure, через функции PutLoadedDBFToFile (absapi.apl)
    --
    --    p_sql           - SQL запрос
    --    p_dbfstruct     - структура описанная через запятую
    --                      (если отсутсвует структура берется из динамического описания SQL-я)
    --    p_encode        - кодировка
    --
    ----------------------------------------

    procedure  dbf_from_sql(
                    p_sql       varchar2,
                    p_dbfstruct varchar2 default null,
    		  p_encode    varchar2 default 'WIN');


    ----------------------------------------
    -- DBF_FROM_SQL ()
    --
    --    Выгрузка в DBF структуру c указанием SQL-я,
    --    с указанием структуры DBF файла.
    --    Как результат в переменную p_blobdbf помещается созданный dbf
    --
    --    p_sql           - SQL запрос
    --    p_dbfstruct     - структура описанная через запятую
    --                      (если отсутсвует структура берется из динамического описания SQL-я)
    --    p_encode        - кодировка
    --    p_blobdbf       - переменная в которую помещаем результирующий blob DBF-а.
    --
    ----------------------------------------

    procedure  dbf_from_sql(
                    p_sql           varchar2,
                    p_dbfstruct     varchar2 default null,
    	            p_encode        varchar2 default 'WIN',
                    p_blobdbf   out blob );



    ----------------------------------------
    --  DBF_FROM_SQLDESC()
    --
    --    Выгрузка таблицы в DBF формат по указанной строке.
    --    Создана для функции выгрузки в Centura Bars Millenium в формат DBF
    --    По описанию строки - определяем выгружать как
    --    dbf_from_table или dbf_from_sql
    --
    --    p_sqldesc       - строка описания
    --    p_coldescr      - описание колонок структуры через запятую
    --    p_encode        - кодировка DBF файла (WIN, DOS, UKG). Предполагается, что
    --                      исходные данные в WIN кодировке
    ----------------------------------------
    procedure  dbf_from_sqldesc(
                    p_sqldesc     varchar2,
                    p_coldescr    varchar2,
                    p_encode      varchar2 default 'WIN');



    ----------------------------------------
    -- IMPORT_DBF_CNT()
    --
    --    Весия для Centura (без использования TMP_LOB)
    --    Загрузить DBF файл в таблицу, предполагается что файл
    --    был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB
    --
    --    p_tabname     --  Имя таблицы для вгрузки
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    ----------------------------------------
    procedure  import_dbf_cnt(
                    p_tabname     varchar2,
                    p_createmode  smallint,
  	            p_srcencode   varchar2 default 'DOS',
                    p_destencode  varchar2 default 'WIN');




    ----------------------------------------
    -- EXPORT_DBF_CNT()
    --
    --    Весия для Centura (без использования TMP_LOB)
    --    Выгрузить в DBF файл таблицу. Выгрузка происходит
    --    в глобальную переменную G_EXCH_BLOB. Предполагается, что потом в Centure
    --    эту переменную вычитают процедурой get_buffer
    --
    --    p_tabname     --  Имя таблицы для выгрузки
    --    p_destencode  --  кодировка исход. DBF файла
    --
    ----------------------------------------
    procedure  export_dbf_cnt(
                    p_tabname     varchar2,
                    p_destencode  varchar2 default 'WIN');





    ----------------------------------------
    --  IMPORT_DBF_SRV()
    --
    --    Импорт dbf файла-а с сервера оракла
    --    через BFILE
    --
    --    p_oradir      --  директория оракла oracledir
    --    p_filename    --  имя файла (если null - имя таблицы - это имя файла без расширения)
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    --
    ----------------------------------------

    procedure  import_dbf_srv(
                  p_oradir      varchar2,
                  p_filename    varchar2,
                  p_tabname     varchar2 default null,
                  p_createmode  smallint default 1,
  	          p_srcencode   varchar2 default 'DOS',
                  p_destencode  varchar2 default 'WIN');



    ----------------------------------------
    -- LOAD_DBF()
    --
    --    Загрузить DBF файл в таблицу
    --
    --    p_dbfblob     --  данные dbf файла
    --    p_tabname     --  Имя таблицы для вгрузки
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    ----------------------------------------
    procedure  load_dbf(
                    p_dbfblob            blob,
                    p_tabname     in out varchar2,
                    p_createmode         smallint,
  	            p_srcencode          varchar2 default 'DOS',
                    p_destencode         varchar2 default 'WIN');



    ----------------------------------------
    --  GET_TBL()
    --
    --    Отдать таблицу символов
    --
    --    p_encode_table    -   значение WIN или UKG
    --
    ----------------------------------------
    function get_tbl(p_encode_table varchar2) return varchar2;



    ----------------------------------------
    --  GET_DBF_DESCRIPTION_CNT()
    --
    --    Узнать версию(описание) DBF, по данной нформации вычслить сущестует или нет memo
    --    и если существует, то какой расширение лоя файла  с мемо полями
    --
    --    предполагается что файл был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB_DBF
    --
    --    p_tabname       - имя таблицы для импорта (для сообщений об ощибках)
    --    p_version       - числовое значение версии
    --    p_description   - описание
    --    p_ismemoexists  - мемо поле  0 - не существует, =1 - существует
    --    p_memofile      - расширение для файла с мемо полем
    ----------------------------------------
    procedure get_dbf_description_cnt(
                p_tabname           varchar2,
		p_version       out number,
                p_description   out varchar2,
                p_ismemoexists  out smallint,
                p_memofile      out varchar2);


end;
/

CREATE OR REPLACE PACKAGE BODY bars_dbf IS

 -----------------------------------------------------------------
 -- --
 -- Работа с DBF форматом --
 -- --
 --
 -- P.S.
 --
 -- Работа с LOGICAL полем:
 -- Для того, что б выгрузить данное поле в DBF формат logical
 -- в запросе нужно обязательно указать символьное поле:
 -- select '0' from ... или select 'F' from ... для FALSE
 -- select '1' from ... или select 'T' from ... для TRUE
 -----------------------------------------------------------------


 -----------------------------------------------------------------
 -- Типы
 -----------------------------------------------------------------

 type vrchr_array is table of varchar2(1000) index by binary_integer;
 type nmbr_array  is table of number index by binary_integer;
 type char_array  is table of char index by binary_integer;
 type clob_array  is table of clob index by binary_integer;

 -- аттрибуты типа DBF файла
 type t_dbf_type is record
    ( vers number,             -- код типа в первух байтах заголовка DBF
      descript varchar2(200),  -- описание типа
      ismemo number(1),        -- поддерживает ли мемо поле данный тип? (1-да/0-нет)
      memofile_ext varchar2(3) -- расширение для файла с мемо полем
    );
 type array_dbf_type is table of t_dbf_type index by binary_integer;


 type t_dbf_header is record
 ( vers t_dbf_type,     --версия DBF
   rowcnt number,       --кол-во записей (4 byte)
   colcnt number,       --кол-во колонок
   frstpos number,      --положение первой записи с данными
   rowlen number,       --длинна одной записи
   colname vrchr_array, --массив наименований столбцов
   collen  nmbr_array,   --массив длинн значений столбцов
   colscl  nmbr_array,   --массив длины дробной части (для number)
   coltype char_array   --массив типов (N,D,C,L)
 );




 -----------------------------------------------------------------
 -- Константы --
 -----------------------------------------------------------------

   G_BODY_VERSION      constant varchar2(64) := 'version 6.6 03.01.2014';
   G_DEF_NUMBER_LENGTH constant number(2)    := 19; --умолчательное значение размера поля NUMBER
   G_DEF_DATE_LENGTH   constant number(2)    := 8; --умолчательное значение размера поля DATE
   G_TRACE             constant varchar2(20) := 'bars_dbf.';
   G_MODULE            constant varchar2(3)  := 'REP';
 
   T_VARCHAR2 constant number :=1;
   T_NUMBER   constant number :=2;
   T_DATE     constant number :=12;
   T_CHAR     constant number :=96;
 
 
   G_WIN_ENCODE constant varchar2(20) := 'CL8MSWIN1251';
   G_DOS_ENCODE constant varchar2(20) := 'RU8PC866';
 
   CRTAB_NOACT constant number :=3; -- если табл. существ, ничего не далать , при импорте строки будут добавлены

   -- типы загружаемых блобов
   G_DBF_TYPE  constant char(3)  := 'DBF'; -- блоб для DBF файла
   G_MEMO_TYPE constant char(4) := 'MEMO'; -- мемо поле(файл) для FoxBase


   -- при вгрузке данных из DBF файла
   G_CRTAB_RECREATE constant number :=1; -- если табл. существ, пересоздать ее
   G_CRTAB_ADDTIME  constant number :=0; -- если табл. существ, создать такоеже имя + время создания
   G_CRTAB_DELDATA  constant number :=2; -- если табл. существ, удалить все данные из таблицы
   G_CRTAB_NOACT    constant number :=3; -- если табл. существ, ничего не далать , при импорте строки будут добавлены


   -- версия DBF
   G_DBFVERS_0   constant number := 0; -- неизвестный
   G_DBFVERS_3   constant number := 3; -- FoxBASE+/dBASE III +/FoxPro/dBASE IV, без memo - (первых два байта - 0х03)
   G_DBFVERS_131 constant number := 131; -- FoxBASE+/dBASE III +, с memo - (первых два байта -0х83) Файл с мемо - DBT (0x83)
   G_DBFVERS_245 constant number := 245; -- FoxPro с memo - 0хF5 (245). Файл с мемо - FPT
   G_DBFVERS_139 constant number := 139; -- dBASE IV с memo - 0x8B (139).Файл с мемо - DBT



 -----------------------------------------------------------------
 -- Переменные
 -----------------------------------------------------------------


   G_EXCH_BLOB_DBF blob := null; -- переменная содержащая файл
   G_EXCH_BLOB_MEMO blob := null; -- переменная содержащая файл c мемо полями
   G_SELECTED_ROWS number := 0; -- кол-во строк выбранных при экспорте в файл DBF
 
   g_dbfvers_list array_dbf_type; -- список всех версий DBF


 ----------------------------------------------------
 -- INIT_DBF_VERSION_LIST()
 --
 -- Заполнить массив существующих версий DBF
 --
 ----------------------------------------------------
    procedure init_dbf_version_list is
    begin

       g_dbfvers_list(G_DBFVERS_0).vers := G_DBFVERS_0;
       g_dbfvers_list(G_DBFVERS_0).descript := 'Неизвестный тип';
       g_dbfvers_list(G_DBFVERS_0).ismemo := 1;
       g_dbfvers_list(G_DBFVERS_0).memofile_ext := '*'; -- может быть любое расширение
 
       g_dbfvers_list(G_DBFVERS_3).vers := G_DBFVERS_3;
       g_dbfvers_list(G_DBFVERS_3).descript := 'FoxBASE+/dBASE III +/FoxPro/dBASE IV, без memo(0х03)';
       g_dbfvers_list(G_DBFVERS_3).ismemo := 0;
       g_dbfvers_list(G_DBFVERS_3).memofile_ext := null;
 
       g_dbfvers_list(G_DBFVERS_131).vers := G_DBFVERS_131;
       g_dbfvers_list(G_DBFVERS_131).descript := 'FoxBASE+/dBASE III +, с memo (0х83)';
       g_dbfvers_list(G_DBFVERS_131).ismemo := 1;
       g_dbfvers_list(G_DBFVERS_131).memofile_ext := 'DBT';
 
       g_dbfvers_list(G_DBFVERS_245).vers := G_DBFVERS_245;
       g_dbfvers_list(G_DBFVERS_245).descript := 'FoxPro с memo (0хF5)';
       g_dbfvers_list(G_DBFVERS_245).ismemo := 1;
       g_dbfvers_list(G_DBFVERS_245).memofile_ext := 'FPT';
 
       g_dbfvers_list(G_DBFVERS_139).vers := G_DBFVERS_139;
       g_dbfvers_list(G_DBFVERS_139).descript := 'dBASE IV с memo(0x8B)';
       g_dbfvers_list(G_DBFVERS_139).ismemo := 1;
       g_dbfvers_list(G_DBFVERS_139).memofile_ext := 'DBT';

 end;


    ----------------------------------------------------
    -- FREE_BUFFER()
    --
    -- Очистка глобальных буфферов
    --
    -- p_buff - буффер
    --
    ----------------------------------------------------
    procedure free_buffer(p_buff in out blob)  is
    begin
    if p_buff is not null then
    if dbms_lob.istemporary(p_buff) = 1 then
    dbms_lob.freetemporary(p_buff);
    end if;
    p_buff := null;
    end if;
    end;
    
    
    ----------------------------------------------------
    -- SET_BUFFER()
    --
    -- Инициализировать или добавить в буффер глоб. переменную
    --
    -- p_buff - кусок буффера
    -- p_bufftype - тип загружаемого файла (DBF, DBT)
    -- p_bufflen - Длинна буффера с данными
    --
    ----------------------------------------------------
    procedure set_buffer(
    p_buff varchar2,
    p_bufftype varchar2,
    p_bufflen number )
    is
    begin
    case p_bufftype
    when G_DBF_TYPE then
    if G_EXCH_BLOB_DBF is null then
    dbms_lob.createtemporary(G_EXCH_BLOB_DBF, true);
    end if;
    dbms_lob.writeappend(G_EXCH_BLOB_DBF, p_bufflen, utl_raw.cast_to_raw(substr(p_buff,1,p_bufflen)));
    when G_MEMO_TYPE then
    if G_EXCH_BLOB_MEMO is null then
    dbms_lob.createtemporary(G_EXCH_BLOB_MEMO, true);
    end if;
    dbms_lob.writeappend(G_EXCH_BLOB_MEMO, p_bufflen, utl_raw.cast_to_raw(substr(p_buff,1,p_bufflen)));
    end case;
    exception when others then
    G_SELECTED_ROWS := 0;
    free_buffer(G_EXCH_BLOB_DBF);
    free_buffer(G_EXCH_BLOB_MEMO);
    raise;
    end;
    
    

    ----------------------------------------
    -- CONVER_ENCODE_INSQL()
    --
    -- Создать поле для SQL, с конвертацией
    -- кодировки в процессе выполнения SQL-я
    --
    -- p_column -- поле SQL-я
    -- p_destencode -- нужная кодировка
    -- p_srcencode -- исходная кодировка
    --
    ----------------------------------------
    function convert_encode_insql(
    p_column varchar2,
    p_destencode varchar2,
    p_srcencode varchar2) return varchar2
    is
    begin
    
    if (p_destencode = p_srcencode) then
    return p_column;
    end if;
    

    if p_destencode = 'WIN' then
    
    if ( p_srcencode = 'DOS' or p_srcencode = 'UKG' ) then
    if p_srcencode = 'DOS' then
    return 'convert('||p_column||', '''||G_WIN_ENCODE||''','''||G_DOS_ENCODE||''')';
    else
    return 'translate('||p_column||', BARS.bars_dbf.get_tbl(''UKG''), bars_dbf.get_tbl(''WIN'') )';
    end if;
    else
    bars_error.raise_error(G_MODULE, 12, p_srcencode);
    end if;

    else
    
    if ( p_destencode = 'DOS' or p_destencode = 'UKG' ) then
    
    if p_destencode = 'DOS' then
    return 'convert('||p_column||', '''||G_DOS_ENCODE||''','''||G_WIN_ENCODE||''')';
    else
    return 'translate('||p_column||', bars_dbf.get_tbl(''WIN''), bars_dbf.get_tbl(''UKG'') )';
    end if;
    else
    bars_error.raise_error(G_MODULE, 12, p_srcencode);
    end if;
    
    end if;
    
    end;
    
    
    
    
    ----------------------------------------
    -- CONVERT_ENCODE()
    --
    -- Перекодировка строки
    --
    -- p_data -- строка
    -- p_destencode -- нужная кодировка
    -- p_srcencode -- исходная кодировка
    --
    ----------------------------------------
    function convert_encode(
       p_data varchar2,
       p_destencode varchar2,
       p_srcencode varchar2) return varchar2
    is
       l_trace varchar2(1000) := g_trace||'conver_encode: ';
    begin
    
    
       if (p_destencode = p_srcencode) then
         return p_data;
       end if;
    
    
    if p_destencode = 'WIN' then
    
    if ( p_srcencode = 'DOS' or p_srcencode = 'UKG' ) then
    if p_srcencode = 'DOS' then
    return convert(p_data, G_WIN_ENCODE, G_DOS_ENCODE);
    else
    return translate(p_data, bars_dbf.ukg_tbl, bars_dbf.win_tbl );
    end if;
    else
    bars_error.raise_error(G_MODULE, 12, p_srcencode);
    end if;


    else
    if ( p_destencode = 'DOS' or p_destencode = 'UKG' ) then
    
    if p_destencode = 'DOS' then
    return convert(p_data, G_DOS_ENCODE, G_WIN_ENCODE);
    else
    return translate(p_data, bars_dbf.win_tbl, bars_dbf.ukg_tbl);
    end if;
    else
    bars_error.raise_error(G_MODULE, 12, p_srcencode);
    end if;

    end if;
    
    exception when others then
    bars_audit.error(l_trace||' Ошибка преобразования из '||p_srcencode||' в '||p_destencode);
          bars_audit.error(l_trace||sqlerrm);
          raise;
       end;
    
    
    --------------------------------------------------
    --  GET_EXPORTED_ROWSCOUNT()
    --
    --    кол-во выгруженных строк в DBF
    --
    ----------------------------------------------------
    procedure get_exported_rowscount(p_rowscount out number)
    is
    begin
        p_rowscount := G_SELECTED_ROWS;
    end;



    ----------------------------------------------------
    --  GET_BUFFER()
    --
    --    Взять часть из буффера пакета
    --
    --
    ----------------------------------------------------
    procedure get_buffer(
                  p_buff     out varchar2,
                  p_bufflen  out number,
                  p_offset       number,
                  p_amount       number)
    is
       l_blob     blob;
       l_trace    varchar2(1000) := g_trace||'get_buffer: ';
    begin


       bars_audit.trace(l_trace||'buffer: '||p_offset);
       if G_EXCH_BLOB_DBF is null or
          (G_EXCH_BLOB_DBF is not null and dbms_lob.getlength(G_EXCH_BLOB_DBF) = 0) then
          bars_error.raise_error(G_MODULE, 22);
       end if;

       l_blob := dbms_lob.substr(G_EXCH_BLOB_DBF, p_amount, p_offset);
       p_buff := utl_raw.cast_to_varchar2(l_blob);

       p_bufflen := nvl(length(p_buff), 0);

       if  p_bufflen = 0 then
           dbms_lob.freetemporary(G_EXCH_BLOB_DBF);
           G_EXCH_BLOB_DBF := null;
       end if;


    exception when others then
       G_SELECTED_ROWS := 0;
       free_buffer(G_EXCH_BLOB_DBF);
       free_buffer(G_EXCH_BLOB_MEMO);
       raise;
    end;



    ----------------------------------------
    --  GET_MEMO_FIELD_DBT()
    --
    --    Получить клоб - для текста MEMO поля
    --
    --    Для FoxBase - это файл DBT, Структура аналогична, но размер блока фиксирован и - 512
    --                  В данный файл записи выводятся блоками, каждый размером 512 байтов.
    --                  В блок, начинающийся с нулевой позиции файла, включен номер блока,
    --                  соответствующий первой свободной позиции в файле.
    --                  Этот номер блока хранится в первых двух байтах в обратном порядке (формат Intel 8086).
    --                  Для того, чтобы найти адрес первого свободного блока,
    --                  надо размер одного блока (512 байтов) умножить на номер блока.
    --                  конец текста определяется наличием символа 1A
    --
    --
    --    p_mblob     - мемо файл
    --    p_blocknbr  - номер блока
    --    p_tablename - имя таблицы для которой проходит импорт
    --    p_srcencode - исходная кодировка memo
    --    p_force     - при ненахождении данного номера блока =1 - отдавать пусто, =0 - выдавать сообщение об ошибке
    --
    ----------------------------------------

    function  get_memo_field_dbt(
                  p_mblob     BLOB,
                  p_blocknbr  number,
                  p_tablename varchar2,
                  p_srcencode varchar2,
		  p_force     number    default 1 ) return clob
    is
       l_buff           blob;
       l_memolen        number;
       l_currpos        number;
       l_blockendpos    number;          -- позиция окончания блока
       l_blockcnt       number := 250;   -- кол-во блоков
       l_blocklen       number := 512;   -- длинна блока
       l_blockdata      varchar2(4000);
       l_fielddata      clob;
       l_trace          varchar2(1000)  := g_trace||'get_memo_field: ';
    begin

       dbms_lob.createtemporary(l_fielddata, true);

       l_currpos  := p_blocknbr * l_blocklen + 1;
       l_memolen  := dbms_lob.getlength(p_mblob);
       l_blockcnt := 1;

       --bars_audit.trace(l_trace||' Запросили блок -'||p_blocknbr||' общий размер -'||l_memolen||' текущая позиция -'||l_currpos);

       if l_currpos > l_memolen  then
          --Указанный номер блока %s для memo поля не существует
          if p_force = 1  then
              l_fielddata := ' ';
	     return l_fielddata ;
	  else
	     bars_error.raise_error(G_MODULE, 26, to_char(p_blocknbr), p_tablename );
	  end if;

       end if;


       loop

          if l_currpos > l_memolen then
             --bars_audit.trace(l_trace||'тек поз -'||l_currpos||' > длинны memo -'||l_memolen||' поле вычитано');
             return l_fielddata;
          end if;



          l_buff       := dbms_lob.substr(p_mblob, l_blocklen, l_currpos);
          l_blockdata  := replace(utl_raw.cast_to_varchar2(l_buff), chr(0),' ');

          -- chr(26) = 1A для foxbase - окончание текста мемо.
          l_blockendpos:= instr(l_blockdata, chr(26));
          if p_srcencode <> 'WIN' then
             l_blockdata := convert_encode(
                  p_data        => l_blockdata,
                  p_destencode  => 'WIN',
                  p_srcencode   => p_srcencode);
          end if;


          --Если в данном блоке находится окончание поля Мемо
          --выходим - отдаем текст


          if l_blockendpos > 0 then
             --bars_audit.trace(l_trace||'нашли конец поля -'||l_blockendpos||' поле вычитано');
             -- если первый символ это не окончание блока
             if l_blockendpos > 1 then
                l_blockdata := substr(l_blockdata, 1, l_blockendpos - 1);
                dbms_lob.writeappend(l_fielddata, length(l_blockdata ), l_blockdata);
             end if;
             return l_fielddata;
          else
             --bars_audit.trace(l_trace||'в данном блоке нету конца поля, читаем следующий блок');
             dbms_lob.writeappend(l_fielddata, length(l_blockdata), l_blockdata);
             l_currpos := l_currpos + l_blocklen;
          end if;


       end loop;
    exception when others then
       bars_audit.error(l_trace||' Ошибка вычитки блока №'||p_blocknbr);
       bars_audit.error(l_trace||sqlerrm);
       raise;
    end;


    ----------------------------------------------
    --    По ссылке получить текст мемо поля структуры FPT
    --
    --
    --    Для FoxPro  - это файл FPT.
    --                  Файл типа memo содержит одну запись заголовка и произвольное число блочных структур.
    --                  В записи заголовка располагается указатель на следующий свободный блок и размер
    --                  блока в байтах. Размер устанавливается командой SET BLOCKSIZE при создании файла.
    --                  Запись заголовка начинается с нулевой позиции файла и занимает 512 байтов.
    --                  За записью заголовка следуют блоки, в которых содержатся заголовок блока и текст memo.
    --                  В файл базы данных включены номера блоков, которые используются для ссылки на блоки memo.
    --                  Расположение блока в файле типа memo определяется умножением номера
    --                  блока на размер блока 3 (находящийся в записи заголовка файла типа memo).
    --                  Все блоки memo начинаются с четных адресов границ блоков.
    --                  Блок memo может занимать более, чем один последовательный блок.
    --                  г==========================================================¬
    --                  ¦ Запись заголовка файла типа memo
    --                  ¦¦-------T--------------------------------------------------
    --                  ¦¦ Байты ¦ Описание
    --                  ¦¦=======+==================================================
    --                  ¦¦ 00-03 ¦Расположение следующего свободного блока*
    --                  ¦¦-------+--------------------------------------------------
    --                  ¦¦ 04-05 ¦Не используются
    --                  ¦¦-------+--------------------------------------------------
    --                  ¦¦ 06-07 ¦Размер блока (число байтов в блоке)
    --                  ¦¦-------+--------------------------------------------------
    --                  ¦¦ 08-511¦Не используются
    --                  ¦¦=======¦==================================================
    --                  ¦¦ Заголовок блока memo и текст memo
    --                  ¦¦=======T==================================================
    --                  ¦¦ 00-03 ¦Сигнатура блока* (указывает тип данных в блоке):
    --                  ¦¦       ¦ а. 0 - шаблон (поле типа шаблон);
    --                  ¦¦       ¦ б. 1 - текст (поле типа memo)
    --                  ¦¦-------+--------------------------------------------------
    --                  ¦¦ 04-07 ¦Длина* memo (в байтах)
    --                  ¦¦-------+--------------------------------------------------
    --                  ¦¦ 08-n  ¦Текст memo (n=длина)
    --                  ¦L=======¦==================================================-
    --

    --    p_mblob     - мемо файл
    --    p_blocknbr  - номер блока
    --    p_srcencode - исходная кодировка memo
    ----------------------------------------------

    function  get_memo_field_fpt(
                  p_mblob     BLOB,
                  p_blocknbr  number,
                  p_tablename varchar2,
                  p_srcencode varchar2 ) return clob
    is
       l_buff           blob;
       l_memolen        number;
       l_currpos        number;
       l_blockendpos    number;          -- позиция окончания блока
       l_blockcnt       number := 250;   -- кол-во блоков
       l_blocklen       number := 512;   -- длинна блока
       l_blockdata      varchar2(4000);
       l_fielddata      clob;
       l_trace          varchar2(1000)  := g_trace||'get_memo_field_ftp: ';

       l_blocklen       number;   -- длинна блока
       l_frstblocklen   number := 512;   -- длинна первого, информационного блока
       l_memoinfo       varchar2(1000);
    begin



       /*bars_audit.trace(l_trace||'Запросили блок -'||p_blocknbr);
       dbms_lob.createtemporary(l_fielddata, false);

       -- позиция 7  от начала (2 байта) - длинна блока
       l_buff     := dbms_lob.substr(p_mblob, 2, 7);
       l_blocklen := utl_raw.cast_to_binary_integer( l_buff);

       bars_audit.trace(l_trace||'длинна блока = '||l_blocklen);
       */
       return null;

    end;



    ----------------------------------------
    --  GET_MEMO_FIELD()
    --
    --    Получить клоб - для текста MEMO поля
    --
    --    p_mblob     - мемо файл
    --    p_blocknbr  - номер блока
    --    p_srcencode - исходная кодировка memo
    --    p_memotype  - тип мемо (DBT/FPT)
    ----------------------------------------
    function  get_memo_field(
                  p_mblob     BLOB,
                  p_blocknbr  number,
                  p_tablename varchar2,
                  p_srcencode varchar2,
                  p_memotype  varchar2 ) return clob
    is
    begin
       case p_memotype
           when 'DBT' then
              return  get_memo_field_dbt( p_mblob     => p_mblob,
                                          p_blocknbr  => p_blocknbr,
                                          p_tablename => p_tablename,
                                          p_srcencode => p_srcencode);
           when 'FPT' then
              return  get_memo_field_fpt( p_mblob     => p_mblob,
                                          p_blocknbr  => p_blocknbr,
                                          p_tablename => p_tablename,
                                          p_srcencode => p_srcencode);

       end case;

    end;


    ----------------------------------------------------
    --  SQL_TYPE_DESC()
    --
    --    Дать описание типа по кодовому значению
    --
    --    p_val    -   числовое значение типа
    --
    ----------------------------------------------------
    function sql_type_desc(p_val number) return varchar2 is
    begin
       case p_val
            when T_VARCHAR2 then return 'VARCHAR2';
            when T_NUMBER   then return 'NUMBER';
            when T_DATE     then return 'DATE';
            when T_CHAR     then return 'CHAR';
        end case;
    end;



    ----------------------------------------------------
    --  GETRAW()
    --
    --    Преобразование в raw числа char, int, long
    --    p_val    -   значение числа
    --    p_type   -   символ типа
    --
    ----------------------------------------------------
    function getraw(p_val number, p_type char default 'i') return raw is
    begin
         case p_type
            when 'c' then return utl_raw.substr(utl_raw.cast_from_binary_integer(p_val),4,1);
            when 'l' then return utl_raw.reverse(utl_raw.cast_from_binary_integer(p_val));
            when 'i' then return utl_raw.reverse(utl_raw.substr(utl_raw.cast_from_binary_integer(p_val),3,2));
        end case;
    end;




    ----------------------------------------
    --  GET_TBL()
    --
    --    Отдать таблицу символов
    --
    --    p_val    -   значение
    --    p_type   -   символ типа
    --
    ----------------------------------------
    function get_tbl(p_encode_table varchar2) return varchar2 is
    begin
         case p_encode_table
           when 'WIN' then  return WIN_TBL;
           when 'UKG' then  return UKG_TBL;
       end case;
    end;




    ----------------------------------------
    --  GETRAW()
    --
    --    Преобразование в raw  строки
    --
    --    p_val    -   значение
    --    p_type   -   символ типа
    --
    ----------------------------------------
    function getraw(p_val varchar2, p_type char default 's') return raw is
    begin
         case p_type
           when 's' then  return utl_raw.cast_to_raw(p_val);
       end case;
    end;




    ----------------------------------------
    --  CONSTRUCT_DBF_HEADER()
    --
    --    Формирование заголовка DBF-а из массива имен колонок,
    --    типов колонок, длин колонок
    --
    --    p_header     -  описание HEADER-а
    --    p_DBFHeader  -  сформированны заголовок
    --
    ----------------------------------------
    procedure construct_dbf_header(
                    p_header        t_dbf_header,
                    p_DBFHeader out blob)
    is
       l_DBFHeader  blob;
       l_hdr        t_dbf_header;
    begin

       l_hdr:=p_header;
       dbms_lob.createtemporary(l_DBFHeader, true);
       -- тип DBF файла
       dbms_lob.append(l_DBFHeader,getraw(3, p_type=>'c') );

       -- текущая дата (3 byte)
       dbms_lob.append(l_DBFHeader,getraw(to_number(to_char(sysdate,'yy')), p_type=>'c'));
       dbms_lob.append(l_DBFHeader,getraw(to_number(to_char(sysdate,'mm')), p_type=>'c'));
       dbms_lob.append(l_DBFHeader,getraw(to_number(to_char(sysdate,'dd')), p_type=>'c'));


       -- кол-во записей (4 byte), храним в обр. порядке для intel
       dbms_lob.append(l_DBFHeader,getraw(l_hdr.rowcnt,p_type=>'l'));


       -- Положение первой записи с данными (2 byte )
       -- 32 byte - кол-во байт до описания колонок
       -- 32 + 1  - это длинна структуры описания поля * кол-во колонок
       dbms_lob.append(l_DBFHeader,getraw( (32+32*(l_hdr.colcnt) + 1 ),  p_type=>'i'));

       --Длина одной записи с данными (включая признак удаления) + 1 признак удаления
       dbms_lob.append(l_DBFHeader,getraw(l_hdr.rowlen + 1));

       --Резерв 16 byte
       for i in 1..16 loop
         dbms_lob.append(l_DBFHeader,getraw(0, p_type=>'c'));
       end loop;

       --Индексный файл 1
       dbms_lob.append(l_DBFHeader,getraw(0, p_type=>'c'));

       --Резерв 3 byte
       for i in 1..3 loop
         dbms_lob.append(l_DBFHeader,getraw(0,p_type=>'c') );
      end loop;


      -- подзаписи полей
      for i in 1..l_hdr.colcnt loop
        -- имя поля  + код типа поля  (12 byte )
        dbms_lob.append(l_DBFHeader,getraw(rpad(l_hdr.colname(i),11,chr(0))||l_hdr.coltype(i)));
        -- номер поля по-порядку  (4 byte)
        dbms_lob.append(l_DBFHeader,getraw(i, p_type=>'l'));


        if l_hdr.colscl(i)=0 then
          --длинна поля (2 byte)
          dbms_lob.append(l_DBFHeader,getraw(l_hdr.collen(i), p_type=>'i'));
        else
          -- длинна поля и дробная часть
          dbms_lob.append(l_DBFHeader,getraw(l_hdr.collen(i), p_type=>'c'));
          dbms_lob.append(l_DBFHeader,getraw(l_hdr.colscl(i), p_type=>'c'));
        end if;
         --резерв (14 byte)
        for k in 1..14 loop
              dbms_lob.append(l_DBFHeader,getraw(0, p_type=>'c'));
        end loop;
      end loop;

     --конец заголовка
     dbms_lob.append(l_DBFHeader,getraw(13, p_type=>'c'));

     p_DBFHeader := l_DBFHeader;
    end;



    ----------------------------------------
    --  GET_PROPER_NAME
    --
    --    откорректиовать имя столбца, если это резервное слово
    --
    --    p_objname    -  имя колонки
    --
    ----------------------------------------
    function get_proper_name(
                    p_objname        varchar2) return varchar2
    is
       --l_keyword varchar2(100);
    begin
       /*select keyword into l_keyword from v$reserved_words where
         keyword = upper(p_objname);
         return '"'||p_objname||'"';

          exception when no_data_found then
          return p_objname;
       */
       return '"'||upper(p_objname)||'"';
    end;

    ----------------------------------------
    --  PARSE_DBF_STRUCT
    --
    --    По имени таблицы в oracle  заполнить поля Header-а
    --
    --    p_tabname    -  имя таблицы
    --    p_header     -  переменная для наполнеия
    --
    ----------------------------------------
    procedure parse_dbf_struct(
                    p_tablename         varchar2,
                    p_where_clause      varchar2,
                    p_header        out t_dbf_header)
    is
       l_tabname     user_tables.table_name%type;
       l_trace       varchar2(2000);
       l_hdr         t_dbf_header;
       l_sql         varchar2(2000);
       i             integer;
    begin
       l_trace:=g_trace||'parse_dbf_struct:';

   begin

       select table_name into l_tabname  from user_tables where table_name=upper(p_tablename);
       exception when no_data_found then
         bars_error.raise_error(G_MODULE, 3, upper(p_tablename));
       end;

       -- колво строк
           l_sql:='select count(*)  from '|| p_tablename;
           if (p_where_clause is not null) then
                    l_sql:=l_sql || ' where '|| p_where_clause;
           end if;

       bars_audit.trace(l_trace||l_sql);
           execute immediate l_sql into l_hdr.rowcnt;

       -- колво колонок
       select count(*) into l_hdr.colcnt
       from  user_tab_columns where table_name=upper(p_tablename);
       bars_audit.trace(l_trace||' colcnt='||l_hdr.colcnt);

       i:=1;
       -- информация по  колонкам
       for c  in  ( select column_name, data_type, data_length,  data_precision,  data_scale
                        from user_tab_columns
                                    where table_name=upper(p_tablename)
                                    order by column_id ) loop

            l_hdr.colname(i) := c.column_name;


            case
                 when c.data_type = 'DATE' then
                      l_hdr.coltype(i):= 'D';
                      l_hdr.collen(i) := G_DEF_DATE_LENGTH;
                      l_hdr.colscl(i) := 0;

                 when c.data_type = 'VARCHAR2' or c.data_type = 'CHAR' then
                      l_hdr.coltype(i):= 'C';
                      l_hdr.collen(i) := c.data_length;
                      l_hdr.colscl(i) := 0;

                 when c.data_type = 'NUMBER' then
                      l_hdr.coltype(i):= 'N';
                      if (nvl(c.data_precision,0) = 0) then
                         l_hdr.collen(i) := c.data_length;
                         l_hdr.colscl(i) := 0;
                      else   -- для dbf-а длинна колоки - это длинна целой части + дробной + 1(точка)
                         l_hdr.collen(i) := c.data_precision;
                         if (nvl(c.data_scale,0) <>0) then
                            l_hdr.collen(i) := l_hdr.collen(i) + c.data_scale + 1;
                         end if;
                            l_hdr.colscl(i) := c.data_scale;
                      end if;
                 else
                    bars_error.raise_nerror(G_MODULE, 'NOTCORRECT_DATATYPE', c.column_name, c.data_type );
            end case;
            --bars_audit.trace(l_trace||'описание колонки: '||l_hdr.colname(i)||'-'||l_hdr.coltype(i)||'-'||l_hdr.collen(i)||'-'||l_hdr.colscl(i));
            i:=i+1;
           end loop;


       l_hdr.rowlen:=0;
       for i in 1..l_hdr.colcnt loop
           l_hdr.rowlen:=l_hdr.rowlen + l_hdr.collen(i);
       end loop;

           p_header:=l_hdr;

    end;



    ----------------------------------------
    --  PARSE_DBF_STRUCT
    --
    --    По открытому курсору заполнить поля Header-а
    --
    --    p_cur        -  описание DBF структуры
    --    p_header     -  переменная для наполнеия
    --
    ----------------------------------------
    procedure parse_dbf_struct(
                    p_cur        integer,
                    p_header out t_dbf_header)
    is
       l_trace       varchar2(2000);
       l_hdr         t_dbf_header;
       l_tabrow      dbms_sql.desc_tab;
       l_colcnt      number;
       i             number;
    begin
       l_trace:=g_trace||'parse_dbf_struct:';
       dbms_sql.describe_columns(p_cur, l_colcnt, l_tabrow);
       l_hdr.colcnt:=l_colcnt;

       i := l_tabrow.first;

       loop
          l_hdr.colname(i):= l_tabrow(i).col_name;
               l_hdr.rowlen    := 0;
          case   when l_tabrow(i).col_type = T_DATE then
                      l_hdr.coltype(i):= 'D';
                                     l_hdr.collen(i) := G_DEF_DATE_LENGTH;
                      l_hdr.colscl(i) := 0;

                 when l_tabrow(i).col_type = T_VARCHAR2 or l_tabrow(i).col_type = T_CHAR then
                      l_hdr.coltype(i):= 'C';
                                     l_hdr.collen(i) := l_tabrow(i).col_max_len;
                      l_hdr.colscl(i) := 0;

                 when l_tabrow(i).col_type = T_NUMBER then
                      --bars_audit.trace(l_trace||l_hdr.colname(i)||': number: max_len='||l_tabrow(i).col_max_len||' pres='||l_tabrow(i).col_precision||' scale='|| l_tabrow(i).col_scale);
                      l_hdr.coltype(i):= 'N';
                      if l_tabrow(i).col_precision = 0 then
                         l_hdr.collen(i) := l_tabrow(i).col_max_len;
                         l_hdr.colscl(i) := 0;
                      else
                         -- для dbf-а длинна колоки - это длинна целой части + дробной + 1(точка)
                         l_hdr.collen(i) := l_tabrow(i).col_precision + l_tabrow(i).col_scale + 1;
                         l_hdr.colscl(i) := l_tabrow(i).col_scale;
                      end if;
                 else
                      bars_error.raise_nerror(G_MODULE, 'NOTCORRECT_DATATYPE', l_hdr.colname(i), to_char(l_tabrow(i).col_type) );

                 end case;

           i := l_tabrow.next(i);
           exit when (i is null);
       end loop;

       l_hdr.rowlen:=0;
       for i in 1..l_hdr.colcnt loop
           l_hdr.rowlen:=l_hdr.rowlen + l_hdr.collen(i);
       end loop;

           p_header:=l_hdr;

    end;




    ----------------------------------------
    --  CHANGE_DECIMAL_SEPARATOR
    --
    --    В описании структуры, символ разделяющий дробную часть и разделитель полей - запятая.
    --    Для того, что б вычленить колонки по запятой, нужно заменить запятую(разделитель разрядов),
    --    другим символом
    --
    --    p_dbfstruct -  описание структуры DBF
    --    p_separator -  знак разделителя
    --    p_tokens    -  исходящий массив в?члененн?х строк
    ----------------------------------------

    function change_decimal_separator(p_dbfstruct varchar2, p_chagewith char) return varchar2
    is
       l_dbfdesc   varchar2(4000);
       l_dbfres    varchar2(4000);
       l_tmp       varchar2(4000);
       l_tmp2      varchar2(4000);
       l_indx      number;
       l_indx2     number;
    begin
       -- заменить символ , в разделителе разрядов
       l_dbfdesc := p_dbfstruct;

       while instr(l_dbfdesc, '(') > 0 loop
           l_indx  := instr(l_dbfdesc, '(');
           l_indx2 := instr(l_dbfdesc, ')');
           if  l_indx2 <= 0 then
              bars_error.raise_nerror(G_MODULE, 'NO_CLOSE_BRACKET');
           end if;

           l_tmp  := substr(l_dbfdesc, 1, l_indx-1);
           l_tmp2 := substr(l_dbfdesc, l_indx, (l_indx2-l_indx+1));

           if instr( l_tmp2, ',' ) > 0 then
              l_tmp2 := replace (l_tmp2,',', p_chagewith);
           end if;

           l_dbfres  := l_dbfres ||l_tmp ||l_tmp2;
           l_dbfdesc := substr(l_dbfdesc, l_indx2+1);
       end loop;
       l_dbfres := l_dbfres||l_dbfdesc;
       return  l_dbfres;

    end;

    ----------------------------------------
    --  GET_TOKENS
    --
    --    по строке, вычленить сроки, разделенные символом p_separator
    --    Учитывается также, если символ заключен в кавычки, например  (,)
    --    он не является разделительным символом
    --
    --    p_tokenlist -  список строк через разделитель
    --    p_separator -  знак разделителя
    --    p_tokens    -  исходящий массив в?члененн?х строк
    ----------------------------------------
    procedure get_tokens(
                    p_tokenlist       varchar2,
                    p_separator       char,
                    p_tokens      out vrchr_array)
    is
       l_tokenlist   varchar2(4000);
       l_tmp         varchar2(4000);
       l_indx        number;
       l_pos         number;
       l_newsepar    char := '#';
       i             number:=1;
    begin
       -- убрать переводы каретки, табуляцию
       l_tokenlist := replace(replace(replace(p_tokenlist,chr(10),' '),chr(13),' '), chr(9), ' ');

       if p_separator = ',' then
          -- заменить запятую, которая разделяет друбную часть в описании размерности поля
          l_tokenlist := change_decimal_separator(l_tokenlist, l_newsepar);
       end if;
       bars_audit.trace('после замены -'||l_tokenlist);

       while (instr(l_tokenlist,p_separator)>0) loop

           l_indx:=1;
           l_pos := instr(l_tokenlist,p_separator,1, l_indx);
           l_tmp := substr(l_tokenlist, 1, l_pos-1);

           -- пока разделитель заключен в скобки
           while (instr(l_tmp, '(')>0  and instr(l_tmp, ')') <=0  ) loop
              l_indx:= l_indx+1;
              l_pos := instr(l_tokenlist,p_separator,1, l_indx);
              l_tmp := substr(l_tokenlist, 1, l_pos-1);
           end loop;

           p_tokens(i) :=  trim(l_tmp);
           i:=i+1;
           l_tokenlist:= substr(l_tokenlist, l_pos + 1);
       end loop;
       p_tokens(i) := trim(l_tokenlist);

       if p_separator = ',' then
          for j in 1..p_tokens.count loop
              p_tokens(j) := replace(p_tokens(j), l_newsepar, ',');
              bars_audit.trace(p_tokens(j));
          end loop;
       end if;
    end;





    ----------------------------------------
    --  PARSE_DBF_STRUCT
    --
    --    По строке описания DBF структуры от пользователя
    --    (описание полей производится через запятую)
    --    наполнить переменную
    --
    --
    --    p_dbfstruct  -  описание DBF структуры
    --    p_cur        -  открытый курсор для валидации описанной схемы
    --    p_header     -  переменная для наполнеия
    --
    ----------------------------------------
    procedure parse_dbf_struct(
                    p_dbfstruct     varchar2,
                    p_cur           number,
                    p_header    out t_dbf_header)
    is
       l_onecoltype  varchar2(500);
       l_coldesc     vrchr_array;
       l_colcnt      number;
       l_trace       varchar2(2000);
       l_hdr         t_dbf_header;
       i1            smallint;
       i2            smallint;
       i3             smallint;
       l_colseparator varchar2(1):=',';
       l_tabrow      dbms_sql.desc_tab;
    begin

       l_trace:=g_trace||'parse_dbf_struct:';

       -- описание колонок в массив
       get_tokens(p_dbfstruct, l_colseparator,l_coldesc);

       dbms_sql.describe_columns(p_cur, l_colcnt, l_tabrow);

       l_hdr.colcnt := l_coldesc.count;

       for i in 1..l_hdr.colcnt loop

           l_coldesc(i)     := trim(l_coldesc(i));
           l_hdr.colname(i) := trim(substr(l_coldesc(i), 1, instr(l_coldesc(i), ' ')-1));
           l_coldesc(i)     := trim(substr(l_coldesc(i), instr(l_coldesc(i), ' ') + 1));

           -- тип данных без размерности
           if ( instr(l_coldesc(i),'(')=0 ) then

              case upper(l_coldesc(i))
                       when 'DATE'    then  l_hdr.collen(i) := G_DEF_DATE_LENGTH;
                                            l_hdr.colscl(i) := 0;
                                            l_hdr.coltype(i):='D';

                       when 'LOGICAL' then  l_hdr.collen(i) := 1;
                                            l_hdr.colscl(i) := 0;
                                            l_hdr.coltype(i):='L';

                       when 'NUMBER'  then  l_hdr.collen(i) := G_DEF_NUMBER_LENGTH;
                                            l_hdr.colscl(i) := 0;
                                            l_hdr.coltype(i):='N';

                       when 'CHAR'    then  l_hdr.collen(i) := 1;
                                            l_hdr.colscl(i) := 0;
                                            l_hdr.coltype(i):='C';

                       else  bars_error.raise_error(G_MODULE, 'NOTCORRECT_DATATYPE', l_hdr.colname(i) , l_coldesc(i) );

              end case;


            -- тип данных с размерностью
            else
               l_onecoltype:=  substr(l_coldesc(i), 1, instr(l_coldesc(i),'(')-1);
               i1 :=  instr(l_coldesc(i),'(')-1;
               --bars_audit.trace('l_coldesc = '||l_coldesc(i)||' istr='||i1||' onecoltype='||l_onecoltype);
               case upper(l_onecoltype)
                          when 'NUMBER' then  l_hdr.coltype(i):='N';
                          when 'CHAR'   then  l_hdr.coltype(i):='C';
                          else bars_error.raise_nerror(G_MODULE, 'NOTCORRECT_DATATYPE', l_hdr.colname(i), l_onecoltype);
               end case;

                     l_coldesc(i) := substr(l_coldesc(i), instr(l_coldesc(i),'(')+1 );

               if (instr(l_coldesc(i),',')<>0) then  -- Number with scale  precisiom
                   i1:=instr(l_coldesc(i),',')-1  ;
                   i2:=instr(l_coldesc(i),',')+1 ;
                         i3:=instr(l_coldesc(i),')') ;

                   -- для dbf-а длинна колоки - это длинна целой части + дробной + 1(точка)
                   l_hdr.colscl(i) := to_number( substr(l_coldesc(i),i2, i3-i2));

                   l_hdr.collen(i) := to_number( substr(l_coldesc(i),1, i1  ) ) + 1;

               else
                   l_hdr.collen(i) := to_number( substr(l_coldesc(i),instr(l_coldesc(i),','),
                                                 instr (l_coldesc(i),')')-1));
                   l_hdr.colscl(i) := 0;
                   end if;

           end if;
           --bars_audit.trace(l_trace||'описание колонки: '||l_hdr.colname(i)||'-'||l_hdr.coltype(i)||'-'||l_hdr.collen(i)||'-'||l_hdr.colscl(i));

       end loop;

       l_hdr.rowlen:=0;
       for i in 1..l_hdr.colcnt loop
           l_hdr.rowlen:=l_hdr.rowlen + l_hdr.collen(i);
       end loop;

       p_header:=l_hdr;

     end;


    ----------------------------------------
    -- HEADER_TO_STRING
    --
    --    Показать в нормальном видечто представляет собой header
    --
    --    p_header        -- Header
    --
    ----------------------------------------
    function  header_to_string( p_header    t_dbf_header)
    return varchar2
    is
       l_hdrdesc  varchar2(32000);
    begin
       l_hdrdesc:='vers:'||p_header.vers.vers||' - '|| p_header.vers.descript||chr(13)||chr(10)||
                  'colcnt='||p_header.colcnt||' rowlen='||p_header.rowlen||' rowcnt='||nvl(p_header.rowcnt,0)||chr(13)||chr(10);

       l_hdrdesc:=l_hdrdesc||' columns description:'||chr(13)||chr(10);
       for i in 1..p_header.colcnt loop
           l_hdrdesc:= l_hdrdesc||i||'.  name: '||p_header.colname(i)||' type:'||p_header.coltype(i)||' length: '||p_header.collen(i) ||
                                     ' scale: '||p_header.colscl(i)||chr(13)||chr(10);
           end loop;
           return  substr(l_hdrdesc,1,3800)||case when length(l_hdrdesc) > 3800 then ' and others ...' else '' end;
    end;




    ----------------------------------------
    --  GET_DBFDATA_FROM_TABLE()
    --
    --   Выгрузка данных из таблицы для создания DBF
    --   в blob Header-а и Body
    --
    --   p_tabnam        - имя таблицы для выгрузки
    --   p_where_clause  - WHERE условие выборки данных из таблицы (без слова WHERE)
    --   p_encode        - кодировка
    --   p_blobheader    - исходящий блоб header-a,
    --   p_blobbody      - исходящий блоб body
    --
    ----------------------------------------

    procedure get_dbfdata_from_table (
                     p_tabname           varchar2,
                     p_where_clause      varchar2 default '',
                     p_encode            varchar2 default 'WIN',
                                     p_blobheader    out blob,
                                     p_blobbody      out blob )
    is
       l_hdr           t_dbf_header;
       l_sqlcol        varchar2(4000);
       l_data          varchar2(4000);
       l_sql           varchar2(4000);
       type type_cur   is ref cursor;
       l_cur           type_cur;
       l_trace         varchar2(2000);
       l_blobHeader    blob ;
       l_blobBody      blob ;
       l_colname       varchar2(100);
       l_rows_cnt      number := 0;
    begin

    l_trace:=g_trace||'get_dbfdata_from_table:';

       parse_dbf_struct(p_tabname, p_where_clause,  l_hdr);
       bars_audit.trace(l_trace||header_to_string(l_hdr));

       -- Начало вычитки данных
       l_sql:='select ';


       for i in 1..l_hdr.colcnt loop

           l_colname:= get_proper_name(l_hdr.colname(i));
           case l_hdr.coltype(i)
                            when 'D' then
                                 l_sqlcol:= 'lpad(nvl(to_char('||l_colname||',''yyyymmdd''), '' ''),'||G_DEF_DATE_LENGTH||') ';
                            when 'C' then
                                 --l_sqlcol:= 'rpad(nvl('|| encode_sql(l_colname, p_encode) ||','' ''),'||l_hdr.collen(i)||')';
                                 -- считаем, что данные в БД в WIN
                                 l_sqlcol:= 'rpad(nvl('|| convert_encode_insql(l_colname, p_encode, 'WIN') ||','' ''),'||l_hdr.collen(i)||')';
                              when 'N' then
                                   l_sqlcol:= 'lpad(nvl(to_char('||l_colname||'),'' ''),'||l_hdr.collen(i)||')';
                   end case;
           if  i = 1 then
               -- строка всегда начинается с символа пробела
                       l_sql:=l_sql ||''' ''||'||l_sqlcol;
                   else
                          l_sql:=l_sql ||'||'||l_sqlcol;
                   end if;
           end loop;

       l_sql:=l_sql || ' from '|| p_tabname;

       if (p_where_clause is not null ) then
           l_sql:=l_sql || ' where '|| p_where_clause;
           end if;

       bars_audit.trace(l_trace||'sql: '||l_sql);

       open l_cur for l_sql;

       dbms_lob.createtemporary(l_blobBody,  true);
       dbms_lob.createtemporary(l_blobHeader,true);
       loop
          fetch l_cur into l_data;
          exit when  l_cur%notfound;
          l_rows_cnt := l_rows_cnt + 1;
          dbms_lob.writeappend(l_blobBody, length(l_data), getraw(l_data));
       end loop;

       close l_cur;

       -- собрать блоб для Header-а
       construct_dbf_header(l_hdr, l_blobHeader);
       p_blobheader:= l_blobHeader;
       p_blobbody  := l_blobBody;

       bars_audit.trace(l_trace||'выбрано '||G_SELECTED_ROWS||' строк ');
       G_SELECTED_ROWS :=  l_rows_cnt;

    end;



    ----------------------------------------
    --  CONSTRUCT_DBF()
    --
    --   По блобам header-a и body сформировать blob header-a
    --   Centura DBase Driver
    --
    --   p_blobheader   - имя таблицы для выгрузки
    --   p_blobbody     - WHERE условие выборки данных из таблицы (без слова WHERE)
    --   p_blobdbf      - кодировка
    --
    ----------------------------------------
    procedure construct_dbf (
                     p_blobheader     blob,
                     p_blobbody       blob,
                     p_blobdbf    out blob)
    is
       l_blobDBF       blob ;
    begin
       dbms_lob.createtemporary(l_blobDBF,  true);

       dbms_lob.append(l_blobDBF, p_blobheader  );
       dbms_lob.append(l_blobDBF, p_blobbody );



       p_blobdbf:=l_blobDBF;

    end;




    ----------------------------------------
    --  DBF_FROM_TABLE()
    --
    --    Выгрузка таблицы в DBF формат без указания формата файла DBF -
    --    по правилам Centura DBase Driver
    --    Как результат в переменную p_blobdbf помещается созданный dbf
    --
    --    p_tabnam        - имя таблицы для выгрузки
    --    p_where_clause  - WHERE условие выборки данных из таблицы (без слова WHERE)
    --    p_encode        - кодировка
    --    p_blobdbf       - переменная в которую помещаем результирующий blob DBF-а.
    --
    ----------------------------------------
    procedure dbf_from_table (
                     p_tabname           varchar2,
                     p_where_clause      varchar2 default '',
                     p_encode            varchar2 default 'WIN',
                     p_blobdbf       out blob )
    is
       l_blobheader    blob ;
       l_blobbody      blob ;
       l_blobdbf       blob ;
       l_trace         varchar2(2000);

    begin
        l_trace:=g_trace||'dbf_from_table:';

        get_dbfdata_from_table (
                     p_tabname      => trim(upper(p_tabname)),
                     p_where_clause => p_where_clause,
                     p_encode       => p_encode,
                       p_blobheader   => l_blobHeader,
                       p_blobbody     => l_blobBody );

        construct_dbf (l_blobheader, l_blobbody, l_blobdbf);

        dbms_lob.freetemporary(l_blobheader);
        dbms_lob.freetemporary(l_blobbody);

        p_blobdbf:= l_blobdbf;
    end;




    ----------------------------------------
    --  DBF_FROM_TABLE()
    --
    --    Выгрузка таблицы в DBF формат без указания формата файла DBF - по правилам
    --    Centura DBase Driver
    --    Как результат во временную таблицу tmp_lob (колонка rawdata)
    --    помещаем тело созданого DBF. Это для дальнейшей работы с
    --    blob-ами в Centure, через функции PutLoadedDBFToFile (absapi.apl)
    --
    --    p_tabnam        - имя таблицы для выгрузки
    --    p_where_clause  - WHERE условие выборки данных из таблицы (без слова WHERE)
    --    p_encode        - кодировка
    --
    ----------------------------------------
    procedure dbf_from_table (
                     p_tabname       varchar2,
                     p_where_clause  varchar2 default '',
                     p_encode        varchar2 default 'WIN')
    is
       l_blobdbf       blob ;

    begin

        dbf_from_table (
                     p_tabname,
                     p_where_clause,
                     p_encode,
                     l_blobdbf);

        bars_lob.export_blob(l_blobdbf);
        dbms_lob.freetemporary(l_blobdbf);

    end;




    ----------------------------------------
    -- COMPARE_DBF_DESC ()
    --
    --    Сравнить описание dbf структуры (из переменной p_hdr -
    --    в ней находится уже разобранное описание полей через запятую), с
    --    типами полей в запросе. Если он не совпадают, напрмер SQL
    --    возвращает дату, а мы описали NUMBER - отдать ошибку
    --
    --    p_cur     -  открытый курсор,
    --    p_hdr     -  описание колонок
    --    p_errcode -  код ошибки из err_rep.sql
    --    p_errmsg -  текст ошибки из err_rep.sql
    --
    ----------------------------------------
    procedure  compare_dbf_desc(
                  p_cur     number,
                  p_hdr     t_dbf_header,
                  p_errcode out varchar2,
                  p_errmsg out varchar2 )
    is
       l_tabrow      dbms_sql.desc_tab;
       l_colcnt      number;
       l_trace       varchar2(2000);
       l_err         smallint := 0;
       i             smallint := 0;
    begin

       p_errcode := '0000';
       l_trace:=g_trace||'compare_dbf_desc:';
       dbms_sql.describe_columns(p_cur, l_colcnt, l_tabrow);

       if  l_colcnt <> p_hdr.colcnt then
           p_errcode := '0019';
           p_errmsg  := bars_error.get_nerror_text(G_MODULE, 'WRONG_COLCNT',  to_char(l_colcnt), to_char(p_hdr.colcnt));
           return;
       end if;


       i := l_tabrow.first;

       loop


          case   when p_hdr.coltype(i) = 'D'  then
                      if l_tabrow(i).col_type <> T_DATE then
                         l_err:=1;
                      end if;

                 when p_hdr.coltype(i) = 'C' then
                      if  l_tabrow(i).col_type <> T_VARCHAR2 and l_tabrow(i).col_type <> T_CHAR  then
                          l_err:=1;
                      end if;

                 when p_hdr.coltype(i) = 'N' then
                      if  l_tabrow(i).col_type <> T_NUMBER  then
                          l_err:=1;
                      end if;

                 -- Logical  мапим в char(1) или number(1)
                 when p_hdr.coltype(i) = 'L' then
                      if     l_tabrow(i).col_type <> T_VARCHAR2
                         and l_tabrow(i).col_type <> T_CHAR
                         and l_tabrow(i).col_type <> T_NUMBER   then
                         l_err:=1;
                      end if;

                 else
                   p_errcode := '0005';
                   p_errmsg  := bars_error.get_nerror_text(G_MODULE, 'NOTCORRECT_DATATYPE', p_hdr.colname(i), to_char(l_tabrow(i).col_type));
                   return;
                end case;

                if l_err = 1 then
                   p_errcode := '0020';
                   p_errmsg  := bars_error.get_nerror_text(G_MODULE, 'WRONG_COLTYPE', p_hdr.colname(i), p_hdr.coltype(i), sql_type_desc(l_tabrow(i).col_type)  );
                   return;
                end if;

           i := l_tabrow.next(i);
           exit when (i is null);

       end loop;

    end;


    ----------------------------------------
    -- COMPARE_DBF_DESC ()
    --
    --    Сравнить описание dbf структуры (из переменной p_hdr -
    --    в ней находится уже разобранное описание полей через запятую), с
    --    типами полей в запросе. Если он не совпадают - выкинуть ошибку
    --
    --    p_cur     -  открытый курсор,
    --    p_hdr     -  описание колонок
    --
    ----------------------------------------
    procedure  compare_dbf_desc(
                  p_cur     number,
                  p_hdr     t_dbf_header)
    is
       l_errcode varchar2(4);
       l_errmsg  varchar2(500);
    begin
       compare_dbf_desc(
                  p_cur     => p_cur,
                  p_hdr     => p_hdr,
                  p_errcode => l_errcode,
                  p_errmsg  => l_errmsg);
       if l_errcode <> '0000' then
          bars_error.raise_nerror(G_MODULE, 'GENERIC_ERROR', l_errmsg );
       end if;

    end;
    ----------------------------------------
    -- GET_DBFDATA_FROM_SQL ()
    --
    --    Фрмирование блобов header-а и body для DBF по указанному запросу
    --
    --    p_sql        -- SQL запрос
    --    p_dbfstruct  -- структура описанная через запятую (если отсутсвует структура берется из описания SQL-я)
    --    p_encode     -- кодировка
    --    p_blobheader    - исходящий блоб header-a,
    --    p_blobbody      - исходящий блоб body
    --
    ----------------------------------------
    procedure  get_dbfdata_from_sql(
                  p_sql            varchar2,
                  p_dbfstruct      varchar2 default null,
                      p_encode         varchar2 default 'WIN',
                    p_blobheader out blob,
                  p_blobbody   out blob)
    is
       l_blobHeader    blob ;
       l_blobBody      blob ;
       l_data          varchar2(4000);
       l_vrchrcol      varchar2(4000);
       l_nmbrcol       number(38,10);
       l_datecol       date;
       l_clobcol       clob;
       l_format        varchar2(50);
       l_hdr           t_dbf_header;
       l_cur           number;
       l_ret           number;
       l_trace         varchar2(2000);
       i               number;

    begin
       l_trace:=g_trace||' get_dbfdata_from_sql:';


       dbms_lob.createtemporary(l_blobBody,  true);
       dbms_lob.createtemporary(l_blobHeader,true);


       -- собственно данные
       l_cur :=dbms_sql.open_cursor;
       bars_audit.trace(l_trace||'Выполнение запроса:'||p_sql);
       dbms_sql.parse(l_cur, p_sql, dbms_sql.native);

       if (p_dbfstruct is not null) then

          parse_dbf_struct(p_dbfstruct, l_cur, l_hdr);
          compare_dbf_desc(l_cur, l_hdr);

       else
          parse_dbf_struct(l_cur, l_hdr);
       end if;
       bars_audit.trace(l_trace||header_to_string(l_hdr));

       l_ret:=dbms_sql.execute(l_cur);




       for i in 1..l_hdr.colcnt  loop
           -- основываемся сдесь на нашем описании структуры
           case l_hdr.coltype(i)
                     when 'D' then   dbms_sql.define_column(l_cur,i,l_datecol);
               when 'C' then   dbms_sql.define_column(l_cur,i,l_vrchrcol, l_hdr.collen(i));
               when 'N' then   dbms_sql.define_column(l_cur,i,l_nmbrcol);
               when 'L' then   dbms_sql.define_column(l_cur,i,l_vrchrcol, 1);
               end case;
       end loop;




       l_hdr.rowcnt:=0;
       while dbms_sql.fetch_rows(l_cur) != 0 loop
          l_data:=' ';
          l_hdr.rowcnt:=l_hdr.rowcnt+1;
          for k in 1..l_hdr.colcnt loop
              case l_hdr.coltype(k)
                   when 'D' then
                           dbms_sql.column_value(l_cur, k, l_datecol);
                           l_data:=l_data||lpad(nvl(to_char(l_datecol,'yyyymmdd'),' '),G_DEF_DATE_LENGTH);

                   when 'C' then
                           dbms_sql.column_value(l_cur, k, l_vrchrcol);
                              /*if (p_encode = 'DOS') then
                                 l_vrchrcol:= convert(l_vrchrcol,G_DOS_ENCODE,G_WIN_ENCODE);
                           end if;*/

                           l_vrchrcol:= nvl(l_vrchrcol,' ');
                           l_vrchrcol:= convert_encode(l_vrchrcol, p_encode, 'WIN');

                           -- обрезаем до указанной длинны в структуре
                           l_vrchrcol:=substr(l_vrchrcol,1, l_hdr.collen(k));
                           -- дополняем пробелами до длинны в структуре
                           l_vrchrcol:=rpad(l_vrchrcol, l_hdr.collen(k));
                           l_data:=l_data||l_vrchrcol;

                   when 'N' then
                           dbms_sql.column_value(l_cur, k, l_nmbrcol);
                           -- если в описании структуры - есть дробная часть

                           if l_hdr.colscl(k) > 0 and l_nmbrcol is not null then
                              -- -1 для точки, -1 для знака в форматеб -1 для написанного нуля
                              l_format := lpadchr('9', '9', l_hdr.collen(k) - l_hdr.colscl(k) - 1 - 1 - 1)||'0.'||lpadchr('9', '9', l_hdr.colscl(k));
                              l_data   := l_data|| to_char(l_nmbrcol, l_format);
                           else
                              l_data   := l_data||lpad(nvl(to_char(l_nmbrcol),' '),l_hdr.collen(k));
                           end if;


                   when 'L' then
                           dbms_sql.column_value(l_cur, k, l_vrchrcol);
                           l_vrchrcol:= nvl(l_vrchrcol,'0');
                           if (l_vrchrcol<>'0' and l_vrchrcol<>'1' and l_vrchrcol<>'F' and l_vrchrcol<>'T') then
                               bars_error.raise_error(G_MODULE, 21, l_vrchrcol );
                           end if;

                                  l_data:=l_data||( case l_vrchrcol  when '0'  then 'F'
                                                              when '1'  then 'T'
                                                              else l_vrchrcol end );
                   else
                          bars_error.raise_error(G_MODULE, 7, '-'||l_hdr.coltype(k)||'-' );

            end case;

         end loop;

         dbms_lob.writeappend(l_blobBody, length(l_data), getraw(l_data));
       end loop;
       dbms_sql.close_cursor(l_cur);


       -- собрать блоб для Header-а
       construct_dbf_header(l_hdr, l_blobHeader);

       p_blobheader:= l_blobHeader;
       p_blobbody  := l_blobBody;

       G_SELECTED_ROWS := l_hdr.rowcnt;
       bars_audit.trace(l_trace||'выбрано '||G_SELECTED_ROWS||' строк ');

	exception when others then
       bars.bars_audit.error(l_trace||' Ошибка выполнения:'||sqlerrm);
	   raise;
    end;



    ----------------------------------------
    -- DBF_FROM_SQL ()
    --
    --    Выгрузка в DBF структуру c указанием SQL-я,
    --    с указанием структуры DBF файла.
    --    Как результат в переменную p_blobdbf помещается созданный dbf
    --
    --    p_sql           - SQL запрос
    --    p_dbfstruct     - структура описанная через запятую
    --                      (если отсутсвует структура берется из динамического описания SQL-я)
    --    p_encode        - кодировка
    --    p_blobdbf       - переменная в которую помещаем результирующий blob DBF-а.
    --
    ----------------------------------------
    procedure  dbf_from_sql(
                    p_sql           varchar2,
                    p_dbfstruct     varchar2 default null,
                        p_encode        varchar2 default 'WIN',
                    p_blobdbf   out blob )
    is
       l_blobHeader    blob ;
       l_blobBody      blob ;
       l_blobDBF       blob ;
       l_trace         varchar2(2000);

    begin

       l_trace:=g_trace||'dbf_from_sql:';

       get_dbfdata_from_sql (
                     p_sql        => p_sql,
                     p_dbfstruct  => p_dbfstruct,
                     p_encode     => p_encode,
                          p_blobheader => l_blobHeader,
                       p_blobbody   => l_blobBody );

        construct_dbf (l_blobheader, l_blobbody, l_blobdbf);

        --dbms_lob.freetemporary(l_blobdbf);
        bars_audit.trace(l_trace||' выгрузка результата в OUT переменную');
        dbms_lob.freetemporary(l_blobheader);
        dbms_lob.freetemporary(l_blobbody);

        p_blobdbf:= l_blobdbf;
    exception when others then
       bars.bars_audit.error(l_trace||' Ошибка выполнения:'||sqlerrm);
	   raise;
    end;





    ----------------------------------------
    -- DBF_FROM_SQL ()
    --
    --    Выгрузка в DBF структуру c указанием SQL-я,
    --    с указанием структуры DBF файла.
    --    Как результат во временную таблицу tmp_lob (колонка rawdata)
    --    помещаем тело созданого DBF. Это для дальнейшей работы с
    --    blob-ами в Centure, через функции PutLoadedDBFToFile (absapi.apl)
    --
    --    p_sql           - SQL запрос
    --    p_dbfstruct     - структура описанная через запятую
    --                      (если отсутсвует структура берется из динамического описания SQL-я)
    --    p_encode        - кодировка
    --
    ----------------------------------------

    procedure  dbf_from_sql(
                    p_sql       varchar2,
                    p_dbfstruct varchar2 default null,
                    p_encode    varchar2 default 'WIN')
    is
       l_blobdbf       blob;
       l_trace         varchar2(2000);
    begin
       l_trace:=g_trace||'dbf_from_sql:';


       dbf_from_sql(p_sql,
                    p_dbfstruct,
                     p_encode    ,
                    l_blobdbf );

        bars_audit.trace(l_trace||' выгрузка результата во временную таблицу tmp_lob');
        bars_lob.export_blob(l_blobdbf);
        dbms_lob.freetemporary(l_blobdbf);

    exception when others then
       G_SELECTED_ROWS := 0;
       free_buffer(G_EXCH_BLOB_DBF);
       free_buffer(G_EXCH_BLOB_MEMO);
       raise;
    end;




    ----------------------------------------
    --  DBF_FROM_SQLDESC()
    --
    --    Выгрузка результата запроса в DBF формат по указанному SQL-ю
    --    Буффер выгруженного файла помещается в переменную пакета G_EXCH_BLOB_DBF
    --    По описанию строки(т.е по SQL запросу) - определяем выгружать как
    --    dbf_from_table или dbf_from_sql
    --
    --    p_sqldesc       - строка описания
    --    p_coldescr      - описание колонок структуры через запятую
    --    p_encode        - кодировка DBF файла (WIN, DOS, UKG). Предполагается, что
    --                      исходные данные в WIN кодировке
    ----------------------------------------
    procedure  dbf_from_sqldesc(
                    p_sqldesc     varchar2,
                    p_coldescr    varchar2,
                    p_encode      varchar2 default 'WIN')
    is
       l_sqldesc      varchar2(2000);
       l_tabname      varchar2(50);
       l_whereclause  varchar2(1000);
       l_trace    varchar2(2000);
    begin

       l_trace:=g_trace||'dbf_from_sqldesc:';
       l_sqldesc := substr(p_sqldesc , 1, instr(lower(p_sqldesc),'from') );

       bars_audit.trace(l_trace||'начало выполнения ф-ции');
       -- если указана выборка всех полей (*) и не указана структура -
       -- тогда это выгрузка по dbf_from_table
       if ( instr(l_sqldesc,' * ')>0 and trim(p_coldescr) is null  ) then

          -- найти имя таблицы
          l_tabname:=substr(p_sqldesc , instr(lower(p_sqldesc),'from') + 4 + 1);
          if (instr(l_tabname,' ')>0) then
             l_tabname:=substr(l_tabname,1, instr(l_tabname,' '));
          end if;


          if (instr(lower(p_sqldesc),'where') >0 ) then
              l_whereclause:=substr(p_sqldesc , instr(lower(p_sqldesc),'where') + 5 + 1);
          else
              l_whereclause:='';
          end if;

          bars_audit.trace(l_trace||'l_tabname='||l_tabname||' l_whereclause='||l_whereclause);
          bars_audit.trace(l_trace||'export like dbf_from_table throuth G_EXCH_BLOB_DBF');



          if (G_EXCH_BLOB_DBF is not null ) then
             dbms_lob.freetemporary(G_EXCH_BLOB_DBF);
          end if;

          dbms_lob.createtemporary(G_EXCH_BLOB_DBF, true);


          dbf_from_table (
                     p_tabname      => l_tabname,
                     p_where_clause => l_whereclause,
                     p_encode       => p_encode,
                     p_blobdbf      => G_EXCH_BLOB_DBF );

          -- старая версия через tmp_lob
          --dbf_from_table(l_tabname, l_whereclause, p_encode);

       -- по запросу, возможно со структурой
       else
          bars_audit.trace(l_trace||'export like dbf_from_sql ');
          dbf_from_sql(
                    p_sql           => p_sqldesc,
                    p_dbfstruct     => p_coldescr,
                    p_encode        => p_encode,
                    p_blobdbf       => G_EXCH_BLOB_DBF);
          -- старая версия через tmp_lob
          --dbf_from_sql(p_sqldesc, p_coldescr, p_encode);
       end if;
       bars_audit.trace(l_trace||'export sucessfull');


    exception when others then
       G_SELECTED_ROWS := 0;
       free_buffer(G_EXCH_BLOB_DBF);
       free_buffer(G_EXCH_BLOB_MEMO);
       bars.bars_audit.error(l_trace||' Ошибка выполнения:'||sqlerrm);
	   raise;
    end;




    ----------------------------------------
    --  PARSE_DBF_HEADER()
    --
    --    Разобрать header из входящего blob-а, в структуру
    --
    --    p_dbfblob     --  blob данные dbf файла
    --    p_dbfheader   --  структура header-а для заполнения
    --    p_tabname     -- имя таблицы для сообщений об ошибках
    ----------------------------------------
    procedure  parse_dbf_header(
                    p_dbfblob       blob,
                    p_tabname       varchar2,
                    p_dbfheader out t_dbf_header)
    is
       l_buff     blob;
       l_currpos  number;
       l_cbuff    varchar2(4000);
       l_nbrvers  number;
       l_ismemo   number(1);
       l_hdr      t_dbf_header;
       l_trace    varchar2(2000);
    begin

       l_trace:=g_trace||'parse_dbfheader:';

       --версия DBF(1 byte) - 0-я позиция от начала
       l_buff           := dbms_lob.substr(p_dbfblob, 1, 1);
       l_nbrvers        := utl_raw.cast_to_binary_integer( utl_raw.reverse(l_buff));


       --кол-во записей (4 byte) - 5-я позиция от начала
       l_buff       := dbms_lob.substr(p_dbfblob, 4, 5);
       l_hdr.rowcnt := utl_raw.cast_to_binary_integer( utl_raw.reverse(l_buff));


       --положение первой записи с данными (2 byte) 9-я позиция от начала
       l_buff       := dbms_lob.substr(p_dbfblob, 2, 9);
       l_hdr.frstpos:= utl_raw.cast_to_binary_integer( utl_raw.reverse(l_buff));


       --длинна одной записи (включая признак удаления) + 1 признак удаления
       -- 2 byte,  11-я позиция от начала
       l_buff       := dbms_lob.substr(p_dbfblob, 2, 11);
       l_hdr.rowlen := utl_raw.cast_to_binary_integer( utl_raw.reverse(l_buff));


       -- кол-во колонок - формируетcя по формуле вычисления положения первой записи
       l_hdr.colcnt := round((l_hdr.frstpos - 1 - 32 ) / 32);


       -- вычитываем описание колонок
       l_currpos:= 32 + 1;
       for i in 1..l_hdr.colcnt loop

           -- наименование поля  (11 byte)
           l_buff          := dbms_lob.substr(p_dbfblob, 11, l_currpos);
           l_cbuff         := utl_raw.cast_to_varchar2(l_buff);
           l_hdr.colname(i):= substr( l_cbuff, 1, instr(l_cbuff, chr(0))-1 );
           l_currpos       := l_currpos + 11;

           -- код типа поля (1 byte)
           l_buff          := dbms_lob.substr(p_dbfblob, 1, l_currpos);
           l_hdr.coltype(i):= utl_raw.cast_to_varchar2(l_buff);
           l_currpos       := l_currpos + 1;


           -- номер поля по-порядку  (4 byte)  - пропускаем - нам не нужен
           l_currpos    := l_currpos + 4;


           -- длинна поля (1 byte)
           l_buff         := dbms_lob.substr(p_dbfblob, 1, l_currpos);
           l_hdr.collen(i):= utl_raw.cast_to_binary_integer( utl_raw.reverse(l_buff));

           l_currpos      := l_currpos + 1;

           -- кол-во знаков после запятой (1 byte)
           if ( l_hdr.coltype(i)='N') then
              l_buff         := dbms_lob.substr(p_dbfblob, 1, l_currpos);
              l_hdr.colscl(i):= utl_raw.cast_to_binary_integer( utl_raw.reverse(l_buff));
           else
              l_hdr.colscl(i):=0;
           end if;

           l_currpos   := l_currpos + 1;


           -- резерв (14 byte)
           l_currpos   := l_currpos + 14;

           bars_audit.trace(l_trace||' name:'||l_hdr.colname(i)||' type:'||l_hdr.coltype(i)||' length:'||l_hdr.collen(i)||' scale:'||l_hdr.colscl(i));
       end loop;



       l_ismemo := 0;
       for i in 1..l_hdr.colcnt loop
           if l_hdr.coltype(i) = 'M' then
              bars_audit.trace(l_trace||'колонка '||i||' мемо поле');
              l_ismemo := l_ismemo + 1;
           end if;
       end loop;

       -- в файле должно быть описано не более 4-х полей мемо
        if l_ismemo > 4 then
           bars_error.raise_nerror(G_MODULE, 'TO_MANY_MEMOS', to_char(l_ismemo), p_tabname);
       end if;



       begin
          if g_dbfvers_list.exists(l_nbrvers) then
             l_hdr.vers  :=  g_dbfvers_list(l_nbrvers);
             if l_hdr.vers.ismemo = 0 and l_ismemo = 1 then
                --bars_audit.error(l_trace||'заголовок dbf файла содержит версию, которая не поддерживает мемо: '||l_nbrvers||', но данный DBF содержит мемо поле ');
                --bars_audit.error(l_trace||'установка неизвестной версии с поддержкой мемо');
                --l_hdr.vers := g_dbfvers_list(G_DBFVERS_0);
                --bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_DBFMEMO', to_char(l_nbrvers), p_tabname);
                -- присвоим тип файла как буд-то с мемо
                l_hdr.vers := g_dbfvers_list(G_DBFVERS_131);
             end if;
          else
             bars_audit.error(l_trace||'неизвестная версия dbf файла: '||l_nbrvers);
             --l_hdr.vers := g_dbfvers_list(G_DBFVERS_0);
             --l_hdr.vers.ismemo := l_ismemo;
             bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_DBFTYPE', to_char(l_nbrvers), p_tabname);
          end if;
       end;


       p_dbfheader:= l_hdr;

    exception when others then
       bars_audit.error(l_trace||' ошибка разбора заголовка:'||sqlerrm);
       raise;
    end;


    ----------------------------------------
    -- GET_DATATYPE()
    --
    --    По номеру колонки  - отдать строку для создания данной колонки в oracle
    --
    --    p_header     --  структура  dbf header-а
    --    p_colnbr     --  порядковый номер колонки
    --
    ----------------------------------------
    function get_datatype(p_header t_dbf_header, p_colnbr number)
    return varchar2
    is
        l_type varchar2(100);
        i      number;
     begin
        i:=p_colnbr;
        case p_header.coltype(i)
                when 'N' then
                   l_type:='NUMBER('||p_header.collen(i);
                   if (p_header.colscl(i)<>0) then
                      l_type:= l_type||','||p_header.colscl(i)||')';
                   else
                      l_type:= l_type||')';
                   end if;
             when 'C' then
                   l_type:='VARCHAR2('||p_header.collen(i)||')';
             when 'D' then
                   l_type:='DATE';
             when 'L' then
                   l_type:='NUMBER(1)';
             when 'M' then
                   l_type:='CLOB';
             else
                  bars_error.raise_error(G_MODULE, 7);
        end case;
        return l_type;
     end;





    ----------------------------------------
    -- CREATE_TABLE()
    --
    --    Создать таблицу в oracle по структуре header-а
    --
    --    p_header      --  структура  dbf header-а
    --    p_tabname     --  Имя таблицы для создания
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    ----------------------------------------
    procedure  create_table(
                    p_header             t_dbf_header,
                    p_tabname     in out varchar2,
                    p_createmode         smallint)
    is
       l_trace      varchar2(2000);
       l_crtabsql   varchar2(4000);
       l_tabexists  smallint;
       l_tabname    user_tables.table_name%type;
    begin
       l_trace:=g_trace||'create_table:';

       --есть ли такая таблица?
       begin
          select object_name into l_tabname
          from user_objects
         where object_name = upper(p_tabname) and object_type in ('TABLE','VIEW');
          bars_audit.trace(l_trace||'таблица '||l_tabname||' уже существует');
          l_tabexists:=1;
       exception when no_data_found  then
          bars_audit.trace(l_trace||'таблица '||l_tabname||' не существует');
          l_tabexists := 0;
       end;


       l_tabname:=p_tabname;
       if l_tabexists = 1  then
          case p_createmode

              when G_CRTAB_RECREATE  then
                   execute immediate 'drop table '||l_tabname;
                   bars_audit.trace(l_trace||'удалили существующую таблицу');

              when G_CRTAB_ADDTIME   then
                   l_tabname:=p_tabname||'_'||to_char(sysdate,'hh24miss');
                   bars_audit.trace(l_trace||'выставлен параметр - не удалять существующую таблицу, создаем таблицу '||l_tabname);

              when G_CRTAB_DELDATA   then
                   bars_audit.trace(l_trace||'удаление всех данных из таблицы '||l_tabname);
                   execute immediate 'delete from '||l_tabname;
                   return;

              when G_CRTAB_NOACT   then
                   return;
              else
                   bars_error.raise_error(G_MODULE,25,to_char(p_createmode ));
          end case;

       end if;



       -- создать таблицу для импорта данных
       l_crtabsql:= 'create table '||l_tabname||' (';

       for i in 1..p_header.colcnt loop
           l_crtabsql:=l_crtabsql||get_proper_name(p_header.colname(i))||' '
                                 ||get_datatype(p_header, i);
           if i<>p_header.colcnt then
              l_crtabsql:=l_crtabsql||',';
           end if;
       end loop;
       l_crtabsql:=l_crtabsql||')';

       -- откключаем триггер на вставкув policy_table
       begin
          execute immediate  'alter trigger bars.tddl_crtab disable';
       exception when others then
          if sqlcode = -4080 then null;   -- no such trigger
          else raise;
          end if;
       end;


       begin
          bars_audit.trace(l_trace||'перед выполнением  '||l_crtabsql);
          execute immediate l_crtabsql;
          bars_audit.trace(l_trace||'создали таблицу '||l_tabname);
       exception when others then
          bars_audit.error(l_trace||'ошибка выполнения: '||l_crtabsql||': '||sqlerrm);
          if sqlcode = -903 then
             bars_error.raise_error(G_MODULE, 23, l_tabname);
          else
             raise;
          end if;
       end;

       -- включаем триггер на вставкув policy_table
       begin
          execute immediate  'alter trigger bars.tddl_crtab enable';
       exception when others then
          if sqlcode = -4080 then null;   -- no such trigger
          else raise;
          end if;
       end;


       p_tabname := l_tabname;

    exception when others then
       bars_audit.error(l_trace||'ошибка создания таблицы '||l_tabname||': '||sqlerrm);
       raise;
    end;



    ----------------------------------------
    --  VALIDATE_NUMBER()
    --
    --    Валидирование числового значения
    --
    --    p_str    --  строка
    --    return   --  0 - ok, 1- ошибка
    ----------------------------------------
    function validate_number(p_str varchar2)
    return smallint
    is
       l_number   number(38,10);
       l_trace    varchar2(2000);
    begin

       l_trace := g_trace||'validate_number: ';
       l_number:= to_number(nvl(trim(p_str),'0'));
       return 0;
    exception when others then
       if upper(p_str) = 'NULL' then
          return 0;
       else
          bars_audit.error(l_trace||'нельзя привести '||p_str||' к числу: '||sqlerrm);
          return 1;
       end if;
    end;




    ----------------------------------------
    --  VALIDATE_DATE()
    --
    --    Валидирование даты
    --
    --    p_str    --  строка
    --    return   --  0 - ok, 1- ошибка
    ----------------------------------------
    function validate_date(p_str varchar2)
    return smallint
    is
       l_date     date;
       l_trace    varchar2(2000);
    begin
       l_trace := g_trace||'validate_date: ';

       l_date  := to_date(p_str,'yyyymmdd');
       return 0;
    exception when others then
       if p_str = '00000000'  or p_str = '0' or upper(p_str) = 'NULL'  then
          -- интерпритируем как null
          return 0;
       end if;

       bars_audit.error(l_trace||'нельзя привести '||p_str||' к дате');
       return 1;
    end;




    ----------------------------------------
    --  VALIDATE_LOGICAL()
    --
    --    Валидирование логического поля
    --
    --    p_str    --  строка
    --    return   --  0 - ok, 1- ошибка
    ----------------------------------------
    function validate_logical(p_str varchar2)
    return smallint
    is
       l_trace    varchar2(2000);
    begin
       l_trace := g_trace||'validate_logical: ';

       if p_str <> 'F' and  p_str <> 'T' and p_str is not null and p_str<>' ' then
          bars_audit.error(l_trace||'значение логич. поле не T и не F = '||nvl(p_str,'null'));
          return 1;
       else
          return 0;
       end if;
    end;



    ----------------------------------------
    --  TRANSLATE_LOGICAL()
    --
    --    По dbf значению LOGICAl поля поляучить соответсвующий number(1)
    --
    --    p_str    --  строка
    ----------------------------------------
    function translate_logical(p_str varchar2)
    return varchar2
    is
    begin
       if p_str is null or p_str = ' ' then
          return 'null';
       else
          case when p_str='T' then return '1'; else return '0'; end case;
       end if;
    end;










    ----------------------------------------
    --  INSERT_DATA()
    --
    --    Вставка данных в oracle таблицу
    --
    --    p_dbfblob     -  блоб дбф-а
    --    p_header      -  заголовок
    --    p_tabname     -  имя таблиц вставки
    --    p_force_err   -  при возникновении ошибок конвертации в определенный тип -
    --                     = 1 - не выдавать ошибку, а делать вставку значением null
    --                     = 0 - выдавать ошибку
    --    p_srcencode   - исходная кодировка
    --    p_destencode  - исходящая кодировка
    --
    ----------------------------------------
    procedure  insert_data(
                    p_dbfblob     blob,
                    p_header      t_dbf_header,
                    p_tabname     varchar2,
                    p_force_err   number   default 1    ,
                    p_srcencode   varchar2 default 'DOS',
                    p_destencode  varchar2 default 'WIN')
    is
       l_currpos     number;
       l_pos         number;
       l_hdr         t_dbf_header;
       l_buff        blob;
       l_rowdata     varchar2(4000);
       l_datc        varchar2(32000);
       l_insertsql   varchar2(4000);
       l_trace       varchar2(2000);
       l_clobdata    clob;
       l_memocnt     smallint := 0;
       l_blocknbr    number;
       l_markdel     char(1);
       l_clobs       clob_array;
       l_markdel_cnt number := 0;
    begin

        l_hdr:=p_header;
        l_trace := g_trace||'insert_data: ';

       -- для каждой строки (строка данных начинается с пробела)

       l_currpos:= l_hdr.frstpos + 1;
       for i in 1..l_hdr.rowcnt loop

           l_buff     := dbms_lob.substr(p_dbfblob, l_hdr.rowlen, l_currpos);
           l_rowdata  := replace(utl_raw.cast_to_varchar2(l_buff), chr(0),' ');
           l_markdel  := dbms_lob.substr(l_rowdata, 1, 1);

--

           if (l_markdel is null or l_markdel = ' ') then

              l_insertsql:= 'insert into '||p_tabname||' values(';
              l_memocnt  := 0;
              -- для каждого столбца
              l_pos:= 1 + 1;
              for j in 1..l_hdr.colcnt loop

                 l_datc:= substr(l_rowdata,l_pos, l_hdr.collen(j));
                 case l_hdr.coltype(j)

                      when 'N' then
                          l_datc := trim(replace(l_datc,',','.'));

                          if validate_number(l_datc) <> 0 then
                             if p_force_err = 1 then
                                l_datc := null;
                             else
                                bars_error.raise_error(G_MODULE, 8, l_datc,  to_char(i), l_hdr.colname(j), p_tabname );
                             end if;
                          end if;

                          l_datc:= nvl(l_datc,'null');
                          l_insertsql:=l_insertsql||l_datc;


                      when 'C' then

                          --l_datc := convert( trim( l_datc ),G_WIN_ENCODE,G_DOS_ENCODE);
                          l_datc := convert_encode( trim( l_datc ), p_destencode, p_srcencode);
                          l_datc := replace(l_datc, chr(39),'''''');
                          l_insertsql:=l_insertsql||''''||l_datc||'''';


                      when 'D' then

                          if ( trim(l_datc) is null ) then
                             l_datc:=null;
                          else
                             if validate_date(l_datc) <> 0 then
                                if p_force_err = 1 then
                                   l_datc := null;
                                else
                                   bars_error.raise_error(G_MODULE, 9, l_datc,  to_char(i), l_hdr.colname(j), p_tabname );
                                end if;
                             end if;
                          end if;


                          if l_datc is null or l_datc = '00000000' or l_datc = '0' then
                             l_insertsql:=l_insertsql||'null';
                          else
                             l_insertsql:=l_insertsql||'to_date('''||l_datc||''',''yyyymmdd'')';
                          end if;


                      when 'L' then

                          if validate_logical(l_datc) <> 0 then
                             if p_force_err = 1 then
                                l_datc := null;
                             else
                                bars_error.raise_error(G_MODULE, 10, l_datc, to_char(i), l_hdr.colname(j), p_tabname );
                             end if;
                          end if;
                          l_insertsql:=l_insertsql||translate_logical(l_datc);

                      when 'M' then

                          l_memocnt := l_memocnt + 1;

                          -- ссылка на номер блока
                          if validate_number(l_datc) <> 0 then
                             if p_force_err = 1 then
                                l_blocknbr := 0;
                             else
                                bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_MEMOREF', l_datc, to_char(i), l_hdr.colname(j), p_tabname );
                             end if;
                          else
                             l_blocknbr := to_number(nvl(trim(l_datc),0));
                          end if;


                          if l_blocknbr <> 0 then
                             if G_EXCH_BLOB_MEMO is null then
                                l_clobdata := '';
                             else
                                l_clobdata := get_memo_field(
                                                 p_mblob     => G_EXCH_BLOB_MEMO,
                                                 p_blocknbr  => l_blocknbr,
                                                 p_srcencode => p_srcencode,
                                                 p_tablename => p_tabname,
                                                 p_memotype  => p_header.vers.memofile_ext);
                             end if;
                          else
                             l_clobdata := '';
                          end if;
                          -- втсатвка клобов будет через  execute immediate используя using
                          l_insertsql:=l_insertsql||':'||l_memocnt;
                          l_clobs(l_memocnt-1) := l_clobdata;

                      else
                          bars_error.raise_error(G_MODULE, 7, l_hdr.coltype(j));
                 end case;

                 l_insertsql:=l_insertsql||',';
                 l_pos := l_pos + l_hdr.collen(j);

               end loop;


               -- убрать последюю запятую, добавить кавычку
               l_insertsql:=substr(l_insertsql,1,length(l_insertsql)-1) ||')';


               -- выполнить вставку
               begin
		           case l_memocnt
                        when 0 then  execute immediate l_insertsql ;
		                when 1 then  execute immediate l_insertsql using l_clobs(0);
                        when 2 then  execute immediate l_insertsql using l_clobs(0),l_clobs(1);
                        when 3 then  execute immediate l_insertsql using l_clobs(0),l_clobs(1), l_clobs(2);
                        when 4 then  execute immediate l_insertsql using l_clobs(0),l_clobs(1), l_clobs(2), l_clobs(3);
		                else bars_error.raise_nerror(G_MODULE, 'TO_MANY_MEMOS', to_char(l_memocnt), p_tabname);
                   end case;
              exception when others then
                 bars_audit.error(l_trace||'ошибка выполнения SQL-я : '||l_insertsql );
                 if sqlcode = -01438 then   -- value larger than specified precision allows for this column
                    -- проверим какое из полей не подходит по размеру
                    bars_error.raise_nerror(G_MODULE, 'LARGE_VALUE', substr(l_insertsql,1,250));
                 else
                    bars_error.raise_nerror(G_MODULE, 'CANNOT_EXEC_SQL', substr(l_insertsql,1,250), substr(sqlerrm,1,250));
                 end if;
              end;
           else
              l_markdel_cnt := l_markdel_cnt + 1;
           end if;  -- if not marked deleted
              l_currpos:= l_currpos + l_hdr.rowlen ;

       end loop;
       bars_audit.info(l_trace||'данные успешно вставлены. Помеченных на удаление '||l_markdel_cnt);
    exception when others then
       bars_audit.error(l_trace||'ошибка вставки данных: '||sqlerrm);
       bars_error.raise_nerror(G_MODULE, 'CANNOT_INSERT_DATA', sqlerrm);
    end;




    ----------------------------------------
    -- LOAD_DBF()
    --
    --    Загрузить DBF файл в таблицу
    --
    --    p_dbfblob     --  данные dbf файла
    --    p_tabname     --  Имя таблицы для вгрузки
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует (т.е. добавить данные до существующих)
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    ----------------------------------------
    procedure  load_dbf(
                    p_dbfblob            blob,
                    p_tabname     in out varchar2,
                    p_createmode         smallint,
                    p_srcencode          varchar2 default 'DOS',
                    p_destencode         varchar2 default 'WIN')
    is
       l_hdr      t_dbf_header;  -- заголовок dbf
       l_cur      number;
       l_trace    varchar2(2000);
       l_errcode  varchar2(4);
       l_errmsg   varchar2(500);
    begin
       l_trace := g_trace||'load_dbf: ';
       parse_dbf_header(p_dbfblob, p_tabname , l_hdr);
       bars_audit.trace(l_trace||header_to_string(l_hdr));

       create_table(
              p_header      => l_hdr,
              p_tabname     => p_tabname,
              p_createmode  => p_createmode);



       -- Если структура не пересоздавалась - нужно слечить структуру таблицы и файла
       if  p_createmode in (G_CRTAB_DELDATA, G_CRTAB_NOACT) then
           l_cur :=dbms_sql.open_cursor;
           dbms_sql.parse(l_cur, 'select * from '||p_tabname, dbms_sql.native);
           compare_dbf_desc(l_cur, l_hdr, l_errcode, l_errmsg);
           if l_errcode <> '0000' then
              case when l_errcode = '0019'  then
                        bars_error.raise_nerror(G_MODULE, 'CH_WRONG_COLCNT');
                   when l_errcode = '0020'  then
                        bars_error.raise_nerror(G_MODULE, 'CH_WRONG_COLTYPES');
                   else
                        bars_error.raise_nerror(G_MODULE, 'GENERIC_ERROR',l_errmsg);
              end case;
           end if;

       end if;

       insert_data(
                    p_dbfblob    =>   p_dbfblob,
                    p_header     =>   l_hdr,
                    p_tabname    =>   p_tabname,
                    p_force_err  =>   1,
                    p_srcencode  =>   p_srcencode,
                    p_destencode =>   p_destencode);





    end;




    ----------------------------------------
    -- IMPORT_DBF_CNT()
    --
    --    Весия для Centura (без использования TMP_LOB)
    --    Загрузить DBF файл в таблицу, предполагается что файл
    --    был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB_DBF
    --
    --    p_tabname     --  Имя таблицы для вгрузки
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    ----------------------------------------
    procedure  import_dbf_cnt(
                    p_tabname     varchar2,
                    p_createmode  smallint,
                    p_srcencode   varchar2 default 'DOS',
                    p_destencode  varchar2 default 'WIN')
    is
       l_hdr      t_dbf_header; -- заголовок dbf
       l_trace    varchar2(2000);
       l_tabname  varchar2(100);
    begin


       if G_EXCH_BLOB_DBF is null or
          (G_EXCH_BLOB_DBF is not null and dbms_lob.getlength(G_EXCH_BLOB_DBF) = 0) then
          bars_error.raise_error(G_MODULE, 22);
       end if;

       l_tabname := p_tabname;
       load_dbf(
            p_dbfblob    => G_EXCH_BLOB_DBF,
            p_tabname    => l_tabname,
            p_createmode => p_createmode,
            p_srcencode  => p_srcencode,
            p_destencode => p_destencode);


       free_buffer(G_EXCH_BLOB_DBF);
       free_buffer(G_EXCH_BLOB_MEMO);

    exception when others then
       G_SELECTED_ROWS := 0;
       free_buffer(G_EXCH_BLOB_DBF);
       free_buffer(G_EXCH_BLOB_MEMO);
       raise;
    end;




    ----------------------------------------
    -- EXPORT_DBF_CNT()
    --
    --    Версия для Centura
    --    (без использования TMP_LOB, через переменную G_EXCH_BLOB_DBF )
    --    Выгрузить в DBF файл таблицу. Выгрузка происходит
    --    в глобальную переменную G_EXCH_BLOB_DBF.
    --    Предполагается, что потом в Centure
    --    эту переменную вычитают процедурой get_buffer
    --
    --    p_tabname     --  Имя таблицы для выгрузки
    --    p_destencode  --  кодировка исход. DBF файла
    --
    ----------------------------------------
    procedure  export_dbf_cnt(
                    p_tabname     varchar2,
                    p_destencode  varchar2 default 'WIN')
    is
       l_hdr      t_dbf_header; -- заголовок dbf
       l_trace    varchar2(1000)  := g_trace||'export_dbf_cnt: ';
    begin


       if (G_EXCH_BLOB_DBF is not null ) then
           dbms_lob.freetemporary(G_EXCH_BLOB_DBF);
       end if;

       dbms_lob.createtemporary(G_EXCH_BLOB_DBF, true);

       dbf_from_table (
                     p_tabname      => p_tabname,
                     p_where_clause => '',
                     p_encode       => p_destencode,
                     p_blobdbf      => G_EXCH_BLOB_DBF );

      bars_audit.trace(l_trace||'длинна выгруженого clob-а = '||dbms_lob.getlength(G_EXCH_BLOB_DBF));

    exception when others then
       G_SELECTED_ROWS := 0;
       free_buffer(G_EXCH_BLOB_DBF);
       free_buffer(G_EXCH_BLOB_MEMO);
       raise;
    end;




    ----------------------------------------
    --  IMPORT_DBF_SRV()
    --
    --    Импорт dbf файла-а с сервера оракла
    --    через BFILE
    --
    --    p_oradir      --  директория оракла oracledir
    --    p_filename    --  имя файла (если null - имя таблицы - это имя файла без расширения)
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    --
    ----------------------------------------

    procedure  import_dbf_srv(
                  p_oradir      varchar2,
                  p_filename    varchar2,
                  p_tabname     varchar2 default null,
                  p_createmode  smallint default 1,
                    p_srcencode   varchar2 default 'DOS',
                  p_destencode  varchar2 default 'WIN')
    is
       l_bfile    bfile;
       l_blob     blob;
       l_tabname  varchar2(100);
    begin

       /* conn sys
           CREATE OR REPLACE DIRECTORY FILE_DIR AS 'D:\TEMP\FILES';
           GRANT READ, WRITE ON DIRECTORY  LOAD_LIM TO BARS WITH GRANT OPTION;
       */

       l_tabname := nvl(p_tabname, substr(p_filename,1, instr(p_filename,'.')-1)  );
       dbms_lob.createtemporary(l_blob, cache=>true);

       begin
           l_bfile := bfilename(p_oradir, p_filename);
           dbms_lob.open(l_bfile, dbms_lob.lob_readonly);
       exception when others then
           bars_error.raise_error(G_MODULE, 24, p_filename, p_oradir);
       end;
       dbms_lob.loadFromFile(dest_lob => l_blob,
                              src_lob  => l_bfile,
                              amount   => dbms_lob.getLength(l_bfile));

       dbms_lob.close(l_bfile);


       bars_dbf.load_dbf(
              p_dbfblob    => l_blob,
              p_tabname    => l_tabname,
              p_createmode => p_createmode,
              p_srcencode  => p_srcencode,
              p_destencode => p_destencode);

        dbms_lob.freetemporary(l_blob);
    end;



    ----------------------------------------
    -- IS_MEMO_EXISTS_CNT()
    --
    --    Существуют ли поля MEMO
    --    предполагается что файл был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB_DBF
    --
    --    p_exists =0 - не существует, =1 - существует
    ----------------------------------------
    procedure is_memo_exists_cnt(
                p_exists  out smallint)
    is
       l_hdr      t_dbf_header; -- заголовок dbf
       l_trace    varchar2(1000)  := g_trace||'is_memo_exists_cnt: ';
    begin

       -- загружено или нет тело dbf файла
       if G_EXCH_BLOB_DBF is null or
          (G_EXCH_BLOB_DBF is not null and dbms_lob.getlength(G_EXCH_BLOB_DBF) = 0) then
          bars_error.raise_error(G_MODULE, 22);
       end if;

       parse_dbf_header(G_EXCH_BLOB_DBF, '',  l_hdr );

       for i in 1..l_hdr.colcnt loop
           if l_hdr.coltype(i) = 'M' then
              bars_audit.trace(l_trace||'колонка '||i||' мемо поле');
              p_exists := 1;
              return;
           end if;
       end loop;
       bars_audit.trace(l_trace||'нету мемо поля');
       p_exists := 0;
       return;
    end;




    ----------------------------------------
    --  GET_DBF_DESCRIPTION_CNT()
    --
    --    Узнать версию(описание) DBF, по данной нформации вычслить сущестует или нет memo
    --    и если существует, то какой расширение лоя файла  с мемо полями
    --
    --    предполагается что файл был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB_DBF
    --
    --    p_tabname       - имя таблицы для импорта (для сообщений об ощибках)
    --    p_version       - числовое значение версии
    --    p_description   - описание
    --    p_ismemoexists  - мемо поле  0 - не существует, =1 - существует
    --    p_memofile      - расширение для файла с мемо полем
    ----------------------------------------
    procedure get_dbf_description_cnt(
                p_tabname           varchar2,
		p_version       out number,
                p_description   out varchar2,
                p_ismemoexists  out smallint,
                p_memofile      out varchar2
             )
    is
       l_hdr      t_dbf_header; -- заголовок dbf
    begin

       -- загружено или нет тело dbf файла
       if G_EXCH_BLOB_DBF is null or
          (G_EXCH_BLOB_DBF is not null and dbms_lob.getlength(G_EXCH_BLOB_DBF) = 0) then
          bars_error.raise_error(G_MODULE, 22);
       end if;

       parse_dbf_header(G_EXCH_BLOB_DBF,  p_tabname,  l_hdr);

       p_version       := l_hdr.vers.vers;
       p_description   := l_hdr.vers.descript;
       p_ismemoexists  := l_hdr.vers.ismemo;
       p_memofile      := l_hdr.vers.memofile_ext;

       return;
    end;



   -----------------------------------------------------------------
   --    BEGIN()
   --
   --    Старт пакета
   --
   --
begin
  init_dbf_version_list;
end bars_dbf;
/





 show err;
 
PROMPT *** Create  grants  BARS_DBF ***
grant EXECUTE                                                                on BARS_DBF        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_DBF        to IMPEXP;
grant EXECUTE                                                                on BARS_DBF        to OBPC;
grant EXECUTE                                                                on BARS_DBF        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dbf.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 