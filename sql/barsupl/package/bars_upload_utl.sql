
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/package/bars_upload_utl.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSUPL.BARS_UPLOAD_UTL 
is

  -----------------------------------------------------------------
  --
  --   Выгрузка данных -  утилиты для обслуживания
  --   author : Lut Anny
  --   created: (26-11-2012)
  --
  -----------------------------------------------------------------
  -- 17.04.2017 - добавлены функции mmfo_list и is_mmfo
    -----------------------------------------------------------------

  G_HEADER_VERSION      constant varchar2(64)  := 'version 4.2 17.04.2017';

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
  --  MAKE_ARCHIVE_BYGROUP
  --
  --   Заархивировать все выгруженные файлы по коду группы (которая стартовала выгрузку этих файлов)
  --    p_auditid    -  код из журнала выгрузки для протоколирования (строка информации по группе выгрузки)
  --    p_auditflid  -  код из журнала выгрузки для конкретного файла (если хотим заархивировтаь лишь один файл)
  --    return имя файла архива
  -----------------------------------------------------------------
  function make_archive_bygroup( p_auditid    number default null,
                                 p_auditflid  number default null)
    return varchar2;

  -----------------------------------------------------------------
  --  MAKE_ARCHIVE_BYGROUP_BYJOB
  --
  --   Заархивировать все выгруженные файлы по коду группы (которая стартовала выгрузку этих файлов) при
  --   помощи external job
  --    p_auditid      --  код из журнала выгрузки для протоколирования (строка информации по группе выгрузки)
  --    p_auditflid    --  код из журнала выгрузки для конкретного файла (если хотим заархивировтаь лишь один файл)
  --    return имя файла архива
  -----------------------------------------------------------------
  function make_archive_bygroup_byjob( p_auditid  number default null,
                                       p_auditflid  number default null)
    return varchar2;

  -----------------------------------------------------------------
  --  SEND_FILE_TO_FTP
  --
  --   Отослать файл на FTP
  --
  --    p_srcfilename    --  Путь+имя файла для передачи
  --    p_auditid        --  код в журнале аудита для записи рез-тов FTP
  -----------------------------------------------------------------
  procedure send_file_to_ftp( p_srcfilename varchar2
                            , p_auditid number default null );

  -----------------------------------------------------------------
  --  COPY_FILE
  --
  -----------------------------------------------------------------
  procedure copy_file( p_srcpath      varchar2,
                       p_srcfilename  varchar2,
                       p_dstpath      varchar2,
                       p_dstfilename  varchar2,
                       p_groupid      number) ;

  -----------------------------------------------------------------
  --  CHECK_SQL_STATEMENT
  --
  --  Перевірка правильності SQL запитів
  --
  --    p_sql_id - Ід. запиту (якщо нул то перевірка усіх)
  -----------------------------------------------------------------
  procedure CHECK_SQL_STATEMENT
  ( p_sql_id   in     upl_sql.sql_id%type );

  -----------------------------------------------------------------
  --  GET_RUNNING_JOB_NAME
  --
  --    Повертає назву джоба запущеного в даний момент
  --
  -----------------------------------------------------------------
  function GET_RUNNING_JOB_NAME
    return dba_scheduler_jobs.job_name%type;

  -----------------------------------------------------------------
  --  MMFO_LIST
  --  возвращает строку всех МФО через разделитель ';'
  -----------------------------------------------------------------
  function mmfo_list return varchar2;

  -----------------------------------------------------------------
  --  IS_MMFO
  --  возвращает количество регионов в БД
  -----------------------------------------------------------------
  function is_mmfo return number;

