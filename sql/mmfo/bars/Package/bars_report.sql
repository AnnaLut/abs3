
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_report.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_REPORT 
is


    -----------------------------------------------------------------
    --                                                             --
    --         Отчетность (отчеты, кат.запросы)                    --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_HEAD      constant varchar2(64)  := 'version 3.2 21.06.2012';

    -- Переменная непечатаемых символов
    G_UNPRN   constant varchar2(108) :=
                         chr(00)||chr(01)||chr(02)||chr(03)||chr(04)||chr(05)||chr(06)||chr(07)||
                         chr(08)||chr(09)||chr(10)||chr(11)||chr(12)||chr(13)||chr(14)||chr(15)||
   		         chr(16)||chr(17)||chr(18)||chr(19)||chr(20)||chr(21)||chr(22)||chr(23)||
  		         chr(24)||chr(25)||chr(26)||chr(27)||chr(28)||chr(29)||chr(30)||chr(31);


    -- Переменная печатных символов (пробелы)
    G_PRN     constant varchar2(108) := rpad(' ',32);


    --------------------------------------------------------------------
    --
    --  Данные переменные исползуются для перекодировкаи из WIN - укр гост
    --  плюс перекодировка непечатаемых символов
    --
    --  chr(124) - это символ
    --  G_WIN  constant varchar2(108)   :=  sep.WIN_||G_UNPRN||chr(124);
    --
    --   Переменная символов УКР гост + пробелы
    --  G_DOS  constant varchar2(108) := sep.DOS_||G_PRN||' ';
    --
    --  translate( field_name, G_WIN, G_DOS)
    --  перекодировать поле field_name из вин кодировки в укр гост +
    --  перекодировать все непечатаемые символы в пробелы +
    --  символ | перекодировать в пробел.
    --
    ------------------------------------------------------------------

    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2;



    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2;



    ----------------------------------------------------
    --  CONVERTSTR()
    --
    --  Преобразование строки
    --
    --    p_srcencode     исходная кодировка -  одно из значений 'WIN',  'UKG'
    --    p_destencode    целевая кодировка  -  одно из значений 'WIN',  'UKG'
    --    p_noprintchr    = 1/0 - заменять или нет непечатные символы
    --    p_srclist       конкатенация символов для замены, например, например  *+@
    --    p_destlist      конкатенация символов на которые заменять, например   123
    --                    (тоесть во входящей строке все символы * будут заменены на символ 1, + на 2, @ на 3 )
    ----------------------------------------------------
    function  convertstr (
                          p_str         varchar2             ,
                          p_srcencode   varchar2 default null,
                          p_destencode  varchar2 default null,
			  p_noprintchr  number   default null,
			  p_srclist     varchar2 default null,
			  p_destlist    varchar2 default null  ) return varchar2;


    ----------------------------------------------------
    --  CONVERTSTR2()
    --
    --   Преобразование строки (специфическое) из WIN - UKG
    --   с заменой непечатных симаолов пробелами, с заменой символа '|' пробелом
    --
    --   p_srcencode     исходная кодировка -  одно из значений 'WIN',  'UKG'
    --   p_destencode    целевая кодировка  -  одно из значений 'WIN',  'UKG'
    --
    --   сделано специально для повышения производительности для преобразования большого кол-ва строк!!!
    --
    ----------------------------------------------------
    function convertstr2 (p_str varchar2)  return varchar2;


    ------------------------------------------------------------------
    -- FRMT_DATE()
    --
    --   По строке даты типа 21.02.2008, отдать форматированн.дату
    --
    --   p_date   - строка даты
    --   p_format - шаблон  ('MMDD', 'DDMM', 'MD'(32-разр), 'DM'-(32-разр))
    --
    function  frmt_date(
                  p_date    varchar2,
                  p_format  varchar2 default 'MD' )  return varchar2;


    ------------------------------------------------------------------
    -- FRMT_DATE()
    --
    --   По дате отдать форматированн.дату
    --
    --   p_date   - дата
    --   p_format - шаблон  ('MMDD', 'DDMM', 'MD'(32-разр), 'DM'-(32-разр))
    --
    function  frmt_date(
                  p_date    date,
                  p_format  varchar2 default 'MD' )  return varchar2;


    ------------------------------------------------------------------
    --  GET_REPORT_TYPE()
    --
    --     Получить тип отчета из существующего печатного отчета
    --     по коду кат.запроса
    --
    --     p_kodz      -  код запроса
    --
    function get_report_type(p_kodz number) return smallint;


    ------------------------------------------------------------------
    --  GET_REPORT_FOLDER()
    --
    --     Получить папку отчета
    --
    --     p_kodz      -  код запроса
    --
    function get_report_folder(p_kodz number) return number;


    ------------------------------------------------------------------
    --  GET_DATES_COUNT()
    --
    --     Получить кол-во дат для отчета по строке бинд переменных
    --
    --     p_kodz      - код запроса
    --
    --     p_reptype   - тип отчета
    --
    --
    function  get_dates_count(p_bindvars  varchar2)  return smallint;


    ------------------------------------------------------------------
    -- GET_BRANCH()
    --
    --   По выранным параметрам бранча - сконструировать строку боанча для запроса
    --
    --   p_branch - строка
    --   p_withdep - с подчиненными или без ('1' - c подчиненными, '0' - без)
    --
    function  get_branch( p_branch varchar2,
                          p_withdep varchar2 default '0')  return varchar2;


    ------------------------------------------------------------------
    --  NEXT_REPORTID()
    --
    --     Последующая дырка для номера в печ. отчетах
    --
    --
    function  next_reportid return  number;





    ------------------------------------------------------------------
    -- PRINT_MESSAGE()
    --
    --   Отпечатать в output сщщбщение
    --
    --   p_message  -  текст сообщения
    --
    --   p_line_len - Длина строки
    --
    --
    procedure print_message(
                  p_message    varchar2,
                  p_line_len   number default 100);



    ------------------------------------------------------------------
    -- IS_VISUAL_DLG()
    --
    --   При генерации строки для кат. запроса
    --   Определить по параметрам - нужен ли визуальный диалог или нет
    --   Как рез-т возврат 'TRUE' или 'FALSE'
    --
    --   p_bindvars    - строка bind переменных
    --
    --
    function  is_visual_dlg(p_bindvars varchar2) return varchar2;




    ------------------------------------------------------------------
    --  GET_REPORT_PARAM()
    --
    --     Получить строку параметров для таблицы отчетов REPORTS
    --
    --     p_kodz      - код запроса
    --
    --     p_reptype   - тип отчета
    --
    --
    function  get_report_param(
                  p_kodz    number,
                  p_reptype smallint)  return varchar2;





    ------------------------------------------------------------------
    --  GET_REPORT_FILEMASK()
    --
    --     По строке описание имени исход файла
    --     вычислить маску файла
    --
    --
    --     p_namef -  строка описания имени маски файла из ZAPROS
    --
    --
    function  get_report_filemask(
                  p_namef varchar2)  return varchar2;




    ------------------------------------------------------------------
    --  EXPORT_TO_SCRIPT()
    --
    --     Создать сченарий по выгрузке кат. отчета.
    --     Полученный отвен положить во временную таблицу tmp_lob Для
    --     дальнейшей работы в Centur-е
    --
    --     p_kodz      -  код запроса
    --     p_repinsert -  делать ли вставку в reports
    --     p_repfixid  -  указанный код отчета
    --     p_reptype   -  тип отчета
    --     p_repfolder -  папка отчета
    --
    procedure export_to_script(
                  p_kodz            number,
                  p_repinsert       smallint,
                  p_repfixid        number,
                  p_reptype         smallint,
		  p_repfolder       number    default null);





    -----------------------------------------------------------------
    --  VALIDATE_NLSMASK()
    --
    --   Валидация коррекности введенной маски счета
    --   Проверяется следующее
    --   1) маска не должна начитнаться символами % и _
    --   2) маска должна содержать слева хотябы p_snum чисельных символов
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_mask    -  маска
    --   p_snum    - кол-во символов слева
    --
    procedure validate_nlsmask(p_mask varchar2, p_snum number default 4);




    -----------------------------------------------------------------
    --  VALIDATE_TWO_NLSMASKS()
    --
    --   Валидация коррекности двух введенных масок счтета c условием И или ИЛИ
    --   если и   - то проверка должна удовдетворять для двух счетов
    --   если или - то проверка должна удовдетворять хотя бы для одного счета
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_mask1      - маска 1
    --   p_snum1      - кол-во симолов слева для счета 1
    --   p_mask2      - маска 2
    --   p_snum2      - кол-во симолов слева для счета 2
    --   p_condition  - условие (принимает значения OR или AND)
    --
    procedure validate_two_nlsmasks(
                  p_mask1 varchar2          ,
                  p_snum1 number   default 4,
	          p_mask2 varchar2          ,
	          p_snum2 number   default 4,
	          p_condition varchar2 );


    -----------------------------------------------------------------
    --  VALIDATE_PERIOD()
    --
    --   Валидация коррекности ввода перриода
    --   Разница дат не должна превышать указанное число дней.
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_date1     - дата с
    --
    --   p_date2     - дата по
    --
    --   p_period    - кол-во дней, которое должно покрывать указанный период дат
    --
    procedure validate_period( p_date1  date,
                               p_date2  date,
			       p_period number );



    -----------------------------------------------------------------
    --  VALIDATE_MASKS_AND_PERIOD()
    --
    --
    --   1) Валидация коррекности двух введенных масок счтета c условием И или ИЛИ
    --      если p_condition =  'AND'  - то проверка должна удовдетворять для двух счетов
    --      если p_condition =  'OR'   - то проверка должна удовдетворять хотя бы для одного счета
    --   2) Если указан только первый счет - валидация одного счета
    --   3) Валидация указнного периода.  Разница дат не должна превышать указанное число дней.
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_mask1      - маска 1
    --   p_snum1      - кол-во симолов слева для счета 1
    --   p_mask2      - маска 2
    --   p_snum2      - кол-во симолов слева для счета 2
    --   p_condition  - условие (принимает значения OR или AND)
    --   p_date1      - дата 1
    --   p_date2      - дата 2
    --   p_period     - кол-во дней, которое должно покрывать указанный период дат
    --
    procedure validate_masks_and_period(
                                    p_mask1     varchar2,
                                    p_snum1     number    default 4,
                                    p_mask2     varchar2  default null,
                                    p_snum2     number    default 4,
				    p_condition varchar2  default null,
				    p_date1     date,
				    p_date2     date,
				    p_period    number );



    ------------------------------------------------------------------
    -- EXEC_XML_REPORT
    --
    --  Выполнение отчета (запроса, который формирует xmlElement)
    --
    --
    procedure exec_xml_report( p_sqlstmt varchar2, p_encode varchar2);

    ------------------------------------------------------------------
    -- EXEC_BLOB_REPORT
    --
    --  Выполнение отчета (запроса, который формирует blob)
    --
    --
    procedure exec_blob_report(p_sqlstmt varchar2);


    ----------------------------------------------------
    --  GET_BLOB_BUFFER()
    --
    --    Взять часть из пременной-буффера пакета G_RESULT_CLOB
    --
    --
    ----------------------------------------------------
    procedure get_blob_buffer(
                  p_buff     out varchar2,
                  p_bufflen  out number,
                  p_offset       number,
                  p_amount       number) ;

    ----------------------------------------------------
    --  GET_BUFFER()
    --
    --    Взять часть из пременной-буффера пакета G_RESULT_CLOB
    --
    --
    ----------------------------------------------------
    procedure get_buffer(
                  p_buff     out varchar2,
                  p_bufflen  out number,
                  p_offset       number,
                  p_amount       number);




    -----------------------------------------------------------------
    --  ADD_REPORT_TO_SHEDULER()
    --
    --  Добавление отчета в список выполнения задач по-расписанию (task_list)
    --
    --      p_pkey      - ключ запроса
    --      p_reptype   - тип отчета
    --      p_paramlist - список параметров с ихними значениями для отчета, наприм. :sFdat1='gl.bd'
    --      p_username  - имя пользователя
    --      p_interval  - интервал срабатывания (в сек)
    --
    procedure add_report_to_sheduler(
                    p_pkey      varchar2,
                    p_reptype   rep_types.typeid%type,
                    p_paramlist varchar2,
                    p_username  varchar2,
                    p_interval  number);
  --------------------------------------------------------------
  --
  --  GET_NEXT_ZAPROS_PKEY()
  --
  --    Достает последующий номер уникального ключа для банка
  --
  --
  function get_next_zapros_pkey return varchar2 ;


    -----------------------------------------------------------------
    --  FORM_REPORT_BLOB
    --
    --  на основании таблицы zapros + кодировка + тип отчета из rep_type
    --  сформировать blob отчета и отдать имя файла
    --  процедурадля веб сервиса по автоматическому формированиюотчетов на старте -финише
    --  (формировнаие за банковскую дату)
    --
    --  p_pkey        - код запроса из zapros
    --  p_reptype     - код типа отчета из rep_types
    --  p_encode      - кодировка из справочника
    --
    procedure form_report_blob(
        p_kodz           varchar2,
        p_encode         varchar2,
        p_reptype        number,
        p_filename   out varchar2,
        p_path       out varchar2,
        p_blob       out blob,
        p_report_date    in date default null);


    -----------------------------------------------------------------
    --  FORM_REPORT_BY_WEBSERVICE
    --
    --  Сформировать отчет на основании zapros.kodz при помощи вызова веб сервиса.
	--  Формирование отчета проходит в каталог веб сервера в папку, указанную в параметре
    --
    procedure form_report_by_webservice( p_kodz            number,
                                         p_report_type     rep_types.typeid%type,
                                         p_report_encode 	 varchar2 default 'WIN',
                                         p_report_date     date default gl.bd());


