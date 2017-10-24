
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_lic.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_LIC 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет проверки лицензий комплекса               --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    --                                                             --
    -- Константы                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- Идентификация версии
    --

    VERSION_HEADER       constant varchar2(64)  := 'version 1.03 19.06.2009';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';




    -----------------------------------------------------------------
    -- VALIDATE_LIC()
    --
    --     Процедура проверки лицензии для входа пользователя
    -- 
    --     Параметры:
    --
    --         p_username   Имя учетной записи пользователя
    --
    --
    procedure validate_lic(
                  p_username  in  varchar2);


    -----------------------------------------------------------------
    -- REVALIDATE_LIC()
    --
    --     Процедура принудительной перепроверки лицензии
    -- 
    --
    --
    procedure revalidate_lic;


    -----------------------------------------------------------------
    -- SET_TRACE()
    --
    --     Процедура включения/отключения отладки пакета
    -- 
    --     Параметры:
    --
    --         p_enable   Признак включения/выключения
    --
    --         p_mode     Код включения/отключения
    --
    procedure set_trace(
                  p_enable  in  boolean,
                  p_mode    in  varchar2 );


    -----------------------------------------------------------------
    -- GET_USER_LICENSE()
    --
    --     Процедура получения информации о количестве свободных 
    --     пользовательских лицензий
    -- 
    --     Параметры:
    --
    --         p_permlicense  Кол-во свободных постоянных лицензий
    --
    --         p_templicense  Кол-во свободных временных лицензий
    --
    --
    procedure get_user_license(
                  p_permlicense  out number,
                  p_templicense  out number );

    -----------------------------------------------------------------
    -- SET_USER_LICENSE()
    --
    --     Процедура установки пользовательской лицензии для 
    --     указанного пользователя
    -- 
    --     Параметры:
    --
    --         p_username  Имя учетной записи пользователя
    --
    --
    procedure set_user_license(
                  p_username  in  varchar2 );


    -----------------------------------------------------------------
    -- GET_USER_LICENSESTATE()
    --
    --     Функция получения кода лицензии пользователя
    -- 
    --
    function get_user_licensestate(
                 p_username in varchar2 ) return number;


    -----------------------------------------------------------------
    -- SET_LICENSE()
    --
    --     Установка/обновление лицензионной информации
    -- 
    --
    procedure set_license(
                  p_bankcode   in  varchar2,
                  p_bankname   in  varchar2,
                  p_userlimit  in  number,
                  p_expiredate in  date,
                  p_authkey    in  varchar2 );


    -----------------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT()
    --
    --     Очистка глобального контекста для текущей сессии
    -- 
    --
    procedure clear_session_context;



    -----------------------------------------------------------------
    --                                                             --
    --  Методы идентификации версии                                --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция получения версии заголовка пакета
    --
    --
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция получения версии тела пакета
    --
    --
    --
    function body_version return varchar2;