end;
/
CREATE OR REPLACE PACKAGE BODY BARSUPL.BARS_UPLOAD_UTL 
is
    -----------------------------------------------------------------
    --                                                             --
    --   Выгрузка данных - пакет для техничских утилит             --
    --   created: anny (26-11-2012)
    --                                                             --
	-- 17.04.2017 - добавлены функции mmfo_list и is_mmfo
    -- 15.12.2015 - додано процедуру перевірки запитів
    --              в табл. UPL_SQL та функцію перевірки наявності
    --              активних завдань вивантаження (A.Biletskyi)
    -- 03.06.2014 - добавлена обработка ошибок архивирования и
    --              их фиксация в upl_stats (V.Kharin)
    -- 08.07.2014 - изменены процедуры "copy_file" и "send_file_to_ftp"
    --              в части работы с UNIX (V.Kharin)
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    G_BODY_VERSION         constant varchar2(64)    := 'version 4.6 17.04.2017';
    G_TRACE                constant varchar2(20)    := 'bars_upload_utl.';
    G_MODULE               constant varchar2(3)     := 'UPL';

    G_COPY_JOB_NAME        constant varchar2(100)   := 'copy_job';

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    function header_version return varchar2
    is
    begin
       return 'package header BARS_UPLOAD_UTL: ' || G_BODY_VERSION;
    end header_version;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    function body_version return varchar2
    is
    begin
       return 'package body BARS_UPLOAD_UTL ' || G_BODY_VERSION;
    end body_version;


    -----------------------------------------------------------------
    --  CLOB_TO_BLOB
    --
    -----------------------------------------------------------------
    function clob_to_blob(p_clob clob) return blob
    is
       pos     pls_integer := 1;
       buffer  raw(32767);
       res     blob;
       lob_len pls_integer := dbms_lob.getlength(p_clob);
    begin
       dbms_lob.createtemporary(res, true);
       dbms_lob.open(res, dbms_lob.lob_readwrite);

       loop
          buffer := utl_raw.cast_to_raw(dbms_lob.substr(p_clob, 16000, pos));

          if utl_raw.length(buffer) > 0 then
             dbms_lob.writeappend(res, utl_raw.length(buffer), buffer);
          end if;

          pos := pos + 16000;
          exit when pos > lob_len;
       end loop;

       return res; -- res is open here
    end;


    -----------------------------------------------------------------
    --  BLOB_TO_FILE
    --
    --  Положить содержимое blob в двоичный файл на диске
    --
    --
    -----------------------------------------------------------------
    procedure blob_to_file(p_blob blob, p_oradir varchar2, p_filename varchar2)
    is
       l_buff      raw(32767);
       l_buffsize  number := 32767;
       l_bloblen   number;
       l_file      utl_file.file_type;
       i           number;
       l_trace    varchar2(1000):= G_TRACE||'.blob_to_file: ';
    begin

       bars_audit.trace(l_trace||'перед открітием файла '|| p_filename);
       begin
          l_file := utl_file.fopen(p_oradir, p_filename, 'wb', l_buffsize);
       exception when others then
          bars.bars_error.raise_nerror(G_MODULE, 'CANNOT_OPEN_FILE_FOR_W',p_filename, p_oradir);
       end;
       bars_audit.trace(l_trace||'после открытия файла для записи');

       l_bloblen := dbms_lob.getlength(p_blob);
       bars_audit.trace(l_trace||'длинна блоба для записи '||l_bloblen);
       i:= 1;

       while i < l_bloblen loop
           dbms_lob.read(p_blob, l_buffsize, i, l_buff);
           sys.utl_file.put_raw(l_file, l_buff, TRUE);
           i := i + l_buffsize;
       end loop;
       utl_file.fclose(l_file);


    end;

    -----------------------------------------------------------------
    --  COMPRESS_CLOB
    --
    --   Заархивировать клоб
    --
    --    p_clob
    -----------------------------------------------------------------
    function compress_clob(p_clob clob) return  blob
    is
       l_blob    blob;
       l_complob blob;
       l_trace    varchar2(1000):= G_TRACE||'.compress_clob: ';
    begin
       l_blob := clob_to_blob(p_clob);
       bars_audit.trace(l_trace||'после коніертации клоб в блоб, размер блоба = '||dbms_lob.getlength(l_blob));
       l_complob := to_blob('1');
       l_complob := utl_compress.lz_compress (l_blob);
       bars_audit.trace(l_trace||'после компресии, размер блоба = '||dbms_lob.getlength(l_blob));
       return l_complob;
    end;




    -----------------------------------------------------------------
    --  COMPRESS_BFILE_TO_FILE
    --
    --   Заархивировать файл на диске в виде BFILE и выложить в файл на диске
    --   p_oradir    - директория оракла
    --   p_filename  - имя файла   на операционной системе
     -----------------------------------------------------------------
    procedure compress_bfile_to_file( p_oradir       varchar2,
                                      p_filename     varchar2,
                                      p_arc_oradir   varchar2,
                                      p_arc_filename varchar2
                                    )
    is
       l_bfile    bfile;
       l_complob  blob;
       l_trace    varchar2(1000):= G_TRACE||'.compress_bfile_to_file: ';
    begin
       l_bfile   :=  bfilename( p_oradir, p_filename);
       dbms_lob.fileopen( l_bfile );
       l_complob :=  utl_compress.lz_compress (l_bfile);
       dbms_lob.fileclose( l_bfile );
       blob_to_file(l_complob, p_arc_oradir, p_arc_filename);

       if dbms_lob.istemporary(l_complob)  = 1 then
          dbms_lob.freetemporary(l_complob);
       end if;
    exception when others then
        if dbms_lob.istemporary(l_complob)  = 1 then
           dbms_lob.freetemporary(l_complob);
        end if;
        bars.bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_SQL_BEFORE',
                              substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 500));

    end;



    -----------------------------------------------------------------
    --  COMPRESS_CLOB_TO_FILE
    --
    --   Заархивировать клоб и выложить архив в файл на диск
    --
    --    p_clob       - для для архивации
    --    p_oradir     - оракл директория
    --    p_filename   - имя файла
    -----------------------------------------------------------------
    procedure compress_clob_to_file(p_clob clob, p_oradir varchar2, p_filename varchar2)
    is
       l_blob blob;
       l_trace    varchar2(1000):= G_TRACE||'.compress_clob_to_file: ';
    begin
       l_blob := compress_clob(p_clob);
       blob_to_file(l_blob, p_oradir, p_filename);
       if dbms_lob.istemporary(l_blob)  = 1 then
          dbms_lob.freetemporary(l_blob);
       end if;
    exception when others then
       if dbms_lob.istemporary(l_blob)  = 1 then
          dbms_lob.freetemporary(l_blob);
       end if;

    end;


    -----------------------------------------------------------------
    --  GET_ARCH_FILENAME
    --
    --   Получить файл архива по коду  из журнала
    --
    --    p_auditid    --  Код из журнала лога
    --
    -----------------------------------------------------------------
    function get_arch_filename( p_auditid number   ) return varchar2
    is
       l_arcfilename  varchar2(200);
       l_groupid      number;
       l_release      varchar2(100);
       l_bankdate     date;
    begin
        select upl_bankdate, group_id
          into l_bankdate, l_groupid
          from upl_stats
         where id = p_auditid;
    l_release := substr(replace(bars_upload.get_param('RELEASE'),'.'),1,3);
        --l_arcfilename := bars_upload.get_param('REGION_PRFX')||'_'||to_char(l_groupid)||'_'||to_char(p_auditid)||'_'||l_release||'_'||to_char(l_bankdate,'yyyymmdd')||'.zip';
        l_arcfilename := bars_upload.get_param('REGION_PRFX')||'_'||to_char(l_groupid)||'_'||to_char(p_auditid)||'_'||to_char(l_bankdate,'yyyymmdd')||'.zip';
        return l_arcfilename;
    end;

    -----------------------------------------------------------------
    --  GET_ARCH_PASSWORD
    --
    --   Получить файл архива по коду  из журнала
    --
    --    p_auditid    --  Код из журнала лога
    --
    -----------------------------------------------------------------
    function get_arch_password
    ( p_auditid  number
    ) return varchar2
    is
      l_arch_pass     varchar2(200);
      l_groupid       number;
      l_bankdate      date;
    begin

      l_arch_pass := trim(bars_upload.get_group_param(l_groupid, 'ZIP_PASSWORD'));

      if ( l_arch_pass is Not Null )
      then

        select upl_bankdate, group_id
          into l_bankdate, l_groupid
          from UPL_STATS
         where id = p_auditid;

        l_arch_pass := '-e -P ' || l_arch_pass || to_char(l_bankdate, 'ddmmyyyy');

      else

        l_arch_pass := ' ';

      end if;

      RETURN l_arch_pass;

    end get_arch_password;

    -----------------------------------------------------------------
    --  ARC_FILE
    --
    --   Заархивировать файл
    --
    --    p_dirname      --  Директория нахождение файла - источника
    --    p_filename     --  Имя файла-источника
    --    p_arcdirname   --  Директория для файла-архива
    --    p_arcfilename  --  Имя файла-архива
    --    p_auditid      --  код в журнале аудита, куда поместить информацию(stdout) от выполнения zip
    -----------------------------------------------------------------
    procedure arc_file(  p_dirname     varchar2,
                         p_filemask    varchar2,
                         p_arcdirname  varchar2,
                         p_arcfilename varchar2,
                         p_auditid     number default null
                       )
    is
       l_zippath    varchar2(1000);
       l_rez        number;
       l_clob       clob;
       l_cmd        varchar2(1000);
       l_trace      varchar2(1000) := G_TRACE||'zip_file: ';
    begin

       --выполнить архивацию, -q директива для возвращения в оракл пакет
       l_cmd := bars_upload.get_param('ZIP_PATH')
         ||' '||bars_upload.get_param('ZIP_KEYS')
         ||' '||get_arch_password(p_auditid)
         ||' '||p_arcdirname||bars_upload.get_param('OS_DIR_DELIMM')||p_arcfilename
         ||' '||p_dirname||bars_upload.get_param('OS_DIR_DELIMM')|| p_filemask;

       bars_audit.info(l_trace||l_cmd);

       bars_upload.log_start_afterupl_event(p_auditid, 'ARC');
       l_clob := barsos.os_command.exec_clob(l_cmd);

       bars_audit.info(l_trace||'Выполнение архивации: '||l_clob);
       bars_upload.log_stop_afterupl_event(p_auditid, 'ARC', substr(l_clob,1,2000));

    exception when others then   ----V.Kharin
       bars_audit.error(l_trace||'Ошибка архивации: '||substr(SQLERRM||l_clob,1,3980));
       bars_upload.log_stop_afterupl_event(p_auditid, 'ARC', 'Ошибка архивации: '||substr(SQLERRM||l_clob,1,1900));
       raise;
    end;



    -----------------------------------------------------------------
    --  GET_FILE_LIST
    --
    --   Получить список файлов для архивации по выгруженной группе
    --
    --    p_group_statid  --  Код в журнале статистики для группы
    --    return перечень имен файлов для выгрузки через запятую
    -----------------------------------------------------------------
    function get_file_list(p_group_statid number) return varchar2
    is
       l_list varchar2(32000);
    begin
       select * into l_list
         from ( select ltrim(sys_connect_by_path(file_name, ','), ',') as "IDs"
                  from ( select file_name, lag(file_name) over (order by file_name) as prev_id
                           from upl_stats
                           where parent_id = p_group_statid and rec_type = 'FILE'
                        )
                  start with prev_id is null
                connect by prev_id = prior file_name
                  order by 1 desc
              )
        where rownum = 1;
        if length(l_list) > 4000 then
            bars.bars_error.raise_nerror(G_MODULE, 'FILE_LIST_ISTOOLONG');
        end if;

        return l_list;
    end;


    -----------------------------------------------------------------
    --  MAKE_ARCHIVE_BYGROUP
    --
    --   Заархивировать все выгруженные файлы по коду группы (которая стартовала выгрузку этих файлов)
    --    p_auditid    -  код из журнала выгрузки для протоколирования (строка информации по группе выгрузки)
    --    p_auditflid  -  код из журнала выгрузки для конкретного файла (если хотим заархивировтаь лишь один файл)
    --    return имя файла архива
    -----------------------------------------------------------------
    function make_archive_bygroup( p_auditid    number default null,
                                   p_auditflid  number default null) return varchar2
    is
       l_upldir       varchar2(1000);
       l_arcdir       varchar2(1000);
       l_srcfilename  varchar2(4000);
       l_arcfilename  varchar2(1000);
       l_trace        varchar2(1000) := G_TRACE||'make_archive_bygroup: ';
    begin

       bars_audit.info(l_trace||'старт архивации файлов по коду группы: '||p_auditid);
       l_arcfilename:= get_arch_filename(p_auditid);


       bars_upload.log_start_afterupl_event(p_auditid, 'ARC');

       for c in ( select id, file_name
                    from upl_stats
                   where parent_id = p_auditid
                     and rec_type = 'FILE'
                     and id       = nvl(p_auditflid, id)
                     and file_name is not null
                     and status_id = 1)
        loop
          l_srcfilename := c.file_name;

          bars_audit.info(l_trace||'старт архивации файла: '||l_srcfilename);
          arc_file( p_dirname     => bars_upload.get_param('UPLOAD_OS_DIR'),
                    p_filemask    => l_srcfilename,
                    p_arcdirname  => bars_upload.get_param('ARC_OS_DIR'),
                    p_arcfilename => l_arcfilename,
                    p_auditid     => c.id);
       end loop;

       bars_upload.log_stop_afterupl_event(p_auditid, 'ARC', 'achiving completed');

       return l_arcfilename;

    end;


    -----------------------------------------------------------------
    --  CREATE_CMD_JOB
    --
    --  Создать external job для выполнения бат файла  (Джоб выполняется в контексте текузей сессии)
    --  p_jobname        - имя задания
    --  p_batpathname    - полный путь к батнику
    --  p_startaftermin  - старт через указанное кол-во минут от создания джоба
    -----------------------------------------------------------------
    procedure create_cmd_job(p_jobname varchar2, p_batpathname varchar2, p_startaftermin  number default 0)
    is
       l_trace        varchar2(1000) := G_TRACE||'create_cmd_job: ';
       l_startdate    date;
       l_userid       number;
    begin
       begin
          dbms_scheduler.drop_job(p_jobname, TRUE);
       exception when others then
          if sqlcode = -27475 then null;
          else raise;
          end if;
       end;
       -- содать
       bars.bars_audit.info(l_trace||'создание джоба '||p_jobname||' для выполнения '||p_batpathname);

       l_startdate := (sysdate + (1 * p_startaftermin)/(24*60));
       bars.bars_audit.trace(l_trace||'дата старта джоба '||to_char(l_startdate,'dd/mm/yyyy hh24:mi:ss'));

       if  bars_upload.get_param('ORACLE_OS') = 'WIN'  then
           dbms_scheduler.create_job(
                 job_name            => p_jobname,
                 job_type            => 'EXECUTABLE'          ,
                 start_date          => l_startdate,
                 job_action          => 'cmd'                 ,
                 number_of_arguments => 3                     ,
                 enabled             => FALSE                 ,
                 comments => 'job '||p_jobname);

           dbms_scheduler.set_job_argument_value(p_jobname,1, '/q');
           dbms_scheduler.set_job_argument_value(p_jobname,2, '/c');
           dbms_scheduler.set_job_argument_value(p_jobname,3, p_batpathname);
           -- для того, что б джоб выполняля в данной сесси  выполним run_job (вместо enable_job)
           dbms_scheduler.run_job(p_jobname, TRUE);
           --dbms_scheduler.enable(p_jobname);

           -- не понятно по какой причине, после  выполнения данной функи слитают все настройки контекста
           -- в т.ч. и current_branch. Поэтому выполним еще раз инициализацию контекста для BARSUPL
           bars.bars_login.login_user(SYS_GUID(), bars_upload.get_param('BARSUPLID'), null, 'BARSUPL');

       else
           dbms_scheduler.create_job(
                 job_name            => p_jobname,
                 job_type            => 'EXECUTABLE',
                 start_date          => l_startdate,
                 job_action          => p_batpathname,
                 enabled             => FALSE,
                 comments => 'job '||p_jobname);
                 --auto_drop           => FALSE,
           dbms_scheduler.enable(p_jobname);

       end if;

    end;

    -----------------------------------------------------------------
    --  COPY_FILE
    --
    --  создание джоба на копирование файла
    --
    -----------------------------------------------------------------
    procedure copy_file( p_srcpath     varchar2,
                         p_srcfilename varchar2,
                         p_dstpath     varchar2,
                         p_dstfilename varchar2,
                         p_groupid     number)
    is
       l_dstpath     varchar2(4000);
       l_srcpath     varchar2(4000);
       l_cmd         varchar2(4000);
       l_netusecmd   varchar2(4000);
       l_batfilename varchar2(1000);
       l_drive       varchar2(10);
       l_netparam    varchar2(500);
       l_ossep       char(1);
       l_fileh       UTL_FILE.File_Type;
       l_trace       varchar2(1000) := G_TRACE||'copy_file: ';
    begin
       -- сформировать бат файл
       l_batfilename := 'makecopy';
       l_ossep := case bars_upload.get_param('ORACLE_OS') when 'WIN' then '\' else '/' end;
       l_srcpath := p_srcpath||l_ossep||p_srcfilename;
       l_dstpath := p_dstpath||l_ossep;

       if  bars_upload.get_param('ORACLE_OS') = 'WIN'  then
           l_cmd     := 'xcopy.exe';
           l_batfilename := l_batfilename||'.bat';
           l_cmd     := l_cmd||' "'||l_srcpath||'" "'||l_dstpath||'"';
       else
           l_cmd     := '#!/bin/bash