end bars_report;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_REPORT 
is


    -----------------------------------------------------------------
    --                                                             --
    --         Отчетность (отчеты, кат.запросы)                    --
    --                                                             --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_BODY      constant varchar2(100) := '$Ver: 5.11.12816 2016-12-27';
    G_MODULE          constant varchar2(64)  := 'REP';
    G_TRACE           constant varchar2(100) := 'bars_report.';

    -----------------------------------------------------------------
    -- Переменные
    -----------------------------------------------------------------
    G_RESULT_CLOB         clob;
    G_RESULT_BLOB         blob;

    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2 is
    begin
       return 'Package header bars_report: '||VERSION_HEAD;
    end header_version;



    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2 is
    begin
       return 'Package body bars_report: '||VERSION_BODY;
    end body_version;



    ----------------------------------------------------
    --  FREE_BUFFER()
    --
    --    Очистка глобальных буфферов
    --
    --    p_buff       - буффер
    --
    ----------------------------------------------------
    procedure free_buffer(p_buff  in out clob)
    is
    begin
       if p_buff is not null then
          if dbms_lob.istemporary(p_buff) = 1 then
            dbms_lob.freetemporary(p_buff);
          end if;
          p_buff := null;
       end if;
    end;


    ----------------------------------------------------
    --  FREE_BUFFER()
    --
    --    Очистка глобальных буфферов
    --
    --    p_buff       - буффер
    --
    ----------------------------------------------------
    procedure free_buffer(p_buff  in out blob)
    is
    begin
       if p_buff is not null then
          if dbms_lob.istemporary(p_buff) = 1 then
            dbms_lob.freetemporary(p_buff);
          end if;
          p_buff := null;
       end if;
    end;

  --------------------------------------------------------------
  --
  --  GET_NEXT_ZAPROS_PKEY()
  --
  --    Достает последующий номер уникального ключа для банка
  --
  --
  function get_next_zapros_pkey return varchar2
  is
     l_pkey    zapros.pkey%type;
     l_par     varchar2(8) := 'ZPRS_PK';
  begin

     if  sys_context('bars_context','user_branch') = '/' then
        l_par := 'ZPRS_PKR';
     end if;

     select '\'||val||'\***\***\'||sum(pk) into l_pkey
     from (  select 1 pk from dual
             union all
             select  (max( to_number(decode (   instr(pkey,'\',2,4), 0,
                    substr(pkey,  instr(pkey,'\',2,3)+1),
                 substr(pkey,  instr(pkey,'\',2,3)+1,  instr(pkey,'\',2,4) -  instr(pkey,'\',2,3)-1)
                  ))) )
            from zapros,
                 params
            where      pkey like '\'||val||'\***\***\%'
                  and  par = l_par
          ) a,
                 params
     where par = l_par
     group by val;

     return l_pkey;

  end;
    ----------------------------------------------------
    --  CONVERTSTR()
    --
    --    Преобразование строки
    --
    --    p_srcencode     исходная кодировка -  одно из значений 'WIN',  'UKG'
    --    p_destencode    целевая кодировка  -  одно из значений 'WIN',  'UKG'
    --    p_noprintchr    = 1/0 - заменять или нет непечатные символы
    --    p_srclist       конкатенация символов для замены, например, например  *+@
    --    p_destlist      конкатенация символов на которые заменять, например   123
    --                    (тоесть во входящей строке все символы * будут заменены на символ 1, + на 2, @ на 3 )
    ----------------------------------------------------
    function convertstr (
                          p_str         varchar2             ,
                          p_srcencode   varchar2 default null,
                          p_destencode  varchar2 default null,
			  p_noprintchr  number   default null,
			  p_srclist     varchar2 default null,
			  p_destlist    varchar2 default null  ) return varchar2
    is
       l_dest   varchar2(4000);
       l_src    varchar2(4000);
       l_result varchar2(4000);
    begin
       if p_srcencode is not null then
          case p_srcencode when 'WIN' then l_src  := sep.WIN_;
                           when 'UKG' then l_src  := sep.DOS_;
                           else bars_error.raise_nerror(G_MODULE, 'UNKNOWN_ENCODE', p_destencode);
          end case;

          case p_destencode when 'WIN' then l_dest  := sep.WIN_;
                            when 'UKG' then l_dest  := sep.DOS_;
                            else bars_error.raise_nerror(G_MODULE, 'UNKNOWN_ENCODE', p_destencode);
          end case;
       end if;

       if p_noprintchr is not null then
          l_src  := l_src ||G_UNPRN;
          l_dest := l_dest||G_PRN;
       end if;

       if p_srclist is not null then
          if  p_destlist is null or length(p_srclist)<>length(p_destlist) then
              bars_error.raise_nerror(G_MODULE, 'NOTCORRECT_LIST', p_srclist, p_destlist);
          end if;
          l_src   := l_src ||p_srclist;
          l_dest  := l_dest||p_destlist;
       end if;

       return translate(p_str, l_src, l_dest);

    end;

    ----------------------------------------------------
    --  CONVERTSTR2()
    --
    --   Преобразование строки (специфическое) из WIN - UKG
    --   с заменой непечатных симаолов пробелами, с заменой символа '|' пробелом
    --
    --   p_srcencode     исходная кодировка -  одно из значений 'WIN',  'UKG'
    --   p_destencode    целевая кодировка  -  одно из значений 'WIN',  'UKG'
    --
    --   сделано специально для повышения производительности для преобразования большого кол-ва строк!!!
    --
    ----------------------------------------------------
    function convertstr2 (p_str varchar2)  return varchar2
    is
    begin
       return  translate(p_str, sep.WIN_||G_UNPRN||'|',  sep.DOS_||G_PRN||' ' );
    end;



    ------------------------------------------------------------------
    -- EXEC_XML_REPORT
    --
    --  Выполнение отчета (запроса, который формирует xmlElement)
    --
    --
    procedure exec_xml_report( p_sqlstmt varchar2, p_encode varchar2)
    is
       l_clob    clob;
       l_length  number;
       l_encode  varchar2(2000);
       l_trace    varchar2(1000) := g_trace||'exec_xml_report: ';
    begin
       bars_audit.trace(l_trace||'вошли в функу');

       if G_RESULT_CLOB is not null then
          free_buffer(G_RESULT_CLOB);
       end if;
       dbms_lob.createtemporary(G_RESULT_CLOB, false);

       bars_audit.trace(l_trace||'запрос: '||p_sqlstmt);

       execute immediate p_sqlstmt into l_clob;
       l_encode := '<?xml version="1.0" encoding="'||p_encode||'"?>';
       dbms_lob.append(G_RESULT_CLOB,  l_encode);
       bars_audit.trace(l_trace||'размер клоба '||l_length);
       dbms_lob.append(G_RESULT_CLOB,  l_clob)  ;

    exception when others then
       free_buffer(G_RESULT_CLOB);
       raise;
    end;



    ------------------------------------------------------------------
    -- EXEC_BLOB_REPORT
    --
    --  Выполнение отчета (запроса, который формирует blob)
    --
    --
    procedure exec_blob_report(p_sqlstmt varchar2)
    is
       l_blob    blob;
       l_length  number;
       l_encode  varchar2(2000);
       l_trace    varchar2(1000) := g_trace||'exec_blob_report: ';
    begin
       bars_audit.info(l_trace||'начало выполнения функциирррр');

       if G_RESULT_BLOB is not null then
          free_buffer(G_RESULT_BLOB);
       end if;
       dbms_lob.createtemporary(G_RESULT_BLOB, false);

       bars_audit.info(l_trace||'запрос: '||p_sqlstmt);

       execute immediate p_sqlstmt into l_blob;

       dbms_lob.append(G_RESULT_BLOB, l_blob);

    exception when others then
       free_buffer(G_RESULT_BLOB);
       raise;
    end;

    ----------------------------------------------------
    --  GET_BLOB_BUFFER()
    --
    --    Взять часть из пременной-буффера пакета G_RESULT_CLOB
    --
    --
    ----------------------------------------------------
    procedure get_blob_buffer(
                  p_buff     out varchar2,
                  p_bufflen  out number,
                  p_offset       number,
                  p_amount       number)
    is
       l_blob     blob;
       l_trace    varchar2(1000) := g_trace||'get_blob_buffer: ';
    begin

/*
       bars_audit.trace(l_trace||'buffer: '||p_offset);
       if G_EXCH_BLOB_DBF is null or
          (G_EXCH_BLOB_DBF is not null and dbms_lob.getlength(G_EXCH_BLOB_DBF) = 0) then
          bars_error.raise_error(G_MODULE, 22);
       end if;

       l_blob := dbms_lob.substr(G_EXCH_BLOB_DBF, p_amount, p_offset);
       p_buff := utl_raw.cast_to_varchar2(l_blob);

  hh     p_bufflen := nvl(length(p_buff), 0);

       if  p_bufflen = 0 then
           dbms_lob.freetemporary(G_EXCH_BLOB_DBF);
           G_EXCH_BLOB_DBF := null;
       end if;

  */

--       bars_audit.trace(l_trace||'buffer: '||p_offset);
       if G_RESULT_BLOB is null or
          (G_RESULT_BLOB is not null and dbms_lob.getlength(G_RESULT_BLOB) = 0) then
          bars_error.raise_nerror('REP', 'RESULT_ISEMPTY');
       end if;

       l_blob := dbms_lob.substr(G_RESULT_BLOB, p_amount, p_offset);
       p_buff := utl_raw.cast_to_varchar2(l_blob);
       p_bufflen := nvl(length(p_buff), 0);

       if  p_bufflen = 0 then
           dbms_lob.freetemporary(G_RESULT_BLOB);
           G_RESULT_BLOB := null;
       end if;
    exception when others then
       free_buffer(G_RESULT_BLOB);
       raise;
    end;



    ----------------------------------------------------
    --  GET_BUFFER()
    --
    --    Взять часть из пременной-буффера пакета G_RESULT_CLOB
    --
    --
    ----------------------------------------------------
    procedure get_buffer(
                  p_buff     out varchar2,
                  p_bufflen  out number,
                  p_offset       number,
                  p_amount       number)
    is
       l_clob     clob;
       l_trace    varchar2(1000) := g_trace||'get_buffer: ';
    begin

       bars_audit.trace(l_trace||'buffer: '||p_offset);
       if G_RESULT_CLOB is null or
          (G_RESULT_CLOB is not null and dbms_lob.getlength(G_RESULT_CLOB) = 0) then
          bars_error.raise_nerror('REP', 'RESULT_ISEMPTY');
       end if;

       p_buff := dbms_lob.substr(G_RESULT_CLOB, p_amount, p_offset);
       p_bufflen := nvl(length(p_buff), 0);

       if  p_bufflen = 0 then
           dbms_lob.freetemporary(G_RESULT_CLOB);
           G_RESULT_CLOB := null;
       end if;
    exception when others then
       free_buffer(G_RESULT_CLOB);
       raise;
    end;

    ------------------------------------------------------------------
    -- CONVERT_DEC_TO_32
    --
    --  перевести 10-ти разрядноре число в 32-разр.
    --
    --
    function convert_dec_to_32(
                  l_dec smallint) return char is

       x char(1);
    begin
       if l_dec >= 0 and l_dec <= 9 then
          X := chr(l_dec + 48);
       elsif l_dec >= 10 and l_dec <= 35 then
          X := chr(l_dec + 55);
       else
          X := '0';
       end if;
       return x;
    end;




    ------------------------------------------------------------------
    -- FRMT_DATE()
    --
    --   По строке даты типа 21.02.2008, отдать форматированн.дату
    --
    --   p_date   - строка даты
    --   p_format - шаблон  ('MMDD', 'DDMM', 'MD'(32-разр), 'DM'-(32-разр))
    --              шаблон строиться из символов
    --              MM/M -  месяц в 10-разр(32-разр)
    --              DD/D -  день в 10-разр(32-разр)
    --              YYYY/YY/Y - год полный/два последних знака/два последних знака (32-разр)
    function  frmt_date(
                  p_date    varchar2,
                  p_format  varchar2 default 'MD' )  return varchar2
    is
       l_day  smallint;
       l_mon  smallint;
       l_year number;
       l_rez  varchar2(8);
       l_fmt  varchar2(8);
    begin

       bars_audit.error('>>>'||p_date);
       l_day  := to_number(substr(p_date,1,2));
       l_mon  := to_number(substr(p_date,4,2));
       l_year := to_number(substr(p_date,-4));

       l_fmt  := upper(p_format);


       if instr(l_fmt,'M') > 0  then
          if instr(l_fmt,'MM') > 0  then
             l_rez := replace(p_format,'MM', lpad(to_char(l_mon),2,'0'));
          else
             l_rez := replace(p_format,'M', convert_dec_to_32(l_mon));
          end if;

       end if;

       if instr(l_fmt,'D') > 0  then
          if instr(l_fmt,'DD') > 0  then
             l_rez := replace(l_rez,'DD', lpad(to_char(l_day),2,'0'));
          else
             l_rez := replace(l_rez,'D', convert_dec_to_32(l_day));
          end if;

       end if;

       if instr(l_fmt,'Y') > 0  then
          if instr(l_fmt,'YYYY') > 0  then
             l_rez := replace(l_rez, 'YYYY', l_year);
          else
             if instr(l_fmt,'YY') > 0  then
                 l_rez := replace(l_rez, 'YY', substr(l_year,-2));
             else
                 l_rez := replace(l_rez, 'Y', convert_dec_to_32(substr(l_year,-2)) );
             end if;
          end if;

       end if;

       return l_rez;

      /* if l_fmt <> 'MD'   and
          l_fmt <> 'DM'   and
          l_fmt <> 'MMDD' and
          l_fmt <> 'DDMM'     then
          bars_error.raise_error('REP',18, l_fmt);
       end if;


       if length(l_fmt) = 2 then
          if l_fmt = 'MD' then
             l_rez :=  convert_dec_to_32(l_mon) || convert_dec_to_32(l_day);
          else
             l_rez :=  convert_dec_to_32(l_day) || convert_dec_to_32(l_mon);
          end if;
       else
          if l_fmt = 'MMDD' then
             l_rez :=  lpad(to_char(l_mon),2,'0') || lpad(to_char(l_day),2,'0');
          else
             l_rez :=  lpad(to_char(l_day),2,'0') || lpad(to_char(l_mon),2,'0');
          end if;
       end if;


      */
    end;


    ------------------------------------------------------------------
    -- FRMT_DATE()
    --
    --   По дате отдать форматированн.дату
    --
    --   p_date   - дата
    --   p_format - шаблон  ('MMDD', 'DDMM', 'MD'(32-разр), 'DM'-(32-разр))
    --
    function  frmt_date(
                  p_date    date,
                  p_format  varchar2 default 'MD' )  return varchar2
    is
    begin
       return frmt_date(to_char(p_date,'dd.mm.yyyy'), p_format);
    end;


    ------------------------------------------------------------------
    -- DBLNOT()
    --
    --   Удвоить кавычки для строки
    --
    --   p_txt - строка
    --
    --
    function  dblnot(p_txt varchar2)  return varchar2
    is
    begin
       return replace(p_txt, chr(39), chr(39)||chr(39));
    end;




    ------------------------------------------------------------------
    -- GET_BRANCH()
    --
    --   По выранным параметрам бранча - сконструировать строку боанча для запроса
    --
    --   p_branch - строка
    --   p_withdep - с подчиненными или без ('1' - c подчиненными, '0' - без)
    --
    function  get_branch(p_branch varchar2, p_withdep varchar2 default '0')  return varchar2
    is
       l_ret varchar2(1000);
    begin
       l_ret := case p_branch when 'Поточне' then  sys_context('bars_context','user_branch') else p_branch end;
       if p_withdep = '1' then
          l_ret := l_ret ||'%';
       end if;
       return l_ret;
    end;



    ------------------------------------------------------------------
    --  DEL_DIR_PATH()
    --
    --   Удалить из маски файла - путь для вычисления чистой маски файла
    --
    --   p_namef - имя файла из REPORTS
    --
    --
    function  del_dir_path(p_namef varchar2)  return varchar2
    is
       l_result varchar2(2000);
       i        number;
       i2       number;
       i3       number;
       l_path   varchar2(2000);
    begin

      l_result := p_namef;

      i := instr(p_namef,':\');
      if  i > 0 then
          -- конец пути
          i2 := instr(p_namef, chr(39), i+1, 1);
          -- собсвенно вся константа пути
          l_path := substr(p_namef,  i - 1,  i2 - (i-1)  );
          -- в пути еще указан и файл


          i3 := 0;
          if substr(l_path, length(l_path) - i3,1) = '\' then

             l_result := substr(l_path, length(l_path) + 4 )||substr(p_namef, i2 + 3);

          else
             i3 := 1;
             while substr(l_path, length(l_path) - i3,1) != '\' loop
                i3 := i3 + 1;
             end loop;
             l_result := ''''||substr(l_path, length(l_path) -i3 +1 )||substr(p_namef, i2);
          end if;

          if (substr(p_namef,1,1) = '=') then
              l_result := '='||l_result ;
          end if;


      end if;

      return l_result;

    end;






    ------------------------------------------------------------------
    --  DEL_SINGLE_ORA_FUNC()
    --
    --   Удалить функцию оракла для формирования имени файла
    --
    --   p_namef   - имя файла из REPORTS
    --
    --   p_orafnc  - позиция начала функции оракла
    --
    --
    --
    function  del_single_ora_func(
                   p_namef  varchar2,
                   p_orafnc varchar2)    return varchar2
    is
       i1       smallint;
       i2       smallint;
       cnt      smallint;
       txt      varchar2(2000);
       l_pos    smallint;
       l_result varchar2(2000);
    begin

       l_result := p_namef;
       l_pos    := instr( lower(p_namef),  lower(p_orafnc) );

       while l_pos > 0 loop

          -- нати первую кавычку
          i1 := instr( lower(l_result),'(', l_pos + 1, 1);
          i2 := instr( lower(l_result),')', l_pos + 1, 1);
          txt:= substr(l_result, i1 + 1, i2-i1-1);

          cnt := 0;
          while instr(txt, '(', 1, cnt+1) > 0 loop
             cnt := cnt+1;
          end loop;


          l_result:=substr(l_result, 1, l_pos - 1)||substr(l_result, instr(l_result, ')',i2, cnt+1)+1 );

          l_pos    := instr( lower(l_result),  lower(p_orafnc) );
       end loop;

       return l_result;
    end;








    ------------------------------------------------------------------
    --  DEL_ORA_FUNCS()
    --
    --   Удалить функи оракла для формирования имени файла
    --
    --   p_namef - имя файла из REPORTS
    --
    --
    function  del_ora_funcs(p_namef varchar2)  return varchar2
    is
       l_result varchar2(2000);
    begin

       l_result := p_namef;

       l_result :=  del_single_ora_func(l_result, 'decode'   );
       l_result :=  del_single_ora_func(l_result, 'to_char'  );
       l_result :=  del_single_ora_func(l_result, 'to_number');
       l_result :=  del_single_ora_func(l_result, 'substr'   );
       l_result :=  del_single_ora_func(l_result, 'replace'  );


       return l_result;

    end;




    ------------------------------------------------------------------
    -- PRINT_MESSAGE()
    --
    --   Отпечатать в output сщщбщение
    --
    --   p_message  -  текст сообщения
    --
    --   p_line_len - Длина строки
    --
    --
    procedure print_message(
                  p_message    varchar2,
                  p_line_len   number default 100)
    is
       i1     number;
       i2     number;
       flg    number;
       l_mess varchar2(220);
       nlchr  char(2):=chr(13)||chr(10);
    begin
       i1:=1;
       i2:=instr(p_message, nlchr);
       loop
          if i2 > 0  then
              if i2 - i1 > p_line_len then
                  i2 := i1 + p_line_len - 1 + 2;
                  flg:=1;
              end if;
                 dbms_output.put_line(substr(p_message, i1, i2-i1 -1 ));
                 if flg = 1 then
                    i1:= i2 + 1 - 3;
                 else
                    i1:= i2 + 2;
                 end if;
                 i2:= instr(p_message, nlchr, i1+1, 1);
                 flg:=0;
          else
              dbms_output.put_line(substr(p_message, i1));
              exit;
          end if;
       end loop;
    end;






    ------------------------------------------------------------------
    -- IS_VISUAL_DLG()
    --
    --   При генерации строки для кат. запроса
    --   Определить по параметрам - нужен ли визуальный диалог или нет
    --   Как рез-т возврат 'TRUE' или 'FALSE'
    --
    --   p_bindvars    - строка bind переменных
    --
    function  is_visual_dlg(p_bindvars varchar2) return varchar2
    is
       i    smallint:=1;
       pos  smallint:=1;
    begin

       bars_audit.trace(p_bindvars );
       loop
           pos:= instr(p_bindvars,'=''', 1, i);

           if pos > 0 then
             if ( substr(p_bindvars, pos+2, 1) <> chr(39) ) then
                return 'TRUE';
             end if;
             i:=i+1;
           else
              return 'FALSE';
           end if;
        end loop;
    end;





    ------------------------------------------------------------------
    --  GET_REPORT_PARAM()
    --
    --     Получить строку параметров для таблицы отчетов REPORTS
    --
    --     p_kodz      - код запроса
    --
    --     p_reptype   - тип отчета
    --
    --
    function  get_report_param(
                  p_kodz    number,
                  p_reptype smallint)  return varchar2
    is
       l_param    reports.param%type;
    begin

       select p_reptype||','||
              decode(   instr(bindvars,':sFdat2'), 0, 'sFdat,sFdat','sFdat,sFdat2' )||',"",'||
              is_visual_dlg(bindvars)||','||
              decode( nvl(namef,'-'),'-','FALSE','TRUE')
       into l_param
       from zapros where kodz = p_kodz;
       return l_param;
    exception when no_data_found then
      bars_error.raise_error('IES', 2 ,to_char(p_kodz));
    end;






    ------------------------------------------------------------------
    --  GET_DATES_COUNT()
    --
    --     Получить кол-во дат для отчета по строке бинд переменных
    --
    --     p_kodz      - код запроса
    --
    --     p_reptype   - тип отчета
    --
    --
    function  get_dates_count(p_bindvars  varchar2)  return smallint
    is
    begin

        if instr(p_bindvars, 'sFdat')  = 0 then
           return 0;
        else
           if instr(p_bindvars, 'sFdat2') > 0 then
              return 2;
           else
              return 1;
           end if;
        end if;
    end;






    ------------------------------------------------------------------
    --  GET_REPORT_FILEMASK()
    --
    --     По строке описание имени исход файла
    --     вычислить маску файла
    --
    --
    --     p_namef -  строка описания имени маски файла из ZAPROS
    --
    --
    function  get_report_filemask(
                  p_namef varchar2)  return varchar2
    is
       l_filemask   reports.mask%type;
       i   smallint;
       i2  smallint;
       l_namef      zapros.namef%type;
    begin


       l_namef := del_dir_path(p_namef);
       l_namef := del_ora_funcs(l_namef);

       if substr(l_namef,1,1) = '=' then
          i:=instr(l_namef, chr(39) );

          if i <=0 then
             return '*.*';
          else
             loop
                if i > 0 then
                   i2:= instr(l_namef, chr(39), i + 1, 1 );
                   l_filemask:= trim(nvl(l_filemask,' ')||substr(l_namef, i+1, i2-i-1));
                   if  (instr(l_namef, chr(39), i2+1,1 )) > 0 then
		        l_filemask:= l_filemask||'*';
		   end if;
                   i :=instr(l_namef, chr(39), i2+1,1 );
                else
                   -- но за кавычкой что-то есть
                   if substr(l_namef,-1) != chr(39) then
                      l_filemask:= l_filemask||'*';
                   end if;
                   return l_filemask;
                end if;
             end loop;

          end if;
       else
          return p_namef;
       end if;
    exception when others then
      return '*.*';
    end;




    ------------------------------------------------------------------
    --  NEXT_REPORTID()
    --
    --     Последующая дырка для номера в печ. отчетах
    --
    --
    function  next_reportid return  number
    is
    begin
       for c in( select id + 1 as newid from reports o1
           where not exists (select id from reports where id=o1.id + 1)) loop
           return c.newid;
       end loop;
    end;







    ------------------------------------------------------------------
    --  REFERENCED_REPORTS()
    --
    --     Нати список отчетов, которые ссылаюся на данный кат. отчет
    --     Возвращает строку со списком, значения разделены запятой
    --
    --     p_kodz      -  код запроса
    --
   /* function  referenced_reports(p_kodz number) return  varchar2
    is

       l_list  varchar2(100);
    begin

       for c in( select param, substr(param, 1, instr(param,',')-1) kodz
                 from reports
                 where form='frm_UniReport' ) loop
             l_list:=l_list||c.kodz||',';
       end loop;
       l_list:=substr(l_list,1, length(l_list)-1);
       return l_list;
    end;
    */



    ------------------------------------------------------------------
    --  GET_REPORT_TYPE()
    --
    --     Получить тип отчета из существующего печатного отчета
    --     по коду кат.запроса
    --
    --     p_kodz      -  код запроса
    --
    function get_report_type(p_kodz number) return smallint
    is
       l_reptype  varchar2(3);
       l_nreptype smallint;
    begin

        select substr(param, instr(param,',',1,1)+1,
                             instr(param,',',1,2) - instr(param,',',1,1) - 1)
        into l_reptype
        from reports
        where form in ('frm_UniReport', 'frm_FastReport') and substr(param, 1, instr(param,',')-1) = to_char(p_kodz)
              and rownum=1;

        begin
           l_nreptype:= to_number(l_reptype);
        exception when others then
           bars_error.raise_error('REP',15, to_char(p_kodz));
        end;

        return l_nreptype;
    exception when no_data_found then
        bars_error.raise_error('REP',16, to_char(p_kodz));
    end;



    ------------------------------------------------------------------
    --  GET_REPORT_FOLDER()
    --
    --     Получить папку отчета
    --
    --     p_kodz      -  код запроса
    --
    function get_report_folder(p_kodz number) return number
    is
       l_repfolder number;
       l_nreptype  smallint;
    begin

        select idf  into l_repfolder
         from reports
        where form in ('frm_UniReport', 'frm_FastReport') and substr(param, 1, instr(param,',')-1) = to_char(p_kodz)
          and rownum=1;

        return l_repfolder;
    exception when no_data_found then
        return null;
    end;



    ------------------------------------------------------------------
    --  REFERENCED_REPORTS()
    --
    --     Нати список отчетов, которые ссылаюся на данный кат. отчет
    --     Возвращает строку со списком, значения разделены запятой
    --
    --     p_kodz      -  код запроса
    --
    function referenced_reports(p_kodz number) return varchar2_list pipelined
    is
    begin

       for c in( select param, substr(param, 1, instr(param,',')-1) kodz
                 from reports
                 where form='frm_UniReport' ) loop
              pipe row (c.kodz);
       end loop;
    end;




    ------------------------------------------------------------------
    --  EXPORT_TO_SCRIPT()
    --
    --     Создать сченарий по выгрузке кат. отчета.
    --     Полученный отвен положить в переменную p_clob
    --
    --     p_kodz      -  код запроса
    --     p_repinsert -  делать ли вставку в reports
    --     p_repfixid  -  указанный код отчета
    --     p_reptype   -  тип отчета
    --     p_repfolder -  код папки отчета
    --     p_clob      -  clob  в который выдается рез-т
    --
    procedure export_to_script(
                  p_kodz          number,
                  p_repinsert     smallint,
                  p_repfixid      number,
                  p_reptype       smallint,
                  p_repfolder     number    default null,
                  p_clob_scrpt  out clob )
    is
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);
       l_zpr      zapros%rowtype;
       l_zprr     zapros%rowtype;
       l_rep      reports%rowtype;
       l_clob     clob;

    begin

       dbms_lob.createtemporary(l_clob,  FALSE);
       begin

          select * into l_zpr
          from zapros
          where kodz=p_kodz;

          if nvl(l_zpr.kodr,0) > 0 then
             select * into l_zprr
             from zapros
             where kodz=l_zpr.kodr;
          end if;

       exception when no_data_found then
          bars_error.raise_error('IES', to_char(p_kodz));
       end;

       l_txt:=       'prompt ===================================== '||nlchr ;
       l_txt:=l_txt||'prompt == '||l_zpr.name                       ||nlchr ;
       l_txt:=l_txt||'prompt ===================================== '||nlchr||nlchr;

       l_txt:=l_txt||'set serveroutput on'||nlchr ;
       l_txt:=l_txt||'set feed off       '||nlchr ;

       l_txt:=l_txt||'declare                               '||nlchr ;
       l_txt:=l_txt||nlchr ;

       l_txt:=l_txt||'   nlchr       char(2):=chr(13)||chr(10);'||nlchr ;
       l_txt:=l_txt||'   l_zpr       zapros%rowtype;    '||nlchr ;
       l_txt:=l_txt||'   l_zprr      zapros%rowtype;    '||nlchr ;
       l_txt:=l_txt||'   l_rep       reports%rowtype;   '||nlchr ;
       l_txt:=l_txt||'   l_repfolder number;            '||nlchr ;
       l_txt:=l_txt||'   l_isnew     smallint:=0;       '||nlchr ;
       l_txt:=l_txt||'   l_isnewr    smallint:=0;       '||nlchr ;
       l_txt:=l_txt||'   l_message   varchar2(1000);    '||nlchr ;

       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'begin     '||nlchr ;
       l_txt:=l_txt||'   l_zpr.name := '''|| dblnot(l_zpr.name)||''';'||nlchr ;
       l_txt:=l_txt||'   l_zpr.pkey := '''|| l_zpr.pkey||''';'||nlchr ;

       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'   l_message  := ''Ключ запроса: ''||l_zpr.pkey||''  ''||nlchr;'||nlchr ;

       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'   begin                                                   '||nlchr ;
       l_txt:=l_txt||'      select kodz, kodr into l_zpr.kodz, l_zpr.kodr        '||nlchr ;
       l_txt:=l_txt||'      from zapros where pkey=l_zpr.pkey;                   '||nlchr ;
       l_txt:=l_txt||'   exception when no_data_found then                       '||nlchr ;
       l_txt:=l_txt||'      l_isnew:=1;                                          '||nlchr ;
       l_txt:=l_txt||'      select s_zapros.nextval into l_zpr.kodz from dual;   '||nlchr ;
       l_txt:=l_txt||'      if ('||nvl(l_zpr.kodr,0)||'>0) then                  '||nlchr ;
       l_txt:=l_txt||'         select s_zapros.nextval into l_zpr.kodr from dual;'||nlchr ;
       l_txt:=l_txt||'         l_zprr.kodz:=l_zpr.kodr;           '||nlchr ;
       l_txt:=l_txt||'      end if;                               '||nlchr ;
       l_txt:=l_txt||'   end;                                     '||nlchr ;
       l_txt:=l_txt||'                                            '||nlchr ;


       dbms_lob.append(l_clob, l_txt);
       l_txt:='';


       if nvl(l_zpr.kodr,0) > 0 then

       l_txt:=       '    ------------------------    '||nlchr ;
       l_txt:=l_txt||'    --  constraint query  --    '||nlchr ;
       l_txt:=l_txt||'    ------------------------    '||nlchr ;
       l_txt:=l_txt||'                                '||nlchr ;

       l_zprr.create_stmt :=  dblnot(l_zprr.create_stmt);
       l_zprr.create_stmt :=  replace ( l_zprr.create_stmt, chr(13)||chr(10), '~' );
       l_zprr.create_stmt :=  replace ( l_zprr.create_stmt, chr(13), '~');
       l_zprr.create_stmt :=  replace ( l_zprr.create_stmt, chr(10), '~');
       l_zprr.create_stmt :=  replace ( l_zprr.create_stmt, '~', '''||nlchr||'||nlchr||'                           ''' );


       l_txt:=l_txt||'    l_zprr.id           := 1;'||nlchr ;
       l_txt:=l_txt||'    l_zprr.name         := '''||dblnot(l_zprr.name)         ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.namef        := '''||dblnot(l_zprr.namef)        ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.bindvars     := '''||dblnot(l_zprr.bindvars)     ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.create_stmt  := '''||l_zprr.create_stmt          ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.rpt_template := '''||l_zprr.rpt_template         ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.form_proc    := '''||dblnot(l_zprr.form_proc)    ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.default_vars := '''||dblnot(l_zprr.default_vars) ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.bind_sql     := '''||dblnot(l_zprr.bind_sql)     ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.xml_encoding := '''||l_zprr.xml_encoding         ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.pkey         := l_zpr.pkey||''\1'';'||nlchr;

       l_zprr.txt := dblnot(l_zprr.txt);
       l_zprr.txt := replace (l_zprr.txt, nlchr, '''||nlchr||'||nlchr||'                           ''');

       dbms_lob.append(l_clob, l_txt);
       l_txt:='';
       l_txt:=l_txt||'    l_zprr.txt          := '''||l_zprr.txt                  ||''';'||nlchr;

       dbms_lob.append(l_clob, l_txt);
       l_txt:='';

       l_txt:=l_txt||'    l_zprr.xsl_data     := '''||dblnot(l_zprr.xsl_data)     ||''';'||nlchr;
       l_txt:=l_txt||'    l_zprr.xsd_data     := '''||dblnot(l_zprr.xsd_data)     ||''';'||nlchr;


       dbms_lob.append(l_clob, l_txt);
       l_txt:='';

       l_txt:=      nlchr;
       l_txt:=l_txt||'    if l_isnew = 1 then            '||nlchr;
       l_txt:=l_txt||'       insert into zapros values l_zprr;  '||nlchr;
       l_txt:=l_txt||'    else                           '||nlchr;
       l_txt:=l_txt||'       update zapros set name         = l_zprr.name,        '||nlchr;
       l_txt:=l_txt||'                         namef        = l_zprr.namef,       '||nlchr;
       l_txt:=l_txt||'                         bindvars     = l_zprr.bindvars,    '||nlchr;
       l_txt:=l_txt||'                         create_stmt  = l_zprr.create_stmt, '||nlchr;
       l_txt:=l_txt||'                         rpt_template = l_zprr.rpt_template,'||nlchr;
       l_txt:=l_txt||'                         form_proc    = l_zprr.form_proc,   '||nlchr;
       l_txt:=l_txt||'                         default_vars = l_zprr.default_vars,'||nlchr;
       l_txt:=l_txt||'                         bind_sql     = l_zprr.bind_sql,    '||nlchr;
       l_txt:=l_txt||'                         xml_encoding = l_zprr.xml_encoding,'||nlchr;
       l_txt:=l_txt||'                         txt          = l_zprr.txt,         '||nlchr;
       l_txt:=l_txt||'                         xsl_data     = l_zprr.xsl_data,    '||nlchr;
       l_txt:=l_txt||'                         xsd_data     = l_zprr.xsd_data     '||nlchr;
       l_txt:=l_txt||'       where pkey=l_zprr.pkey;                              '||nlchr;
       l_txt:=l_txt||'                                                            '||nlchr;
       l_txt:=l_txt||'    end if;                                                 '||nlchr;


       end if;

       l_txt:=l_txt||nlchr ;
       l_txt:=l_txt||'    ------------------------    '||nlchr ;
       l_txt:=l_txt||'    --  main query        --    '||nlchr ;
       l_txt:=l_txt||'    ------------------------    '||nlchr ;
       l_txt:=l_txt||'                                '||nlchr ;



       dbms_lob.append(l_clob, l_txt);
       l_txt:='';

       l_txt:=       '    l_zpr.id           := 1;'||nlchr ;
       l_txt:=l_txt||'    l_zpr.name         := '''||dblnot(l_zpr.name)         ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.namef        := '''||dblnot(l_zpr.namef)        ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.bindvars     := '''||dblnot(l_zpr.bindvars)     ||''';'||nlchr;

       l_zpr.create_stmt := dblnot(l_zpr.create_stmt);

       l_zpr.create_stmt :=  replace ( l_zpr.create_stmt, chr(13)||chr(10), nlchr );
       l_zpr.create_stmt :=  replace ( l_zpr.create_stmt, chr(13), nlchr);
       l_zpr.create_stmt :=  replace ( l_zpr.create_stmt, chr(10), nlchr);
       l_zpr.create_stmt :=  replace ( l_zpr.create_stmt, nlchr, '''||nlchr||'||nlchr||'                           ''' );

       l_txt:=l_txt||'    l_zpr.create_stmt  := '''||l_zpr.create_stmt          ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.rpt_template := '''||l_zpr.rpt_template         ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.form_proc    := '''||dblnot(l_zpr.form_proc)    ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.default_vars := '''||dblnot(l_zpr.default_vars) ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.bind_sql     := '''||dblnot(l_zpr.bind_sql)     ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.xml_encoding := '''||l_zpr.xml_encoding         ||''';'||nlchr;

       l_zpr.txt := dblnot(l_zpr.txt);
       l_zpr.txt := replace (l_zpr.txt, nlchr, '''||nlchr||'||nlchr||'                           ''' );


       dbms_lob.append(l_clob, l_txt);
       l_txt:='';
       l_txt:=l_txt||'    l_zpr.txt          := '''||l_zpr.txt                  ||''';'||nlchr;
       dbms_lob.append(l_clob, l_txt);
       l_txt:='';


       l_txt:=l_txt||'    l_zpr.xsl_data     := '''||dblnot(l_zpr.xsl_data)     ||''';'||nlchr;
       l_txt:=l_txt||'    l_zpr.xsd_data     := '''||dblnot(l_zpr.xsd_data)     ||''';'||nlchr;


       dbms_lob.append(l_clob, l_txt);
       l_txt:='';


       l_txt:=       nlchr;
       l_txt:=l_txt||'    if l_isnew = 1 then           '||nlchr;
       l_txt:=l_txt||'       insert into zapros values l_zpr;  '||nlchr;
       l_txt:=l_txt||'       l_message:=l_message||''Добавлен новый кат.запрос №''||l_zpr.kodz||''.''; '||nlchr;
       l_txt:=l_txt||'    else                           '||nlchr;
       l_txt:=l_txt||'       update zapros set name         = l_zpr.name,        '||nlchr;
       l_txt:=l_txt||'                         namef        = l_zpr.namef,       '||nlchr;
       l_txt:=l_txt||'                         bindvars     = l_zpr.bindvars,    '||nlchr;
       l_txt:=l_txt||'                         create_stmt  = l_zpr.create_stmt, '||nlchr;
       l_txt:=l_txt||'                         rpt_template = l_zpr.rpt_template,'||nlchr;
       l_txt:=l_txt||'                         form_proc    = l_zpr.form_proc,   '||nlchr;
       l_txt:=l_txt||'                         default_vars = l_zpr.default_vars,'||nlchr;
       l_txt:=l_txt||'                         bind_sql     = l_zpr.bind_sql,    '||nlchr;
       l_txt:=l_txt||'                         xml_encoding = l_zpr.xml_encoding,'||nlchr;
       l_txt:=l_txt||'                         txt          = l_zpr.txt,         '||nlchr;
       l_txt:=l_txt||'                         xsl_data     = l_zpr.xsl_data,    '||nlchr;
       l_txt:=l_txt||'                         xsd_data     = l_zpr.xsd_data     '||nlchr;
       l_txt:=l_txt||'       where pkey=l_zpr.pkey;                              '||nlchr;
       l_txt:=l_txt||'       l_message:=l_message||''Кат.запрос c таким ключем уже существует под №''||l_zpr.kodz||'', его параметры изменены.''; '||nlchr;
       l_txt:=l_txt||'                                                           '||nlchr;
       l_txt:=l_txt||'    end if;                                                '||nlchr;



       -- если деать вставку в REPORTS
       if p_repinsert = 1 then


       l_txt:=l_txt||nlchr;
       l_txt:=l_txt||'    ------------------------    '||nlchr ;
       l_txt:=l_txt||'    --  report            --    '||nlchr ;
       l_txt:=l_txt||'    ------------------------    '||nlchr ;
       l_txt:=l_txt||'                                '||nlchr ;


       dbms_lob.append(l_clob, l_txt);
       l_txt:='';

       l_txt:=       nlchr;
       l_txt:=l_txt||'    l_rep.name        :=''Empty'';'||nlchr;
       l_txt:=l_txt||'    l_rep.description :='''||l_zpr.name||''';'||nlchr;
       l_txt:=l_txt||'    l_rep.form        :='''|| case when lower(l_zpr.rpt_template) like '%frx' then 'frm_FastReport' else 'frm_UniReport' end ||''';'||nlchr;
       l_txt:=l_txt||'    l_rep.param       :=l_zpr.kodz||'','||get_report_param(p_kodz,p_reptype)||''';'||nlchr;
--mik  l_txt:=l_txt||'    l_rep.ndat        :='||(case when instr(l_zpr.bindvars,':sFdat2') = 0 then 1 else 2 end)||';'||nlchr;
       l_txt:=l_txt||'    l_rep.ndat        :='||bars_report.get_dates_count(l_zpr.bindvars)||';'||nlchr;
       l_txt:=l_txt||'    l_rep.mask        :='''||get_report_filemask(l_zpr.namef)||''';'||nlchr;
       l_txt:=l_txt||'    l_rep.usearc      :=0;'||nlchr;

       -- проверить есть ли такоая папка отчетов
       if  p_repfolder is not null then
           l_txt:=l_txt||'    begin                                                                        '||nlchr;
           l_txt:=l_txt||'        select idf into l_repfolder from reportsf where idf = '||p_repfolder||'; ' ||nlchr;
           l_txt:=l_txt||'    exception when no_data_found then                                            ' ||nlchr;
           l_txt:=l_txt||'        l_repfolder := null;                                                     ' ||nlchr;
           l_txt:=l_txt||'    end;                         '||nlchr;
           l_txt:=l_txt||'    l_rep.idf := l_repfolder;    '||nlchr;
       else
           l_txt:=l_txt||'    l_rep.idf         :=null;    '||nlchr;
       end if;




       -- фиксированный номер отчета
       if p_repfixid > 0 then


       l_txt:=l_txt||nlchr;
       l_txt:=l_txt||'    -- Фиксированный № печатного отчета   '||nlchr;
       l_txt:=l_txt||'    l_rep.id          := '||p_repfixid||';'||nlchr;



       l_txt:=l_txt||nlchr||nlchr;
       l_txt:=l_txt||'    if l_isnew = 1 then                     '||nlchr;
       l_txt:=l_txt||'       begin                                '||nlchr;
       l_txt:=l_txt||'          insert into reports values l_rep;        '||nlchr;
       l_txt:=l_txt||'          l_message:=l_message||nlchr||''Добавлен новый печ. отчет под №''||l_rep.id;'||nlchr;
       l_txt:=l_txt||'       exception when dup_val_on_index then  '||nlchr;
       l_txt:=l_txt||'           bars_error.raise_error(''REP'',14, to_char(l_rep.id));'||nlchr;
       l_txt:=l_txt||'       end;                                    '||nlchr;
       l_txt:=l_txt||'    else                                            '||nlchr;
       l_txt:=l_txt||'       begin                                        '||nlchr;
       l_txt:=l_txt||'          insert into reports values l_rep;         '||nlchr;
       l_txt:=l_txt||'          l_message:=l_message||nlchr||''Добавлен новый печ. отчет под №''||l_rep.id;'||nlchr;
       l_txt:=l_txt||'       exception when dup_val_on_index then         '||nlchr;
       l_txt:=l_txt||'          l_message:=l_message||nlchr||''Печатный отчет под №''||l_rep.id||'' изменен.'';'||nlchr;
       l_txt:=l_txt||'          update reports set                '||nlchr;
       l_txt:=l_txt||'             name        = l_rep.name,       '||nlchr;
       l_txt:=l_txt||'             description = l_rep.description,'||nlchr;
       l_txt:=l_txt||'             form        = l_rep.form,       '||nlchr;
       l_txt:=l_txt||'             param       = l_rep.param,      '||nlchr;
       l_txt:=l_txt||'             ndat        = l_rep.ndat,       '||nlchr;
       l_txt:=l_txt||'             mask        = l_rep.mask,       '||nlchr;
       l_txt:=l_txt||'             usearc      = l_rep.usearc,     '||nlchr;
       l_txt:=l_txt||'             idf         = l_rep.idf         '||nlchr;
       l_txt:=l_txt||'          where id=l_rep.id;                 '||nlchr;
       l_txt:=l_txt||'       end;                                  '||nlchr;
       l_txt:=l_txt||'    end if;                                  '||nlchr;

           -- номер отчета - не фиксированный
           else

       l_txt:=l_txt||nlchr||nlchr;
       l_txt:=l_txt||'    if l_isnew = 1 then                        '||nlchr;
       l_txt:=l_txt||'       l_isnewr:=1;                            '||nlchr;


              -- кат. отчет существовал обновим все отчеты,кот на него ссылаются
       l_txt:=l_txt||'    else                                        '||nlchr;
       l_txt:=l_txt||'       begin                                    '||nlchr;
       l_txt:=l_txt||'          select id into l_rep.id               '||nlchr;
       l_txt:=l_txt||'          from reports                          '||nlchr;
       l_txt:=l_txt||'          where substr(param, 1,instr(param,'','')-1)=to_char(l_zpr.kodz) '||nlchr;
       l_txt:=l_txt||'                and form='''|| case when lower(l_zpr.rpt_template) like '%frx' then 'frm_FastReport' else 'frm_UniReport' end ||'''      '||nlchr;
       l_txt:=l_txt||'                and rownum=1;                   '||nlchr;
       l_txt:=l_txt||'                                                '||nlchr;
       l_txt:=l_txt||'          l_message:=l_message||nlchr||''Существуют печатные отчеты, которые ссылаются на данный кат.запрос.'';'||nlchr;
       l_txt:=l_txt||'                                                '||nlchr;
       l_txt:=l_txt||'          update reports set                    '||nlchr;
       l_txt:=l_txt||'            name        = l_rep.name,           '||nlchr;
       l_txt:=l_txt||'            description = l_rep.description,    '||nlchr;
       l_txt:=l_txt||'            form        = l_rep.form,           '||nlchr;
       l_txt:=l_txt||'            param       = l_rep.param,          '||nlchr;
       l_txt:=l_txt||'            ndat        = l_rep.ndat,           '||nlchr;
       l_txt:=l_txt||'            mask        = l_rep.mask,           '||nlchr;
       l_txt:=l_txt||'            usearc      = l_rep.usearc,         '||nlchr;
       l_txt:=l_txt||'            idf         = l_rep.idf             '||nlchr;
       l_txt:=l_txt||'          where id in (                         '||nlchr;
       l_txt:=l_txt||'           select id from reports               '||nlchr;
       l_txt:=l_txt||'           where substr(param, 1,instr(param,'','')-1)=to_char(l_zpr.kodz) '||nlchr;
       l_txt:=l_txt||'           and form='''|| case when lower(l_zpr.rpt_template) like '%frx' then 'frm_FastReport' else 'frm_UniReport' end ||''');                             '||nlchr;
       l_txt:=l_txt||'                                                 '||nlchr;
       l_txt:=l_txt||'          l_message:=l_message||nlchr||''Печатные отчеты - изменены.'';'||nlchr;
       l_txt:=l_txt||'                                                 '||nlchr;
       l_txt:=l_txt||'       exception when no_data_found then         '||nlchr;
       l_txt:=l_txt||'          l_isnewr:=1;                           '||nlchr;
       l_txt:=l_txt||'       end;                                      '||nlchr;
       l_txt:=l_txt||'                                                 '||nlchr;
       l_txt:=l_txt||'     end if;                                     '||nlchr;
       l_txt:=l_txt||'                                                 '||nlchr;
       l_txt:=l_txt||'                                                 '||nlchr;
       l_txt:=l_txt||'     if l_isnewr = 1 then                        '||nlchr;
       l_txt:=l_txt||'        l_rep.id := bars_report.next_reportid;   '||nlchr;
       l_txt:=l_txt||'        begin                                    '||nlchr;
       l_txt:=l_txt||'           insert into reports values l_rep;     '||nlchr;
       l_txt:=l_txt||'           l_message:=l_message||nlchr||''Добавлен новый печ. отчет под №''||l_rep.id;'||nlchr;
       l_txt:=l_txt||'        exception when dup_val_on_index then     '||nlchr;
       l_txt:=l_txt||'           bars_error.raise_error(''REP'',13,to_char(l_rep.id));'||nlchr;
       l_txt:=l_txt||'        end;                                     '||nlchr;
       l_txt:=l_txt||'     end if;                                     '||nlchr;
       l_txt:=l_txt||'                                           '||nlchr;
       l_txt:=l_txt||'                                           '||nlchr;

           end if;

       end if;


       l_txt:=l_txt||'    bars_report.print_message(l_message);   '||nlchr;
       l_txt:=l_txt||'end;                                        '||nlchr;
       l_txt:=l_txt||'/                                           '||nlchr;
       l_txt:=l_txt||'                                            '||nlchr;
       l_txt:=l_txt||'commit;                                     '||nlchr;

       dbms_lob.append(l_clob, l_txt);
       p_clob_scrpt:=l_clob;

   end;





    ------------------------------------------------------------------
    --  EXPORT_TO_SCRIPT()
    --
    --     Создать сченарий по выгрузке кат. отчета.
    --     Полученный отвен положить во временную таблицу tmp_lob Для
    --     дальнейшей работы в Centur-е
    --
    --     p_kodz      -  код запроса
    --     p_repinsert -  делать ли вставку в reports
    --     p_repfixid  -  указанный код отчета
    --     p_reptype   -  тип отчета
    --     p_repfolder -  папка отчета
    --
    procedure export_to_script(
                  p_kodz            number,
                  p_repinsert       smallint,
                  p_repfixid        number,
                  p_reptype         smallint,
		  p_repfolder       number    default null)
    is
       l_clob clob;
    begin
       export_to_script(
                  p_kodz       => p_kodz,
                  p_repinsert  => p_repinsert,
                  p_repfixid   => p_repfixid,
                  p_reptype    => p_reptype,
                  p_repfolder  => p_repfolder,
                  p_clob_scrpt => l_clob);

       bars_lob.export_clob(l_clob);
       dbms_lob.freetemporary(l_clob);

    end;


    -----------------------------------------------------------------
    --  VALIDATE_NLSMASK()
    --
    --   Валидация коррекности введенной маски счета
    --   Проверяется следующее
    --   1) маска не должна начитнаться символами % и _
    --   2) маска должна содержать слева хотябы p_snum чисельных символов
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_mask    -  маска
    --   p_snum    - кол-во символов слева
    --
    procedure validate_nlsmask(p_mask varchar2, p_snum number default 4)
    is
       l_res   number;
       l_trace varchar2(1000) := G_TRACE||'validate_nlsmask: ';
    begin


       execute immediate ' select 1 from dual where  regexp_like('''|| p_mask||''' ,''[0-9]''||''{''||'||p_snum||'||''}'')' into l_res;

       /*if not regexp_like(p_mask ,'[0-9]'||'{'||p_snum||'}') then
          bars_error.raise_error(G_MODULE, 37, p_mask, to_char(p_snum));
       end if;
       */
    exception when no_data_found then
        bars_error.raise_error(G_MODULE, 37, p_mask, to_char(p_snum));
    end;




    -----------------------------------------------------------------
    --  VALIDATE_TWO_NLSMASKS()
    --
    --   Валидация коррекности двух введенных масок счтета c условием И или ИЛИ
    --   если и   - то проверка должна удовдетворять для двух счетов
    --   если или - то проверка должна удовдетворять хотя бы для одного счета
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_mask1      - маска 1
    --   p_snum1      - кол-во симолов слева для счета 1
    --   p_mask2      - маска 2
    --   p_snum2      - кол-во симолов слева для счета 2
    --   p_condition  - условие (принимает значения OR или AND)
    --
    procedure validate_two_nlsmasks(
               p_mask1 varchar2          ,
               p_snum1 number   default 4,
	       p_mask2 varchar2          ,
	       p_snum2 number   default 4,
	       p_condition varchar2 )
    is
       l_valid     number :=0;
       l_valid2     number :=0;
       l_condition  varchar2(100);

    begin

       l_condition := upper(p_condition);



       if l_condition <> 'AND' and  l_condition <> 'OR'  then
          bars_error.raise_error(G_MODULE, 39);
       end if;


       if p_condition = 'AND' then
          begin
	     validate_nlsmask(p_mask1, p_snum1);
          exception when others then
             bars_error.raise_error(G_MODULE, 40, sqlerrm);
          end;

          begin
	     validate_nlsmask(p_mask2, p_snum2);
          exception when others then
             bars_error.raise_error(G_MODULE, 41, sqlerrm);
          end;
	  return;
       end if;


       if p_condition = 'OR' then
          begin
	     validate_nlsmask(p_mask1, p_snum1);
	     return;
          exception when others then
             begin
	        validate_nlsmask(p_mask2, p_snum2);
	        return;
             exception when others then
                bars_error.raise_error(G_MODULE, 42, to_char(p_snum2));
             end;
          end;
       end if;


       return;
    end;


    -----------------------------------------------------------------
    --  VALIDATE_PERIOD()
    --
    --   Валидация коррекности ввода периода.
    --   Разница дат не должна превышать указанное число дней.
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_date1     - дата с
    --
    --   p_date2     - дата по
    --
    --   p_period    - кол-во дней, которое должно покрывать указанный период дат
    --
    procedure validate_period( p_date1  date,
                               p_date2  date,
			       p_period number )
    is
    begin
       if p_date1 > p_date2 then
          bars_error.raise_error(G_MODULE, 43, to_char(p_date1,'dd/mm/yyyy'), to_char(p_date2,'dd/mm/yyyy'));
       end if;

       if p_date2 - p_date1 > p_period then
          bars_error.raise_error(G_MODULE, 44, to_char(p_period), to_char(p_date2 - p_date1));
       end if;

    end;


    -----------------------------------------------------------------
    --  VALIDATE_MASKS_AND_PERIOD()
    --
    --
    --   1) Валидация коррекности двух введенных масок счтета c условием И или ИЛИ
    --      если p_condition =  'AND'  - то проверка должна удовдетворять для двух счетов
    --      если p_condition =  'OR'   - то проверка должна удовдетворять хотя бы для одного счета
    --   2) Если указан только первый счет - валидация одного счета
    --   3) Валидация указнного периода.  Разница дат не должна превышать указанное число дней.
    --   При неуспешной валидации выкидывается сообщение с соответсвующим текстом
    --
    --   p_mask1      - маска 1
    --   p_snum1      - кол-во симолов слева для счета 1
    --   p_mask2      - маска 2
    --   p_snum2      - кол-во симолов слева для счета 2
    --   p_condition  - условие (принимает значения OR или AND)
    --   p_date1      - дата 1
    --   p_date2      - дата 2
    --   p_period     - кол-во дней, которое должно покрывать указанный период дат
    --
    procedure validate_masks_and_period(
                                    p_mask1     varchar2,
                                    p_snum1     number    default 4,
                                    p_mask2     varchar2  default null,
                                    p_snum2     number    default 4,
				    p_condition varchar2  default null,
				    p_date1     date,
				    p_date2     date,
				    p_period    number )
    is
    begin
       if p_mask2 is null then
	  validate_nlsmask(p_mask1, p_snum1);
       else
          validate_two_nlsmasks(p_mask1, p_snum1,  p_mask2, p_snum2,   p_condition);
       end if;
       validate_period(p_date1,p_date2, p_period);
    end;


    -----------------------------------------------------------------
    --  ADD_REPORT_TO_SHEDULER()
    --
    --  Добавление отчета в список выполнения задач по-расписанию (task_list)
    --
    --      p_pkey      - ключ запроса
    --      p_reptype   - тип отчета
    --      p_paramlist - список параметров с ихними значениями для отчета, наприм. :sFdat1='gl.bd'
    --      p_username  - имя пользователя
    --      p_interval  - интервал срабатывания (в сек)
    --
    --      exec bars_report.add_report_to_sheduler(
    --           p_pkey      => '\BRS\SBM\REP\82',
    --           p_reptype   => 3,
    --           p_paramlist =>  ':sFdat1=''gl.bd''',
    --           p_username  => 'ABSADM',
    --           p_interval  => 10);
    --
    procedure add_report_to_sheduler(
                    p_pkey      varchar2,
                    p_reptype   rep_types.typeid%type,
                    p_paramlist varchar2,
                    p_username  varchar2,
                    p_interval  number)
    is
       l_kodz      number;
       l_taskid    number;
       l_userid    number;
       l_idkey     number;
       l_ord       number;
       l_taskname  task_list.name%type;
       l_fncname   task_list.function%type;
    begin
       select kodz, substr(name,1,100)
         into l_kodz, l_taskname
         from zapros
        where pkey  = p_pkey;

       l_fncname := 'ExportCatQuery('||l_kodz||','''','||p_reptype||',"'||p_paramlist||'",FALSE)';

       begin
          select task_id into l_taskid
            from task_list
           where function = l_fncname;
      exception when no_data_found then
         select nvl(max(task_id),0) + 1 into l_taskid from task_list;
         insert into task_list(task_id, name, function)
         values(l_taskid,l_taskname, l_fncname);
      end;

      begin
         select id into l_userid from staff$base where  logname = p_username;
      exception when no_data_found then
         bars_error.raise_nerror(G_MODULE, 'NO_SUCH_USERNAME', p_username);
      end;

   begin
      select task_id
        into l_taskid
        from task_staff
       where task_id = l_taskid and  id = l_userid;
   exception when no_data_found then

      select nvl(max(ord),0) +1 into l_ord
        from task_staff
       where id = l_userid;

      select nvl(max(idkey),0) + 1 into l_idkey from task_staff;

      insert into task_staff(ID, TASK_ID, ORD, INTERVAL, METHOD, TRIGGER_DATE, IDKEY)
      values (l_userid, l_taskid, l_ord, p_interval, null, null, l_idkey);
   end;

 end;


    -----------------------------------------------------------------
    --  MAKE_REPORT_DELIM
    --
    --  На основании запроса - отдать клоб, в который помещен
    --  результат выборки в сироку с разделителем
    --
    --  p_sqltxt      - текст запроса
    --  p_delimdesc   - описание структуры вывода
    --
    --
    procedure make_report_delim(
                    p_sqltxt         clob,
                    p_delimdesc      clob,
                    p_outclob    out clob)
    is
    begin
       null;
    end;



    -----------------------------------------------------------------
    --  FORM_REPORT_BLOB
    --
    --  на основании таблицы zapros + кодировка + тип отчета из rep_type
    --  сформировать blob отчета и отдать имя файла
    --  процедурадля веб сервиса по автоматическому формированиюотчетов на старте -финише
    --
    --  p_pkey        - код запроса из zapros
    --  p_reptype     - код типа отчета из rep_types
    --  p_encode      - кодировка из справочника
    --
    procedure form_report_blob(
        p_kodz           varchar2,
        p_encode         varchar2,
        p_reptype        number,
        p_filename   out varchar2,
        p_path       out varchar2,
        p_blob       out blob,
        p_report_date    in date default null)
    is
       l_row      zapros%rowtype;
       l_txt      varchar2(4000);
       l_datechr  varchar2(10);
       l_filename varchar2(1000);
       l_trace    varchar2(1000) :=  g_trace||'form_report_blob: ';
    begin
        bars_audit.log_info('bars_report.form_report_blob',
                            'p_kodz        : ' || p_kodz        || chr(10) ||
                            'p_encode      : ' || p_encode      || chr(10) ||
                            'p_reptype     : ' || p_reptype     || chr(10) ||
                            'p_report_date : ' || p_report_date);

       select * into l_row from zapros where kodz = p_kodz;
       if (p_report_date is not null) then
           gl.pl_dat(p_report_date);
       end if;
       execute immediate 'alter session set nls_date_format="dd/mm/yyyy"';
       l_datechr := to_char(gl.bd, 'dd/mm/yyyy');
       l_txt := replace (l_row.txt, ':sFdat1', ' to_char(gl.bd,''dd/mm/yyyy'') ');
       l_filename := trim(replace (l_row.namef, ':sFdat1',  'to_char(gl.bd,''dd/mm/yyyy'' )'));
       l_filename := case when substr(l_filename,1,1) = '=' then substr(l_filename, 2) else l_filename end;
       --l_filename := replace (l_filename,'''','''''');

       bars_audit.info(l_trace||'formula for file name: '||l_filename);

       --DBF формат
       if p_reptype = 201 then
           bars_dbf.dbf_from_sql( p_sql        => l_txt,
                                  p_dbfstruct  => l_row.create_stmt,
                                  p_encode     => p_encode,
                                  p_blobdbf    => p_blob);
       end if;


       begin
           execute immediate  'select '||l_filename||' from dual' into p_filename;
       exception when others then
          bars_audit.error(l_trace||'Некооректно указана формула для имени файла: '||l_filename);
          raise;
       end;
       p_path := branch_attribute_utl.get_value('TMS_REPORTS_DIR');
    end;




    -----------------------------------------------------------------
    --  FORM_REPORT_BY_WEBSERVICE
    --
    --  Сформировать отчет на основании zapros.kodz при помощи вызова веб сервиса.
    --  Формирование отчета проходит в каталог веб сервера в папку, указанную в параметре
    --
    procedure form_report_by_webservice( p_kodz            number,
                                         p_report_type     rep_types.typeid%type,
                                         p_report_encode   varchar2 default 'WIN',
                                         p_report_date     date default gl.bd()
                                       ) is

    l_authorization varchar2(4000);
    l_login         varchar2(400);
    l_password      varchar2(400);
    l_wallet_path   varchar2(4000);
    l_wallet_pass   varchar2(4000);
    l_request       clob;
    l_url           varchar2(4000);
    l_response      wsm_mgr.t_response;
    l_trace    varchar2(1000) :=  g_trace||'form_report_by_webservice: ';

    begin

      l_request := '{ "kodz": "'||p_kodz||'",  "encode": "'||p_report_encode||'",  "reptype": "'||p_report_type||'", "RepDate": "' || to_char(p_report_date, 'yyyy-mm-dd') || '" }';
      dbms_output.put_line(l_request);

      l_url         := branch_attribute_utl.get_value('LINK_FOR_ABSBARS_WEBAPISERVICES')||'FormReport/FormReportBlob';
      l_wallet_path := branch_attribute_utl.get_value('TMS_WALLET_PATH');
      l_wallet_pass := branch_attribute_utl.get_value('TMS_WALLET_PASS');
      l_login       := nvl(branch_attribute_utl.get_value('TMS_LOGIN'),'absadm01');
      l_password    := nvl(branch_attribute_utl.get_value('TMS_PASS'), 'qwerty');
      if (l_login is not null) then
        l_authorization := 'Basic ' ||
                           utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(l_login || ':' ||
                                                                                                 l_password)));
      end if;

      bars.wsm_mgr.prepare_request(p_url          => l_url,
                                   p_action       => null,
                                   p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                   p_wallet_path  => l_wallet_path,
                                   p_wallet_pwd   => l_wallet_pass,
                                   p_body         => l_request);

      if (l_authorization is not null) then
        bars.wsm_mgr.add_header(p_name  => 'Authorization',
                                p_value => l_authorization);
      end if;
      wsm_mgr.add_header(p_name  => 'Content-Type',
                         p_value => 'application/json; charset=utf-8');
      bars.wsm_mgr.execute_api(l_response);
      bars_audit.info(l_trace||'Сформирован кат.отчет №'||p_kodz||' через веб сервис. Ответ:'||l_response.cdoc);
    end;

end bars_report;
/
 show err;
 
PROMPT *** Create  grants  BARS_REPORT ***
grant EXECUTE                                                                on BARS_REPORT     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_REPORT     to QUERY_EDITOR;
grant EXECUTE                                                                on BARS_REPORT     to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_report.sql =========*** End ***
 PROMPT ===================================================================================== 
 