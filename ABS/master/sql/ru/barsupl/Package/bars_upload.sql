
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/package/bars_upload.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSUPL.BARS_UPLOAD is

    -----------------------------------------------------------------
    --
    --   Выгрузка данных
    --
    --   created: anny (01-07-2012)
    --
    -- version 4.2 16.02.2018 Добавлены функции установки параметров выгрузки set_param, set_job_param, set_group_param
    -----------------------------------------------------------------

    G_HEADER_VERSION      constant varchar2(64)  := 'version 4.2 16.02.2018';

    -----------------------------------------------------------------
    -- Константы
    -----------------------------------------------------------------
    G_UPLOADING            constant number(1) := 0;
    G_UPLOADED             constant number(1) := 1;
    G_UPLERROR             constant number(1) := 2;
    G_UPLNOPROCESS         constant number(1) := -1;

    -----------------------------------------------------------------
    -- Типы
    -----------------------------------------------------------------
    type vrchr_array is table of varchar2(1000) index by binary_integer;
    type nmbr_array  is table of number         index by binary_integer;
    type char_array  is table of varchar2(50)   index by binary_integer;
    type clob_array  is table of clob           index by binary_integer;


    -- структура колонок
    type t_cols is record
    (  colcnt      number,       -- кол-во колонок
       colname     vrchr_array,  -- массив наименований столбцов
       collen      nmbr_array,   -- массив длинн значений столбцов
       colscl      nmbr_array,   -- массив длины дробной части (для number)
       coltype     char_array,   -- массив типов (NUMBER,DATE,CHAR)
       colfrmt     vrchr_array,  -- массив форматов
       chrfrom     vrchr_array,  -- массив символов, которые нужно заменить
	   chrto       vrchr_array   -- массив символов, которыми нужно заменить
    );


    -- структура файла
    type t_file is record
    (  delimm         upl_files.delimm%type,          -- описани разделителя колонок (например '09||124' -  табуляция и пробел)
       endline        upl_files.endline%type,         -- символ окончания строки (аналогично как и для разделителя)
       head_line      upl_files.head_line%type,       -- наличие первой строки заголовка с колонками в файле
       eqvspace       upl_files.eqvspace%type,        -- =1 фиксированя ширина колонки, -0 - нет
       filename_prfx  upl_files.filename_prfx%type    -- префикс для формирования имени файла
    );


    ----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    function body_version return varchar2;


    -----------------------------------------------------------------
    --  ADD_TABLE_TO_UPLOAD
    --
    --   Автоматически добавить описание таблицы для выгрузки
    --   автоматом идет добавление имени файла, запроса и всех колонок таблицы(исключая RAW, CLOB, BLOB)
    --
    --    p_tabname    --  Имя таблицы
    --    p_owner      --  схема
    --    p_delimm     --  разделитеь
    --    p_endline    --  символ конца строки
    --    p_head_line  --  (1/0) 1 - первая строка наименование колонок, 0 - первая строка - начало данных
    --    p_eqvspace   --  (1/0) 1 - фиксированя ширина колонки, -0 - нет
    --    p_nullval    --  символы заменяющие пустое значение в файле (может быть переопределено для конкретной колонки в upl_columns)
    --    p_fileid     --  указать принудительно номер file_id, при значении null берется из последовательности s_upl_files
    --    p_ispart     --  (1/0). 1 - таблица содержит код филиала  0 - не содержит
    -----------------------------------------------------------------
    procedure add_table_to_upload(
                        p_tabname     user_tables.table_name%type,
                        p_owner       varchar2     default  'BARS',
                        p_delimm      varchar2     default '09'    ,
                        p_endline     varchar2     default '13||10' ,
                        p_head_line   number       default 1        ,
                        p_eqvspace    number       default 1        ,
                        p_nullval     varchar2     default 'null'   ,
                        p_ispart      number       default 0        ,
                        p_fileid      number       default null
                    );

    -----------------------------------------------------------------
    --  ADD_SQL_TO_UPLOAD
    --
    --   Автоматически добавить описание структуры колонок из запроса
    --   автоматом идет добавление имени файла, запроса и всех колонок таблицы(исключая RAW, CLOB, BLOB)
    --
    --    p_sqltext    -- Запрос
    --    p_filecode   -- Код файла выгрузки
    --    p_filedesc   -- описание
    --    p_delimm     -- описани разделителя колонок (например '09||124' -  табуляция и пробел)
    --    p_endline    -- символ окончания строки (аналогично как и для разделителя)
    --    p_headline   -- наличие первой строки заголовка с колонками в файле
    --    p_eqvspace   -- (1/0) 1 - фиксированя ширина колонки, 0 - нет
    --    p_nullval    -- символы заменяющие пустое значение в файле (может быть переопределено для конкретной колонки в upl_columns)
    --    p_fileid     -- указать принудительно номер file_id, при значении null берется из последовательности s_upl_files
    --    p_ispart     -- (1/0). 1 - таблица содержит код филиала  0 - не содержит
    --
    -----------------------------------------------------------------
    procedure add_sql_to_upload
    ( p_sqltext       varchar2,
      p_filecode      varchar2,
      p_filedesc      varchar2,
      p_delimm        varchar2   default '09',
      p_endline       varchar2   default '13||10',
      p_head_line     number     default 1,
      p_eqvspace      number     default 1,
      p_nullval       varchar2   default 'null',
      p_ispart        number     default 0,
      p_fileid        number     default null );

    -----------------------------------------------------------------
    --  UPLOAD_FILE
    --
    --   Выгрузить файл
    --
    --    p_filecode    --  Мнемонический код файла из справочника (UPL_FILES)
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --
    -----------------------------------------------------------------
    procedure upload_file( p_filecode   upl_files.file_code%type ,
                           p_param1     varchar2,
                           p_param2     varchar2);

    -----------------------------------------------------------------
    --  UPLOAD_FILE
    --
    --   Выгрузить файл  из справочника выгрузок UPL_FILES
    --
    --    p_filecode    --  Мнемонический код файла из справочника (UPL_FILES)
    --    p_sqlid       --  файл может быть выгруженным с указанием конкретного запроса (иначе берется запрос по-усолчению из upl_files.sql_id)
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --
    -----------------------------------------------------------------
    procedure upload_file( p_filecode   upl_files.file_code%type,
                           p_sqlid      number,
                           p_param1     varchar2,
                           p_param2     varchar2
                          );

    -----------------------------------------------------------------
    --  UPLOAD_FILES_GROUP
    --
    --   Выгрузить группу файлов
    --
    --    p_filegroup   --  Код группы
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --    p_forcestop   --  при
    -----------------------------------------------------------------
    procedure upload_file_group( p_filegroup  number,
                                 p_param1     varchar2,
                                 p_param2     varchar2,
                                 p_forcestop  number    default 0);

    -----------------------------------------------------------------
    --  UPLOAD_FILES_GROUP
    --
    --   Выгрузить группу файлов
    --
    --    p_filegroup   --  Код группы
    --    p_defsqlid    --  умалчательные или нет значения sql_id для выгрузки файла.
    --                      Если (1=да), тогда берем из upl_files.sql_id, если (0=нет), тогда берем из upl_filegroups_rln.sqlid
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --    p_forcestop   --  при
    -----------------------------------------------------------------
    procedure upload_file_group( p_filegroup  number,
	                         p_defsqlid   number,
                                 p_param1     varchar2,
                                 p_param2     varchar2,
                                 p_forcestop  number    default 0);



    -----------------------------------------------------------------
    --  UPLOAD_FILE_GROUP
    --
    --   Выгрузить группу файлов cо значениями кодов запросов из связки группа - файл
    --
    --    p_filegroup   --  Код группы
    --    p_parentid    --  код из журнала выполнения для родителя (для группы - это джоб)
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --    p_forcestop   --  при
    --    return        --  код в журнале аудита для группы (upl_stats)
    -----------------------------------------------------------------
    function  upload_file_group( p_filegroup  number,
	                         p_parentid   number default null,
                                 p_param1     varchar2,
                                 p_param2     varchar2,
                                 p_forcestop  number    default 0) return number;



    -----------------------------------------------------------------
    --  LOG_START_AFTERUPL_EVENT()
    --
    --    Запротоколировать начало события после выгрузки (архивация, фтп)
    --
    --    p_id             --  Код в протоколе выгрузки
    --    p_eventname      --  (ARC или FTP)
    -----------------------------------------------------------------
    procedure log_start_afterupl_event(
                    p_id           number,
                    p_eventname    varchar2 );


    -----------------------------------------------------------------
    --  LOG_STOP_AFTERUPL_EVENT()
    --
    --    Запротоколировать окончание события после выгрузки (архивация, фтп)
    --
    --    p_id             --  Код в протоколе выгрузки
    --    p_eventname      --  (ARC или FTP)
	--    p_message        --  сообщение
    -----------------------------------------------------------------
    procedure log_stop_afterupl_event(
                    p_id           number,
                    p_eventname    varchar2,
                    p_message	   varchar2);


    -----------------------------------------------------------------
    --  LOG_START_PROCESS()
    --
    --    Запротоколировать старт выгрузки
    --    p_start_time     --  свремя старта
    --    p_groupid        --  код группы (или пусто , если для файла)
    --    p_fileid         --  код файла
    --    p_parentid       --  родительский код аудита группы для файла
    --    p_params         --  параметры
    --    p_id             --  возвращает внутренний код код
    -----------------------------------------------------------------
    procedure log_start_process(
                    p_start_time       date                  ,
                    p_jobid            number    default null,
                    p_groupid          number    default null,
                    p_fileid           number    ,
                    p_parentid         number    ,
                    p_sqlid            number    ,
                    p_params           varchar2  ,
                    p_bankdate         date      ,
                    p_id               in out number);


    -----------------------------------------------------------------
    --  LOG_END_PROCESS()
    --
    --    Запротоколировать успешное завершние выгрузки
    --    p_stop_time      --  свремя окончания
    --    p_rowsuploaded
    --    p_id             --  возвращает внутренний код код
    --
    -----------------------------------------------------------------
    procedure log_end_process(
                    p_stop_time        date     ,
                    p_rows_uploaded    number   ,
                    p_filename         varchar2 ,
                    p_id               in out number) ;
   -----------------------------------------------------------------
   --  LOG_ERROR_PROCESS()
   --
   --    Запротоколировать неуспешное  завершние выгрузки
   --    p_stop_time      --  свремя окончания
   --    p_errmess        --  ошибка
   --    p_id             --  возвращает внутренний код код
   --
   -----------------------------------------------------------------
   procedure log_error_process(
                   p_stop_time        date     ,
                   p_errmess          varchar2 ,
                   p_id               in out number) ;

   -----------------------------------------------------------------
   --    GET_PARAM
   --
   --    Получить параметр
   --
   function get_param(p_param_name varchar2) return varchar2;

   -----------------------------------------------------------------
   --    SET_PARAM
   --
   --    Устанвить глобальный параметр
   --
   function  set_param(p_param_name varchar2, p_value varchar2) return varchar2;
   procedure set_param(p_param_name varchar2, p_value varchar2);
   -----------------------------------------------------------------
   --    GET_JOB_PARAM
   --
   --    Получить параметр джоба по наименованию джоба
   --
   function get_job_param(p_job_name varchar2, p_param_name varchar2) return varchar2;
   -----------------------------------------------------------------
   --    SET_JOB_PARAM
   --
   --    Устанвить параметр джоба по наименованию джоба
   --
   function  set_job_param(p_job_name varchar2, p_param_name varchar2, p_value varchar2) return varchar2;
   procedure set_job_param(p_job_name varchar2, p_param_name varchar2, p_value varchar2);

  -----------------------------------------------------------------
   --    GET_GROUP_PARAM
   --
   --    Получить параметры группы выгрузки (или другими словами джоба)
   --
   function get_group_param(p_groupid number, p_param_name varchar2) return varchar2;

   -----------------------------------------------------------------
   --    SET_GROUP_PARAM
   --
   --    Устанвить параметры группы выгрузки (или другими словами джоба)
   --
   function  set_group_param(p_groupid number, p_param_name varchar2, p_value varchar2) return varchar2;
   procedure set_group_param(p_groupid number, p_param_name varchar2, p_value varchar2);
   -----------------------------------------------------------------
   --    INIT_PARAMS
   --
   --    Функция для инициализации переменных
   --
   procedure init_params(p_force number default 0);

	-----------------------------------------------------------------
    --  UPLOAD_STAT_FILE
    --
    --   Выгрузить файл со статистикой c логированием в upl_stats
    --
    --    p_filegroup   --  Код группы
    --    p_parentid    --  код родителя в журнале статистикки (код статистики для группы, которая запустила этот файл на выгрузку)
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    return        --  номер записи в журнале статистики (upl_stats) для данного файла
    -----------------------------------------------------------------
    function   upload_stat_file (  p_filegroup    number,
                                   p_parentid     number default null,
                                   p_param1       varchar2
                                ) return number;