cp';
           l_batfilename := l_batfilename||'.sh';
           l_cmd     := l_cmd||' '||l_srcpath||' '||l_dstpath;
       end if;

       l_fileh :=  utl_file.fopen (location     => bars_upload.get_param('ORACLE_DIR') ,
                                   filename     => l_batfilename,
                                   open_mode    => 'w',
                                   max_linesize => 32767);

       l_netparam := trim(bars_upload.get_group_param(p_groupid, 'NETUSE'));

       if  l_netparam is not null and l_netparam <> 'notused' then
          utl_file.put_line(l_fileh, 'net use '||l_netparam);
       end if ;

       utl_file.put_line(l_fileh, l_cmd);

       -- удаление монтированого диска
       if  l_netparam is not null and  l_netparam <> 'notused' then
          l_drive  := substr(l_netparam, 1, instr(l_netparam,  ' ')-1 );
          utl_file.put_line(l_fileh, 'net use '||l_drive||' /delete /y');
       end if ;

       utl_file.fclose(l_fileh);

       create_cmd_job( p_jobname       => G_COPY_JOB_NAME,
                       p_batpathname   => bars_upload.get_param('UPLOAD_OS_DIR')||l_ossep||l_batfilename,
                       p_startaftermin => bars_upload.get_param('COPY_JOB_DELAY') );
    end;


    -----------------------------------------------------------------
    --  MAKE_ARCHIVE_BYGROUP_BYJOB
    --
    --   Заархивировать все выгруженные файлы по коду группы (которая стартовала выгрузку этих файлов) при
    --   помощи external job
    --    p_auditid      --  код из журнала выгрузки для протоколирования (строка информации по группе выгрузки)
    --    p_auditflid    --  код из журнала выгрузки для конкретного файла (если хотим заархивировтаь лишь один файл)
    --    return имя файла архива
    -----------------------------------------------------------------
    function make_archive_bygroup_byjob( p_auditid  number default null,
                                         p_auditflid  number default null) return varchar2
    is
       l_bankdate     date;
       l_arcfilename  varchar2(1000);
       l_arcpath     varchar2(4000);
       l_srcdir      varchar2(4000);
       l_srcpath     varchar2(4000);
       l_cmd         varchar2(4000);
       l_arcjobname  varchar2(100);
       l_batfilename varchar2(1000);
       l_ossep       char(1);
       l_cnt         number;
       l_fileh       UTL_FILE.File_Type;
       l_trace        varchar2(1000) := G_TRACE||'make_archive_bygroup_byjob: ';
    begin

       bars_audit.trace(l_trace||'старт создания джоба на архивацию по выгруженной группе #'||p_auditid||', для файла '||nvl(p_auditflid,0) );

       -- сформировать бат файл
       l_batfilename := 'makezip.bat';
       l_fileh :=  utl_file.fopen (location     => bars_upload.get_param('ORACLE_DIR') ,
                                   filename     => l_batfilename,
                                   open_mode    => 'w',
                                   max_linesize => 32767);

       l_ossep   := case when bars_upload.get_param('ORACLE_OS') = 'WIN' then '\' else '/' end;

       begin
          select upl_bankdate into l_bankdate from  upl_stats where id = p_auditid;
       exception when no_data_found then
          bars.bars_error.raise_nerror(G_MODULE, 'NO_GROUP_INFORMATION', to_char(p_auditid) );
       end;
       l_arcfilename:= get_arch_filename(p_auditid);
       l_arcpath := bars_upload.get_param('ARC_OS_DIR')||l_ossep||l_arcfilename;


       -- посемтить строку удаления предидущего архива
       --         **    l_cmd := 'del /Q '||l_arcpath;
       --         **    utl_file.put_line(l_fileh, l_cmd);

       l_srcdir := bars_upload.get_param('UPLOAD_OS_DIR')||l_ossep;
       -- для каждого файла сформиоровать строку архивации (архивация каждого файла приведет к добавлению этого файла в архив)
       for c in ( select file_name, id
                    from upl_stats
                   where parent_id = p_auditid
                     and rec_type = 'FILE'
                     and id = nvl(p_auditflid, id)
                     and file_name is not null
                     and status_id = 1
                   order by file_name) loop
           l_srcpath := l_srcdir||c.file_name;
           l_cmd := bars_upload.get_param('ZIP_PATH')||' '||bars_upload.get_param('ZIP_KEYS')||' '||get_arch_password(c.id)||' '||l_arcpath||' '||l_srcpath;

           utl_file.put_line(l_fileh, l_cmd);
       end loop;
       utl_file.fclose(l_fileh);

       -- сформировать external job для выполнения батника
       l_arcjobname := 'arc_uplfiles';


       create_cmd_job(p_jobname     => l_arcjobname,
                      p_batpathname => bars_upload.get_param('UPLOAD_OS_DIR')||l_ossep||l_batfilename );

       return l_arcfilename;

    end;


    -----------------------------------------------------------------
    --  MAKE_ARCHIVE
    --
    --   Заархивировать все выгруженные файлы
    --   Выбираются все файлы по маске даты и архивируются в один файл
    --
    --   p_bankdate     --  Дата выгрузки
    --   p_auditid      --  код из журнала выгрузки для протоколирования (строка информации по группе выгрузки)
    --   return имя файла архива
    -----------------------------------------------------------------
    function make_archive( p_bankdate date,
                           p_auditid  number default null) return varchar2
    is
       l_upldir       varchar2(1000);
       l_arcdir       varchar2(1000);
       l_srcfilename  varchar2(4000);
       l_arcfilename  varchar2(1000);
       l_trace        varchar2(1000) := G_TRACE||'make_archive: ';
    begin
       bars_audit.info(l_trace||'старт архивации файлов за '||to_char(p_bankdate,'dd/mm/yyyy'));


       l_srcfilename := bars_upload.get_param('REGION_PRFX')  ||
                       '*_'                          ||
                        to_char(p_bankdate,'ddmmyyyy')||
                        '.*';

       l_arcfilename:=     bars_upload.get_param('REGION_PRFX')||'_all_'||to_char(p_bankdate,'ddmmyyyy')||'.zip';

       bars_audit.info(l_trace||' src filename='||l_srcfilename||' descname='||l_arcfilename);

       arc_file( p_dirname     => bars_upload.get_param('UPLOAD_OS_DIR'),
                 p_filemask    => l_srcfilename,
                 p_arcdirname  => bars_upload.get_param('ARC_OS_DIR'),
                 p_arcfilename => l_arcfilename,
                 p_auditid     => p_auditid);

       bars_audit.info(l_trace||'архивация завершена. '||bars_upload.get_param('UPLOAD_OS_DIR')||'\'|| l_srcfilename||' => '||bars_upload.get_param('ARC_OS_DIR')||'\'||l_arcfilename);
       return l_arcfilename;

    end;


    -----------------------------------------------------------------
    --  SEND_FILE_TO_FTP
    --
    --   Отослать файл на FTP
    --   Для UINIX-платформ используется для копорования на внешнюю WIN-шару
    --
    --    p_srcfilename    --  Путь+имя файла для передачи
    --    p_auditid        --  код в журнале аудита для записи рез-тов FTP
    -----------------------------------------------------------------
    procedure send_file_to_ftp(p_srcfilename varchar2,
                               p_auditid number default null)
    is
       l_fileh       UTL_FILE.File_Type;
       l_rez         number;
       l_cmd         varchar2(1000);
       l_ftppath     varchar2(1000);
       l_clob        clob;
       l_trace       varchar2(1000) := G_TRACE ||'.send_file_to_ftp: ';
       l_batfilename varchar2(1000);
    begin
       bars_audit.trace(l_trace||'старт отправки на ФТП');

       l_batfilename := case bars_upload.get_param('ORACLE_OS') when 'WIN' then 'ftpcmd.dat' else 'ftpcmd.sh' end;
       l_fileh :=  utl_file.fopen (location     => bars_upload.get_param('ORACLE_DIR') ,
                                   filename     => l_batfilename,
                                   open_mode    => 'w',
                                   max_linesize => 32767);

       if  bars_upload.get_param('ORACLE_OS') = 'WIN'  then
           utl_file.put_line(l_fileh, bars_upload.get_param('FTP_USER')||'@'||bars_upload.get_param('FTP_DOMAIN'));
           utl_file.put_line(l_fileh, bars_upload.get_param('FTP_USER')||'@'||bars_upload.get_param('FTP_DOMAIN'));
           utl_file.put_line(l_fileh, bars_upload.get_param('FTP_PASSWORD'));
           utl_file.put_line(l_fileh,'cd '||bars_upload.get_param('FTP_PATH'));
           utl_file.put_line(l_fileh,'send '||bars_upload.get_param('ARC_OS_DIR')||'\'||p_srcfilename);
           utl_file.put_line(l_fileh,'quit');
           l_cmd := bars_upload.get_param('FTPCLI_PATH')||' -s:'||bars_upload.get_param('UPLOAD_OS_DIR')||'\ftpcmd.dat '||bars_upload.get_param('FTP_SERVER');
       else
           utl_file.put_line(l_fileh, '#!/bin/bash');
           utl_file.put_line(l_fileh, 'login=''' || bars_upload.get_param('FTP_DOMAIN') || '/' || bars_upload.get_param('FTP_USER') || '''');
           utl_file.put_line(l_fileh, 'pass=''' || bars_upload.get_param('FTP_PASSWORD') || '''');
           utl_file.put_line(l_fileh, 'cd ' || bars_upload.get_param('ARC_OS_DIR'));
           l_cmd := '/bin/smbclient ' || bars_upload.get_param('FTP_SERVER') || ' $pass -U $login -c "';
           if bars_upload.get_param('FTP_PATH') is not null then
              l_cmd := l_cmd || ' cd ' || bars_upload.get_param('FTP_PATH') || '; ';
           end if;
           l_cmd := l_cmd || 'put ' || p_srcfilename || '"';
           utl_file.put_line(l_fileh, l_cmd);
           l_cmd := bars_upload.get_param('UPLOAD_OS_DIR') || '/' || l_batfilename;
       end if;
       utl_file.fclose(l_fileh);

       bars_upload.log_start_afterupl_event(p_auditid, 'FTP');
       l_clob := barsos.os_command.exec_clob(l_cmd);

       bars_audit.info(l_trace||'Выполнение переброски: '||substr(l_clob,1,32000));
       bars_upload.log_stop_afterupl_event(p_auditid, 'FTP', substr(l_clob,1,2000));
    end;

  -----------------------------------------------------------------
  --  CHECK_SQL_STATEMENT
  --
  --  Перевірка правильності SQL запитів
  --
  --    p_sql_id - Ід. запиту (якщо нул то перевірка усіх)
  -----------------------------------------------------------------
  procedure CHECK_SQL_STATEMENT
  ( p_sql_id   in     upl_sql.sql_id%type
  )
  is
    l_Cursor          integer;
  begin

    l_Cursor := DBMS_SQL.OPEN_CURSOR;

    for c in ( select SQL_ID, SQL_TEXT from BARSUPL.UPL_SQL
                where ( p_sql_id Is Not Null AND SQL_ID = p_sql_id )
                   or ( p_sql_id IS Null )
             )
    loop
      begin
        DBMS_SQL.PARSE( l_Cursor, c.SQL_TEXT, dbms_sql.native );
      exception
        when OTHERS then
          dbms_output.put_line( 'SQL Statement ' || to_char(c.SQL_ID) || ' Has Error: ' || dbms_utility.format_error_stack() );
      end;
    end loop;

    IF DBMS_SQL.IS_OPEN( l_Cursor )
    THEN
       DBMS_SQL.CLOSE_CURSOR( l_Cursor );
    END IF;

  end CHECK_SQL_STATEMENT;

  -----------------------------------------------------------------
  --  GET_RUNNING_JOB_NAME
  --
  --    Повертає назву джоба запущеного в даний момент
  --
  -----------------------------------------------------------------
  function GET_RUNNING_JOB_NAME
    return dba_scheduler_jobs.job_name%type
  is
    l_job_name varchar(30);
  begin

    begin
      select JOB_NAME
        into l_job_name
        from V_UPL_SCHEDULER_JOBS
       where STATE   = 'RUNNING'
         and ENABLED = 'TRUE'
         and rownum  = 1;
    exception
      when NO_DATA_FOUND then
        l_job_name := null;
    end;

    RETURN l_job_name;

  end GET_RUNNING_JOB_NAME;

  -----------------------------------------------------------------
  --  MMFO_LIST
  --  возвращает строку всех МФО через разделитель ';'
  -----------------------------------------------------------------
  function mmfo_list return varchar2 is
  l_is_mmfo  varchar2(500);
  begin
      select listagg(kf, ';') WITHIN GROUP(order by kf) as kf_list
        into l_is_mmfo
        from BARS.MV_KF;
      return nvl(l_is_mmfo, ' ');
  end mmfo_list;

  -----------------------------------------------------------------
  --  IS_MMFO
  --  возвращает количество регионов в БД
  -----------------------------------------------------------------
  function is_mmfo return number is
  l_is_mmfo  number := 0;
  begin
      select count(*)
        into l_is_mmfo
        from BARS.MV_KF;
      return l_is_mmfo;
  end is_mmfo;

end BARS_UPLOAD_UTL;
/
 show err;
 
PROMPT *** Create  grants  BARS_UPLOAD_UTL ***
grant EXECUTE                                                                on BARS_UPLOAD_UTL to BARS;
grant EXECUTE                                                                on BARS_UPLOAD_UTL to BARS_ACCESS_USER;
grant EXECUTE                                                                on BARS_UPLOAD_UTL to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSUPL/package/bars_upload_utl.sql =========*** 
 PROMPT ===================================================================================== 
 