end bars_lic;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_LIC 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет проверки лицензий комплекса               --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    --                                                             --
    -- Константы                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- Идентификация версии
    --

    VERSION_BODY         constant varchar2(64)  := 'version 1.10 09.09.2009';
    VERSION_BODY_DEFS    constant varchar2(512) := '';

    -- имя контекста
    LIC_CTX              constant varchar2(30)  := 'BARS_LIC';

    -- код модуля для ошибок и сообщений
    MODCODE              constant varchar2(3)   := 'SVC';

    -- переменные контекста
    SYSLIC_EXPDATE       constant varchar2(10)  := '1';
    SYSLIC_LICSTAT       constant varchar2(10)  := '2';
    SYSLIC_USRLIM        constant varchar2(10)  := '3';
    USRLIC_EXPDATE       constant varchar2(10)  := '100';
    USRLIC_LICSTAT       constant varchar2(10)  := '101';


    LICSTAT_CORRECT      constant number(1)     := 1;
    LICSTAT_INCORRECT    constant number(1)     := 0;

    -- типы размещения конф. параметров
    PARTYPE_ONETAB       constant number(1)     := 0;
    PARTYPE_TWOTAB       constant number(2)     := 1;

    -- имена конф. параметров
    PARNM_GLBBANK        constant varchar2(30)  := 'GLB-MFO';
    PARNM_BANKCODE       constant varchar2(30)  := 'MFO';
    PARNM_BANKNAME       constant varchar2(30)  := 'NAME';
    PARNM_EXPDATE        constant varchar2(30)  := 'EXPDATE';
    PARNM_USRLIMIT       constant varchar2(30)  := 'USRLIMIT';
    PARNM_AUTHKEY        constant varchar2(30)  := 'AUTHKEY';
    PARNM_BANKDATE       constant varchar2(30)  := 'BANKDATE';

    LICCACHE_LIFETIME    constant number        := 1;

    -- состояние пользователя (см. BARS_USERADM)
    USER_STATE_ACTIVE    constant number        :=  1;
    USER_STATE_DELETED   constant number        :=  0;

    USRLIC_TEMPORARY_LIFETIME constant number   := 31;
    USRLIC_TEMPORARY_LIMIT    constant number   := 0.05;

    -- коды состояний пользовательской лицензии
    USRLIC_STATE_VALID      constant number     :=  1;
    USRLIC_STATE_INVALID    constant number     := -1;



    -----------------------------------------------------------------
    --                                                             --
    -- Глобальные переменные                                       --
    --                                                             --
    -----------------------------------------------------------------

    g_inttrc    boolean;   -- Признак включения внутренней отладки
    g_partype   number;    -- Тип размещения конф. параметров












    -----------------------------------------------------------------
    -- ITRC()
    --
    --     Процедура записи отладочного сообщения
    --
    --     Параметры:
    --
    --         p_msg      Текст сообщения
    --
    --         p_arg<n>   Подстановочные параметры
    --
    --
    procedure itrc(
                  p_msg  in  varchar2,
                  p_arg1 in  varchar2  default null,
                  p_arg2 in  varchar2  default null,
                  p_arg3 in  varchar2  default null,
                  p_arg4 in  varchar2  default null,
                  p_arg5 in  varchar2  default null,
                  p_arg6 in  varchar2  default null,
                  p_arg7 in  varchar2  default null,
                  p_arg8 in  varchar2  default null,
                  p_arg9 in  varchar2  default null )
    is
    begin

        if (g_inttrc) then

            bars_audit.trace(
                  p_msg  => p_msg,
                  p_arg1 => p_arg1,
                  p_arg2 => p_arg2,
                  p_arg3 => p_arg3,
                  p_arg4 => p_arg4,
                  p_arg5 => p_arg5,
                  p_arg6 => p_arg6,
                  p_arg7 => p_arg7,
                  p_arg8 => p_arg8,
                  p_arg9 => p_arg9 );

        end if;

    end itrc;



    -----------------------------------------------------------------
    -- LOAD_DEFAULTS()
    --
    --     Процедура установки состояния пакета
    --
    --
    --
    procedure load_defaults
    is
    begin

      -- Отладка отключена
      g_inttrc := false;

      -- Определяем как размещены параметры
      select count(*) into g_partype
        from user_tables
       where table_name = 'PARAMS$GLOBAL';

      -- Перевірка на наявність таблиці BRANCH_ATTRIBUTE_VALUE для випадку коли
      -- таблиця PARAMS$GLOBAL замінена на вюху V_DEPRICATED_PARAMS$GLOBAL з синонімом ARAMS$GLOBAL
      If ( g_partype = 0 )
      then
        select count(*)
          into g_partype
          from USER_TABLES
         where TABLE_NAME = 'BRANCH_ATTRIBUTE_VALUE';
      end if;

    end load_defaults;



    -----------------------------------------------------------------
    -- IGETCTX()
    --
    --     Функция получения данных из контекста
    --
    --     Параметры:
    --
    --         p_ctxns    Раздел контекста (системный, пользов.)
    --
    --         p_ctxvar   Переменная контекста
    --
    function igetctx(
                 p_ctxns   in varchar2,
                 p_ctxvar  in varchar2 ) return varchar2
    is
    p          constant varchar2(30)   := 'lic.igetctx';
    l_ctxval   varchar2(250);
    begin
        itrc('%s: entry point par[0]=>%s par[1]=>%s', p, p_ctxns, p_ctxvar);
        l_ctxval := sys_context(LIC_CTX, p_ctxns || p_ctxvar);
        itrc('%s: succ end val=%s', p, l_ctxval);
        return l_ctxval;
    end igetctx;


    -----------------------------------------------------------------
    -- ISETCTX()
    --
    --     Процедура установки значения переменной контекста
    --
    --     Параметры:
    --
    --         p_ctxns    Раздел контекста (системный, пользов.)
    --
    --         p_ctxvar   Переменная контекста
    --
    --         p_ctxval   Значение переменной
    --
    procedure isetctx(
                 p_ctxns   in varchar2,
                 p_ctxvar  in varchar2,
                 p_ctxval  in varchar2 )
    is
    p    constant varchar2(30) := 'lic.isetctx';

    begin
        itrc('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', p, p_ctxns, p_ctxvar, p_ctxval);
        sys.dbms_session.set_context(LIC_CTX, p_ctxns || p_ctxvar, p_ctxval, null, sys_context('userenv', 'client_identifier'));
        itrc('%s: succ end', p);
    end isetctx;


    -----------------------------------------------------------------
    -- IGETPAR()
    --
    --     Функция получения конфигурационных параметров
    --
    --     Параметры:
    --
    --         p_parname  Имя параметра
    --
    --
    function igetpar(
                 p_parname in varchar2 ) return varchar2
    is
    p    constant varchar2(30) := 'lic.igetpar';

    l_val  params.val%type;
    begin
        itrc('%s: entry point par[0]=>%s', p, p_parname);

        select val into l_val
          from params
         where par = p_parname;
        itrc('%s: par val is %s', p, l_val);

        return l_val;
    exception
        when NO_DATA_FOUND then
            itrc('%s: param %s not found', p, p_parname);
            return null;
    end igetpar;


    -----------------------------------------------------------------
    -- IGETLPAR()
    --
    --     Функция получения локальных конфигурационных параметров
    --
    --     Параметры:
    --
    --         p_parname  Имя параметра
    --
    --         p_parkf    Код балансового отделения
    --
    function igetlpar(
                 p_parname in varchar2,
                 p_parkf   in varchar2 ) return varchar2
    is
    p    constant varchar2(30) := 'lic.igetlpar';

    l_val  params.val%type;
    begin
        itrc('%s: entry point par[0]=>%s par[1]=>%s', p, p_parname, p_parkf);

        if (g_partype = PARTYPE_ONETAB) then
            execute immediate 'select val from params where par = :par'
            into l_val using p_parname;
        else
            execute immediate 'select val from params$base where par = :par and kf = :kf'
            into l_val using p_parname, p_parkf;
        end if;
        itrc('%s: par val is %s', p, l_val);
        return l_val;
    exception
        when NO_DATA_FOUND then
            itrc('%s: param %s not found', p, p_parname);
            return null;
    end igetlpar;


    -----------------------------------------------------------------
    -- IGETGPAR()
    --
    --     Функция получения глобальных конфигурационных параметров
    --
    --     Параметры:
    --
    --         p_parname  Имя параметра
    --
    --
    function igetgpar(
                 p_parname in varchar2 ) return varchar2
    is
    p    constant varchar2(30) := 'lic.igetgpar';

    l_val  params.val%type;
    begin
        itrc('%s: entry point par[0]=>%s', p, p_parname);

        if (g_partype = PARTYPE_ONETAB) then
            execute immediate 'select val from params where par = :par'
             into l_val using p_parname;
        else
            execute immediate 'select val from params$global where par = :par'
             into l_val using p_parname;
        end if;
        itrc('%s: par val is %s', p, l_val);
        return l_val;
    exception
        when NO_DATA_FOUND then
            itrc('%s: param %s not found', p, p_parname);
            return null;
    end igetgpar;


    -----------------------------------------------------------------
    -- ISETLPAR()
    --
    --     Функция получения локальных конфигурационных параметров
    --
    --     Параметры:
    --
    --         p_parname  Имя параметра
    --
    --         p_parkf    Код балансового отделения
    --
    function isetlpar(
                 p_parname in varchar2,
                 p_parkf   in varchar2 ) return varchar2
    is
    p    constant varchar2(30) := 'lic.igetlpar';

    l_val  params.val%type;
    begin
        itrc('%s: entry point par[0]=>%s par[1]=>%s', p, p_parname, p_parkf);

        if (g_partype = PARTYPE_ONETAB) then
            execute immediate 'select val from params where par = :par'
            into l_val using p_parname;
        else
            execute immediate 'select val from params$base where par = :par and kf = :kf'
            into l_val using p_parname, p_parkf;
        end if;
        itrc('%s: par val is %s', p, l_val);
        return l_val;
    exception
        when NO_DATA_FOUND then
            itrc('%s: param %s not found', p, p_parname);
            return null;
    end isetlpar;


    -----------------------------------------------------------------
    -- ISETGPAR()
    --
    --     Установка глобальных конфигурационных параметров
    --
    --     Параметры:
    --
    --         p_parname  Имя параметра
    --
    --         p_parvalue Значение параметра
    --
    procedure isetgpar(
                 p_parname  in varchar2,
                 p_parvalue in varchar2 )
    is
    p    constant varchar2(30) := 'lic.isetgpar';
    begin
        itrc('%s: entry point par[0]=>%s par[1]=>%s', p, p_parname, p_parvalue);

        if (g_partype = PARTYPE_ONETAB) then
            execute immediate 'update params set val=:val where par=:par'
            using p_parvalue, p_parname;

            if (sql%rowcount = 0) then
                execute immediate 'insert into params (par, val) values (:par, :val)'
                using p_parname, p_parvalue;
            end if;

        else
            execute immediate 'update params$global set val=:val where par=:par'
            using p_parvalue, p_parname;

            if (sql%rowcount = 0) then
                execute immediate 'insert into params$global (par, val) values (:par, :val)'
                using p_parname, p_parvalue;
            end if;
        end if;
        itrc('%s: par val is set', p);

    end isetgpar;


    -----------------------------------------------------------------
    -- ISETLPAR()
    --
    --     Установка локальных конфигурационных параметров
    --
    --     Параметры:
    --
    --         p_parname  Имя параметра
    --
    --         p_parkf    Код балансового
    --
    --         p_parvalue Значение параметра
    --
    procedure isetlpar(
                 p_parname  in varchar2,
                 p_parkf    in varchar2,
                 p_parvalue in varchar2 )
    is
    p    constant varchar2(30) := 'lic.isetgpar';
    begin
        itrc('%s: entry point par[0]=>%s par[1]=>%s', p, p_parname, p_parvalue);

        if (g_partype = PARTYPE_ONETAB) then
            execute immediate 'update params set val=:val where par=:par'
            using p_parvalue, p_parname;

            if (sql%rowcount = 0) then
                execute immediate 'insert into params (par, val) values (:par, :val)'
                using p_parname, p_parvalue;
            end if;

        else
            execute immediate 'update params$base set val=:val where par=:par and kf = :kf'
            using p_parvalue, p_parname, p_parkf;

            if (sql%rowcount = 0) then
                execute immediate 'insert into params$base (par, val, kf) values (:par, :val, :kf)'
                using p_parname, p_parvalue, p_parkf;
            end if;
        end if;
        itrc('%s: par val is set', p);

    end isetlpar;


    -----------------------------------------------------------------
    -- IMAKE_KEYPART()
    --
    --     Функция создания части ключа по сформированному буферу
    --
    --     Параметры:
    --
    --         p_buf   Сформированный буфер (число)
    --
    function imake_keypart(
                 p_buf   in  number ) return varchar2
    is

    p          constant varchar2(30) := 'lic.imkkp';

    l_buf      number;                   /*                    локальный буфер */
    l_sbuf     varchar2(2);              /*    символьное представление буфера */
    l_ascii    number;                   /*  ASCII-код текущего символа буфера */
    l_keypart  varchar2(4);              /*         результирующая часть ключа */

    begin
        itrc('%s: entry point par[0]=>%s', p, to_char(p_buf));

        -- Приводим буфер к числу (две цифры)
        l_buf := p_buf;

        while (l_buf > 100)
        loop
            l_buf := mod(l_buf, 83);
        end loop;

        -- Получаем символьное представление
        l_sbuf := to_char(round(l_buf, 0));

        for i in 1..length(l_sbuf)
        loop
            l_ascii   := nvl(ascii(substr(l_sbuf, i, 1)), 0);
            l_keypart := l_keypart               ||
                         chr(65+(l_ascii-48)*2)  ||
                         substr(to_char(round(l_ascii-48, 0)), 1, 1);
        end loop;

        -- Выравниваем ключ до 4-х символов
        l_keypart := lpad(l_keypart, 4, '0');
        itrc('%s: succ end, key part is %s', p, l_keypart);

        return l_keypart;

    end imake_keypart;


    -----------------------------------------------------------------
    -- IMAKE_SYSKEY()
    --
    --     Функция создания лицензионного ключа по установленным
    --     конфигурационным параметрам
    --
    --
    function imake_syskey return varchar2
    is

    p               constant varchar2(30) := 'lic.imksk';
    salt            constant varchar2(10) := '^BYGVFb(q';

    type            t_num is table of number index by pls_integer;

    l_cpglbbank     varchar2(12);        /* Конф. параметр:   МФО главного банка */
    l_cpbankcode    varchar2(12);        /* Конф. параметр:            МФО банка */
    l_cpbankname    varchar2(100);       /* Конф. параметр:   наименование банка */
    l_cplicusrlim   number;              /* Конф. параметр: кол-во пользователей */
    l_cplicexpdate  date;                /* Конф. параметр:        дата лицензии */

    l_keybuf1       varchar2(4);         /*       буфер 1 для формирования ключа */
    l_keybuf2       varchar2(100);       /*       буфер 2 для формирования ключа */
    l_keybuf3       varchar2(100);       /*       буфер 3 для формирования ключа */
    l_keybuf4       varchar2(100);       /*       буфер 4 для формирования ключа */

    l_subbuf1       varchar2(100);       /*                    временный буфер 1 */
    l_subbuf2       varchar2(100);       /*                    временный буфер 2 */
    l_dig1          number;              /*           текущая цифра вр. буфера 1 */
    l_dig2          number;              /*           текущая цифра вр. буфера 2 */

    l_offset        number;              /*    дополн. смещение для 3-его буфера */
    l_offsets       t_num;               /*     массив смещений для 3-его буфера */

    l_key           varchar2(20);        /*     сформированный лицензионный ключ */

    begin
        itrc('%s: entry point', p);

        -- Инициализируем массив смещений
        l_offsets(1) := 1; l_offsets(2) := 3;  l_offsets(3) := 5;
        l_offsets(4) := 7; l_offsets(5) := 11; l_offsets(6) := 13; l_offsets(7) := 17;

        -- Получаем необходимые конфигурационные параметры
        l_cpglbbank    := substr(igetgpar(PARNM_GLBBANK), 1, 12);
        l_cpbankcode   := substr(igetlpar(PARNM_BANKCODE, l_cpglbbank), 1, 12);
        l_cpbankname   := substr(igetlpar(PARNM_BANKNAME, l_cpglbbank), 1, 50);
        l_cplicusrlim  := to_number(igetgpar(PARNM_USRLIMIT));
        l_cplicexpdate := to_date(igetgpar(PARNM_EXPDATE), 'dd/mm/yyyy');

        for i in 1..length(SALT)
        loop
           l_cpbankname := substr(l_cpbankname, 1, i*2) || substr(SALT, i, 1) || substr(l_cpbankname, i*2+1);
        end loop;

        -- Первая часть ключа
        l_keybuf1 := 'BARS';
        l_offset  := 0;
        -- Сводим всех к одному алгоритму
        --  if (substr(l_cpbankcode, 1, 1)= '8') then
        --      l_keybuf1 := 'BSKZ';
        --      l_offset  := 3;
        --  else
        --      l_keybuf1 := 'BARS';
        --      l_offset  := 0;
        --  end if;

        -- Вторая часть ключа
        l_keybuf2     := l_cpbankcode;

        -- Третья часть ключа
        for i in 1..7
        loop
            l_keybuf3 := l_keybuf3 ||
                         to_char(nvl(ascii(substr(l_cpbankname, l_offsets(i)+l_offset+1, 1)), 0));
        end loop;

        -- Четвертая часть ключа
        l_subbuf1 := to_char(l_cplicexpdate, 'yyyymmdd') || to_char(nvl(l_cplicusrlim, 0));

        for i in 1..length(l_subbuf1)
        loop
            l_subbuf2 := l_subbuf2 ||
                         to_char(nvl(ascii(substr(l_cpbankname, i, 1)), 0));
        end loop;

        l_subbuf2 := substr(l_subbuf2, 1, length(l_subbuf1));

        for i in 1..length(l_subbuf1)
        loop
            l_dig1 := to_number(substr(l_subbuf1, i, 1));
            l_dig2 := to_number(substr(l_subbuf2, i, 1));
            l_keybuf4 := l_keybuf4 ||
                         to_char(l_dig1+l_dig2-bitand(l_dig1, l_dig2) * 2);
        end loop;

        l_key := l_keybuf1                           || '-' ||
                 imake_keypart(to_number(l_keybuf2)) || '-' ||
                 imake_keypart(to_number(l_keybuf3)) || '-' ||
                 imake_keypart(to_number(l_keybuf4));

        itrc('%s: succ end, key is %s', p, l_key);

        return l_key;

    end imake_syskey;


    -----------------------------------------------------------------
    -- IMAKE_USRKEY()
    --
    --     Функция расчета контрольной суммы записи пользователя
    --     по имени его учетной записи
    --
    --     Параметры:
    --
    --         p_username    Имя учетной записи
    --
    --
    function imake_usrkey(
                 p_username in varchar2 ) return varchar2
    is

    p               constant varchar2(30)  := 'lic.imkuk';

    SALT_BUF1       constant varchar2(100) := 'Gwe24r(&^TZWdv';
    SALT_BUF2       constant varchar2(100) := 'H76(Y&%M 8999,';
    SALT_BUF3       constant varchar2(100) := '9w85 m^G%B*&/&';
    SALT_BUF4       constant varchar2(100) := '*7nh96B&G%57$Vz{)_N)(N52';

    l_rec           staff$base%rowtype;      /* запись с реквизитами пользователя */
    l_chksum        staff$base.chksum%type;  /*          контрольная сумма записи */
    l_usrcnt        number;                  /*              кол-во пользователей */

    l_buf1          varchar2(1000);          /*                    буфер данных 1 */
    l_buf2          varchar2(1000);          /*                    буфер данных 2 */
    l_buf3          varchar2(32);            /*                    буфер данных 3 */

    begin

        itrc('%s: entry point par[0]=>%s', p, p_username);

        select * into l_rec
          from staff$base
         where logname = p_username;

        select count(*) into l_usrcnt
          from staff$base
         where created < l_rec.created;

        l_buf1 := to_char(l_rec.id) || l_rec.logname || to_char(l_rec.active)
                  || to_char(l_rec.expired, 'ddmmyyyyhh24miss') || to_char(l_usrcnt)
                  || to_char(l_rec.created, 'ddmmyyyyhh24miss');

        l_buf2 := to_char(l_rec.id) || SALT_BUF1 || to_char(l_rec.active) ||
                  SALT_BUF2 || to_char(l_rec.expired, 'ddmmyyyyhh24miss') ||
                  SALT_BUF3 || l_rec.logname || SALT_BUF4 || to_char(l_usrcnt) ||
                  to_char(l_rec.created, 'ddmmyyyyhh24miss');

        l_buf3 := dbms_obfuscation_toolkit.md5(input_string=> l_buf1) ||
                  dbms_obfuscation_toolkit.md5(input_string=> l_buf2);

        l_chksum := to_hex(dbms_obfuscation_toolkit.md5(input_string=> l_buf3));

        itrc('%s: succ end, key is %s', p, l_chksum);
        return l_chksum;

    end imake_usrkey;


    -----------------------------------------------------------------
    -- IMAKE_USRTKEY()
    --
    --     Функция расчета временной контрольной суммы записи
    --     пользователя по имени его учетной записи
    --     Код должен совпадать с пакетом BARS_USERADM
    --
    --     Параметры:
    --
    --         p_username    Имя учетной записи
    --
    --
    function imake_usrtkey(
                 p_username in varchar2 ) return varchar2
    is

    p               constant varchar2(30)  := 'lic.imkutk';

    l_rec           staff$base%rowtype;      /* запись с реквизитами пользователя */
    l_chksum        staff$base.chksum%type;  /*          контрольная сумма записи */
    l_buf           varchar2(1000);          /*                      буфер данных */

    begin

        itrc('%s: entry point par[0]=>%s', p, p_username);

        select * into l_rec
          from staff$base
         where logname = p_username;

        l_buf := to_char(l_rec.id) || l_rec.logname || to_char(l_rec.active)
                 || to_char(l_rec.expired, 'ddmmyyyyhh24miss');

        l_chksum := to_hex(dbms_obfuscation_toolkit.md5(input_string=> l_buf));

        itrc('%s: succ end, key is %s', p, l_chksum);
        return l_chksum;

    end imake_usrtkey;




    -----------------------------------------------------------------
    -- ICHECK_SYSLIC()
    --
    --     Процедура проверки целостности лицензии
    --
    --
    --
    procedure icheck_syslic
    is

    p              constant varchar2(30) := 'lic.ichksyslic';

    l_expdate      date;              /*          дата устаревания рез. проверки */
    l_licstat      number(1);         /*                   код проверки лицензии */

    l_licexpdate   date;              /* Конф. параметр:  срок действия лицензии */
    l_licauthkey   varchar2(20);      /* Конф. параметр:           ключ лицензии */
    l_licusrlim    number(20);        /* Конф. параметр:    кол-во пользователей */
    l_bankdate     date;              /* Конф. параметр: текущая банковская дата */

    begin
        itrc('%s: entry point', p);

        -- Получаем конфигурационные параметры
        l_licexpdate := to_date(igetgpar(PARNM_EXPDATE), 'dd/mm/yyyy');
        l_licauthkey := substr(igetgpar(PARNM_AUTHKEY), 1, 20);
        l_licusrlim  := to_number(igetgpar(PARNM_USRLIMIT));
        l_bankdate   := to_date(igetpar(PARNM_BANKDATE), 'mm/dd/yyyy');

        -- Формируем ключ и сравниваем
        if (nvl(l_licauthkey, '-') != imake_syskey) then

            -- устанавливаем контекст
            isetctx('SYS', SYSLIC_EXPDATE, to_char(sysdate, 'yyyymmddhh24miss'));
            isetctx('SYS', SYSLIC_LICSTAT, to_char(LICSTAT_INCORRECT));

            -- генерируем ошибку
            bars_error.raise_nerror(MODCODE, 'LICENSE_INCORRECT');
        end if;

        -- Проверяем дату лицензии
        if ((nvl(l_licexpdate, sysdate-1) < sysdate) or
            (nvl(l_licexpdate, sysdate)   < nvl(l_bankdate, sysdate))) then

            -- устанавливаем контекст
            isetctx('SYS', SYSLIC_EXPDATE, to_char(sysdate, 'yyyymmddhh24miss'));
            isetctx('SYS', SYSLIC_LICSTAT, to_char(LICSTAT_INCORRECT));

            -- генерируем ошибку
            bars_error.raise_nerror(MODCODE, 'LICENSE_EXPIRED');

        end if;

        --
        l_licstat := LICSTAT_CORRECT;
        l_expdate := sysdate + LICCACHE_LIFETIME;

        itrc('%s: store values in ctx...', p);
        isetctx('SYS', SYSLIC_EXPDATE, to_char(l_expdate, 'yyyymmddhh24miss'));
        isetctx('SYS', SYSLIC_LICSTAT, to_char(l_licstat));
        isetctx('SYS', SYSLIC_USRLIM,  l_licusrlim );
        itrc('%s: values are stored in ctx.', p);

        itrc('%s: succ end', p);
    end icheck_syslic;


    -----------------------------------------------------------------
    -- ICHECK_USRLIC()
    --
    --     Процедура проверки целостности записи о пользователе
    --
    --
    --
    procedure icheck_usrlic(
                  p_username in  varchar2 )
    is

    p              constant varchar2(30) := 'lic.ichkusrlic';

    l_expdate      date;               /*          дата устаревания рез. проверки */
    l_licstat      number(1);          /*                   код проверки лицензии */
    l_bankdate     date;               /* Конф. параметр: текущая банковская дата */

    l_rec          staff$base%rowtype; /*      запись с реквизитами пользователя  */

    begin
        itrc('%s: entry point', p);

        -- Получаем конфигурационные параметры
        l_bankdate   := to_date(igetpar(PARNM_BANKDATE), 'mm/dd/yyyy');

        -- Получаем контрольную сумму записи пользователя
        select * into l_rec
          from staff$base
         where logname = p_username;

        -- Формируем ключ и сравниваем
        if (nvl(l_rec.chksum, '-') != imake_usrkey(p_username)) then

            -- устанавливаем контекст
            isetctx('SYS', USRLIC_EXPDATE, to_char(sysdate, 'yyyymmddhh24miss'));
            isetctx('SYS', USRLIC_LICSTAT, to_char(LICSTAT_INCORRECT));

            -- генерируем ошибку
            bars_error.raise_nerror(MODCODE, 'LICENSE_USER_INCORRECT', p_username);

        end if;

        -- Проверяем признак активности пользователя
        if (l_rec.active != USER_STATE_ACTIVE) then

            -- устанавливаем контекст
            isetctx('SYS', USRLIC_EXPDATE, to_char(sysdate, 'yyyymmddhh24miss'));
            isetctx('SYS', USRLIC_LICSTAT, to_char(LICSTAT_INCORRECT));

            -- генерируем ошибку
            bars_error.raise_nerror(MODCODE, 'LICENSE_USER_DELETED', p_username);
        end if;

        -- Проверяем срок действия временной учетной записи
        if (l_rec.expired is not null and
               (l_rec.expired < sysdate or l_rec.expired < l_bankdate-30 or
                l_rec.created > sysdate or l_rec.created > l_bankdate+30   )) then

            -- устанавливаем контекст
            isetctx('SYS', USRLIC_EXPDATE, to_char(sysdate, 'yyyymmddhh24miss'));
            isetctx('SYS', USRLIC_LICSTAT, to_char(LICSTAT_INCORRECT));

            -- генерируем ошибку
            bars_error.raise_nerror(MODCODE, 'LICENSE_USER_EXPIRED', p_username);

            -- end if;

        end if;

        --
        l_licstat := LICSTAT_CORRECT;
        l_expdate := sysdate + LICCACHE_LIFETIME;

        itrc('%s: store values in ctx...', p);
        isetctx('SYS', USRLIC_EXPDATE, to_char(l_expdate, 'yyyymmddhh24miss'));
        isetctx('SYS', USRLIC_LICSTAT, to_char(l_licstat));
        itrc('%s: values are stored in ctx.', p);

        itrc('%s: succ end', p);
    end icheck_usrlic;


    -----------------------------------------------------------------
    -- IVLD_SYSLIC()
    --
    --     Процедура общей проверки целостности лицензии
    --
    --
    --
    procedure ivld_syslic
    is

    p    constant varchar2(30) := 'lic.vldsyslic';

    l_expdate   date;        /* дата и время достоверности кэша состояния лицензии */
    l_licstat   number(1);   /*                             код состояния лицензии */

    begin
        itrc('%s: entry point', p);

        -- получаем дату и состояние лицензии
        l_expdate := to_date(igetctx('SYS', SYSLIC_EXPDATE), 'yyyymmddhh24miss');
        itrc('%s: license cache lifetime expired at %s',p, to_char(l_expdate, 'dd.mm.yyyy hh24:mi:ss'));

        if (nvl(l_expdate, sysdate) <= sysdate) then
            itrc('%s: license state in cache expired, try to check now...', p);
            icheck_syslic;
            itrc('%s: license validated.', p);
        else

            l_licstat := to_number(igetctx('SYS', SYSLIC_LICSTAT));
            itrc('%s: license state value in cache is %s', p, to_char(l_licstat));

            if (nvl(l_licstat, LICSTAT_INCORRECT) = LICSTAT_INCORRECT) then
                itrc('%s: license state in cache is incorrect, try to check now...', p);
                icheck_syslic;
                itrc('%s: license validated.', p);
            else
                itrc('%s: license state in cache is correct.', p);
            end if;

        end if;

        itrc('%s: succ end', p);

    end ivld_syslic;


    -----------------------------------------------------------------
    -- IVLD_USRLIC()
    --
    --     Процедура проверки лицензии пользователя
    --
    --     Параметры:
    --
    --         p_username  Имя учетной записи пользователя
    --
    procedure ivld_usrlic(
                  p_username in  varchar2 )
    is

    p    constant varchar2(30) := 'lic.vldusrlic';

    l_expdate   date;        /* дата и время срок действия кэша польз. лицензии */
    l_licstat   number(1);   /*                   код состояния польз. лицензии */

    begin
        itrc('%s: entry point par[0]=>%s', p, p_username);

        icheck_usrlic(p_username);

        -- получаем дату и состояние лицензии
        l_expdate := to_date(igetctx('SYS', USRLIC_EXPDATE), 'yyyymmddhh24miss');
        itrc('%s: user license cache lifetime expired at %s',p, to_char(l_expdate, 'dd.mm.yyyy hh24:mi:ss'));

        if (nvl(l_expdate, sysdate) <= sysdate) then
            itrc('%s: user license state in cache expired, try to check now...', p);
            icheck_usrlic(p_username);
            itrc('%s: user license validated.', p);
        else

            l_licstat := to_number(igetctx('SYS', USRLIC_LICSTAT));
            itrc('%s: user license state value in cache is %s', p, to_char(l_licstat));

            if (nvl(l_licstat, LICSTAT_INCORRECT) = LICSTAT_INCORRECT) then
                itrc('%s: user license state in cache is incorrect, try to check now...', p);
                icheck_usrlic(p_username);
                itrc('%s: user license validated.', p);
            else
                itrc('%s: user license state in cache is correct.', p);
            end if;

        end if;

        itrc('%s: succ end', p);

    end ivld_usrlic;



    -----------------------------------------------------------------
    -- VALIDATE_LIC()
    --
    --     Процедура проверки лицензии для входа пользователя
    --
    --     Параметры:
    --
    --         p_username   Имя учетной записи пользователя
    --
    --
    procedure validate_lic(
                  p_username  in  varchar2)
    is

    p    constant varchar2(30) := 'lic.vldlic';


    begin
        return;
        itrc('%s: entry point par[0]=>%s', p, p_username);

        -- проверка общей лицензии
        ivld_syslic;
        itrc('%s: sys lic is valid.', p);

        -- проверка лицензии пользователя
        if (p_username is not null) then
            ivld_usrlic(p_username);
            itrc('%s: user lic is valid.', p);
        else
            itrc('%s: user lic skipped, username not defined.', p);
        end if;

        itrc('%s: succ end', p);
    end validate_lic;


    -----------------------------------------------------------------
    -- SET_TRACE()
    --
    --     Процедура включения/отключения отладки пакета
    --
    --     Параметры:
    --
    --         p_enable   Признак включения/выключения
    --
    --         p_mode     Код включения/отключения
    --
    procedure set_trace(
                  p_enable  in  boolean,
                  p_mode    in  varchar2 )
    is
    begin
        -- TODO: написать проверку кода
        null;

        -- Устанавливаем признак отладки
        g_inttrc := p_enable;

    end set_trace;


    -----------------------------------------------------------------
    -- ISET_USRCHKSUM()
    --
    --     Процедура установки контрольной суммы на
    --     запись пользователя
    --
    --     Параметры:
    --
    --         p_username  Имя учетной записи пользователя
    --
    --         p_expire    Срок действия
    --
    procedure iset_usrchksum(
                  p_username  in  varchar2,
                  p_expire    in  date  default null   )
    is

    p    constant varchar2(30) := 'lic.isetucs';

    l_chksum   staff$base.chksum%type;

    begin
        itrc('%s: entry point par[0]=>%s', p, p_username, to_char(p_expire, 'dd.mm.yyyy'));

        update staff$base
           set expired = p_expire
         where logname = p_username;
        itrc('%s: expire date is set.', p);

        l_chksum := imake_usrkey(p_username);
        itrc('%s: chksum = %s', p, l_chksum);

        update staff$base
           set chksum = l_chksum
         where logname = p_username;
        itrc('%s: chksum is set.', p);

    end iset_usrchksum;

    -----------------------------------------------------------------
    -- ICALC_USRLIMIT()
    --
    --     Функция возвращает количество свободных лицензий
    --
    --
    function icalc_usrlimit return number
    is

    p    constant varchar2(30) := 'lic.icalcul';

    l_active  number := 0;
    l_free    number := 0;

    begin

        itrc('%s: entry point', p);

        for c in (select *
                    from staff$base)
        loop
            if (c.chksum = imake_usrkey(c.logname)) then
                if (c.active = USER_STATE_ACTIVE) then
                    l_active := l_active + 1;
                end if;
            else
                l_active := l_active + 1;
            end if;

        end loop;

        itrc('%s: active users %s', p, to_char(l_active));

        l_free := to_number(igetctx('SYS', SYSLIC_USRLIM)) - l_active;
        itrc('%s: succ end, free is %s', p, to_char(l_free));
        return l_free;

    end icalc_usrlimit;


    -----------------------------------------------------------------
    -- ICALC_USRLIMIT()
    --
    --     Процедура расчета количества доступных
    --     пользовательских лицензий
    --
    --     Параметры:
    --
    --         p_permlic   Кол-во доступных постоянных лицензий
    --
    --         p_templic   Кол-во доступных временных лицензий
    --
    --
    procedure icalc_usrlimit(
                  p_permlic  out number,
                  p_templic  out number  )
    is

    p    constant varchar2(30) := 'lic.icalcul';

    l_active  number := 0;
    l_free    number := 0;

    l_permlic number := 0;    /* кол-во активных пост. учетных записей */
    l_templic number := 0;    /* кол-во активных врем. учетных записей */
    l_badlic  number := 0;    /* кол-во   учетных записей без лицензии */

    begin
        itrc('%s: entry point', p);

        -- проходим по всем пользователям
        for c in (select *
                    from staff$base
                   where logname not in ('BARS', 'HIST', 'FINMON'))
        loop

            if (c.chksum = imake_usrkey(c.logname)) then

                -- флажкам верим
                if (c.active = USER_STATE_ACTIVE) then
                    if (c.expired is null) then
                        l_permlic := l_permlic + 1;
                    else
                        l_templic := l_templic + 1;
                    end if;
                end if;

            else
                -- отдельно считаем непроверенные
                l_badlic := l_badlic + 1;
            end if;

        end loop;

        itrc('%s: active users %s', p, to_char(l_active));

        l_free := to_number(igetctx('SYS', SYSLIC_USRLIM)) - l_active;
        itrc('%s: succ end, free is %s', p, to_char(l_free));
        return;

    end icalc_usrlimit;



    -----------------------------------------------------------------
    -- IGET_USRLICCNT()
    --
    --     Процедура получения информации о количестве свободных
    --     пользовательских лицензий
    --
    --     Параметры:
    --
    --         p_exclusr  Имя пользователя, которого исключить
    --
    --         p_permlic  Кол-во свободных постоянных лицензий
    --
    --         p_templic  Кол-во свободных временных лицензий
    --
    --
    procedure iget_usrliccnt(
                  p_exclusr  in  varchar2,
                  p_permlic  out number,
                  p_templic  out number   )
    is