end;
/
CREATE OR REPLACE PACKAGE BODY BARSUPL.BARS_UPLOAD 
is
    -----------------------------------------------------------------
    --                                                             --
    --   Выгрузка данных вплоские текстовые файлы                  --
    --   author : Lut Anny
    --   created: 01-07-2012
    --                                                             --
    -- version 4.9 16.02.2018 Добавлены функции установки параметров выгрузки set_param, set_job_param, set_group_param
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    G_BODY_VERSION         constant varchar2(64)  := 'version 4.9 16.02.2018';
    G_TRACE                constant varchar2(20)  := 'bars_upload.';
    G_MODULE               constant varchar2(3)   := 'UPL';

    T_VARCHAR2             constant number := 1;
    T_NUMBER               constant number := 2;
    T_DATE                 constant number := 12;
    T_CHAR                 constant number := 96;

    G_WIN_ENCODE           constant varchar2(20) := 'CL8MSWIN1251';
    G_DOS_ENCODE           constant varchar2(20) := 'RU8PC866';

    G_DEF_DATE_FORMAT      constant varchar2(18) := 'dd/mm/yyyyhh:mi:ss';
    G_DEF_DATE_LENGTH      constant number       :=  18;

    G_DEF_DECIMAL_FOR      constant varchar2(18) := '99999999999990.00';
    G_BUFF_LENGTH          constant number       :=  32765;

    G_USE_BUFF             constant varchar2(20) := 'BUFF';
    G_USE_CLOB             constant varchar2(20) := 'CLOB';

    G_INITIAL              constant number(1) := 1;
    G_INCREMENTAL          constant number(1) := 2;


    -----------------------------------------------------------------
    -- Типы
    -----------------------------------------------------------------

    -- масив параметров джоба
    type t_jobparam_list is table of upl_autojob_param_values.value%type   index by upl_autojob_param_values.param%type;

    -- таблица с масивами параметров джоба с индексом - наименованием джоба
    type t_alljobparam_list is table of t_jobparam_list index by upl_autojobs.job_name%type;


    -- список параметров системы
    type t_params_list is table of upl_params.value%type              index by upl_params.param%type;
    -- список статусов
    type t_staus_list  is table of upl_process_status.status_id%type  index by upl_process_status.status_code%type;
    -- список джобов и их групп
    type t_jobsgroup_list  is table of upl_autojobs.job_name%type     index by binary_integer;  --upl_groups.group_id%type;

    -----------------------------------------------------------------
    -- Переменные
    -----------------------------------------------------------------
    G_UPLOAD_METHOD        varchar2(20);
    G_PARAMS_LIST          t_params_list;
    G_STATUS_LIST          t_staus_list;
    G_JOBPARAM_LIST        t_alljobparam_list;
    G_JOBGROUP_LIST        t_jobsgroup_list;
    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2
    is
    begin
       return 'package header BARS_UPLOAD: ' || G_BODY_VERSION;
    end header_version;


    ---------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2
    is
    begin
       return 'package body BARS_UPLOAD ' || G_BODY_VERSION;
    end body_version;


    -----------------------------------------------------------------
    --  LOG_EVENT()
    --
    --    Запротоколировать событие
    --
    --    p_status_code    --  Код статуса
    --    p_start_time     --  свремя старта
    --    p_stop_time      --  время оончания
    --    p_errmess        --  сообщение об ошшибке
    --    p_jobid          --
    --    p_groupid        --  код группы (или пусто , если для файла)
    --    p_fileid         --  код файла
    --    p_parentid       --  родительский код аудита группы для файла
    --    p_rows_uploaded  --  кол-во выгруженых
    --    p_bankdate       -- банк дата выгрузки
    --    p_params         -- параметры выгрузки
    --    p_id             --  возвращает внутренний код код
    -----------------------------------------------------------------
    procedure log_event(
                    p_status_code      upl_process_status.status_code%type,
                    p_start_time       date      default null,
                    p_stop_time        date      default null,
                    p_errmess          varchar2  default null,
                    p_jobid            number    default null,
                    p_groupid          number    default null,
                    p_fileid           number    default null,
                    p_parentid         number    default null,
                    p_sqlid            number    default null,
                    p_rows_uploaded    number    default null,
                    p_filename         varchar2  default null,
                    p_bankdate         date      default null,
                    p_params           varchar2  default null,
                    p_id               in out number)
    is
       pragma autonomous_transaction;
       l_newid    number;
       l_statusid number;
       l_parentid number;
       l_rectype  upl_stats.rec_type%type;
    begin

       select status_id into l_statusid  from  upl_process_status where status_code = p_status_code;



       case p_status_code
            -- старт работы выгрузки
            when  'UPLOADING' then
                  l_newid := s_upl_stats.nextval;
                  insert into upl_stats(id, file_id, sql_id, start_time, status_id, group_id,
                                        params, parent_id, job_id, upl_bankdate, rec_type)
                  values (l_newid, p_fileid, p_sqlid, p_start_time, l_statusid,  p_groupid,
                          p_params, p_parentid, p_jobid, p_bankdate,
                           case when p_groupid is null then 'JOB'
                                  when p_fileid  is null and  p_groupid is not null then 'GROUP'
                                else 'FILE' end);
                  p_id := l_newid;
            -- успешное завершение работы
            when  'UPLOADED' then
                  update upl_stats
                     set stop_time = p_stop_time, status_id = l_statusid, file_name =  p_filename,  rows_uploaded = p_rows_uploaded
                   where id = p_id;

                  begin
                     select rec_type, parent_id into l_rectype, l_parentid  from  upl_stats  where  id = p_id;
                     if l_rectype = 'GROUP'  then  -- нужно закрыть и статус JOB-а
                        update upl_stats set stop_time = p_stop_time, status_id = l_statusid,  rows_uploaded = p_rows_uploaded
                         where id = l_parentid;
                     end if;
                  exception when no_data_found then null;
                  end;

            -- ошибочное завершение работы
            when  'ERROR' then
                  update upl_stats
                     set stop_time = p_stop_time,
                         status_id = l_statusid,
                          rows_uploaded = p_rows_uploaded,
                         upl_errors = p_errmess
                   where id = p_id;
            else null;
       end case;
       commit;

    end;


    -----------------------------------------------------------------
    --  LOG_START_AFTERUPL_EVENT()
    --
    --    Запротоколировать начало события после выгрузки (архивация, фтп)
    --
    --    p_id             --  Код в протоколе выгрузки
    --    p_eventname      --  (ARC или FTP)
    -----------------------------------------------------------------
    procedure log_start_afterupl_event(
                    p_id           number,
                    p_eventname    varchar2 )
    is
       pragma autonomous_transaction;
    begin
       if p_id is not null then
          if p_eventname = 'ARC' then
             update upl_stats set start_arc_time = sysdate where id = p_id;
          else
             update upl_stats set start_ftp_time = sysdate where id = p_id;
          end if;
          commit;
       end if;

    end;


    -----------------------------------------------------------------
    --  LOG_STOP_AFTERUPL_EVENT()
    --
    --    Запротоколировать окончание события после выгрузки (архивация, фтп)
    --
    --    p_id             --  Код в протоколе выгрузки
    --    p_eventname      --  (ARC или FTP)
    --    p_message        --  сообщение
    -----------------------------------------------------------------
    procedure log_stop_afterupl_event(
                    p_id           number,
                    p_eventname    varchar2,
                    p_message       varchar2)
    is
       pragma autonomous_transaction;
    begin
       if p_id is not null then
          if p_eventname = 'ARC' then
             update upl_stats set stop_arc_time = sysdate, arc_logmess = p_message where id = p_id;
          else
             update upl_stats set stop_ftp_time = sysdate, ftp_logmess = p_message where id = p_id;
          end if;
          commit;
       end if;
    end;


    -----------------------------------------------------------------
    --  LOG_START_PROCESS()
    --
    --    Запротоколировать старт выгрузки
    --    p_start_time     --  свремя старта
    --    p_groupid        --  код группы (или пусто , если для файла)
    --    p_fileid         --  код файла
    --    p_parentid       --  родительский код аудита группы для файла
    --    p_params         --  параметры
    --    p_id             --  возвращает внутренний код код
    -----------------------------------------------------------------
    procedure log_start_process(
                    p_start_time       date                  ,
                    p_jobid            number    default null,
                    p_groupid          number    default null,
                    p_fileid           number    ,
                    p_parentid         number    ,
                    p_sqlid            number    ,
                    p_params           varchar2  ,
                    p_bankdate         date      ,
                    p_id               in out number)
    is
       l_trace varchar2(500) := G_TRACE||'log_start_process: ';
       l_msg   varchar2(500);
       l_res   varchar2(100);
    begin

       l_msg := case when p_fileid is null     and p_groupid is null     then 'джоба №'||p_jobid
                     when p_fileid is null     and p_groupid is not null then 'группы №'||p_groupid
                     when p_fileid is not null                           then 'файла №'||p_fileid
                end;
       log_event(
                 p_status_code    => 'UPLOADING',
                 p_start_time     => p_start_time,
                 p_jobid          => p_jobid,
                 p_groupid        => p_groupid,
                 p_fileid         => p_fileid,
                 p_parentid       => p_parentid,
                 p_sqlid          => p_sqlid,
                 p_params         => p_params,
                 p_bankdate       => p_bankdate,
                 p_id             => p_id);
       l_res := case when p_fileid is null     and p_groupid is null     then set_param('STAT_JOB_ID',to_char(p_id))
                     when p_fileid is null     and p_groupid is not null then set_param('STAT_GROUP_ID',to_char(p_id))
                     when p_fileid is not null                           then set_param('STAT_FILE_ID',to_char(p_id))
                end;
       bars.bars_audit.info(l_trace||'старт выгрузки '||l_msg||' upl_stat.id=' || p_id);
    end;


    -----------------------------------------------------------------
    --  LOG_END_PROCESS()
    --
    --    Запротоколировать успешное завершние выгрузки
    --    p_stop_time      --  свремя окончания
    --    p_rowsuploaded
    --    p_id             --  возвращает внутренний код код
    --
    -----------------------------------------------------------------
    procedure log_end_process(
                    p_stop_time        date     ,
                    p_rows_uploaded    number   ,
                    p_filename         varchar2 ,
                    p_id               in out number)

    is
       l_trace    varchar2(500) := G_TRACE||'log_end_process: ';
       l_filename varchar2(200) := '';
    begin
       l_filename :=  case when p_filename is null then '' else p_filename end;
       log_event(
                 p_status_code   => 'UPLOADED',
                 p_stop_time     => p_stop_time,
                 p_rows_uploaded => p_rows_uploaded,
                 p_filename      => p_filename,
                 p_id            => p_id);
       bars.bars_audit.info(l_trace||'успешное завершение выгрузки ' || l_filename ||' upl_stat.id=' || p_id);
    end;


    -----------------------------------------------------------------
    --  LOG_ERROR_PROCESS()
    --
    --    Запротоколировать неуспешное  завершние выгрузки
    --    p_stop_time      --  свремя окончания
    --    p_errmess        --  ошибка
    --    p_id             --  возвращает внутренний код код
    --
    -----------------------------------------------------------------
    procedure log_error_process(
                    p_stop_time        date     ,
                    p_errmess          varchar2 ,
                    p_id               in out number)
    is
       l_trace varchar2(500) := G_TRACE||'log_error_process: ';
    begin
       bars.bars_audit.error(l_trace||'ошибочное завершение выгрузки: '||p_errmess);
       log_event(
                 p_status_code   => 'ERROR',
                 p_stop_time     => p_stop_time,
                 p_errmess       => p_errmess,
                 p_id            => p_id);
    end;


    -----------------------------------------------------------------
    --  PARSE_COL_DESC()
    --
    --    По курсору разобрать поля запроса и заполнить сруктуру колонок
    --
    --    p_cur           --  Открытый курсор 
    --    p_cdesc         --  структура описания колонок
    --
    -----------------------------------------------------------------
    procedure parse_col_desc(
                    p_cur               number,
                    p_cdesc     in out  t_cols)
    is
       l_tabrow      dbms_sql.desc_tab;
       l_colcnt      number;
       i             number;
       l_trace       varchar2(2000) := G_MODULE||'.parse_col_desc:';
    begin
       bars_audit.trace(l_trace||'Начало разбора структуры колонок запроса');
       dbms_sql.describe_columns(p_cur, l_colcnt, l_tabrow);
       p_cdesc.colcnt := l_colcnt;

       i := l_tabrow.first;

       loop
          p_cdesc.colname(i):= l_tabrow(i).col_name;
          case   when l_tabrow(i).col_type = T_DATE then
                      p_cdesc.coltype(i):= 'DATE';
                      p_cdesc.collen(i) := G_DEF_DATE_LENGTH;
                      p_cdesc.colscl(i) := 0;

                 when l_tabrow(i).col_type = T_VARCHAR2 or l_tabrow(i).col_type = T_CHAR then
                      p_cdesc.coltype(i):= 'CHAR';
                      p_cdesc.collen(i) := l_tabrow(i).col_max_len;
                      p_cdesc.colscl(i) := 0;

                 when l_tabrow(i).col_type = T_NUMBER then
                      p_cdesc.coltype(i):= 'NUMBER';
                      if l_tabrow(i).col_precision = 0 then
                         p_cdesc.collen(i) := l_tabrow(i).col_max_len;
                         p_cdesc.colscl(i) := 0;
                      else
                         p_cdesc.collen(i) := l_tabrow(i).col_precision + l_tabrow(i).col_scale;
                         p_cdesc.colscl(i) := l_tabrow(i).col_scale;
                      end if;
                 else
                      bars.bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_DATATYPE', p_cdesc.colname(i), to_char(l_tabrow(i).col_type) );
                 end case;

           i := l_tabrow.next(i);
           exit when (i is null);
       end loop;



    end;


    -----------------------------------------------------------------
    --  GET_DATE_COLVAL()
    --
    function get_date_colval( p_cur      number,
                              p_cdesc    t_cols,
                              p_datecol  in out  date,
                              p_nullval  varchar2,
                              p_eqvspace number,
                              k          number) return varchar2
    is
        l_tmp           varchar2(4000);
    begin
       dbms_sql.column_value(p_cur, k, p_datecol);
       -- форматируем дату
       l_tmp := to_char(p_datecol, nvl(p_cdesc.colfrmt(k), G_DEF_DATE_FORMAT)  );
       -- замещаем указанные символы
       if  p_cdesc.chrfrom(k) is not null  then
           l_tmp := translate(l_tmp, p_cdesc.chrfrom(k), p_cdesc.chrto(k));
       end if;
       l_tmp :=  case  when p_eqvspace  = 1 then
                       lpad( nvl(l_tmp, p_nullval), nvl( p_cdesc.collen(k), G_DEF_DATE_LENGTH ) )
                       else nvl(l_tmp,p_nullval)
                 end;
       return l_tmp;
    end;

    -----------------------------------------------------------------
    --  GET_CHAR_COLVAL()
    --
    function get_char_colval( p_cur       number,
                              p_cdesc     t_cols,
                              p_vrchrcol  in out varchar2,
                              p_nullval   varchar2,
                              p_eqvspace  number,
                              k          number  ) return varchar2
    is
        l_tmp           varchar2(4000);
    begin
      dbms_sql.column_value(p_cur, k, p_vrchrcol);
      l_tmp := p_vrchrcol;
      -- замещаем указанные символы
      if p_cdesc.chrfrom(k) is not null then
            l_tmp := translate(l_tmp, p_cdesc.chrfrom(k), p_cdesc.chrto(k));
      end if;
      l_tmp := case when p_eqvspace  = 1 then
                    rpad( substr( nvl(l_tmp,p_nullval), 1, p_cdesc.collen(k)),p_cdesc.collen(k))
                    else nvl(l_tmp, p_nullval)
               end;
       return l_tmp;
    end;


    -----------------------------------------------------------------
    --  GET_NUM_COLVAL()
    --
    function get_num_colval(  p_cur       number,
                              p_cdesc     t_cols,
                              p_nmbrcol   in out number,
                              p_nullval   varchar2,
                              p_eqvspace  number,
                              k          number  ) return varchar2
    is
        l_tmp           varchar2(4000);
    begin
       dbms_sql.column_value(p_cur, k, p_nmbrcol);
       if p_nmbrcol is not null then
           if p_cdesc.colfrmt(k) is not null then
               l_tmp := to_char(p_nmbrcol,  p_cdesc.colfrmt(k));
           else
               l_tmp := to_char(p_nmbrcol);
           end if;
       else
           l_tmp:=null;
       end if;

       -- замещаем указанные символы
       if  p_cdesc.chrfrom(k) is not null then
           l_tmp := translate(l_tmp, p_cdesc.chrfrom(k), p_cdesc.chrto(k));
       end if;

       l_tmp :=  case  when p_eqvspace  = 1 then
                       lpad( substr( nvl(l_tmp, p_nullval), 1, p_cdesc.collen(k)),p_cdesc.collen(k))
                       else nvl(l_tmp, p_nullval)
                 end;

       return l_tmp;
    end;

