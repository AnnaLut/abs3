
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_error.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ERROR 
is

    -----------------------------------------------------------------
    --
    -- Пакет процедур и функций для работы с ошибками комплекса
    --
    --
    --
    --
    --


    -----------------------------------------------------------------
    --
    -- Константы
    --
    --
    --
    VERSION_HEADER        constant varchar2(64)  := 'version 1.04 01.10.2007';
    VERSION_HEADER_DEFS   constant varchar2(512) := '';

    SCOPE_SESSION         constant number        := 0;
    SCOPE_CONFIG          constant number        := 1;


    --
    -- Исключение
    --

    ERR    exception;
    pragma exception_init(ERR, -20097);




    -----------------------------------------------------------------
    -- RAISE_ERROR()
    --
    --     Процедура генерации ошибки с указанным кодом
    --
    --     Параметры:
    --
    --         p_errmod     Код модуля
    --
    --         p_errnum     Номер ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    procedure raise_error(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errnum  in  err_codes.err_code%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  );


    -----------------------------------------------------------------
    -- RAISE_ERROR()
    --
    --     Процедура генерации ошибки с указанным кодом
    --
    --     Параметры:
    --
    --         p_errcode    Код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    procedure raise_error(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  );



    -----------------------------------------------------------------
    -- RAISE_NERROR()
    --
    --     Процедура генерации ошибки с мнемоническим кодом
    --
    --     Параметры:
    --
    --         p_errcode    Код ошибки
    --
    --         p_errname    Мнемонический код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    procedure raise_nerror(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  );



    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     Функция получения строки ошибки по ее номеру
    --
    --     Параметры:
    --
    --         p_errmod     Код модуля
    --
    --         p_errnum     Номер ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    function get_error_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errnum  in  err_codes.err_code%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2;


    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     Функция получения строки ошибки по ее коду
    --
    --     Параметры:
    --
    --         p_errcode    Код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    function get_error_text(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2;

    -----------------------------------------------------------------
    -- GET_NERROR_TEXT()
    --
    --     Функция получения строки ошибки по ее мнемоническому коду
    --
    --     Параметры:
    --
    --         p_errmod     Код модуля
    --
    --         p_errname    Мнемонический код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    function get_nerror_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2;


    -----------------------------------------------------------------
    -- GET_ERROR_CODE()
    --
    --     Функция получения прикладной ошибки по тексту исключения
    --
    --     Параметры:
    --
    --         p_errtxt     Текст исключения
    --
    --
    --
    function get_error_code(
                  p_errtxt   in  varchar2 ) return varchar2;


    -----------------------------------------------------------------
    -- GET_NERROR_CODE()
    --
    --     Функция мнемонического кода ошибки по тексту исключения
    --
    --     Параметры:
    --
    --         p_errtxt     Текст исключения
    --
    --
    --
    function get_nerror_code(
                  p_errtxt   in  varchar2 ) return varchar2;



    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     Процедура получения описания ошибки по ее тексту
    --
    --     Параметры:
    --
    --         p_errtxt     Текст полученной ошибки
    --
    --         p_errumsg    Текст ошибки для пользователя
    --
    --         p_erracode   Код прикладной ошибки
    --
    --         p_erramsg    Текст прикладной ошибки
    --
    --         p_errahlp    Описание ошибки
    --
    --         p_modcode    Код модуля
    --
    --         p_modname    Наименование модуля
    --
    --         p_errmsg     Текст исходной ошибки
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  );


    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     Процедура получения описания ошибки по ее тексту для пользователя
    --
    --     Параметры:
    --
    --         p_errtxt     Текст полученной ошибки
    --
    --         p_errumsg    Текст ошибки для пользователя
    --
    --         p_erracode   Код прикладной ошибки
    --
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2);

    -----------------------------------------------------------------
    -- ADD_LANG()
    --
    --     Процедура добавления языка в справочник сообщений
    --
    --     Параметры:
    --
    --         p_lngcode    Код языка сообщений
    --
    --         p_lngname    Наименование языка сообщений
    --
    --         p_forceupd   Признак обновления, если существует
    --
    --
    --
    procedure add_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_lngname  in  err_langs.errlng_name%type,
                  p_forceupd in  number default 0           );

    -----------------------------------------------------------------
    -- ADD_MODULE()
    --
    --     Процедура добавления модуля в справочник сообщений
    --
    --     Параметры:
    --
    --         p_modcode    Код модуля
    --
    --         p_modname    Наименование модуля
    --
    --         p_forceupd   Признак обновления, если существует
    --
    --
    --
    procedure add_module(
                  p_modcode  in  err_modules.errmod_code%type,
                  p_modname  in  err_modules.errmod_name%type,
                  p_forceupd in  number default 0             );

    -----------------------------------------------------------------
    -- ADD_MESSAGE()
    --
    --     Процедура добавления текста сообщения об ошибке
    --     в справочник сообщений
    --
    --     Параметры:
    --
    --         p_modcode    Код модуля
    --
    --         p_errcode    Номер ошибки
    --
    --         p_lngcode    Код языка
    --
    --         p_errmsg     Текст сообщения об ошибке
    --
    --         p_errhlp     Текст описания ошибки
    --
    --         p_forceupd   Признак обновления, если существует
    --
    --
    --
    procedure add_message(
                  p_modcode  in  err_texts.errmod_code%type,
                  p_errcode  in  err_texts.err_code%type,
                  p_excpnum  in  err_codes.err_excpnum%type,
                  p_lngcode  in  err_texts.errlng_code%type,
                  p_errmsg   in  err_texts.err_msg%type,
                  p_errhlp   in  err_texts.err_hlp%type,
                  p_forceupd in  number default 0,
                  p_errname  in  err_codes.err_name%type default null);


    -----------------------------------------------------------------
    -- GET_LANG()
    --
    --     Функция получения текущего языка сообщений
    --
    --
    function get_lang return varchar2;

    -----------------------------------------------------------------
    -- SET_LANG()
    --
    --     Процедура установки текущего языка сообщений
    --
    --
    procedure set_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_scope    in  number  default SCOPE_SESSION );


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



