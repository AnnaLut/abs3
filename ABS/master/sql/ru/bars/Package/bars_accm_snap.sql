
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_accm_snap.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ACCM_SNAP 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет заполнения таблиц срезов состояний        --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    --                                                             --
    -- Типы данных                                                 --
    --                                                             --
    -----------------------------------------------------------------
    --
    -- Список заданий для формирования снимков баланса, индексированный датой YYYYMMDD
    --
    type t_joblist      is table of varchar2(30) index by varchar2(8);

    -----------------------------------------------------------------
    --                                                             --
    -- Константы                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- Идентификация версии
    --

    VERSION_HEADER       constant varchar2(64)  := 'version 1.10 06.06.2012';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';

    -- алгоритмы наполнения accm_snap_balances
    ALGORITHM_OLD        constant varchar2(30)  := 'OLD';
    ALGORITHM_SALNQC     constant varchar2(30)  := 'SALNQC';
    ALGORITHM_MIK        constant varchar2(30)  := 'ALGORITMIK';

    -- таблица оборотов в номинале по банковским датам
    TAB_SALDOA           constant varchar2(30)  := 'SALDOA';
    -- таблица оборотов в эквиваленте по банковским датам
    TAB_SALDOB           constant varchar2(30)  := 'SALDOB';
    -- таблица записей(ключей), удаленных из SALDOA
    TAB_SALDOA_DEL_ROWS  constant varchar2(30)  := 'SALDOA_DEL_ROWS';

    -- флаги состояний снимков баланса
    FLAG_CREATED        constant varchar2(30)   := 'CREATED';
    FLAG_RECREATED      constant varchar2(30)   := 'RECREATED';
    FLAG_REUSED         constant varchar2(30)   := 'REUSED';

    ----
    -- lock_day_snap - блокировка дневного снимка баланса
    --
    procedure lock_day_snap(
                  p_snapdtid in  number );

    ----
    -- unlock_day_snap - разблокирование дневного снимка баланса
    --
    procedure unlock_day_snap(
                  p_snapdtid in  number );

    ----
    -- lock_month_snap - блокирует месячный снимок баланса
    --
    procedure lock_month_snap(
                  p_snapdtid in  number );

    ----
    -- unlock_month_snap - разблокирует месячный снимок баланса
    --
    procedure unlock_month_snap(
                  p_snapdtid in  number );

    ----
    -- lock_year_snap - блокирует годовой снимок баланса
    --
    procedure lock_year_snap(
                  p_snapdtid in  number );

    ----
    -- unlock_year_snap - разблокирует годовой снимок баланса
    --
    procedure unlock_year_snap(
                  p_snapdtid in  number );

    ----
    -- set_day_snap_state - установка состояния снимка баланса
    --
    procedure set_day_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    );

    ----
    -- set_month_snap_state - установка состояния снимка баланса
    --
    procedure set_month_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    );

    ----
    -- set_year_snap_state - установка состояния снимка баланса
    --
    procedure set_year_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    );

    ----
    -- ask_day_snap_state - запрашиваем состояние дневного снимка баланса и scn его создания
    --
    procedure ask_day_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    );

    ----
    -- ask_month_snap_state - запрашиваем состояние месячного снимка баланса и scn его создания
    --
    procedure ask_month_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    );

    ----
    -- ask_year_snap_state - запрашиваем состояние годового снимка баланса и scn его создания
    --
    procedure ask_year_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    );

    ----
    -- set_day_call - установка scn, даты и времени обращения к дневному снимку баланса
    --
    procedure set_day_call(
        p_caldtid        in number,
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    );

    ----
    -- set_month_call - установка scn, даты и времени обращения к месячному снимку баланса
    --
    procedure set_month_call(
        p_caldtid        in number,
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    );

    ----
    -- set_year_call - установка scn, даты и времени обращения к годовому снимку баланса
    --
    procedure set_year_call(
        p_caldtid        in number,
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    );

    ----
    -- drop_obsolete_partitions - удаление устаревших партиций в accm_snap_balances
    --
    procedure drop_obsolete_partitions;

    ----
    -- get_algorithm - возвращает алгоритм наполнения accm_snap_balances
    --
    function get_algorithm return varchar2;

    ----
    -- set_algorithm - устанавливает алгоритм наполнения accm_snap_balances
    --
    procedure set_algorithm(p_algorithm in varchar2);

    ----
    -- get_mod_scn - возвращает scn последней модификации партиции указанной таблицы
    --
    function get_mod_scn(p_table in varchar2, p_date in date)
    return number;

    ----
    -- is_partition_modified - возвращает флаг 0/1 модификации партиции таблицы с момента p_scn
    --                         останавливает сканирование после первого положительного блока
    --
    function is_partition_modified(p_table in varchar2, p_date in date, p_scn in number)
    return number;

    ----
    -- get_snap_scn - возвращает scn последней генерации снимка баланса по партиции указанной таблицы
    --
    function get_snap_scn(p_table in varchar2, p_date in date)
    return number;

    ----
    -- set_snap_scn - устанавливает scn последней генерации снимка баланса по партиции указанной таблицы
    --
    procedure set_snap_scn(p_table in varchar2, p_date in date, p_scn in number);

    -----------------------------------------------------------------
    -- SNAP_BALANCE()
    --
    --     Создание/обновление снимков баланса
    --
    --     Параметры:
    --
    --         p_mode      Режим создания/обновления
    --
    --         p_bankdate  Банковская дата снимка
    --                     (для ручного режима)
    --
    procedure snap_balance(
                  p_snapdate    in  date,
                  p_snapmode    in  number,
                  p_requestscn  in number default null);


    -----------------------------------------------------------------
    -- SNAP_BALANCE_IN_JOB()
    --
    --     Создание/обновление снимков баланса в отдельном задании
    --
    --     Параметры:
    --
    --         p_mode      Режим создания/обновления
    --
    --         p_bankdate  Банковская дата снимка
    --                     (для ручного режима)
    --
    --         p_requestscn Снимок нужен не ниже данного SCN
    --
    --         p_jobname    Имя задания
    --
    procedure snap_balance_in_job(
                  p_snapdate    in  date,
                  p_snapmode    in  number,
                  p_requestscn  in  number default null,
                  p_jobname     out varchar2);

    -----------------------------------------------------------------
    -- SNAP_BALANCE_PERIOD()
    --
    --     Создание/обновление снимков баланса за период
    --
    --     Параметры:
    --
    --         p_startdate  Дата начала периода
    --
    --         p_finishdate Дата окончания периода
    --
    --         p_snapmode   Режим создания/обновления
    --                      0-полное, 1-частичное
    --
    procedure snap_balance_period(
                  p_startdate   in  date,
                  p_finishdate  in  date,
                  p_snapmode    in  number );



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


    ----
    -- get_max_bankdate - возвращает макс. банк. дату по всем балансам
    --
    function get_max_bankdate return date
    result_cache;

    ----
    -- get_prev_bankdate - возвращает предыдущую банковскую дату по отношению к переданной
    --
    function get_prev_bankdate(p_bankdate date) return date
    result_cache;

end bars_accm_snap;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ACCM_SNAP wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
d64e 3360
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
c2q1HUjHKpk=
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_accm_snap.sql =========*** End 
 PROMPT ===================================================================================== 
 