/*
    -----------------------------------------------------------------
    --  UPLOAD_PARALLEL
    --
    --   По открытому курсору и указанной структуре  выгрузить файл на сервере
    --   Разделитель в конце не проставляется
    --
    -----------------------------------------------------------------
    function cur_to_flatfile_parallel(
                      p_cur         number,
                      p_cdesc       t_cols,
                      p_nullval     varchar2  default null,
                      p_delim       varchar2,
                      p_eqvspace    number  ,
                      p_colhdr      number  ,
                      p_directory   varchar2,
                      p_uplmethod   varchar2,
                      p_filename    varchar2
                      ) return t_upl_table
                      pipelined
                      parallel_enable (partition p_cur by any) as
      type row_ntt is table of varchar2(32767);
      v_rows    row_ntt;
      v_file    UTL_FILE.FILE_TYPE;
      v_buffer  VARCHAR2(32767);
      v_sid     NUMBER;
      v_name    VARCHAR2(128);
      v_lines   PLS_INTEGER := 0;
       c_eol     CONSTANT VARCHAR2(1) := CHR(10);
      c_eollen  CONSTANT PLS_INTEGER := LENGTH(c_eol);
      c_maxline CONSTANT PLS_INTEGER := 32767;
       l_ret           number;
       l_rowcnt        number;
       i               number;
       l_data          varchar2(32765);
       l_tmp           varchar2(32000);
       l_vrchrcol      varchar2(4000);
       l_nmbrcol       number(38,10);
       l_datecol       date;
       l_clobcol       clob;
       l_fileh         UTL_FILE.File_Type;
       l_colhdrline    varchar2(4000);
       l_format        varchar2(100);
       l_nullval       varchar2(10);
       l_clob          clob;
       l_trace         varchar2(2000) := G_TRACE||'cur_to_flatfile:';

   BEGIN

      SELECT sid INTO v_sid FROM v$mystat WHERE ROWNUM = 1;
      v_name := p_filename || '_' || TO_CHAR(v_sid) || '.txt';
      v_file := UTL_FILE.FOPEN(p_directory, v_name, 'w', 32767);


        -- Для выполнения динамич. запроса - присвоим IN переменные
       for i in 1..p_cdesc.colcnt  loop
           -- основываемся сдесь на нашем описании структуры
           case p_cdesc.coltype(i)
               when 'DATE'     then   dbms_sql.define_column(p_cur,i,l_datecol);
               when 'CHAR'     then   dbms_sql.define_column(p_cur,i,l_vrchrcol, p_cdesc.collen(i));
               when 'VARCHAR2' then   dbms_sql.define_column(p_cur,i,l_vrchrcol, p_cdesc.collen(i));
               when 'NUMBER'   then   dbms_sql.define_column(p_cur,i,l_nmbrcol);
               else
                    bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_DATATYPE', p_cdesc.coltype(i));
           end case;

           -- создать строку с наименованиями колонок
           if p_colhdr = 1 then
              if i <> 1 then
                 l_colhdrline := l_colhdrline ||case when p_delim is not null then p_delim else '' end;
              end if;
              l_colhdrline := l_colhdrline ||  rpad(substr(p_cdesc.colname(i), 1, p_cdesc.collen(i) ), p_cdesc.collen(i));
           end if;
       end loop;

       v_name := p_filename || '_' || TO_CHAR(v_sid) || '.txt';

        case when G_UPLOAD_METHOD = 'BUFF'  then
                 -- Открыть файл для записи
                 begin
                    l_fileh :=  utl_file.fopen (location     => p_directory,
                                                filename     => v_name,
                                                open_mode    => 'w',
                                                max_linesize => 32767);
                 exception when others then
                    if sqlcode = -29280 then    -- ORA-29280: invalid directory path
                       bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_ORADIR', p_directory);
                    else raise;
                    end if;
                 end;
            when G_UPLOAD_METHOD = 'CLOB' then
                 -- инициализировать клоб
                 dbms_lob.createtemporary(l_clob, TRUE);
       end case;

       case when G_UPLOAD_METHOD = 'BUFF' then bars.bars_audit.trace(l_trace||'Выгрузка через буффер');
            when G_UPLOAD_METHOD = 'CLOB' then bars.bars_audit.trace(l_trace||'Выгрузка через клоб');
       end case;


       -- Начинаем построчно вынимать данные из курсора
       l_rowcnt := 0;
       i := 0;
       l_nullval := nvl(p_nullval, case  when p_eqvspace  = 1 then ' ' else  '' end);
       l_data := '';

       while dbms_sql.fetch_rows(p_cur) != 0 loop

          l_rowcnt := l_rowcnt + 1;
          for k in 1..p_cdesc.colcnt loop

              case -- дата
                   when p_cdesc.coltype(k) = 'DATE' then
                        l_tmp := get_date_colval( p_cur, p_cdesc, l_datecol, l_nullval, p_eqvspace,k);
                   -- строки
                   when p_cdesc.coltype(k) = 'CHAR'  or p_cdesc.coltype(k) =  'VARCHAR2' then
                        l_tmp := get_char_colval( p_cur, p_cdesc, l_vrchrcol, l_nullval, p_eqvspace,k);
                   -- числа
                   when  p_cdesc.coltype(k) = 'NUMBER' then
                        l_tmp := get_num_colval( p_cur, p_cdesc, l_nmbrcol, l_nullval, p_eqvspace,k);
                   else  bars.bars_error.raise_error(G_MODULE, 7, '-'||p_cdesc.coltype(k)||'-' );
             end case;


             if length(l_data) + length(p_delim) + length(l_tmp) > G_BUFF_LENGTH - 1  then
                case when G_UPLOAD_METHOD = 'BUFF' then
                          i:= i+1;
                          utl_file.put(l_fileh, l_data);
                          utl_file.fflush(l_fileh);
                          --bars.bars_audit.trace(l_trace||'flash #'||i);
                        when G_UPLOAD_METHOD = 'CLOB' then
                          dbms_lob.writeappend(l_clob, length(l_data), l_data);
                end case;
                l_data := '';
             end if;


             --

             l_data:= l_data||case when (k > 1 and p_delim is not null) then p_delim else '' end||l_tmp;

          end loop;  -- по колонкам
          l_data := l_data||chr(10);
       end loop;  --- по строкам


       case when G_UPLOAD_METHOD = 'BUFF' then
                 utl_file.put(l_fileh, l_data);
                 utl_file.fclose(l_fileh);
            when G_UPLOAD_METHOD = 'CLOB' then
             dbms_lob.writeappend(l_clob, length(l_data), l_data);
          dbms_xslprocessor.clob2file(l_clob, p_directory, v_name);
                  dbms_lob.freetemporary(l_clob);
       end case;

        dbms_sql.close_cursor(p_cur);

      pipe row (t_upl_ot(v_name, l_rowcnt, v_sid));
      return;

   END;
    */


    -----------------------------------------------------------------
    --  CUR_TO_FLAT_FILE()
    --
    --   По открытому курсору и указанной структуре  выгрузить файл на сервере
    --   Разделитель в конце не проставляется
    --
    --    p_cur           --  открытый курсор
    --    p_coldesc       --  структура колонок
    --    p_nullval       --  значения, которыми заенять null
    --    p_eqvspace      --  =1 -  выравнивать все по указанной длинне в структуре, =0 - обрезать по длине значения
    --    p_colhdr        --  флаг =1 - добавлять первой строкой наименование колонок,  =0 - не добавлять
    --    p_directory     --  oracle directory
    --    p_uplmethod     --  Способ выгрузки (CLOB- через CLOB, BUFF - через utl_file))
    --    p_filename      --  имя файла
    --    p_arcdir        --  директория для архива
    --    p_rownum        --  кол-во выбранных строк
    --
    -----------------------------------------------------------------
    procedure cur_to_flatfile(
                    p_cur         number,
                    p_cdesc       t_cols,
                    p_nullval     varchar2  default null,
                    p_delim       varchar2,
                    p_eqvspace    number  ,
                    p_colhdr      number  ,
                    p_directory   varchar2,
                    p_uplmethod   varchar2,
                    p_filename    varchar2,
                    p_rownum      out number)
    is
       l_ret           number;
       l_rowcnt        number;
       i               number;
       l_data          varchar2(32765);
       l_tmp           varchar2(32000);
       l_vrchrcol      varchar2(4000);
       l_nmbrcol       number;  --l_nmbrcol       number(38,10)
       l_datecol       date;
       l_clobcol       clob;
       l_fileh         UTL_FILE.File_Type;
       l_colhdrline    varchar2(4000);
       l_format        varchar2(100);
       l_nullval       varchar2(10);
       l_arcdir        varchar2(200);
       l_clob          clob;
       l_trace         varchar2(2000) := G_TRACE||'cur_to_flatfile: ';
    begin

       G_UPLOAD_METHOD := p_uplmethod;

       bars.bars_audit.trace(l_trace||'старт функции');

       -- выполнить запрос
       l_ret := dbms_sql.execute(p_cur);
       bars.bars_audit.trace(l_trace||'выполнили курсор');
       bars.bars_audit.trace(l_trace||'в описании колонок всего колонок'||p_cdesc.colcnt);



       -- Для выполнения динамич. запроса - присвоим IN переменные
       for i in 1..p_cdesc.colcnt  loop
           -- основываемся сдесь на нашем описании структуры
           case p_cdesc.coltype(i)
               when 'DATE'     then   dbms_sql.define_column(p_cur,i,l_datecol);
               when 'CHAR'     then   dbms_sql.define_column(p_cur,i,l_vrchrcol, p_cdesc.collen(i));
               when 'VARCHAR2' then   dbms_sql.define_column(p_cur,i,l_vrchrcol, p_cdesc.collen(i));
               when 'NUMBER'   then   dbms_sql.define_column(p_cur,i,l_nmbrcol);
               else
                    bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_DATATYPE', p_cdesc.coltype(i));
           end case;

           -- создать строку с наименованиями колонок
           if p_colhdr = 1 then
              if i <> 1 then
                 l_colhdrline := l_colhdrline ||case when p_delim is not null then p_delim else '' end;
              end if;
              l_colhdrline := l_colhdrline ||  rpad(substr(p_cdesc.colname(i), 1, p_cdesc.collen(i) ), p_cdesc.collen(i));
           end if;
       end loop;

       bars.bars_audit.trace(l_trace||'открываем файл для записи '||p_filename);

       case when G_UPLOAD_METHOD = 'BUFF'  then
                 -- Открыть файл для записи
                 begin
                    l_fileh :=  utl_file.fopen (location     => p_directory,
                                                filename     => p_filename,
                                                open_mode    => 'w',
                                                max_linesize => 32767);
                 exception when others then
                    if sqlcode = -29280 then    -- ORA-29280: invalid directory path
                       bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_ORADIR', p_directory);
                    else raise;
                    end if;
                 end;
            when G_UPLOAD_METHOD = 'CLOB' then
                 -- инициализировать клоб
                 dbms_lob.createtemporary(l_clob, TRUE);
       end case;

       case when G_UPLOAD_METHOD = 'BUFF' then bars.bars_audit.trace(l_trace||'Выгрузка через буффер');
            when G_UPLOAD_METHOD = 'CLOB' then bars.bars_audit.trace(l_trace||'Выгрузка через клоб');
       end case;


       -- если нужно вставить первую строку с наименованиями колонок
       if p_colhdr  = 1 then
          case when G_UPLOAD_METHOD = 'BUFF' then utl_file.put_line(l_fileh, l_colhdrline);
               when G_UPLOAD_METHOD = 'CLOB' then dbms_lob.writeappend(l_clob, length(l_colhdrline), l_colhdrline);
          end case;
       end if;

       -- Начинаем построчно вынимать данные из курсора
       l_rowcnt := 0;
       i := 0;
       l_nullval := nvl(p_nullval, case  when p_eqvspace  = 1 then ' ' else  '' end);
       l_data := '';

       while dbms_sql.fetch_rows(p_cur) != 0 loop

          l_rowcnt := l_rowcnt + 1;
          for k in 1..p_cdesc.colcnt loop

              case -- дата
                   when p_cdesc.coltype(k) = 'DATE' then
                        l_tmp := get_date_colval( p_cur, p_cdesc, l_datecol, l_nullval, p_eqvspace,k);
                   -- строки
                   when p_cdesc.coltype(k) = 'CHAR'  or p_cdesc.coltype(k) =  'VARCHAR2' then
                        l_tmp := get_char_colval( p_cur, p_cdesc, l_vrchrcol, l_nullval, p_eqvspace,k);
                   -- числа
                   when  p_cdesc.coltype(k) = 'NUMBER' then
                        l_tmp := get_num_colval( p_cur, p_cdesc, l_nmbrcol, l_nullval, p_eqvspace,k);
                   else  bars.bars_error.raise_error(G_MODULE, 7, '-'||p_cdesc.coltype(k)||'-' );
             end case;


             if length(l_data) + nvl(length(p_delim),0) + nvl(length(l_tmp),0) > G_BUFF_LENGTH - 1  then
                case when G_UPLOAD_METHOD = 'BUFF' then
                          i:= i+1;
                          utl_file.put(l_fileh, l_data);
                          utl_file.fflush(l_fileh);
                        when G_UPLOAD_METHOD = 'CLOB' then
                          dbms_lob.writeappend(l_clob, length(l_data), l_data);
                end case;
                l_data := '';
             end if;


             l_data:= l_data||case when (k > 1 and p_delim is not null) then p_delim else '' end||l_tmp;

          end loop;  -- по колонкам
          l_data := l_data||chr(10);
       end loop;  --- по строкам

       p_rownum := l_rowcnt;

       bars_audit.trace(l_trace||'всего выгружено строк '||(l_rowcnt));

       case when G_UPLOAD_METHOD = 'BUFF' then
                if length(l_data) > 0 then
                   utl_file.put(l_fileh, l_data);
                end if;


                utl_file.fclose(l_fileh);
            when G_UPLOAD_METHOD = 'CLOB' then
                if length(l_data) > 0 then
                      dbms_lob.writeappend(l_clob, length(l_data), l_data);
                end if;


                if dbms_lob.getlength(l_clob) > 0 then
                   bars_audit.trace(l_trace||' запись в файл, в дир.='||p_directory||' файл = '||p_filename||'. Размер клоба='||dbms_lob.getlength(l_clob));
                   dbms_xslprocessor.clob2file(l_clob, p_directory, p_filename);
                else
                   -- генерить пустые файлы
                   if G_PARAMS_LIST('EMPTY_FILES') = '1' then
                         l_fileh :=  utl_file.fopen (location     => p_directory,
                                                  filename     => p_filename,
                                                  open_mode    => 'w',
                                                  max_linesize => 32767
                                                  );
                      utl_file.fclose(l_fileh);
                    end if;

               end if;


                dbms_lob.freetemporary(l_clob);
       end case;
    end;


    -----------------------------------------------------------------
    --  SQL_TO_FLAT_FILE()
    --
    --   По тектсу SQL выгрузить в файл на сервере
    --   Разделитель в конце не проставляется
    --
    --    p_sql           --  запрос SQL 
    --    p_delim         --  разделитель
    --    p_eqvspace      --  флаг =1 - дополнение значений до указанной длинны (все значения будут одинаковой длинны), =0 - значения будут триматься
    --    p_colhdr        --  флаг =1 - добавлять первой строкой наименование колонок,  =0 - не добавлять
    --    p_directory     --  oracle directory
    --    p_uplmethod     --  Способ выгрузки (CLOB- через CLOB, BUFF - через utl_file))
    --    p_filename      --  имя файла
    -----------------------------------------------------------------
    procedure sql_to_flatfile(
                    p_sql         clob,
                    p_nullval     varchar2,
                    p_delim       varchar2,
                    p_eqvspace    number  ,
                    p_colhdr      number  ,
                    p_directory   varchar2,
                    p_uplmethod   varchar2,
                    p_filename    varchar2)

    is
       l_cur           number;
       l_rownum        number;
       l_cdesc         t_cols;
       l_trace         varchar2(2000) := G_TRACE||'sql_to_flatfile:';
    begin

       l_cur := dbms_sql.open_cursor;
       bars.bars_audit.trace(l_trace||'Выполнение запроса:'||p_sql);
       dbms_sql.parse(l_cur, p_sql, dbms_sql.native);

       --разобрать запрос по колонкам
       parse_col_desc(l_cur, l_cdesc);

       cur_to_flatfile(
                    p_cur        => l_cur,
                    p_cdesc      => l_cdesc,
                    p_nullval    => p_nullval,
                    p_delim      => p_delim,
                    p_eqvspace   => p_eqvspace,
                    p_colhdr     => p_colhdr,
                    p_directory  => p_directory,
                    p_uplmethod  => p_uplmethod,
                    p_filename   => p_filename,
                    p_rownum     => l_rownum);
       dbms_sql.close_cursor(l_cur);
    end;

    -----------------------------------------------------------------
    --  SQL_TO_FLAT_FILE()
    --
    --   По тектсу SQL выгрузить в файл на сервере
    --   Разделитель в конце не проставляется
    --
    --    p_sql           --  запрос SQL 
    --    p_delim         --  разделитель
    --    p_eqvspace      --  флаг =1 - дополнение значений до указанной длинны (все значения будут одинаковой длинны), =0 - значения будут триматься
    --    p_colhdr        --  флаг =1 - добавлять первой строкой наименование колонок,  =0 - не добавлять
    --    p_directory     --  oracle directory
    --    p_filename      --  имя файла
    --
    -----------------------------------------------------------------
    procedure sql_to_flatfile(
                    p_sql         clob,
                    p_nullval     varchar2,
                    p_delim       varchar2,
                    p_eqvspace    number  ,
                    p_colhdr      number  ,
                    p_directory   varchar2,
                    p_filename    varchar2)
    is
    begin
        sql_to_flatfile(
                    p_sql         => p_sql,
                    p_nullval     => p_nullval,
                    p_delim       => p_delim,
                    p_eqvspace    => p_eqvspace,
                    p_colhdr      => p_colhdr,
                    p_directory   => p_directory,
                    p_uplmethod   => 'CLOB',
                    p_filename    => p_filename);
    end;


    -----------------------------------------------------------------
    --  ADD_TABLE_TO_UPLOAD
    --
    --   Автоматически добавить описание таблицы для выгрузки
    --   автоматом идет добавление имени файла, запроса и всех колонок таблицы(исключая RAW, CLOB, BLOB)
    --
    --    p_tabname    --  Имя таблицы
    --    p_owner      --  схема
    --    p_delimm     --  разделитеь
    --    p_endline    --  символ конца строки
    --    p_head_line  --  (1/0) 1 - первая строка наименование колонок, 0 - первая строка - начало данных
    --    p_eqvspace   --  (1/0) 1 - фиксированя ширина колонки, 0 - нет
    --    p_nullval    --  символы заменяющие пустое значение в файле (может быть переопределено для конкретной колонки в upl_columns)
    --    p_fileid     --  указать принудительно номер file_id, при значении null берется из последовательности s_upl_files
    --    p_ispart     --  (1/0). 1 - таблица содержит код филиала  0 - не содержит
    -----------------------------------------------------------------
    procedure add_table_to_upload
    ( p_tabname       user_tables.table_name%type,
      p_owner         varchar2     default 'BARS',
      p_delimm        varchar2     default '09',
      p_endline       varchar2     default '13||10',
      p_head_line     number       default 1,
      p_eqvspace      number       default 1,
      p_nullval       varchar2     default 'null',
      p_ispart        number       default 0,
      p_fileid        number       default null
    ) is
      l_tab_comment   sys.dba_tab_comments.comments%type;
      l_sqltext       varchar2(4000);
      l_tabalias      char(1);
      l_column_list   varchar2(4000);
      l_fileid        number;
      l_sqlid         number;
      i               number;
      l_skeleton      upl_columns.skeleton_values%type;
      l_format        upl_columns.col_format%type;
      l_length        upl_columns.col_length%type;
      l_scale         upl_columns.col_scale%type;
    begin

      begin
        select comments
          into l_tab_comment
          from sys.dba_tab_comments
         where table_name = upper(p_tabname)
           and owner = p_owner;
      exception
        when no_data_found then
          bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_TABLE', p_tabname, p_owner);
      end;

      l_tabalias := lower(substr(p_tabname,1,1));

      if p_fileid is Null
      then
        l_sqlid  := s_upl_sql.nextval;
        l_fileid := s_upl_files.nextval;
      else
        -- додати перевірку на існування файлу з такии ідентифікатором
        l_sqlid  := p_fileid;
        l_fileid := p_fileid;
      end if;

      -- вставка информации по запросу
      insert into upl_sql
        ( sql_id, descript, vers )
      values
        ( l_sqlid, l_tab_comment, '1.0' );

      -- вставка информации по файлу
      insert into upl_files
        ( file_id, sql_id, file_code, filename_prfx, descript, order_id,
          delimm, eqvspace, head_line, endline, nullval, partitioned )
      values
        ( l_fileid, l_sqlid, upper(p_tabname), lower(SubStr(p_tabname,1,15)), l_tab_comment, l_fileid,
          p_delimm, p_eqvspace, p_head_line, p_endline, p_nullval, p_ispart );

      if ( p_ispart = 1 )
      then
        -- вставка информации о колонке партиционирования
        Insert into BARSUPL.UPL_COLUMNS
          ( FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, PK_CONSTR, NULLABLE, SKELETON_VALUES, PK_CONSTR_ID )
        Values
          ( l_fileid, 0, 'KF', 'Код філіалу', 'CHAR', 6, 'Y', 'N', '-', 0 );
      end if;

      i := 1;

      for c in ( SELECT tc.column_id, tc.table_name,  tc.column_name,
                        tc.data_type, tc.data_length, tc.data_precision, tc.data_scale,
                        tc.nullable,  cm.comments,    cc.position,
                        nvl2(cc.position, 'Y', cc.position) as pk_col
                   FROM dba_tab_cols     tc
                  INNER
                   JOIN dba_col_comments cm
                     ON ( cm.table_name      = tc.table_name      and
                          cm.owner           = tc.owner           and
                          cm.column_name     = tc.column_name     )
                   LEFT
                   JOIN all_constraints  cs
                     ON ( cs.owner           = tc.owner           and
                          cs.table_name      = tc.table_name      and
                          cs.constraint_type = 'P'                )
                   LEFT
                   JOIN all_cons_columns cc
                     ON ( cc.owner           = tc.owner           and
                          cc.table_name      = tc.table_name      and
                          cc.column_name     = tc.column_name     and
                          cc.constraint_name = cs.constraint_name )
                  WHERE tc.table_name = upper(p_tabname)
                    AND tc.owner = upper(p_owner)
                    AND tc.data_type not in ('RAW','CLOB','BLOB')
                  ORDER BY tc.column_id )
      loop

        if ( p_ispart = 1 AND c.column_name = 'KF' )
        then
          null;
        else

          case
            when (c.data_type = 'DATE')
            then

              l_length   := 8;
              l_scale    := c.data_scale;
              l_format   := 'ddmmyyyy';
              l_skeleton := '31/12/9999';

            when (c.data_type = 'CHAR')
            then

              l_length   := c.data_length;
              l_scale    := c.data_scale;
              l_format   := null;
              l_skeleton := '-';

            when (c.data_type = 'VARCHAR2')
            then

              l_length   := c.data_length;
              l_scale    := c.data_scale;
              l_format   := null;
              l_skeleton := 'N/A';

            when (c.data_type = 'NUMBER')
            then

              l_length   := nvl(c.data_precision, c.data_length);
              l_scale    := c.data_scale;
              l_skeleton := '0';

              case
                when (c.data_precision is Null AND c.data_scale is Null)
                then -- тип поля NUMBER (без вказання к-ті значимих цифр)
                  l_scale  := 10;
                  l_format := '999999999990D0099999999';

                when (c.data_scale > 0)
                then -- вказана к-ть знаків після розділювача
                  l_format := lpad('0D', c.data_precision - c.data_scale + 1, '9') || rpad('0', c.data_scale, '0');

                else -- c.data_scale = 0 (INTEGER)
                  l_length := 15;
                  l_format := null;

              end case;

            else

              l_length   := c.data_length;
              l_scale    := c.data_scale;
              l_format   := null;
              l_skeleton := null;

          end case;

          -- вставка информации о колонке
          insert into upl_columns
            ( file_id,    col_id,    col_name,   col_desc,        col_type,  nullable,
              col_length, col_scale, col_format, skeleton_values, pk_constr, pk_constr_id )
          values
            ( l_fileid, c.column_id, c.column_name, c.comments, c.data_type, c.nullable,
              l_length, l_scale,     l_format,      l_skeleton, c.pk_col,    c.position );

          -- формирование строки запроса
          if ( i = 1 )
          then
             l_column_list := l_tabalias||'.'||c.column_name;
          else
             l_column_list := l_column_list||', '||l_tabalias||'.'||c.column_name;
          end if;

          i := i + 1;

        end if;

      end loop;

      if (p_ispart = 1)
      then
        l_column_list := 'bars.gl.kf as KF, ' || l_column_list;
      end if;

      l_sqltext := 'select '||l_column_list||chr(10)||
                   '  from '||p_owner||'.'||p_tabname||' '||l_tabalias;

      update upl_sql
         set sql_text = l_sqltext
       where sql_id   = l_sqlid;

    end;


    -----------------------------------------------------------------
    --  ADD_SQL_TO_UPLOAD
    --
    --   Автоматически добавить описание структуры колонок из запроса
    --   автоматом идет добавление имени файла, запроса и всех колонок таблицы(исключая RAW, CLOB, BLOB)
    --
    --    p_sqltext    -- Запрос
    --    p_filecode   -- Код файла выгрузки
    --    p_filedesc   -- описание
    --    p_delimm     -- описани разделителя колонок (например '09||124' -  табуляция и пробел)
    --    p_endline    -- символ окончания строки (аналогично как и для разделителя)
    --    p_headline   -- наличие первой строки заголовка с колонками в файле
    --    p_eqvspace   -- =1 фиксированя ширина колонки, -0 - нет
    --    p_nullval    --  символы заменяющие пустое значение в файле (может быть переопределено для конкретной колонки в upl_columns)
    --    p_ispart     --  (1/0). 1 - таблица содержит код филиала  0 - не содержит
    --    p_fileid     --  указать принудительно номер file_id, при значении null берется из последовательности s_upl_files
    --
    -----------------------------------------------------------------
    procedure add_sql_to_upload
    ( p_sqltext       varchar2,
      p_filecode      varchar2,
      p_filedesc      varchar2,
      p_delimm        varchar2   default '09',
      p_endline       varchar2   default '13||10',
      p_head_line     number     default 1,
      p_eqvspace      number     default 1,
      p_nullval       varchar2   default 'null',
      p_ispart        number     default 0,
      p_fileid        number     default null
    ) is
      l_cur           number;
      l_rownum        number;
      l_fileid        number;
      l_sqlid         number;
      l_cdesc         t_cols;
      l_trace         varchar2(2000) := G_TRACE||'add_sql_to_upload:';
    begin

      l_cur := dbms_sql.open_cursor;
      dbms_sql.parse(l_cur, p_sqltext, dbms_sql.native);

      --разобрать запрос по колонкам
      parse_col_desc(l_cur, l_cdesc);

       if p_fileid is Null
      then
        l_sqlid  := s_upl_sql.nextval;
        l_fileid := s_upl_files.nextval;
      else
        l_sqlid  := p_fileid;
        l_fileid := p_fileid;
      end if;

      -- вставка информации по запросу
      insert into upl_sql
        ( sql_id, sql_text, descript, vers )
      values
        ( l_sqlid, p_sqltext, p_filedesc, '1.0' );

      -- вставка информации по файлу
      insert into upl_files
        ( file_id, sql_id, file_code, filename_prfx, descript, order_id,
          delimm, eqvspace, head_line, endline, nullval, partitioned )
      values
        ( l_fileid, l_sqlid, upper(p_filecode), lower(p_filecode), p_filedesc, l_fileid,
          p_delimm, p_eqvspace, p_head_line, p_endline, p_nullval, p_ispart );

      -- установим описание колонок в соответсвующую таблицу
      for k in 1..l_cdesc.colcnt
      loop
        insert into upl_columns
          ( file_id, col_id, col_name, col_desc, col_type, col_length, col_scale )
        values
          ( l_fileid, k, l_cdesc.colname(k), l_cdesc.colname(k), l_cdesc.coltype(k), l_cdesc.collen(k), l_cdesc.colscl(k) );
      end loop;

      dbms_sql.close_cursor(l_cur);

    end;

    -----------------------------------------------------------------
    --  CHECK_COLS_STRUCTURES
    --
    --   Проверить на совместимость две структуры описания колонок
    --
    --    p_c1      --  Первая структура
    --    p_c2      --  Вторая структура
    --    p_retcode --  0 - ok, 1- ошибка
    --    p_errmsg  --  сообщение об ошибке
    --
    -----------------------------------------------------------------
    procedure check_cols_structures(p_c1              t_cols,
                                    p_c2              t_cols,
                                    p_retcode in out  number,
                                    p_errmsg  in out  varchar2)
    is
    begin
       if p_c1.colcnt <> p_c2.colcnt then
          p_retcode := 1;
          p_errmsg  := 'Не совпадает кол-во колонок: '||p_c1.colcnt||'<>'||p_c2.colcnt;
          return;
       else
          for i in 1..p_c1.colcnt loop
             if  p_c1.coltype(i) <>  p_c2.coltype(i) then
                 case when p_c1.coltype(i) in ('CHAR', 'VARCHAR2') and  p_c2.coltype(i) in ('CHAR', 'VARCHAR2') then null;
                      else
                        p_retcode := 1;
                        p_errmsg  := 'Не совпадает тип колонки: '||p_c1.colname(i)||' и '||p_c2.colname(i)||':  '||p_c1.coltype(i)||'<>'||p_c2.coltype(i);
                         return;
                 end case;
             end if;
          end loop;
       end if;
       p_retcode := 0;

    end check_cols_structures;


    -----------------------------------------------------------------
    --  UPLOAD_FILE_DATA
    --
    --   Выгрузить файл  из справочника выгрузок UPL_FILES по числовому коду фала
    --
    --    p_fileid      --  Код файла из справочника (UPL_FILES)
    --    p_sqlid       --  Код запроса для файла
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --    p_rowsupl     --  кол-во выгруженных строк
    --    p_filename    --  имя исходящего файла
    -----------------------------------------------------------------
    procedure upload_file_data
    ( p_fileid     in     number,
      p_sqlid      in     number  default null,
      p_param1     in     varchar2,
      p_param2     in     varchar2,
      p_rowsupl    in out number,
      p_filename      out varchar2
    ) is
      l_cur               number;
      l_sqlid             number;
      i                   number;
      l_ret               number(1);
      l_bankdate          date;
      l_cdesc             t_cols; -- описание колонок по таблице описания
      l_cdesc_sql         t_cols; -- описание колонок по запросу
      l_file              upl_files%rowtype;
      l_oradir            varchar2(100);
      l_uplmethod         varchar2(4);
      l_sqltext           varchar2(32000);
      l_retcode           number(1);
      l_orderid           number(5);
      l_errmsg            varchar2(1000);
      l_filename          varchar2(100);
      l_sql_before        upl_sql.before_proc%type;
      l_sql_after         upl_sql.after_proc%type;
      l_region_prfx       varchar2(100);
      l_chrlistfrom       varchar2(100);
      l_chrlistto         varchar2(100);
      l_tmp               varchar2(100);
      l_nextnmbr          number;
      l_trace             varchar2(2000) := G_TRACE||'upload_file_data: ';
    begin

       l_cur := dbms_sql.open_cursor;

       -- вычитать параметры для файла
       begin
          select *
            into l_file
            from upl_files f
           where f.file_id = p_fileid;
       exception when no_data_found then
           bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_FILE_ID', to_char(p_fileid));
       end;

       l_file.sql_id := nvl(p_sqlid, l_file.sql_id);

       -- вычитать запрос для файла
       begin
          select sql_text, s.sql_id, s.before_proc, s.after_proc
            into l_sqltext, l_sqlid, l_sql_before, l_sql_after
            from upl_sql s
           where s.sql_id = l_file.sql_id;
       exception when no_data_found then
           bars.bars_error.raise_nerror(G_MODULE, 'NO_SQL_FOR_FILEID', to_char(p_fileid));
       end;

       -- пропарсим запрос
       begin
          dbms_sql.parse(l_cur, l_sqltext, dbms_sql.native);
       exception when no_data_found then
          bars.bars_error.raise_nerror(G_MODULE, 'CANN_NOT_PARSE_SQL', to_char(l_sqlid), l_sqltext);
       end;

      i := 1;

      -- Инициализировать структуру колонок по их описанию
      for c in ( select col_name, col_type, col_length, col_scale, col_format, repl_chars_with, count(*) over() cnt
                   from upl_columns
                  where file_id = p_fileid
                  order by col_id )
      loop
        l_cdesc.colcnt    := c.cnt;
        l_cdesc.colname(i):= c.col_name;
        l_cdesc.coltype(i):= c.col_type;
        l_cdesc.collen(i) := c.col_length;
        l_cdesc.colscl(i) := c.col_scale;
        l_cdesc.colfrmt(i):= c.col_format;

        l_chrlistfrom := '';

        l_tmp := substr(c.repl_chars_with,1,instr(c.repl_chars_with,'|')-1);

        for m in ( select column_value val from table(bars.gettokens(l_tmp) ) )
        loop
            l_chrlistfrom := l_chrlistfrom ||chr(m.val);
        end loop;

        l_chrlistto := '';
        l_tmp := substr(c.repl_chars_with, -1 * instr(c.repl_chars_with,'|')+1 );

        for m in (select column_value val from table(bars.gettokens(l_tmp) )  )
        loop
            l_chrlistto := l_chrlistto ||chr(m.val);
        end loop;

        l_cdesc.chrfrom(i) := l_chrlistfrom;
        l_cdesc.chrto(i) := l_chrlistto;

        i := i + 1;

      end loop;

      -- разобрать запрос в структуру колонок  для дальнейшего сравнения описания с написанным запросом.
      parse_col_desc(l_cur, l_cdesc_sql);

      -- проверить на совместимость описанной структуры для файла и колонками в запросе
      check_cols_structures(l_cdesc, l_cdesc_sql, l_retcode, l_errmsg);

      if l_retcode <>  0
      then
        bars.bars_error.raise_nerror(G_MODULE, 'UNCOMPATIBLE_STRUCTS', l_errmsg);
      end if;

      -- получить директорию оракла, куда грузить файлы
      begin
        select value into l_oradir
          from upl_params
         where param = 'ORACLE_DIR';
      exception
        when no_data_found then
          bars.bars_error.raise_nerror(G_MODULE, 'NO_ORADIR_PARAMETER');
      end;

      -- получить способ выгрузки
      begin
         select value into l_uplmethod
           from upl_params
          where param = 'UPL_METHOD';
      exception when no_data_found then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_UPL_METHOD_PARAMETER');
      end;

      -- получить префикс для фалов от конктретного РУ
      begin
         select value into l_region_prfx
           from upl_params
          where param = 'REGION_PRFX';
      exception when no_data_found then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_REGION_PRFX_PARAMETER');
      end;

      -- установить бинд переменные
      if instr(l_sqltext, ':param1') > 0
      then
        dbms_sql.bind_variable(l_cur, ':param1', p_param1);
      end if;

      if instr(l_sqltext, ':param2') > 0
      then
        dbms_sql.bind_variable(l_cur, ':param2', p_param2);
      end if;

       -- выполнить действие 'ДО'
       if l_sql_before is not null
       then
         begin
           bars.bars_audit.trace(l_trace||'Выполнение запроса <ДО>: '||l_sql_before);

           if instr(l_sql_before,':param1') > 0 and instr(l_sql_before,':param2') > 0
           then
             execute immediate l_sql_before using p_param1, p_param2;
           else

             case
               when ( instr(l_sql_before,':param1') > 0 )
               then -- есть вхождение param1
                 bars.bars_audit.trace(l_trace||'есть вхождение param1');
                 execute immediate l_sql_before using in p_param1;
               when ( instr(l_sql_before,':param2') > 0 )
               then -- есть вхождение param2
                 bars.bars_audit.trace(l_trace||'есть вхождение param2');
                 execute immediate l_sql_before using p_param2;
               else -- нет вхождения параметров
                 execute immediate l_sql_before;
             end case;

            end if;

         exception
           when others then
              bars.bars_error.raise_nerror( G_MODULE, 'NOT_CORRECT_SQL_BEFORE', to_char(l_file.sql_id),
                                            substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 300) );
         end;
       end if;

       -- получить последовательный номер выгрузки
       begin

         select cnt + 1 into l_nextnmbr
           from upl_file_counters
          where file_id = p_fileid
            and bank_date = to_date(p_param1,'dd/mm/yyyy');

         update upl_file_counters
            set cnt = l_nextnmbr
          where file_id = p_fileid
            and bank_date = to_date(p_param1,'dd/mm/yyyy');
       exception
         when no_data_found then
           l_nextnmbr := 1;
           insert into upl_file_counters(file_id, bank_date, cnt)
           values (p_fileid, to_date(p_param1,'dd/mm/yyyy'), l_nextnmbr);
       end;

       -- формируем имя исходящего файла
       begin
          l_bankdate := to_date(p_param1,'dd/mm/yyyy');
       exception when others then
          bars.bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_DATE', p_param1);
       end;

       l_filename := l_region_prfx||'_'||l_file.filename_prfx||'_'||to_char(l_bankdate,'yyyymmdd')||'.'||bars.lpadchr(to_char(l_nextnmbr),'0',3);
       p_filename := l_filename;

       bars.bars_audit.trace(l_trace||'Имя файла: '||l_filename);

       bars_upload.cur_to_flatfile(
                    p_cur       =>  l_cur,
                    p_cdesc     =>  l_cdesc,
                    p_nullval   =>  l_file.nullval,
                    p_delim     =>  chr(to_number(l_file.delimm)),
                    p_eqvspace  =>  l_file.eqvspace,
                    p_colhdr    =>  l_file.head_line,
                    p_directory =>  l_oradir,
                    p_uplmethod =>  l_uplmethod,
                    p_filename  =>  l_filename,
                    p_rownum    =>  p_rowsupl);

      dbms_sql.close_cursor(l_cur);

      -- выполнить действие 'ПОСЛЕ'
      if l_sql_after is not null
      then
        begin

           bars.bars_audit.trace(l_trace||'Выполнение запроса <ПОСЛЕ>: '||l_sql_after);

           if instr(l_sql_after,':param1') > 0  and instr(l_sql_after,':param2') > 0
           then
              execute immediate l_sql_after using p_param1, p_param2;
           else
             case
               when ( instr(l_sql_after,':param1') > 0 )
               then -- есть вхождение param1
                 bars.bars_audit.trace(l_trace||'есть вхождение param1');
                 execute immediate l_sql_after using in p_param1;
               when ( instr(l_sql_after,':param2') > 0 )
               then -- есть вхождение param2
                 bars.bars_audit.trace(l_trace||'есть вхождение param2');
                 execute immediate l_sql_after using p_param2;
               else -- нет вхождения параметров
                 execute immediate l_sql_after;
             end case;
           end if;

        exception
          when others then
            bars.bars_error.raise_nerror( G_MODULE, 'NOT_CORRECT_SQL_AFTER', to_char(l_file.sql_id),
                                          substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 300) );
        end;
      end if;
      -- dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 500)
    end upload_file_data;


    -----------------------------------------------------------------
    --  UPLOAD_FILE
    --
    --   Выгрузить файл  из справочника выгрузок UPL_FILES
    --
    --    p_filecode    --  Мнемонический код файла из справочника (UPL_FILES)
    --    p_sqlid       --  файл может быть выгруженным с указанием конкретного запроса (иначе берется запрос по-усолчению из upl_files.sql_id)
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --
    -----------------------------------------------------------------
    procedure upload_file( p_filecode   upl_files.file_code%type,
                           p_sqlid      number,
                           p_param1     varchar2,
                           p_param2     varchar2
                          )
    is
      l_uplfile_id number;
      l_filename   varchar2(100);
      l_stat_id    number;
      l_sqlid      number;
      l_rowsupl    number;
      l_errmsg     varchar2(500);
      l_trace      varchar2(2000) := G_TRACE||'upload_file: ';
    begin

      begin
        select file_id, nvl(p_sqlid, sql_id)
          into l_uplfile_id, l_sqlid
          from upl_files f
         where f.file_code = upper(p_filecode);
      exception
        when no_data_found then
          bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_FILE_CODE', p_filecode);
      end;

      log_start_process( p_start_time  => sysdate,
                         p_groupid     => null,
                         p_fileid      => l_uplfile_id,
                         p_parentid    => null,
                         p_sqlid       => l_sqlid,
                         p_params      => 'p1='||p_param1||' p2='||p_param2,
                         p_bankdate    => to_date(p_param1,'dd/mm/yyyy'),
                         p_id          => l_stat_id );

      upload_file_data( p_fileid       => l_uplfile_id,
                        p_sqlid        => l_sqlid,
                        p_param1       => p_param1,
                        p_param2       => p_param2,
                        p_rowsupl      => l_rowsupl,
                        p_filename     => l_filename);

      log_end_process( p_stop_time     => sysdate,
                       p_rows_uploaded => l_rowsupl,
                       p_filename      => l_filename,
                       p_id            => l_stat_id );


    exception
      when others then
        l_errmsg := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 500);
        log_error_process( p_stop_time => sysdate,
                           p_errmess   => l_errmsg,
                           p_id        => l_stat_id );
        bars.bars_error.raise_nerror(G_MODULE, 'ERROR_MESS', l_errmsg);
    end upload_file;


  -----------------------------------------------------------------
  --  UPLOAD_FILE
  --
  --   Выгрузить файл  из справочника выгрузок UPL_FILES c умолчательными значениями кодов звпросов  (sql_id)
  --
  --    p_filecode    --  Мнемонический код файла из справочника (UPL_FILES)
  --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
  --    p_param2      --  Текстовое значение параметра 2
  --
  -----------------------------------------------------------------
  procedure upload_file( p_filecode   upl_files.file_code%type,
                         p_param1     varchar2,
                         p_param2     varchar2
                        )
  is
    l_trace   varchar2(1000):= G_TRACE||'.upload_file: ';
  begin

    upload_file( p_filecode  => p_filecode,
                 p_sqlid     => null,
                 p_param1    => p_param1,
                 p_param2    => p_param2
               );
  end upload_file;


  -----------------------------------------------------------------
  --  UPLOAD_FILE
  --
  --   Выгрузить файл c логированием в upl_stats
  --
  --    p_filegroup   --  Код группы
  --    p_parentid    --  код родителя в журнале статистикки (код статистики для группы, которая запустила этот файл на выгрузку)
  --    p_defsqlid    --  умалчательные или нет значения sql_id для выгрузки файла.
  --                      Если (1=да), тогда берем из upl_files.sql_id, если (0=нет),
  --                      тогда берем из upl_filegroups_rln.sqlid
  --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
  --    p_param2      --  Текстовое значение параметра 2
  --    p_forcestop   --  при
  --    p_fileid      --  номер файла для выгрузки
  --    p_sqlid       --  код SQL для выгрузки
  --    p_critical    -- критичность выгрузки файла
  --    return        --  номер записи в журнале статистики (upl_stats) для данного файла
  -----------------------------------------------------------------
  function upload_file( p_filegroup    number,
                        p_parentid     number    default null,
                        p_defsqlid     number,
                        p_param1       varchar2,
                        p_param2       varchar2,
                        p_forcestop    number    default 0,
                        p_fileid       number,
                        p_sqlid        number,
                        p_critical     number
  ) return number
  is
    l_statfl_id  number;
    l_filename   varchar2(100);
    l_rowsupl    number;
    l_errmsg     varchar2(500);
    l_trace      varchar2(2000) := G_TRACE||'upload_file: ';
  begin
    log_start_process( p_start_time => sysdate,
                       p_groupid    => p_filegroup,
                       p_fileid     => p_fileid,
                       p_parentid   => p_parentid,
                       p_sqlid      => p_sqlid,
                       p_params     => 'p1='||p_param1||' p2='||p_param2,
                       p_bankdate   => to_date(p_param1,'dd/mm/yyyy'),
                       p_id         => l_statfl_id );

    upload_file_data( p_fileid   => p_fileid,
                      p_sqlid    => p_sqlid,
                      p_param1   => p_param1,
                      p_param2   => p_param2,
                      p_rowsupl  => l_rowsupl,
                      p_filename => l_filename );

    if (l_rowsupl = 0 and p_critical = 2)
    then
      l_errmsg := 'Файл не повинен бути пустим';
      bars.bars_error.raise_nerror( G_MODULE, 'ERROR_MESS', l_errmsg );
    else
      log_end_process( p_stop_time     => sysdate,
                       p_rows_uploaded => l_rowsupl,
                       p_filename      => l_filename,
                       p_id            => l_statfl_id );
    end if;

    return l_statfl_id;

    exception
      when others then

        l_errmsg := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 500);

        log_error_process( p_stop_time  => sysdate,
                           p_errmess    => l_errmsg,
                           p_id         => l_statfl_id);

        if (p_forcestop = 1 or p_critical != 0)
        then -- выгрузка файла является критической.
          bars.bars_error.raise_nerror( G_MODULE, 'ERROR_MESS', l_errmsg );
        end if;

        return 0;

    end upload_file;


    -----------------------------------------------------------------
    --  UPLOAD_FILE_GROUP
    --
    --   Выгрузить группу файлов
    --
    --    p_filegroup   --  Код группы
    --    p_parentid    --  код родителя в журнале статистикки (код статистики лдя джоба, который запустил эту группу на выполнение)
    --    p_defsqlid    --  умалчательные или нет значения sql_id для выгрузки файла.
    --                      Если (1=да), тогда берем из upl_files.sql_id, если (0=нет),
    --                      тогда берем из upl_filegroups_rln.sqlid
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --    p_forcestop   --  при
    --    return        --  ID в журнале выгрузки для информации по этой группе
    -----------------------------------------------------------------
    function upload_file_group(  p_filegroup    number,
                                 p_parentid     number default null,
                                 p_defsqlid     number,
                                 p_param1       varchar2,
                                 p_param2       varchar2,
                                 p_forcestop    number    default 0
                               ) return number
    is
       l_statgrp_id    number;
       l_statfl_id     number;
       l_errmsg        varchar2(500);
       l_trace         varchar2(2000) := G_TRACE||'upload_file_group: ';
    begin

       log_start_process(
            p_start_time => sysdate,
            p_groupid    => p_filegroup,
            p_fileid     => null,
            p_parentid   => p_parentid,
            p_sqlid      => null,
            p_params     => 'p1='||p_param1||' p2='||p_param2,
            p_bankdate   => to_date(p_param1,'dd/mm/yyyy'),
            p_id         => l_statgrp_id);

      -- главный цикл по выгрузке всех файлов группы
      for c in ( select f.file_id, f.file_code,
                        case when p_defsqlid = 1 then f.sql_id else fg.sql_id  end sql_id,
                        nvl(critical_flg,0) critical_flg
                   from upl_files f, upl_filegroups_rln fg
                  where f.file_id = fg.file_id
                    and fg.group_id = p_filegroup
                    and isactive = 1
                  order by critical_flg desc, order_id asc)
      loop

        l_statfl_id := upload_file( p_filegroup => p_filegroup,
                                    p_parentid  => l_statgrp_id,
                                    p_defsqlid  => p_defsqlid,
                                    p_param1    => p_param1,
                                    p_param2    => p_param2,
                                    p_forcestop => p_forcestop,
                                    p_fileid    => c.file_id,
                                    p_sqlid     => c.sql_id,
                                    p_critical  => c.critical_flg );
      end loop;

      bars.bars_audit.trace(l_trace||'перед записью в лог об окончании выгрузки группы');
      log_end_process( p_stop_time     => sysdate,
                       p_rows_uploaded => 0,
                       p_filename      => null,
                       p_id            => l_statgrp_id );
      bars.bars_audit.trace(l_trace||'после записи в лог об окончании выгрузки группы');

      return l_statgrp_id;

    exception
      when others then
        l_errmsg := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 500);
        log_error_process(
             p_stop_time  => sysdate,
             p_errmess    => l_errmsg,
             p_id         => l_statgrp_id);
        bars.bars_error.raise_nerror(G_MODULE, 'ERROR_MESS', l_errmsg);
    end upload_file_group;


    -----------------------------------------------------------------
    --  UPLOAD_FILE_GROUP
    --
    --   Выгрузить группу файлов
    --
    --    p_filegroup   --  Код группы
    --    p_defsqlid    --  умалчательные или нет значения sql_id для выгрузки файла.
    --                      Если (1=да), тогда берем из upl_files.sql_id, если (0=нет),
    --                      тогда берем из upl_filegroups_rln.sqlid
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    p_param2      --  Текстовое значение параметра 2
    --    p_forcestop   --  при
    -----------------------------------------------------------------
    procedure upload_file_group( p_filegroup  number,
                                 p_defsqlid   number,
                                 p_param1     varchar2,
                                 p_param2     varchar2,
                                 p_forcestop  number    default 0
                               )
    is
      l_auditid number;
    begin
      l_auditid := upload_file_group( p_filegroup => p_filegroup,
                                      p_parentid  => null       ,
                                      p_defsqlid  => p_defsqlid ,
                                      p_param1    => p_param1   ,
                                      p_param2    => p_param2   ,
                                      p_forcestop => p_forcestop );
    end upload_file_group;


  -----------------------------------------------------------------
  --  UPLOAD_FILE_GROUP
  --
  --   Выгрузить группу файлов cо значениями кодов запросов из связки группа - файл
  --
  --    p_filegroup   --  Код группы
  --    p_parentid    --  код из журнала выполнения для родителя (для группы - это джоб)
  --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
  --    p_param2      --  Текстовое значение параметра 2
  --    p_forcestop   --  при
  --    return        --  код в журнале аудита для группы (upl_stats)
  -----------------------------------------------------------------
  function upload_file_group( p_filegroup  number,
                              p_parentid   number default null,
                              p_param1     varchar2,
                              p_param2     varchar2,
                              p_forcestop  number    default 0
  ) return number
  is
    l_auditid number;
  begin
    l_auditid := upload_file_group( p_filegroup  => p_filegroup ,
                                    p_defsqlid   => 0,
                                    p_parentid   => p_parentid ,
                                    p_param1     => p_param1,
                                    p_param2     => p_param2,
                                    p_forcestop  => p_forcestop );
    return l_auditid;

  end upload_file_group;


  -----------------------------------------------------------------
  --  UPLOAD_FILES_GROUP
  --
  --   Выгрузить группу файлов cо значениями кодов запросов из связки группа - файл
  --
  --    p_filegroup   --  Код группы
  --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
  --    p_param2      --  Текстовое значение параметра 2
  --    p_forcestop   --  при
  -----------------------------------------------------------------
  procedure upload_file_group( p_filegroup  number,
                               p_param1     varchar2,
                               p_param2     varchar2,
                               p_forcestop  number    default 0)
  is
    l_auditid number;
  begin
    l_auditid := upload_file_group( p_filegroup => p_filegroup,
                                    p_parentid  => null,
                                    p_defsqlid  => 0,
                                    p_param1    => p_param1,
                                    p_param2    => p_param2,
                                    p_forcestop => p_forcestop
                                  );
  end upload_file_group;


    -----------------------------------------------------------------
    --  UPLOAD_STAT_FILE
    --
    --   Выгрузить файл со статистикой c логированием в upl_stats
    --
    --    p_filegroup   --  Код группы
    --    p_parentid    --  код родителя в журнале статистикки (код статистики для группы, которая запустила этот файл на выгрузку)
    --    p_param1      --  Текстовое значение параметра 1 (данные парметры будут использованы для bind переменных в запросах на выгрузку)
    --    return        --  номер записи в журнале статистики (upl_stats) для данного файла
    -----------------------------------------------------------------
    function upload_stat_file(  p_filegroup    number,
                                p_parentid     number default null,
                                p_param1       varchar2
    ) return number
    is
       l_fileid     number;
       l_sqlid      number;
       l_statfl_id  number;
    begin

       begin
          select file_id, sql_id into l_fileid, l_sqlid from upl_files where file_code = 'UPLSTAT';
       exception when no_data_found then
          return 0;
       end;

       l_statfl_id := upload_file(
                      p_filegroup  => p_filegroup,
                      p_parentid   => p_parentid ,
                      p_defsqlid   => 0,
                      p_param1     => p_param1,
                      p_param2     => null,
                      p_forcestop  => 0,
                      p_fileid     => l_fileid,
                      p_sqlid      => l_sqlid,
                      p_critical   => 1
                    );
        return l_statfl_id;

    end;


   -----------------------------------------------------------------
   --    GET_PARAM
   --
   --    Получить глобальный параметр
   --
   function get_param(p_param_name varchar2) return varchar2
   is
   begin
      return  G_PARAMS_LIST(p_param_name);
   exception when others then
      return null;
   end;

   --    SET_PARAM
   --
   --    Устанвить глобальный параметр
   --
   function set_param(p_param_name varchar2, p_value varchar2) return varchar2
   is
   begin
        G_PARAMS_LIST(p_param_name) := p_value;
        return p_value;
   exception when others then
      return null;
   end;

   procedure set_param(p_param_name varchar2, p_value varchar2)
   is
     l_ret_value  varchar2(1);
   begin
        l_ret_value := set_param(p_param_name, p_value);
   end;

   -----------------------------------------------------------------
   --    GET_JOB_PARAM
   --
   --    Получить параметр джоба по наименованию джоба
   --
   function get_job_param(p_job_name varchar2, p_param_name varchar2) return varchar2
   is
   begin
      return  G_JOBPARAM_LIST(p_job_name)(p_param_name);
   exception when others then
      return null;
   end;

   -----------------------------------------------------------------
   --    SET_JOB_PARAM
   --
   --    Устанвить параметр джоба по наименованию джоба
   --
   function set_job_param(p_job_name varchar2, p_param_name varchar2, p_value varchar2) return varchar2
   is
   begin
        G_JOBPARAM_LIST(p_job_name)(p_param_name) := p_value;
        return p_value;
   exception when others then
      return null;
   end;

   procedure set_job_param(p_job_name varchar2, p_param_name varchar2, p_value varchar2)
   is
     l_ret_value  varchar2(1);
   begin
        l_ret_value := set_job_param(p_job_name, p_param_name, p_value);
   end;

   -----------------------------------------------------------------
   --    GET_GROUP_PARAM
   --
   --    Получить параметры группы выгрузки (или другими словами джоба)
   --
   function get_group_param(p_groupid number, p_param_name varchar2) return varchar2
   is
   begin
      return  G_JOBPARAM_LIST( G_JOBGROUP_LIST(p_groupid) )(p_param_name);
   exception when others then
      return null;
   end;

   -----------------------------------------------------------------
   --    SET_GROUP_PARAM
   --
   --    Устанвить параметры группы выгрузки (или другими словами джоба)
   --
   function set_group_param(p_groupid number, p_param_name varchar2, p_value varchar2) return varchar2
   is
   begin
        G_JOBPARAM_LIST( G_JOBGROUP_LIST(p_groupid) )(p_param_name) := p_value;
        return p_value;
   exception when others then
      return null;
   end;

   procedure set_group_param(p_groupid number, p_param_name varchar2, p_value varchar2)
   is
     l_ret_value  varchar2(1);
   begin
        l_ret_value := set_group_param(p_groupid, p_param_name, p_value);
   end;

   -----------------------------------------------------------------
   --    INIT_GLOBAL_PARAMS
   --
   --    Инициализация глобальных параметров  и статусов
   --
   procedure init_global_params(p_force number)
   is

      l_trace varchar2(1000):= G_TRACE||'init_global_params: ';
      l_kf    upl_regions.kf%type;
   begin

      --------------
      -- инициализация глобальных параметров системы
      ------------
      if G_PARAMS_LIST.count  = 0 or p_force = 1 then
             for c in (select trim(param) param, value from upl_params) loop
                 G_PARAMS_LIST(c.param) := c.value;
                 if c.param = 'REGION_PRFX' then --
                    select kf into l_kf from upl_regions where CODE_CHR = c.value;
                    G_PARAMS_LIST('KF') :=  l_kf;
                    bars_audit.info(l_trace||'KF'||'-'||G_PARAMS_LIST('KF'));
                 end if;
                 bars_audit.info(l_trace||c.param||'-'||c.value);
             end loop;
      end if;

      --------------
      -- проверка на корректноть глобальных параметров системы и заполнение дефолтов
      ------------
      -- Директория оракля для выгрузки.
      if not G_PARAMS_LIST.exists('ORACLE_DIR')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_ORADIR_PARAMETER');
      else
         -- Проверка наличия такого объекта
         begin
            bars_audit.trace(l_trace||'проверяем наличие объекта оракл-директория ='||G_PARAMS_LIST('ORACLE_DIR'));
            select directory_path into G_PARAMS_LIST('UPLOAD_OS_DIR')
              from dba_directories
             where directory_name = G_PARAMS_LIST('ORACLE_DIR') ;
               bars_audit.trace(l_trace||'нашли '||G_PARAMS_LIST('UPLOAD_OS_DIR'));
         exception when no_data_found then
             bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_ORADIR', G_PARAMS_LIST('ORACLE_DIR'));
         end;
      end if;

      bars_audit.info(l_trace||'UPLOAD_OS_DIR='||G_PARAMS_LIST('UPLOAD_OS_DIR') );
      bars_audit.info(l_trace||'ORACLE_DIR='||G_PARAMS_LIST('ORACLE_DIR') );

      -- Диреткория оракля для архивов выгрузки.
      if not G_PARAMS_LIST.exists('ORACLE_ARC_DIR')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_ORAARCDIR_PARAMETER');
      else
         -- Проверка наличия такого объекта
         begin
            bars_audit.trace(l_trace||'проверяем наличие объекта оракл-директория ='||G_PARAMS_LIST('ORACLE_ARC_DIR'));
            select directory_path into G_PARAMS_LIST('ARC_OS_DIR')
              from dba_directories
             where directory_name = G_PARAMS_LIST('ORACLE_ARC_DIR');
            bars_audit.trace(l_trace||'нашли '||G_PARAMS_LIST('ARC_OS_DIR'));
         exception when no_data_found then
             bars_audit.info(l_trace||'НЕ нашли ');
             bars.bars_error.raise_nerror(G_MODULE, 'NO_SUCH_ORADIR', G_PARAMS_LIST('ORACLE_ARC_DIR'));
         end;
      end if;


      if not G_PARAMS_LIST.exists('REGION_PRFX')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_REGION_PRFX_PARAMETER');
      end if;

      bars_audit.info(l_trace||'REGION_PRFX='||G_PARAMS_LIST('REGION_PRFX') );

      if not G_PARAMS_LIST.exists('ZIP_PATH')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_ZIPPATH_PARAM');
      end if;
      bars_audit.info(l_trace||'ZIP_PATH='||G_PARAMS_LIST('ZIP_PATH') );

      if not G_PARAMS_LIST.exists('BARSUPLID')  then
         begin
            select id into G_PARAMS_LIST('BARSUPLID') from bars.staff$base where logname ='BARSUPL';
         exception when no_data_found then
             G_PARAMS_LIST('BARSUPLID') := 0;
         end;
      end if;


      if not G_PARAMS_LIST.exists('ZIP_KEYS')  then
         G_PARAMS_LIST('ZIP_KEYS') := ' -r -q -D -j -m ';
      end if;
      bars_audit.info(l_trace||'ZIP_KEYS='||G_PARAMS_LIST('ZIP_KEYS') );

      if not G_PARAMS_LIST.exists('FTPCLI_PATH')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_FTPCLIPATH_PARAM');
      end if;
      bars_audit.info(l_trace||'FTPCLI_PATH='||G_PARAMS_LIST('FTPCLI_PATH') );


      if not G_PARAMS_LIST.exists('FTP_SERVER')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_FTPSERVER_PARAM' );
      end if;
      bars_audit.info(l_trace||'FTP_SERVER='||G_PARAMS_LIST('FTP_SERVER') );


      if not G_PARAMS_LIST.exists('FTP_DOMAIN')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_FTPDOMAIN_PARAM');
      end if;
      bars_audit.info(l_trace||'FTP_DOMAIN='||G_PARAMS_LIST('FTP_DOMAIN') );


      if not G_PARAMS_LIST.exists('FTP_PASSWORD')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_FTPPASSWORD_PARAM');
      end if;
      bars_audit.info(l_trace||'FTP_PASSWORD='||G_PARAMS_LIST('FTP_PASSWORD') );

      if not G_PARAMS_LIST.exists('FTP_PATH')  then
         bars.bars_error.raise_nerror(G_MODULE, 'NO_FTPPATH_PARAM');
      end if;
      bars_audit.info(l_trace||'FTP_PATH='||G_PARAMS_LIST('FTP_PATH') );

      if not G_PARAMS_LIST.exists('USE_COMPRESS')  then
         G_PARAMS_LIST('USE_COMPRESS') := '0';
      end if;

      if not G_PARAMS_LIST.exists('UPL_METHOD')  then
         G_PARAMS_LIST('UPL_METHOD') := 'CLOB';
      end if;

      if not G_PARAMS_LIST.exists('ORACLE_OS')  then
         G_PARAMS_LIST('ORACLE_OS') := 'WIN';
      end if;

      if not G_PARAMS_LIST.exists('EMPTY_FILES')  then
         G_PARAMS_LIST('EMPTY_FILES') := '1';
      end if;

      if not G_PARAMS_LIST.exists('CRITICAL_STOP')  then
         G_PARAMS_LIST('CRITICAL_STOP') := '1';
      end if;


      if G_PARAMS_LIST('ORACLE_OS') = 'WIN' then
            G_PARAMS_LIST('OS_DIR_DELIMM') := '\';
      else
         G_PARAMS_LIST('OS_DIR_DELIMM') := '/';
      end if;

      if not G_PARAMS_LIST.exists('ARCH_METHOD')  then
         G_PARAMS_LIST('ARCH_METHOD') := 'JAVA';
      end if;



      if not G_PARAMS_LIST.exists('COPY_JOB_DELAY')  then
         G_PARAMS_LIST('COPY_JOB_DELAY') := '0';
      end if;

      ------
      -- инициализация статусов
      if G_STATUS_LIST.count  = 0 then
             for c in (select status_id, status_code from upl_process_status) loop
                 G_PARAMS_LIST(c.status_code) := c.status_id;
             end loop;
      end if;

   end;


   -----------------------------------------------------------------
   --    INIT_JOBS_PARAMS
   --
   --    Функция для инициализации переменных заданий
   --
   procedure init_jobs_params(p_force number)
   is
      l_trace varchar2(1000):= G_TRACE||'init_jobs_params: ';
      l_job   t_jobparam_list;
      l_nmbr  number;
   begin


      if G_JOBPARAM_LIST.count  = 0 or p_force = 1 then
             for c in (select trim(t.job_name) job_name, trim(t.param) param, trim(t.value ) value
                         from v_upl_autojob_param_values t
                        where is_active = 1
                        order by t.job_name
                      ) loop
                 G_JOBPARAM_LIST(c.job_name)(c.param) := c.value;
                 bars_audit.info(l_trace||c.job_name||': param '||c.param||' = '||c.value);
             end loop;
      end if;


      -- проверка значений параметров дожобов и установка их дефолтов
      for c in (select job_name from upl_autojobs where is_active = 1 order by job_name)  loop
          l_job := G_JOBPARAM_LIST(c.job_name);

          -- группа выгрузки
             if not l_job.exists('GROUPID')  then
             bars.bars_error.raise_nerror(G_MODULE, 'NO_GROUPID_FOR_JOB',c.job_name );
          end if;

          --кол-во дней ДО текущего дня для вырузки
             if not l_job.exists('BANKDAYS_BEFORE')  then
             l_job('BANKDAYS_BEFORE') := '2';
          else
             begin
                l_nmbr := to_number(l_job('BANKDAYS_BEFORE'));
                exception when others then
                bars.bars_error.raise_nerror(G_MODULE, 'NOT_NUMERIC', 'BANKDAYS_BEFORE',c.job_name);
             end;
             end if;

         -- список дней для выгрузки
             if not l_job.exists('WHEN_DAYLIST')  then
             l_job('WHEN_DAYLIST') := 'MON,TUE,WED,THU,FRI,SAT,SUN';
          end if;

          if not l_job.exists('WHEN_HOUR')  then
             l_job('WHEN_HOUR') := '4';
          end if;

          if not l_job.exists('WHEN_MINUTE')  then
             l_job('WHEN_MINUTE') := '0';
          end if;

          if not l_job.exists('COPY_TO_DIR')  then
             l_job('COPY_TO_DIR') := null;
          end if;

          if not l_job.exists('USE_COPY') or l_job.exists('USE_COPY') is null then
            l_job('USE_COPY') := '0';
          end if;

          if not l_job.exists('USE_FTP') or  l_job.exists('USE_FTP')  is null then
               l_job('USE_FTP') := '0';
          end if;

          if not l_job.exists('USE_ARCH') or l_job.exists('USE_ARCH') is null then
             l_job('USE_ARCH') := '0';
          end if;

          if not l_job.exists('NETUSE')  then
             l_job('NETUSE') := null;
          end if;

          if not l_job.exists('HOLIDAY_UPLOAD') or l_job.exists('HOLIDAY_UPLOAD') is null then
             l_job('HOLIDAY_UPLOAD') := '0';
          end if;

          if not l_job.exists('HOLIDAY_CHECK_STATUS') or l_job.exists('HOLIDAY_CHECK_STATUS') is null then
             l_job('HOLIDAY_CHECK_STATUS') := '0';
          end if;

      end loop;

      if G_JOBGROUP_LIST.count  = 0 or p_force = 1 then
         for c in (select job_name from upl_autojobs where is_active = 1 order by job_name)  loop
                 G_JOBGROUP_LIST(G_JOBPARAM_LIST(c.job_name)('GROUPID'))  := c.job_name;
           end loop;
      end if;


   end;


   -----------------------------------------------------------------
   --    INIT_PARAMS
   --
   --    Функция для инициализации переменных
   --    p_force -  принудительно перечитать переменные если они уже и были проинициализированы
   --
   procedure init_params(p_force number)
   is
   begin
      init_global_params(p_force);
      init_jobs_params(p_force);
   end;

   -----------------------------------------------------------------
   --    INIT_PARAMS
   --
   --    Функция для инициализации переменных
   --
   procedure init_params is
   begin
      init_params (p_force => 0);
   end;


   -----------------------------------------------------------------
   --    INIT_PACK
   --
   --    Функция для инициализации пакета
   --
   procedure init_pack is
   begin
      init_params(p_force => 0);
   end;


begin
   init_pack;

end bars_upload;
/
 show err;
 
PROMPT *** Create  grants  BARS_UPLOAD ***
grant EXECUTE                                                                on BARS_UPLOAD to BARS;
grant EXECUTE                                                                on BARS_UPLOAD to BARS_ACCESS_USER;
grant EXECUTE                                                                on BARS_UPLOAD to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSUPL/package/bars_upload.sql =========*** End 
 PROMPT ===================================================================================== 
 