end bars_error;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ERROR 
is


    -----------------------------------------------------------------
    --
    -- Константы
    --
    --
    VERSION_BODY      constant varchar2(64)  := 'version 1.09 11.11.2016';
    VERSION_BODY_DEFS constant varchar2(512) := '';


    --
    -- Формат предстваления кода ошибки
    --

    ERROR_PRFLEN   constant number      := 3;
    ERROR_NUMLEN   constant number      := 5;
    ERROR_NAMLEN   constant number      := 30;


    --
    -- Внутренние ошибки данного модуля (99800-99900)
    --

    ERRCODE_SYSTEM      constant varchar2(9)    := 'BRS-99800';
    ERRCODE_UNDEFINED   constant varchar2(9)    := 'BRS-99801';
    ERRCODE_INVALID     constant varchar2(9)    := 'BRS-99802';
    ERRCODE_DEVENV      constant varchar2(9)    := 'BRS-99803';
    ERRCODE_ACCESSVIO   constant varchar2(9)    := 'BRS-99804';
    ERRCODE_INVALIDLANG constant varchar2(9)    := 'BRS-99805';
    ERRCODE_UNDEFNAME   constant varchar2(9)    := 'BRS-99806';
    ERRCODE_INVALIDNAME constant varchar2(9)    := 'BRS-99807';
    ERRCODE_DUPLERRNAME constant varchar2(9)    := 'BRS-99808';
    ERRCODE_INTERNAL    constant varchar2(9)    := 'BRS-99999';



    --
    -- Умолчательный язык сообщений
    --

    LANG_DEFAULT        constant varchar2(3) := 'RUS';
    LANG_PARAMNAME      constant varchar2(8) := 'ERRLNG';


    --
    -- Номер исключения (сихронно с заголовком)
    --

    BARS_ERRNUM          constant number(5)     := -20097;




    -----------------------------------------------------------------
    --
    -- Глобальные типы пакета
    --
    --

    type narg is record (                  /*           тип именованого аргумента */
             name varchar2(30),            /*           имя именованого аргумента */
             value varchar2(2000));        /*      значение именованого аргумента */

    type nargs is table of narg;           /*   тип массива именованых аргументов */
    type args  is table of varchar2(2000); /*              тип массива аргументов */



    -----------------------------------------------------------------
    --
    -- Глобальные переменные пакета
    --
    --

    --
    -- Текущий язык сообщений
    --

    g_lngcode    err_langs.errlng_code%type;




    -----------------------------------------------------------------
    -- GET_ERROR_BASEMSG()
    --
    --     Функция получения строки ошибки по ее номеру
    --
    --     Параметры:
    --
    --         p_errnum     Номер ошибки
    --
    --         p_lngcode    Код языка
    --
    --
    function get_error_basemsg(
                 p_errmod  in  err_codes.errmod_code%type,
                 p_errnum  in  err_codes.err_code%type     )  return err_texts.err_msg%type
    is
    l_errmsg    err_texts.err_msg%type;  /* Базовое сообщение об ошибке */
    begin
        select err_msg into l_errmsg
          from err_texts
         where errmod_code = p_errmod
           and err_code    = p_errnum
           and errlng_code = g_lngcode;
        return l_errmsg;

    exception
        when NO_DATA_FOUND then
            begin
                select err_msg into l_errmsg
                  from err_texts
                 where errmod_code = p_errmod
                   and err_code    = p_errnum
                   and errlng_code = LANG_DEFAULT;
                return l_errmsg;
            exception
                when NO_DATA_FOUND then
                    bars_audit.trace('BARS_ERROR: Не определен текст для ошибки с номером %s для модуля %s', to_char(p_errnum), p_errmod);
                    return null;
            end;
    end get_error_basemsg;


    -----------------------------------------------------------------
    -- GET_ERROR_DESC()
    --
    --     Функция получения описания ошибки по ее коду
    --
    --     Параметры:
    --
    --         p_errcode    Код ошибки
    --
    --
    function get_error_desc(
                 p_errcode in  varchar2 )  return err_texts.err_hlp%type
    is
    l_errhlp    err_texts.err_hlp%type;      /*    Описание ошибки */
    begin
        select err_hlp into l_errhlp
          from err_texts
         where errmod_code = substr(p_errcode, 1, ERROR_PRFLEN)
           and err_code    = to_number(substr(p_errcode, ERROR_PRFLEN+2, ERROR_NUMLEN))
           and errlng_code = g_lngcode;
        return l_errhlp;
    exception
        when NO_DATA_FOUND then return null;
    end get_error_desc;


    -----------------------------------------------------------------
    -- GET_ERROR_USRMSG()
    --
    --     Функция получения текст сообщения для пользователя
    --     по полному тексту сообщения
    --
    --     Параметры:
    --
    --         p_erramsg   Текст сообщения об ошибке
    --
    --
    function get_error_usrmsg(
                 p_erramsg in  varchar2 )  return varchar2
    is
    begin
        return substr(p_erramsg, ERROR_PRFLEN+ERROR_NUMLEN+3);
    end get_error_usrmsg;


    -----------------------------------------------------------------
    -- GET_ERROR_MODULE()
    --
    --     Функция получения кода и имени модуля по коду ошибки
    --
    --     Параметры:
    --
    --         p_errcode  Код ошибки
    --
    --
    procedure get_error_module(
                 p_errcode in  varchar2,
                 p_modcode out varchar2,
                 p_modname out varchar2 )
    is
    begin
        select errmod_code, errmod_name
          into p_modcode, p_modname
          from err_modules
         where errmod_code = substr(p_errcode, 1, ERROR_PRFLEN);
    exception
        when NO_DATA_FOUND then null;
    end get_error_module;





    -----------------------------------------------------------------
    -- ADD_ARG_LIST()
    --
    --     Функция добавления аргумента в один из списков аргументов
    --     (неименованый аргумент или именованый аргумент)
    --
    --     Параметры:
    --
    --         p_prevarg    Значение предыдущего аргумента
    --
    --         p_thisarg    Значение текущего аргумента
    --
    --         p_nextarg    Значение следующего аргумента
    --
    --         p_list       Список неименованых аргументов
    --
    --         p_nlist      Список именованых аргументов
    --
    --
    procedure add_param_list(
                  p_prevarg   in      varchar2,
                  p_thisarg   in      varchar2,
                  p_nextarg   in      varchar2,
                  p_list      in out  args,
                  p_nlist     in out  nargs    )
    is

    l_recno   number;     /* счетчик размера списка */

    begin

        --
        -- Если предыдущий аргумент был именем именем именованого
        -- аргумента, то следующий (p_thisarg)  это его значение,
        -- которое мы внесли в список
        --
        if (p_prevarg is not null and substr(p_prevarg, 1, 1) = '$') then
            return;
        end if;

        --
        -- Если текущий аргумент пуст, то выходим
        --
        if (p_thisarg is null) then return;
        end if;


        --
        -- Проверяем является ли параметр p_thisarg именем именованого
        -- параметра
        --
        if (p_thisarg is not null and substr(p_thisarg, 1, 1) = '$') then

            -- добавляем в список именованых аргументов
            l_recno := p_nlist.count + 1;
            p_nlist.extend(1);
            p_nlist(l_recno).name  := substr(p_thisarg, 2, 30);
            p_nlist(l_recno).value := substr(p_nextarg, 1, 2000);

        else

            -- добавляем в список неименованых аргументов
            l_recno := p_list.count + 1;
            p_list.extend(1);
            p_list(l_recno) := substr(p_thisarg, 1, 2000);

        end if;

    end add_param_list;




    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     Функция получения строки ошибки по ее номеру
    --
    --     Параметры:
    --
    --         p_modcode    Код модуля
    --
    --         p_errnum     Номер ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    function get_error_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errnum  in  err_codes.err_code%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2
    is

    l_args     args     := args();         /*           массив аргументов ошибки  */
    l_nargs    nargs    := nargs();        /* массив именованых аргументов ошибки */
    l_argn     number;                     /*           номер текущего аргумента  */
    l_argc     number;                     /*           размер массива аргументов */

    l_src      err_texts.err_msg%type;     /*  базовое сообщение (из справочника) */
    l_pos      number;                     /* позиция в строке базового сообщения */
    l_dummy    number;                     /*                  буфер для проверки */

    l_errmsg   varchar2(4000);             /*                 Сообщение об ошибке */

    begin

        --
        -- Проверяем зарегистрирована ли ошибка
        --
        begin

            select 1 into l_dummy
              from err_codes
             where errmod_code = p_errmod
               and err_code    = p_errnum;

        exception
            when NO_DATA_FOUND then
                raise_error(ERRCODE_UNDEFINED, upper(p_errmod) || '-' || lpad(p_errnum, ERROR_NUMLEN, '0'));
        end;


        -- получаем базовое сообщение
        l_src := get_error_basemsg(p_errmod, p_errnum);

        -- создаем списки параметров
        add_param_list(    null, p_param1, p_param2, l_args, l_nargs);
        add_param_list(p_param1, p_param2, p_param3, l_args, l_nargs);
        add_param_list(p_param2, p_param3, p_param4, l_args, l_nargs);
        add_param_list(p_param3, p_param4, p_param5, l_args, l_nargs);
        add_param_list(p_param4, p_param5, p_param6, l_args, l_nargs);
        add_param_list(p_param5, p_param6, p_param7, l_args, l_nargs);
        add_param_list(p_param6, p_param7, p_param8, l_args, l_nargs);
        add_param_list(p_param7, p_param8, p_param9, l_args, l_nargs);
        add_param_list(p_param8, p_param9,     null, l_args, l_nargs);

        -- подставляем переменные
        l_pos  := 0;
        l_argn := 1;
        l_argc := l_args.count;

        --
        -- dbms_output.put_line('Not-named argument list:');
        -- dbms_output.put_line('------------------------');
        --
        -- if (l_args.count > 0) then
        --
        --     for i in l_args.first..l_args.last
        --     loop
        --         dbms_output.put_line('...arg[' || to_char(i) || ']=>' || l_args(i));
        --     end loop;
        --
        -- end if;
        --
        --
        -- dbms_output.put_line('Named argument list:');
        -- dbms_output.put_line('--------------------');
        --
        -- if (l_nargs.count > 0) then
        --
        --     for i in l_nargs.first..l_nargs.last
        --     loop
        --         dbms_output.put_line('...arg[' || l_nargs(i).name || ']=>' || l_nargs(i).value);
        --     end loop;
        --
        -- end if;
        --


        --
        -- Вставляем в сообщение неименованые аргументы
        --

        loop

            --
            -- получаем первую позицию символа %s
            --
            l_pos := instr(l_src, '%s');

            --
            -- Выходим, если символа нет (0, null) или уже
            -- подставили все возможные аргументы
            --
            exit when (l_pos = 0 or l_pos is null);

            --
            -- Переносим часть до указателя и текущий аргумент
            -- в выходное сообщение
            --
            l_errmsg := substr(l_errmsg || substr(l_src, 1, l_pos-1), 1, 4000);

            if (l_argn <= l_argc) then
                l_errmsg  := substr(l_errmsg || l_args(l_argn), 1, 4000);
            end if;

            l_src     := substr(l_src, l_pos+2);
            l_argn    := l_argn + 1;

        end loop;

        if (l_src is not null) then
            l_errmsg := l_errmsg || l_src;
        end if;

        -- dbms_output.put_line('after no-named=>' || l_errmsg);


        --
        -- Вставляем в сообщение именованые аргументы
        --
        for i in 1..l_nargs.count
        loop
            l_src := l_errmsg;
            l_pos := instr(l_src, '$(' || l_nargs(i).name || ')');

            if (l_pos is not null and l_pos != 0) then

                l_errmsg := substr(substr(l_src, 1, l_pos-1) || l_nargs(i).value, 1, 4000);
                l_errmsg := substr(l_errmsg || substr(l_src, l_pos + length(l_nargs(i).name) + 3), 1, 4000);

            end if;

        end loop;

        -- dbms_output.put_line('after named=>' || l_errmsg);


        -- создаем префикс
        l_errmsg := upper(p_errmod) || '-' || lpad(p_errnum, ERROR_NUMLEN, '0') || ' ' || l_errmsg;

        return l_errmsg;

    end get_error_text;



    -----------------------------------------------------------------
    -- GET_ERROR_TEXT()
    --
    --     Функция получения строки ошибки по ее коду
    --
    --     Параметры:
    --
    --         p_errcode    Код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    function get_error_text(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2
    is

    l_errmod  err_codes.errmod_code%type;  /*     Код модуля */
    l_errnum  err_codes.err_code%type;     /*   Номер ошибки */

    begin

        begin
            l_errmod := substr(p_errcode, 1, ERROR_PRFLEN);
            l_errnum := to_number(substr(p_errcode, ERROR_PRFLEN+2));
        exception
            when OTHERS then
                raise_error(ERRCODE_UNDEFINED, p_errcode);
        end;

        return get_error_text(
                  p_errmod  => l_errmod,
                  p_errnum  => l_errnum,
                  p_param1  => p_param1,
                  p_param2  => p_param2,
                  p_param3  => p_param3,
                  p_param4  => p_param4,
                  p_param5  => p_param5,
                  p_param6  => p_param6,
                  p_param7  => p_param7,
                  p_param8  => p_param8,
                  p_param9  => p_param9  );

    end get_error_text;


    -----------------------------------------------------------------
    -- GET_NERROR_TEXT()
    --
    --     Функция получения строки ошибки по ее мнемоническому коду
    --
    --     Параметры:
    --
    --         p_errmod     Код модуля
    --
    --         p_errname    Мнемонический код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    function get_nerror_text(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )  return varchar2
    is

    l_errnum   err_codes.err_code%type;   /* номер ошибки */


    begin

        begin
            select err_code into l_errnum
              from err_codes
             where errmod_code = p_errmod
               and err_name    = p_errname;
        exception
            when NO_DATA_FOUND then
                raise_error(ERRCODE_UNDEFINED, upper(p_errmod) || '-' || p_errname);
        end;

        return get_error_text(
                  p_errmod  => p_errmod,
                  p_errnum  => l_errnum,
                  p_param1  => p_param1,
                  p_param2  => p_param2,
                  p_param3  => p_param3,
                  p_param4  => p_param4,
                  p_param5  => p_param5,
                  p_param6  => p_param6,
                  p_param7  => p_param7,
                  p_param8  => p_param8,
                  p_param9  => p_param9  );

    end get_nerror_text;





  -----------------------------------------------------------------
  -- RAISE_ERROR()
  --
  --     Процедура генерации ошибки с указанным кодом
  --
  --     Параметры:
  --
  --         p_errmod     Код модуля
  --
  --         p_errnum     Номер ошибки
  --
  --         p_param<n>   Параметры, специфичные для ошибки
  --
  --
  procedure raise_error
  ( p_errmod  in  err_codes.errmod_code%type,
    p_errnum  in  err_codes.err_code%type,
    p_param1  in  varchar2 default null,
    p_param2  in  varchar2 default null,
    p_param3  in  varchar2 default null,
    p_param4  in  varchar2 default null,
    p_param5  in  varchar2 default null,
    p_param6  in  varchar2 default null,
    p_param7  in  varchar2 default null,
    p_param8  in  varchar2 default null,
    p_param9  in  varchar2 default null
  ) is

    l_excpnum  err_codes.err_excpnum%type; /* Номер исключения oracle */
    l_errmsg   varchar2(512);              /* Текст ошибки ( up to 2048 bytes long ) */

  begin

    begin

      select ERR_EXCPNUM
        into l_excpnum
        from ERR_CODES
       where ERRMOD_CODE = p_errmod
         and ERR_CODE    = p_errnum;

      if ( l_excpnum not between -20999 and -20001 )
      then
        l_excpnum := BARS_ERRNUM;
      end if;

    exception
      when NO_DATA_FOUND then

        bars_audit.trace('BARS_ERROR: Не определена ошибка с номером %s для модуля %s', to_char(p_errnum), p_errmod);

        if (p_errmod || '-' || lpad(to_char(p_errnum), ERROR_NUMLEN, '0') = ERRCODE_UNDEFINED)
        then
          raise_application_error(BARS_ERRNUM, 'internal error [error ERRCODE_UNDEFINED not found]');
        else
          raise_error( p_errcode => ERRCODE_UNDEFINED,
                       p_param1  => '[' || p_errmod || '-' || to_char(p_errnum) || ']',
                       p_param2  => '[' || p_param1  || ']',
                       p_param3  => '[' || p_param2  || ']'  );
        end if;

    end;

    l_errmsg := substr(get_error_text(p_errmod => p_errmod,
                                      p_errnum => p_errnum,
                                      p_param1 => p_param1,
                                      p_param2 => p_param2,
                                      p_param3 => p_param3,
                                      p_param4 => p_param4,
                                      p_param5 => p_param5,
                                      p_param6 => p_param6,
                                      p_param7 => p_param7,
                                      p_param8 => p_param8,
                                      p_param9 => p_param9), 1, 512);

    bars_audit.trace('err=%s', l_errmsg);
    bars_audit.error(l_errmsg);

    raise_application_error( l_excpnum, l_errmsg );

  end raise_error;

    -----------------------------------------------------------------
    -- RAISE_ERROR()
    --
    --     Процедура генерации ошибки с указанным кодом
    --
    --     Параметры:
    --
    --         p_errcode    Код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    procedure raise_error(
                  p_errcode in  varchar2,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )
    is

    l_errmod  err_codes.errmod_code%type;  /*     Код модуля */
    l_errnum  err_codes.err_code%type;     /*   Номер ошибки */

    begin

        begin
            l_errmod := substr(p_errcode, 1, ERROR_PRFLEN);
            l_errnum := to_number(substr(p_errcode, ERROR_PRFLEN+2));
        exception
            when OTHERS then

                raise_error(
                    p_errcode => ERRCODE_INVALID,
                    p_param1  => '[' || p_errcode || ']',
                    p_param2  => '[' || p_param1  || ']',
                    p_param3  => '[' || p_param2  || ']'  );

        end;


        raise_error(
            p_errmod  => l_errmod,
            p_errnum  => l_errnum,
            p_param1  => p_param1,
            p_param2  => p_param2,
            p_param3  => p_param3,
            p_param4  => p_param4,
            p_param5  => p_param5,
            p_param6  => p_param6,
            p_param7  => p_param7,
            p_param8  => p_param8,
            p_param9  => p_param9 );

    end raise_error;



    -----------------------------------------------------------------
    -- RAISE_NERROR()
    --
    --     Процедура генерации ошибки с мнемоническим кодом
    --
    --     Параметры:
    --
    --         p_errcode    Код ошибки
    --
    --         p_errname    Мнемонический код ошибки
    --
    --         p_param<n>   Параметры, специфичные для ошибки
    --
    --
    procedure raise_nerror(
                  p_errmod  in  err_codes.errmod_code%type,
                  p_errname in  err_codes.err_name%type,
                  p_param1  in  varchar2 default null,
                  p_param2  in  varchar2 default null,
                  p_param3  in  varchar2 default null,
                  p_param4  in  varchar2 default null,
                  p_param5  in  varchar2 default null,
                  p_param6  in  varchar2 default null,
                  p_param7  in  varchar2 default null,
                  p_param8  in  varchar2 default null,
                  p_param9  in  varchar2 default null  )
    is

    l_errnum   err_codes.err_code%type;    /* Код ошибки     */

    begin

        begin
            select err_code
              into l_errnum
              from err_codes
             where errmod_code = p_errmod
               and err_name    = p_errname;
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('BARS_ERROR: Не определена ошибка с именем %s для модуля %s', p_errname, p_errmod);

                if (p_errmod || '-' || p_errname = ERRCODE_UNDEFNAME) then
                    raise_application_error(BARS_ERRNUM, 'internal error [error ERRCODE_UNDEFINED not found]');
                else
                    raise_error(
                        p_errcode => ERRCODE_UNDEFNAME,
                        p_param1  => '[' || p_errmod || '-' || to_char(p_errname) || ']',
                        p_param2  => '[' || p_param1  || ']',
                        p_param3  => '[' || p_param2  || ']'  );
                end if;
        end;

        raise_error(
            p_errmod  => p_errmod,
            p_errnum  => l_errnum,
            p_param1  => p_param1,
            p_param2  => p_param2,
            p_param3  => p_param3,
            p_param4  => p_param4,
            p_param5  => p_param5,
            p_param6  => p_param6,
            p_param7  => p_param7,
            p_param8  => p_param8,
            p_param9  => p_param9 );

    end raise_nerror;



    -----------------------------------------------------------------
    -- GET_ERROR_CODE()
    --
    --     Функция получения прикладной ошибки по тексту исключения
    --
    --     Параметры:
    --
    --         p_errtxt     Текст исключения
    --
    --
    --
    function get_error_code(
                  p_errtxt   in  varchar2 ) return varchar2
    is
    begin
        return substr(p_errtxt, 12, ERROR_PRFLEN+ERROR_NUMLEN+1);
    end get_error_code;


    -----------------------------------------------------------------
    -- GET_NERROR_CODE()
    --
    --     Функция мнемонического кода ошибки по тексту исключения
    --
    --     Параметры:
    --
    --         p_errtxt     Текст исключения
    --
    --
    --
    function get_nerror_code(
                  p_errtxt   in  varchar2 ) return varchar2
    is

    l_errfcode  varchar2(20);                /* полный текстовый код ошибки */
    l_modcode   err_codes.errmod_code%type;  /* код модуля */
    l_errnum    err_codes.err_code%type;     /* номер ошибки */
    l_errname   err_codes.err_name%type;     /* мнемон. код ошибки */

    begin

        l_errfcode := get_error_code(p_errtxt);

        begin
            l_modcode := substr(l_errfcode, 1, ERROR_PRFLEN);
            l_errnum  := to_number(substr(l_errfcode, ERROR_PRFLEN+2));
        exception
            when OTHERS then return l_errfcode;
        end;

        begin
            select err_name into l_errname
              from err_codes
             where errmod_code = l_modcode
               and err_code    = l_errnum;
        exception
            when NO_DATA_FOUND then return l_errfcode;
        end;

        return l_modcode || '-' || l_errname;

    end get_nerror_code;




    -----------------------------------------------------------------
    -- GET_SYSERROR_INFO()
    --
    --     Процедура получения описания системной ошибки по ее тексту
    --
    --     Параметры:
    --
    --         p_errtxt     Текст полученной ошибки
    --
    --         p_errumsg    Текст ошибки для пользователя
    --
    --         p_erracode   Код прикладной ошибки
    --
    --         p_erramsg    Текст прикладной ошибки
    --
    --         p_errahlp    Описание ошибки
    --
    --         p_modcode    Код модуля
    --
    --         p_modname    Наименование модуля
    --
    --         p_errmsg     Текст исходной ошибки
    --
    --
    --
    procedure get_syserror_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  )
    is
    begin

        --
        -- На данный момент все ошибки из сред разработки
        -- показываются как внутренняя ошибка (BRS-99999)
        -- с первым параметром "Ошибка в среде разработки"
        -- (BRS-99803)
        --

        p_erracode := ERRCODE_INTERNAL;
        p_erramsg  := get_error_text(p_erracode, '[' || ERRCODE_DEVENV || ']');
        p_errmsg   := p_errtxt;
        p_errumsg  := get_error_usrmsg(p_erracode);

        --
        -- По новой ошибке получаем модуль
        --
        get_error_module(
            p_errcode  => p_erracode,
            p_modcode  => p_modcode,
            p_modname  => p_modname  );

        --
        -- Получаем описание ошибки
        --
        p_errahlp := get_error_desc(p_erracode);

    end get_syserror_info;




    -----------------------------------------------------------------
    -- GET_DBERROR_INFO()
    --
    --     Процедура получения описания системной ошибки по ее тексту
    --
    --     Параметры:
    --
    --         p_errtxt     Текст полученной ошибки
    --
    --         p_errumsg    Текст ошибки для пользователя
    --
    --         p_erracode   Код прикладной ошибки
    --
    --         p_erramsg    Текст прикладной ошибки
    --
    --         p_errahlp    Описание ошибки
    --
    --         p_modcode    Код модуля
    --
    --         p_modname    Наименование модуля
    --
    --         p_errmsg     Текст исходной ошибки
    --
    --
    --
    procedure get_dberror_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  )
    is

    CR           constant varchar2(1) := chr(10);

    l_excpnum    number;                     /*     Номер исключения oracle */
    l_errmsg     varchar2(4000);             /*    Текст ошибки для разбора */
    l_errmod     err_codes.errmod_code%type; /*                  Код модуля */
    l_errnum     err_codes.err_code%type;    /*                Номер ошибки */
    l_dummy      number;                     /*                       буфер */
    l_pos        number;                     /*  позиция подстан. параметра */
    l_arg        varchar2(4000);             /*     подстановочный аргумент */

    begin

        begin
            -- Определяем номер исключения
            l_excpnum := to_number(substr(p_errtxt, 5, 5));
        exception
            when OTHERS then

                -- Внутренняя ошибка
                p_erracode := ERRCODE_INTERNAL;
                p_erramsg  := get_error_text(p_erracode, '[' || ERRCODE_INVALID || ']');
                p_errmsg   := p_errtxt;
                p_errumsg  := get_error_usrmsg(get_error_text(p_erracode));

                --
                -- По новой ошибке получаем модуль
                --
                get_error_module(
                    p_errcode  => p_erracode,
                    p_modcode  => p_modcode,
                    p_modname  => p_modname  );

                --
                -- Получаем описание ошибки
                --
                p_errahlp := get_error_desc(p_erracode);

                return;
        end;

        if (l_excpnum < 20000 or l_excpnum > 20999) then

            --
            -- Системная ошибка
            --
            p_erracode := ERRCODE_SYSTEM;
            p_erramsg  := get_error_text(p_erracode, '[' || substr(p_errtxt, 1, 9) || ']');
            p_errmsg   := p_errtxt;
            p_errumsg  := get_error_usrmsg(get_error_text(p_erracode));


            --
            -- По новой ошибке получаем модуль
            --
            get_error_module(
                p_errcode  => p_erracode,
                p_modcode  => p_modcode,
                p_modname  => p_modname  );

            --
            -- Получаем описание ошибки
            --
            p_errahlp := get_error_desc(p_erracode);

            return;

        end if;


        -- Исключение прикладное, номер нас не интересует
        l_errmsg := substr(p_errtxt, 12);

        --
        -- Анализируем вид прикладной ошибки
        --
        if (substr(l_errmsg, 1, 1) = '\') then

            --
            -- Наш старый вариант (через S_ER)
            --

            p_erracode := 'BRS-0' || substr(l_errmsg, 2, 4);

            --
            -- По новой ошибке получаем модуль
            --
            get_error_module(
                p_errcode  => p_erracode,
                p_modcode  => p_modcode,
                p_modname  => p_modname  );

            begin
                select n_er  into p_errumsg
                  from s_er
                 where k_er = substr(l_errmsg, 2, 4);
            exception
                when NO_DATA_FOUND then
                    p_errumsg := substr(trim(regexp_replace(l_errmsg, '\\\d+')), 1, 250);
            end;

            --
            -- Подставляем параметры
            --
            l_pos := instr(l_errmsg, '#');

            if (l_pos is not null and l_pos != 0) then

                l_arg     := substr(l_errmsg, l_pos+1);
                if (nvl(instr(l_arg, CR), 0) != 0) then
                    l_arg := substr(l_arg, 1, instr(l_arg, CR)-1);
                end if;

                p_errumsg := p_errumsg || ' ' || l_arg;
            end if;

            p_erramsg := p_erracode || ' ' || p_errumsg;
            p_errahlp := null;
            p_errmsg  := p_errtxt;

        else

            --
            -- Проверяем формат кода ошибки
            --
            begin
                l_errmod := substr(l_errmsg, 1, ERROR_PRFLEN);
                l_errnum := to_number(substr(l_errmsg, ERROR_PRFLEN+2, ERROR_NUMLEN));
            exception
                when OTHERS then

                    -- Внутренняя ошибка
                    p_erracode := ERRCODE_INTERNAL;
                    p_erramsg  := get_error_text(p_erracode, '[' || ERRCODE_INVALID || ']');
                    p_errmsg   := p_errtxt;
                    p_errumsg  := get_error_usrmsg(get_error_text(p_erracode));

                    --
                    -- По новой ошибке получаем модуль
                    --
                    get_error_module(
                        p_errcode  => p_erracode,
                        p_modcode  => p_modcode,
                        p_modname  => p_modname  );

                    --
                    -- Получаем описание ошибки
                    --
                    p_errahlp := get_error_desc(p_erracode);

                    return;

            end;

            --
            -- Проверяем наличие ошибки
            --
            begin
                select 1 into l_dummy
                  from err_codes
                 where errmod_code = l_errmod
                   and err_code    = l_errnum;
            exception
                when NO_DATA_FOUND then

                    -- Внутренняя ошибка
                    p_erracode := ERRCODE_UNDEFINED;
                    p_erramsg  := get_error_text(p_erracode, substr(l_errmsg, 1, ERROR_PRFLEN+ERROR_NUMLEN+1));
                    p_errmsg   := p_errtxt;
                    p_errumsg  := get_error_usrmsg(p_erramsg);

                    --
                    -- По новой ошибке получаем модуль
                    --
                    get_error_module(
                        p_errcode  => p_erracode,
                        p_modcode  => p_modcode,
                        p_modname  => p_modname  );

                    --
                    -- Получаем описание ошибки
                    --
                    p_errahlp := get_error_desc(p_erracode);

                    return;

            end;

            -- Внутренняя ошибка
            p_erracode := substr(l_errmsg, 1, ERROR_PRFLEN+ERROR_NUMLEN+1);
            p_erramsg  := l_errmsg;
            p_errmsg   := p_errtxt;
            p_errumsg  := get_error_usrmsg(p_erramsg);

            --
            -- По новой ошибке получаем модуль
            --
            get_error_module(
                p_errcode  => p_erracode,
                p_modcode  => p_modcode,
                p_modname  => p_modname  );

            --
            -- Получаем описание ошибки
            --
            p_errahlp := get_error_desc(p_erracode);

        end if;

    end get_dberror_info;



    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     Процедура получения описания ошибки по ее тексту
    --
    --     Параметры:
    --
    --         p_errtxt     Текст полученной ошибки
    --
    --         p_errumsg    Текст ошибки для пользователя
    --
    --         p_erracode   Код прикладной ошибки
    --
    --         p_erramsg    Текст прикладной ошибки
    --
    --         p_errahlp    Описание ошибки
    --
    --         p_modcode    Код модуля
    --
    --         p_modname    Наименование модуля
    --
    --         p_errmsg     Текст исходной ошибки
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2,
                  p_errahlp  out varchar2,
                  p_modcode  out varchar2,
                  p_modname  out varchar2,
                  p_errmsg   out varchar2  )
    is
    begin

        if (substr(p_errtxt, 1, 4) != 'ORA-') then

            -- Источник ошибки не база данных
            get_syserror_info(
                p_errtxt   => p_errtxt,
                p_errumsg  => p_errumsg,
                p_erracode => p_erracode,
                p_erramsg  => p_erramsg,
                p_errahlp  => p_errahlp,
                p_modcode  => p_modcode,
                p_modname  => p_modname,
                p_errmsg   => p_errmsg   );

            return;

        else

            -- Источник ошибки база данных
            get_dberror_info(
                p_errtxt   => p_errtxt,
                p_errumsg  => p_errumsg,
                p_erracode => p_erracode,
                p_erramsg  => p_erramsg,
                p_errahlp  => p_errahlp,
                p_modcode  => p_modcode,
                p_modname  => p_modname,
                p_errmsg   => p_errmsg   );

            return;

        end if;

    end get_error_info;


    -----------------------------------------------------------------
    -- GET_ERROR_INFO()
    --
    --     Процедура получения описания ошибки по ее тексту для пользователя
    --
    --     Параметры:
    --
    --         p_errtxt     Текст полученной ошибки
    --
    --         p_errumsg    Текст ошибки для пользователя
    --
    --         p_erracode   Код прикладной ошибки
    --
    --
    --
    --
    procedure get_error_info(
                  p_errtxt   in  varchar2,
                  p_errumsg  out varchar2,
                  p_erracode out varchar2,
                  p_erramsg  out varchar2)
    is

    l_errahlp  err_texts.err_hlp%type;
    l_modcode  err_codes.errmod_code%type;
    l_modname  err_modules.errmod_name%type;
    l_errmsg   varchar2(8000);

    begin

        get_error_info(p_errtxt,
                       p_errumsg,
                       p_erracode,
                       p_erramsg,
                       l_errahlp,
                       l_modcode,
                       l_modname,
                       l_errmsg);
    end;

    -----------------------------------------------------------------
    -- CHECK_ADMIN_PRIVS()
    --
    --     Процедура проверки прав на добавление данные в справочники
    --
    --
    procedure check_admin_privs
    is
    begin

        if (sys_context('userenv', 'session_user') != 'BARS') then
            raise_error(ERRCODE_ACCESSVIO, sys_context('userenv', 'session_user'));
        end if;

    end check_admin_privs;



    -----------------------------------------------------------------
    -- ADD_LANG()
    --
    --     Процедура добавления языка в справочник сообщений
    --
    --     Параметры:
    --
    --         p_lngcode    Код языка сообщений
    --
    --         p_lngname    Наименование языка сообщений
    --
    --         p_forceupd   Признак обновления, если существует
    --
    --
    --
    procedure add_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_lngname  in  err_langs.errlng_name%type,
                  p_forceupd in  number  default 0            )
    is
    begin

        -- Проверяем права на изменение
        check_admin_privs;

        begin
            insert into err_langs(errlng_code, errlng_name)
            values (p_lngcode, p_lngname);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    update err_langs
                       set errlng_name = p_lngname
                     where errlng_code = p_lngcode;

                end if;

        end;

    end add_lang;


    -----------------------------------------------------------------
    -- ADD_MODULE()
    --
    --     Процедура добавления модуля в справочник сообщений
    --
    --     Параметры:
    --
    --         p_lngcode    Код модуля
    --
    --         p_lngname    Наименование модуля
    --
    --         p_forceupd   Признак обновления, если существует
    --
    --
    --
    procedure add_module(
                  p_modcode  in  err_modules.errmod_code%type,
                  p_modname  in  err_modules.errmod_name%type,
                  p_forceupd in  number default 0             )
    is
    begin

        -- Проверяем права на изменение
        check_admin_privs;

        begin
            insert into err_modules(errmod_code, errmod_name)
            values (p_modcode, p_modname);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    update err_modules
                       set errmod_name = p_modname
                     where errmod_code = p_modcode;

                end if;

        end;

    end add_module;


    -----------------------------------------------------------------
    -- ADD_MESSAGE()
    --
    --     Процедура добавления текста сообщения об ошибке
    --     в справочник сообщений
    --
    --     Параметры:
    --
    --         p_modcode    Код модуля
    --
    --         p_errcode    Номер ошибки
    --
    --         p_lngcode    Код языка
    --
    --         p_errmsg     Текст сообщения об ошибке
    --
    --         p_errhlp     Текст описания ошибки
    --
    --         p_forceupd   Признак обновления, если существует
    --
    --         p_errname    Мнемоническое имя ошибки
    --
    --
    procedure add_message(
                  p_modcode  in  err_texts.errmod_code%type,
                  p_errcode  in  err_texts.err_code%type,
                  p_excpnum  in  err_codes.err_excpnum%type,
                  p_lngcode  in  err_texts.errlng_code%type,
                  p_errmsg   in  err_texts.err_msg%type,
                  p_errhlp   in  err_texts.err_hlp%type,
                  p_forceupd in  number default 0,
                  p_errname  in  err_codes.err_name%type default null)
    is

    l_dummy    number;                   /*          временный буфер */
    l_errname  err_codes.err_name%type;  /* мнемонический код ошибки */

    begin

        -- Проверяем права на изменение
        check_admin_privs;

        if (p_errname is not null) then

            --
            -- Первый символ мнемонического кода
            -- не может быть цифрой
            --
            begin

                l_dummy := to_number(substr(p_errname, 1, 1));
                raise_error(ERRCODE_INVALIDNAME, p_errname);

            exception
                when OTHERS then null;
            end;

            l_errname := substr(p_errname, 1, ERROR_NAMLEN);

        else
            l_errname := to_char(p_errcode);
        end if;


        -- Добавляем в справочник кодов
        begin
            insert into err_codes(errmod_code, err_code, err_excpnum, err_name)
            values (p_modcode, p_errcode, p_excpnum, l_errname);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    begin
                        update err_codes
                           set err_excpnum = p_excpnum,
                               err_name    = l_errname
                         where errmod_code = p_modcode
                           and err_code    = p_errcode;
                    exception
                        when DUP_VAL_ON_INDEX then
                            raise_error(ERRCODE_DUPLERRNAME, p_modcode, l_errname);
                    end;

                end if;
        end;


        begin
            insert into err_texts(errmod_code, err_code, errlng_code, err_msg, err_hlp)
            values (p_modcode, p_errcode, p_lngcode, p_errmsg, p_errhlp);
        exception
            when DUP_VAL_ON_INDEX then

                if (p_forceupd = 1) then

                    update err_texts
                       set err_msg = p_errmsg,
                           err_hlp = p_errhlp
                     where errmod_code = p_modcode
                       and err_code    = p_errcode
                       and errlng_code = p_lngcode;

                end if;

        end;

    end add_message;


    -----------------------------------------------------------------
    -- READ_LANG()
    --
    --     Процедура получения установленного значения языка
    --
    --
    procedure read_lang
    is
    begin

        select substr(val, 1, 3) into g_lngcode
          from params
         where par = LANG_PARAMNAME;

    exception
        when NO_DATA_FOUND then
            g_lngcode := LANG_DEFAULT;
    end read_lang;

    -----------------------------------------------------------------
    -- CHK_LANG()
    --
    --     Процедура проверки наличия указанного языка
    --     в справочнике
    --
    procedure chk_lang(
                  p_lngcode  in  err_langs.errlng_code%type )
    is
    l_dummy    number;    /* буфер */
    begin

        select count(*) into l_dummy
          from err_langs
         where errlng_code = p_lngcode;

        if (l_dummy = 0) then
            raise_error(ERRCODE_INVALIDLANG, p_lngcode);
        end if;

    end chk_lang;


    -----------------------------------------------------------------
    -- GET_LANG()
    --
    --     Функция получения текущего языка сообщений
    --
    --
    function get_lang return varchar2
    is
    begin

        if (g_lngcode is null) then
            read_lang;
        end if;

        return g_lngcode;

    end get_lang;


    -----------------------------------------------------------------
    -- SET_LANG()
    --
    --     Процедура установки текущего языка сообщений
    --
    --
    procedure set_lang(
                  p_lngcode  in  err_langs.errlng_code%type,
                  p_scope    in  number                     )
    is

    l_dummy    number;    /* буфер */

    begin

        --
        -- Модифицируем либо в сессии, либо в параметрах
        --
        if    (p_scope = SCOPE_SESSION) then

            if (p_lngcode is null) then
                read_lang;
            else

                -- проверяем код языка
                chk_lang(p_lngcode);

                -- устанавливаем
                g_lngcode := p_lngcode;

            end if;

        elsif (p_scope = SCOPE_CONFIG ) then

            -- Проверяем права на модификацию
            check_admin_privs;

            -- проверяем код языка
            chk_lang(p_lngcode);

            -- изменяем параметр
            update params
               set val = p_lngcode
             where par = LANG_PARAMNAME;

            if (sql%rowcount = 0) then
                insert into params (par, val)
                values (LANG_PARAMNAME, p_lngcode);
            end if;

            -- устанавливаем
            g_lngcode := p_lngcode;

        end if;

    end set_lang;


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
        return 'package header BARS_ERROR ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_ERROR ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


begin
    read_lang;
end bars_error;
/
 show err;
 
PROMPT *** Create  grants  BARS_ERROR ***
grant EXECUTE                                                                on BARS_ERROR      to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_ERROR      to BARSAQ_ADM;
grant EXECUTE                                                                on BARS_ERROR      to BARSUPL;
grant EXECUTE                                                                on BARS_ERROR      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ERROR      to BASIC_INFO;
grant EXECUTE                                                                on BARS_ERROR      to DM;
grant EXECUTE                                                                on BARS_ERROR      to START1;
grant EXECUTE                                                                on BARS_ERROR      to UPLD;
grant EXECUTE                                                                on BARS_ERROR      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_error.sql =========*** End *** 
 PROMPT ===================================================================================== 
 