/*
    p    constant varchar2(30) := 'lic.getulcnt';

    l_usrlim  number := 0;    \* кол-во       пользователей в лицензии *\
    l_permlic number := 0;    \* кол-во активных пост. учетных записей *\
    l_templic number := 0;    \* кол-во активных врем. учетных записей *\
    l_badlic  number := 0;    \* кол-во   учетных записей без лицензии *\
    l_tmplic  number := 0;    \* кол-во     превышенных пост. лицензии *\
*/

    begin
        p_permlic := 100000;
        p_templic := 100000;
/*
        itrc('%s: entry point par[0]=>%s', p, p_exclusr);

        -- получаем кол-во пользователей из лицензии
        l_usrlim := nvl(to_number(igetctx('SYS', SYSLIC_USRLIM)), 0);

        -- проходим по всем пользователям
        for c in (select *
                    from staff$base
                   where logname != nvl(p_exclusr, ' ')
                     and logname not in ('BARS', 'HIST', 'FINMON'))
        loop

            if (c.chksum = imake_usrkey(c.logname)) then

                -- флажкам верим
                if (c.active = USER_STATE_ACTIVE) then
                    if (c.expired is null) then
                        l_permlic := l_permlic + 1;
                    else
                        l_templic := l_templic + 1;
                    end if;
                end if;

            else
                -- отдельно считаем непроверенные
                l_badlic := l_badlic + 1;
            end if;

        end loop;

        itrc('%s: lics total: %s lics used: perm %s, temp %s, incorrect %s', p,
              to_char(l_usrlim), to_char(l_permlic), to_char(l_templic), to_char(l_badlic));

        p_permlic := l_usrlim - l_permlic - l_badlic;
        if (p_permlic < 0) then
            l_tmplic  := p_permlic;
            p_permlic := 0;
        end if;

        p_templic := round((l_usrlim * USRLIC_TEMPORARY_LIMIT)) - l_templic + l_tmplic;
        if (p_templic < 0) then
            p_templic := 0;
        end if;

        itrc('%s: succ end, return lics free: perm %s, temp %s', p, to_char(p_permlic), to_char(p_templic));
*/
    end iget_usrliccnt;











    -----------------------------------------------------------------
    -- GET_USER_LICENSE()
    --
    --     Процедура получения информации о количестве свободных
    --     пользовательских лицензий
    --
    --     Параметры:
    --
    --         p_permlicense  Кол-во свободных постоянных лицензий
    --
    --         p_templicense  Кол-во свободных временных лицензий
    --
    --
    procedure get_user_license(
                  p_permlicense  out number,
                  p_templicense  out number )
    is
    begin
        -- Проверяем системную лицензию
        validate_lic(null);
        iget_usrliccnt(null, p_permlicense, p_templicense);
    end get_user_license;


    -----------------------------------------------------------------
    -- SET_USER_LICENSE()
    --
    --     Процедура установки пользовательской лицензии
    --
    --     Параметры:
    --
    --         p_username  Имя учетной записи пользователя
    --
    --
    procedure set_user_license(
                  p_username  in  varchar2 )
    is

    p            constant varchar2(30) := 'lic.setucs';

    l_rec        staff$base%rowtype;     /*          реквизиты пользователя */
    l_permlic    number;                 /* кол-во пост. свободных лицензий */
    l_templic    number;                 /* кол-во врем. свободных лицензий */
    l_cnt        number;                 /*          счетчик учетн. записей */

    begin
        itrc('%s: entry point par[0]=>%s', p, p_username);

        -- Проверяем системную лицензию
        validate_lic(null);

        begin
            select * into l_rec
              from staff$base
             where logname = p_username;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'LICENSE_USERNAME_NOT_FOUND', p_username);
        end;
        itrc('%s: user req got', p);

        -- Если пользователь удален, то переподписываем если нет учетной записи
        if (l_rec.active != USER_STATE_ACTIVE) then

            itrc('%s: user state is inactive, checking login...', p);

            select count(*) into l_cnt
              from dba_users
             where username = p_username;
            itrc('%s: found %s account(s).', p, to_char(l_cnt));

            if (l_cnt > 0) then
                bars_error.raise_nerror(MODCODE, 'LICENSE_USERACCOUNT_EXISTS', p_username);
            end if;

            iset_usrchksum(p_username);
            itrc('%s: succ end point 1', p);
            return;

        else
            itrc('%s: user state is active', p);
        end if;

        -- Получаем свободные лицензии
        iget_usrliccnt(p_username, l_permlic, l_templic);
        itrc('%s: user perm lic is %s, user temp lic is %s', p, to_char(l_permlic), to_char(l_templic));

        -- Если свободные лицензии еще есть, то подписываем
        if (l_permlic > 0) then
            iset_usrchksum(p_username);
            itrc('%s: user license is set.', p);
            itrc('%s: succ end point 1', p);
            return;
        else
            -- выдаем ошибку для постоянной учетной записи
            if (l_rec.expired is null) then
                bars_error.raise_nerror(MODCODE, 'LICENSE_USER_EXCEEDLIMIT', p_username);
            end if;

        end if;

        -- Если свободных лицензий нет, то подписать можно только
        -- временные с установленным временным хэшем
        if (l_rec.expired <= sysdate+USRLIC_TEMPORARY_LIFETIME and nvl(l_rec.chksum, '-') = imake_usrtkey(p_username)) then

            if (l_templic > 0) then
                iset_usrchksum(p_username, l_rec.expired);
                itrc('%s: user temp license is set.', p);
            else
                bars_error.raise_nerror(MODCODE, 'LICENSE_USER_TEMPLIMITEXCEED', p_username);
            end if;

        else
            itrc('%s: temporary checksum is bad or expired date is too far', p);
            itrc('%s: %s %s %s %s', p, to_char(l_rec.id), l_rec.logname, to_char(l_rec.active), to_char(l_rec.expired, 'ddmmyyyyhh24miss'));
            bars_error.raise_nerror(MODCODE, 'LICENSE_USER_EXPIREPARAM', p_username);
        end if;

        itrc('%s: succ end', p);

    end set_user_license;


    -----------------------------------------------------------------
    -- GET_USER_LICENSESTATE()
    --
    --     Функция получения кода лицензии пользователя
    --
    --
    function get_user_licensestate(
                 p_username in varchar2 ) return number
    is

    p            constant varchar2(30) := 'lic.getuls';

    l_chk   staff$base.chksum%type;  /* контрольная сумма */

    begin
        return USRLIC_STATE_VALID;
        itrc('%s: entry point par[0]=>%s', p, p_username);

        begin
            select chksum into l_chk
              from staff$base
             where logname = p_username;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'LICENSE_USERNAME_NOT_FOUND', p_username);
        end;
        itrc('%s: user license is %s', p, l_chk);

        if (l_chk = imake_usrkey(p_username)) then
            itrc('%s: user licence is valid.', p);
            return USRLIC_STATE_VALID;
        else
            itrc('%s: user licence isnt valid.', p);
            return USRLIC_STATE_INVALID;
        end if;

    end get_user_licensestate;

    -----------------------------------------------------------------
    -- REVALIDATE_LIC()
    --
    --     Процедура принудительной перепроверки лицензии
    --
    --
    --
    procedure revalidate_lic
    is
    p    constant varchar2(30) := 'lic.revldlic';
    --
    l_errcnt  number := 0;
    l_errmsg  varchar2(4000);
    --
    l_permlic number := 0;
    l_templic number := 0;
    --
    begin
        itrc('%s: entry point par[0]=>%s', p);

        -- проверка общей лицензии
        icheck_syslic;
        itrc('%s: sys lic is valid.', p);

        -- переподписываем пользователей
        for c in (select logname, chksum
                    from staff$base
                  order by id       )
        loop
            begin
                if (c.chksum = imake_usrkey(c.logname)) then
                    itrc('%s: user account %s revalidated.', p, c.logname);
                else
                    set_user_license(c.logname);
                    commit;
                    itrc('%s: user account %s resigned.', p, c.logname);
                end if;
            exception
                when bars_error.err then
                    l_errcnt := l_errcnt + 1;
                    if (l_errcnt = 1) then
                        l_errmsg := sqlerrm;
                    end if;
            end;
        end loop;
        itrc('%s: user licenses revalidated.', p);

        get_user_license(l_permlic, l_templic);
        itrc('%s: free lics: perm %s, temp %s', p, to_char(l_permlic), to_char(l_templic));

        -- если есть свободные постоянные лицензии, то выполняем
        -- переводим временных учетных записей в постоянные
        if (l_permlic > 0) then

            for c in (select logname, chksum
                        from staff$base
                       where expired is not null
                         and active = USER_STATE_ACTIVE
                      order by created           )
            loop

                if (l_permlic > 0) then
                    -- проверяем ключ
                    if (c.chksum = imake_usrkey(c.logname)) then
                        iset_usrchksum(c.logname, null);
                        l_permlic := l_permlic - 1;
                        commit;
                        itrc('%s: temporary user account %s changed to permanent', p, c.logname);
                    else
                        itrc('%s: bad lic found, user account %s', p, c.logname);
                    end if;
                else
                    itrc('%s: user account %s not changed, license limit exceed', p, c.logname);
                end if;

            end loop;

        else
            itrc('%s: perm lic limit exceed, skip temp lic transferring step', p);
        end if;

        if (l_errcnt > 0) then
            bars_error.raise_nerror(MODCODE, 'LICENSE_REVALIDATE_USER_ERRORS', l_errmsg);
        end if;

        itrc('%s: succ end', p);

    end revalidate_lic;


    -----------------------------------------------------------------
    -- SET_LICENSE()
    --
    --     Установка/обновление лицензионной информации
    --
    --
    procedure set_license(
                  p_bankcode   in  varchar2,
                  p_bankname   in  varchar2,
                  p_userlimit  in  number,
                  p_expiredate in  date,
                  p_authkey    in  varchar2 )
    is
    p    constant varchar2(30) := 'lic.setlic';
    --
    l_cpglbbank    varchar2(12);
    l_cpbankcode   varchar2(12);
    --
    begin
        itrc('%s: entry point', p);


        if (g_partype = PARTYPE_ONETAB) then

            -- Если МФО установлено, то сверяем его МФО с лицензии
            l_cpbankcode := substr(igetpar(PARNM_BANKCODE), 1, 12);
            if (l_cpbankcode is not null and l_cpbankcode != p_bankcode) then
                bars_error.raise_nerror(MODCODE, 'LICENSE_MFO_MISMATCH', p_bankcode, l_cpbankcode);
            end if;

            -- Если МФО не установлено, то устанавливаем
            if (l_cpbankcode is null) then
                isetlpar(PARNM_BANKCODE, p_bankcode, p_bankcode);
            end if;

           -- Обновляем наименование
           isetlpar(PARNM_BANKNAME, p_bankcode, p_bankname);

        else

            -- Получаем параметр МФО ГБ
            l_cpglbbank := substr(igetgpar(PARNM_GLBBANK), 1, 12);

            -- Проверяем на совпадение
            if (l_cpglbbank is not null) then
                if (l_cpglbbank != p_bankcode) then
                    bars_error.raise_nerror(MODCODE, 'LICENSE_MFO_MISMATCH', p_bankcode, l_cpbankcode);
                end if;
            end if;

            -- проверяем есть ли такое МФО
            l_cpbankcode := substr(igetlpar(PARNM_BANKCODE, p_bankcode), 1, 12);

            -- такого МФО нет, ошибка
            if (l_cpbankcode is null or (l_cpbankcode is not null and l_cpbankcode != p_bankcode)) then
                bars_error.raise_nerror(MODCODE, 'LICENSE_MFO_NOTEXISTS', p_bankcode);
            end if;

            -- обновляем наименование
            isetlpar(PARNM_BANKNAME, p_bankcode, p_bankname);

            -- если параметра МФО ГБ не было, устанавливаем
            if (l_cpglbbank is null) then
                isetgpar(PARNM_GLBBANK, p_bankcode);
            end if;

        end if;

        -- Устанавливаем параметры
        isetgpar(PARNM_USRLIMIT, to_char(p_userlimit));
        isetgpar(PARNM_EXPDATE,  to_char(p_expiredate, 'dd/mm/yyyy'));
        isetgpar(PARNM_AUTHKEY,  p_authkey);
        itrc('%s: succ end', p);

    end set_license;



    -----------------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT()
    --
    --     Очистка глобального контекста для текущей сессии
    --
    --
    procedure clear_session_context
    is
    begin
        sys.dbms_session.clear_context(LIC_CTX, sys_context('userenv', 'client_identifier'));
    end clear_session_context;



    -----------------------------------------------------------------
    --                                                             --
    --  Методы идентификации версии                                --
    --                                                             --
    -----------------------------------------------------------------

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
        return 'package header BARS_LIC ' || VERSION_HEADER || chr(10) ||
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
        return 'package body BARS_LIC ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


begin
    load_defaults;
end bars_lic;
/
 show err;
 
PROMPT *** Create  grants  BARS_LIC ***
grant EXECUTE                                                                on BARS_LIC        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_LIC        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_lic.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 