
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_accm_sync.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ACCM_SYNC 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --         Пакет синхронизации накопительных таблиц            --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    --                                                             --
    -- Типы данных                                                 --
    --                                                             --
    -----------------------------------------------------------------

    subtype t_snap_mode  is number(1);

    subtype t_accmobjtype  is number;
    subtype t_accmobjname  is varchar2(30);
    subtype t_accmsyncmode is number(1);

    subtype t_accmsnapdate is date;


    -----------------------------------------------------------------
    --                                                             --
    -- Константы                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- Идентификация версии
    --

    VERSION_HEADER       constant varchar2(64)  := 'version 1.02 01.06.2011';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';

    --
    -- Режимы создания снимков
    --

    SNAPMODE_FULL        constant t_snap_mode   := 0;
    SNAPMODE_INCR        constant t_snap_mode   := 1;

    --
    -- Типы синхронизации
    --
    SYNCMODE_FULL        constant t_accmsyncmode := 0;
    SYNCMODE_INCR        constant t_accmsyncmode := 1;

    --
    -- Типы объектов
    --
    OBJTYPE_CALC         constant t_accmobjtype  := 1;
    OBJTYPE_SNAP         constant t_accmobjtype  := 2;

    -----------------------------------------------------------------
    -- ENQUEUE_MONBAL()
    --
    --     Добавление даты в очередь синхронизации накопительного
    --     баланса за месяц
    --
    --     Параметры:
    --
    --         p_fdat      Банковская дата
    --
    procedure enqueue_monbal(
                  p_fdat    in  date );

    -----------------------------------------------------------------
    -- ENQUEUE_YEARBAL()
    --
    --     Добавление даты в очередь синхронизации накопительного
    --     баланса за год
    --
    --     Параметры:
    --
    --         p_fdat      Банковская дата
    --
    procedure enqueue_yearbal(
                  p_fdat    in  date );


    -----------------------------------------------------------------
    -- ENQUEUE_FDAT()
    --
    --     Добавление банковского дня в очередь синхронизации
    --
    --     Параметры:
    --
    --         p_fdat      Банковская дата
    --
    --
    procedure enqueue_fdat(
                  p_fdat    in  date );


    -----------------------------------------------------------------
    -- ENQUEUE_CORRDOC()
    --
    --     Добавление корр. документа в очередь синхронизации
    --
    --     Параметры:
    --
    --         p_ref      Реф. корр. документа
    --
    --
    procedure enqueue_corrdoc(
                  p_ref    in  number );










    -----------------------------------------------------------------
    -- SYNC_CALC()
    --
    --     Обновление реквизитов объекта
    --
    --     Параметры:
    --
    --         p_objname   Имя объекта
    --
    procedure sync_calc(
                  p_objname  in  t_accmobjname,
                  p_syncmode in  t_accmsyncmode );


    -----------------------------------------------------------------
    -- SYNC_SNAP()
    --
    --     Синхронизация снимка объекта для указанной даты
    --
    --     Параметры:
    --
    --         p_objname   Имя объекта
    --
    --         p_snapdate  Дата снимка
    --
    --         p_snapmode  Тип синхронизации снимка
    --
    procedure sync_snap(
                  p_objname  in  t_accmobjname,
                  p_snapdate in  t_accmsnapdate,
                  p_snapmode in  t_accmsyncmode default SNAPMODE_INCR);

    -----------------------------------------------------------------
    -- SYNC_SNAP_PERIOD()
    --
    --     Синхронизация снимков объекта за период
    --
    --     Параметры:
    --
    --         p_objname    Имя объекта(BALANCE)
    --
    --         p_startdate  Дата начала периода
    --
    --         p_finishdate Дата окончания периода
    --
    --         p_snapmode   Тип синхронизации снимка
    --
    procedure sync_snap_period(
                  p_objname    in  t_accmobjname,
                  p_startdate  in  t_accmsnapdate,
                  p_finishdate in  t_accmsnapdate,
                  p_snapmode   in  t_accmsyncmode default SNAPMODE_INCR);

    -----------------------------------------------------------------
    -- SYNC_AGG()
    --
    --     Синхронизация агрегата объекта для указанной даты
    --
    --     Параметры:
    --
    --         p_objname   Имя объекта
    --
    --         p_snapdate  Дата снимка
    --
    --         p_snapmode  Тип синхронизации снимка
    --
    procedure sync_agg(
                  p_objname  in  t_accmobjname,
                  p_aggdate  in  t_accmsnapdate,
                  p_aggmode  in  t_accmsyncmode default SYNCMODE_INCR);








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


end bars_accm_sync;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ACCM_SYNC 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --         Пакет синхронизации накопительных таблиц            --
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

    VERSION_BODY       constant varchar2(64)  := 'version 1.06 14.05.2012';
    VERSION_BODY_DEFS  constant varchar2(512) := '';

    -- Код модуля
    MODCODE            constant varchar2(3)   := 'ACM';

    -- Префикс для трассировки
    PKG_CODE           constant varchar2(100) := 'accmsync';

    -- Имена конф. параметров
    CFGPAR_BANKDATE    constant varchar2(8)   := 'BANKDATE';


    -----------------------------------------------------------------
    -- ENQUEUE_MONBAL()
    --
    --     Добавление даты в очередь синхронизации накопительного
    --     баланса за месяц
    --
    --     Параметры:
    --
    --         p_fdat      Банковская дата
    --
    procedure enqueue_monbal(
                  p_fdat    in  date )
    is
    begin
        insert into accm_queue_monbals(fdat) values (trunc(p_fdat, 'mon'));
    exception
        when DUP_VAL_ON_INDEX then null;
    end enqueue_monbal;


    -----------------------------------------------------------------
    -- ENQUEUE_YEARBAL()
    --
    --     Добавление даты в очередь синхронизации накопительного
    --     баланса за год
    --
    --     Параметры:
    --
    --         p_fdat      Банковская дата
    --
    procedure enqueue_yearbal(
                  p_fdat    in  date )
    is
    begin
        insert into accm_queue_yearbals(fdat) values (trunc(p_fdat, 'year'));
    exception
        when DUP_VAL_ON_INDEX then null;
    end enqueue_yearbal;



    -----------------------------------------------------------------
    -- ENQUEUE_FDAT()
    --
    --     Добавление банковского дня в очередь синхронизации
    --
    --     Параметры:
    --
    --         p_fdat      Банковская дата
    --
    --
    procedure enqueue_fdat(
                  p_fdat    in  date )
    is
    begin
        insert into accm_queue_calendar(cal_date, bank_date, rep_date)
        values (p_fdat, p_fdat, p_fdat);
    exception
        when DUP_VAL_ON_INDEX then null;
    end enqueue_fdat;

    -----------------------------------------------------------------
    -- ENQUEUE_CORRDOC()
    --
    --     Добавление корр. документа в очередь синхронизации
    --
    --     Параметры:
    --
    --         p_ref      Реф. корр. документа
    --
    --
    procedure enqueue_corrdoc(
                  p_ref    in  number )
    is
    begin
        insert into accm_queue_corrdocs(ref) values (p_ref);
    exception
        when DUP_VAL_ON_INDEX then null;
    end enqueue_corrdoc;












    -----------------------------------------------------------------
    -- ADD_STATE_BANKDATE()
    --
    --     Добавление строки в таблицу банковских дат
    --
    --     Параметры:
    --
    --         p_bankdate  Банковская дата
    --
    procedure add_state_bankdate(
                  p_bankdate in  date )
    is
    --
    p                constant varchar2(100) := PKG_CODE || '.addsnapbdt';
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_bankdate, 'dd.mm.yyyy'));
--        insert into accm_state_fdat(fdat) values (p_bankdate);
        bars_audit.trace('%s: succ end, bankdate %s added', p, to_char(p_bankdate, 'dd.mm.yyyy'));
    exception
        when DUP_VAL_ON_INDEX then
            bars_audit.trace('%s: succ end, bankdate %s already exists', p, to_char(p_bankdate, 'dd.mm.yyyy'));
    end add_state_bankdate;


    -----------------------------------------------------------------
    -- LOCK_STATE_BANKDATE()
    --
    --     Блокировка банковской даты для обработки
    --
    --     Параметры:
    --
    --         p_bankdate  Банковская дата
    --
    procedure lock_state_bankdate(
                  p_bankdate in  date )
    is
    --
    p                constant varchar2(100) := PKG_CODE || '.lcksnapbdt';
    --
    l_dummy  number;
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_bankdate, 'dd.mm.yyyy'));
/*
        select 1 into l_dummy
          from accm_state_fdat
         where fdat = p_bankdate
        for update;
*/
        bars_audit.trace('%s: succ end, bankdate %s locked', p, to_char(p_bankdate, 'dd.mm.yyyy'));

    end lock_state_bankdate;





    -----------------------------------------------------------------
    --                                                             --
    --  Создание снимков                                           --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- CLEAR_BALANCE_SNAP()
    --
    --     Очистка снимка баланса за указанную дату
    --
    --     Параметры:
    --
    --         p_bankdate  Банковская дата снимка
    --
    procedure clear_balance_snap(
                  p_bankdate in  date )
    is
    --
    p                constant varchar2(100) := PKG_CODE || '.clrbalsnap';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_bankdate, 'dd.mm.yyyy'));

        -- Очищаем секцию
        execute immediate 'alter table accm_snap_balance truncate partition for date to_date(''' || to_char(p_bankdate, 'ddmmyyyy') || ''', ''ddmmyyyy'')';
        bars_audit.trace('%s: succ end', p);

    end clear_balance_snap;





    -----------------------------------------------------------------
    -- SNAP_BALANCE_FULL()
    --
    --     Создание снимка баланса за указанную дату
    --
    --     Параметры:
    --
    --         p_bankdate  Банковская дата снимка
    --
    procedure snap_balance_full(
                  p_bankdate in  date )
    is
    --
    p                constant varchar2(100) := PKG_CODE || '.snapbalfull';
    --
    l_dummy     number;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_bankdate, 'dd.mm.yyyy'));

        -- Добавляем банковскую дату (если ее нет)
        add_state_bankdate(p_bankdate);
        bars_audit.trace('%s: bankdate %s added to dict', p, to_char(p_bankdate, 'dd.mm.yyyy'));

        -- Блокируем банковскую дату
        lock_state_bankdate(p_bankdate);
        bars_audit.trace('%s: bankdate %s locked', p, to_char(p_bankdate, 'dd.mm.yyyy'));

        -- Очищаем данные за этот день
        clear_balance_snap(p_bankdate);
        bars_audit.trace('%s: balance snapshot cleared on bankdate %s', p, to_char(p_bankdate, 'dd.mm.yyyy'));

        -- Еще раз блокируем, т.к. при очистке выполняется неявный commit
        lock_state_bankdate(p_bankdate);
        bars_audit.trace('%s: bankdate %s locked (2)', p, to_char(p_bankdate, 'dd.mm.yyyy'));

        -- Создаем снимок





        null;



        bars_audit.trace('%s: succ end', p);

    end snap_balance_full;


    -----------------------------------------------------------------
    -- SNAP_BALANCE_QUEUE()
    --
    --     Обновление снимков балансов по указанную дату
    --
    --     Параметры:
    --
    --         p_bankdate  Банковская дата снимка
    --
    procedure snap_balance_queue(
                  p_bankdate in  date )
    is
    --
    p                constant varchar2(100) := PKG_CODE || '.snapbalque';
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_bankdate, 'dd.mm.yyyy'));

        null;

        bars_audit.trace('%s: succ end', p);

    end snap_balance_queue;













    -----------------------------------------------------------------
    -- VALIDATE_SYNCMODE()
    --
    --     Процедура проверки корректность задания
    --     режима синхронизации
    --
    --     Параметры:
    --
    --         p_syncmode  Тип синхронизации
    --
    procedure validate_syncmode(
                  p_syncmode in  t_accmsyncmode )
    is
    p                constant varchar2(100) := PKG_CODE || '.vldsyncmode';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_syncmode));

        if (p_syncmode is null or p_syncmode not in (SYNCMODE_FULL, SYNCMODE_INCR)) then
            bars_error.raise_nerror(MODCODE, 'INVALID_SYNCMODE');
        end if;
        bars_audit.trace('%s: succ end', p);

    end validate_syncmode;


    -----------------------------------------------------------------
    -- VALIDATE_OBJECT()
    --
    --     Процедура проверки корректность задания
    --     объекта
    --
    --     Параметры:
    --
    --         p_objname  Имя объекта
    --
    procedure validate_object(
                  p_objtype  in  t_accmobjtype,
                  p_objname  in  t_accmobjname )
    is
    p                constant varchar2(100) := PKG_CODE || '.vldobj';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_objtype), p_objname);

        -- TODO: необходим полноценный справочник
        if (p_objname is null or p_objname not in ('ACCOUNTS', 'CUSTOMERS', 'BALANCE')) then
            bars_error.raise_nerror(MODCODE, 'INVALID_OBJECT_NAME', p_objname, to_char(p_objtype));
        end if;
        bars_audit.trace('%s: succ end', p);

    end validate_object;


    -----------------------------------------------------------------
    -- VALIDATE_DATE()
    --
    --     Проверка корректности даты (наличие в календаре)
    --
    --     Параметры:
    --
    --         p_caldt    Календарная дата
    --
    --
    procedure validate_date(
                  p_caldt    in  date )
    is
    p                constant varchar2(100) := PKG_CODE || '.vldcaldt';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_caldt, 'dd.mm.yyyy'));

        -- TODO: необходимо проверить наличие даты в календаре

        bars_audit.trace('%s: succ end', p);

    end validate_date;





    -----------------------------------------------------------------
    -- SYNC_CALC()
    --
    --     Обновление реквизитов объекта
    --
    --     Параметры:
    --
    --         p_objname   Имя объекта
    --
    procedure sync_calc(
                  p_objname  in  t_accmobjname,
                  p_syncmode in  t_accmsyncmode )
    is
    p                constant varchar2(100) := PKG_CODE || '.synccalc';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, p_objname, to_char(p_syncmode));

        -- Проверяем корректность имени объекта
        validate_object(OBJTYPE_CALC, p_objname);
        bars_audit.trace('%s: object name validated.', p);

        -- Проверяем корректность задания режима
        validate_syncmode(p_syncmode);
        bars_audit.trace('%s: syncmode succ validated.', p);

        -- TODO: нужно будет делать по справочнику
        if (p_syncmode = SYNCMODE_FULL) then

            null;
            -- if    (p_objname = 'CUSTOMERS') then bars_accm_calc.resync_customers;
            -- elsif (p_objname = 'ACCOUNTS' ) then bars_accm_calc.resync_accounts;
            -- end if;

        else
            null;
        end if;

        bars_audit.trace('%s: succ end', p);

    end sync_calc;



    -----------------------------------------------------------------
    -- SYNC_SNAP()
    --
    --     Синхронизация снимка объекта для указанной даты
    --
    --     Параметры:
    --
    --         p_objname   Имя объекта
    --
    --         p_snapdate  Дата снимка
    --
    --         p_snapmode  Тип синхронизации снимка
    --
    procedure sync_snap(
                  p_objname  in  t_accmobjname,
                  p_snapdate in  t_accmsnapdate,
                  p_snapmode in  t_accmsyncmode default SNAPMODE_INCR)
    is
    p                constant varchar2(100) := PKG_CODE || '.syncsnap';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, p_objname, to_char(p_snapdate, 'dd.mm.yyyy'));

        -- Проверяем корректность имени объекта
        validate_object(OBJTYPE_SNAP, p_objname);
        bars_audit.trace('%s: object name validated.', p);

        -- Проверяем корректность задания режима
        validate_date(p_snapdate);
        bars_audit.trace('%s: snapdate succ validated.', p);

        if (p_objname = 'BALANCE') then
            bars_accm_calendar.sync_calendar;
            bars_accm_snap.snap_balance(p_snapdate, p_snapmode);
        end if;
        bars_audit.trace('%s: succ end', p);


    end sync_snap;

    -----------------------------------------------------------------
    -- SYNC_SNAP_PERIOD()
    --
    --     Синхронизация снимков объекта за период
    --
    --     Параметры:
    --
    --         p_objname    Имя объекта(BALANCE)
    --
    --         p_startdate  Дата начала периода
    --
    --         p_finishdate Дата окончания периода
    --
    --         p_snapmode   Тип синхронизации снимка
    --
    procedure sync_snap_period(
                  p_objname    in  t_accmobjname,
                  p_startdate  in  t_accmsnapdate,
                  p_finishdate in  t_accmsnapdate,
                  p_snapmode   in  t_accmsyncmode default SNAPMODE_INCR)
    is
    	p         constant varchar2(100) := PKG_CODE || '.syncsnapperiod';
    begin
        if logger.trace_enabled()
        then
            logger.trace('%s: entry point p_objname=>%s, p_startdate=>%s, p_finishdate=>%s, p_snapmode=>%s',
                          p, p_objname, to_char(p_startdate, 'dd.mm.yyyy'), to_char(p_finishdate, 'dd.mm.yyyy'),
                          to_char(p_snapmode)
                        );
        end if;
        --
        if (p_objname = 'BALANCE') then
            bars_accm_calendar.sync_calendar;
            bars_accm_snap.snap_balance_period(p_startdate, p_finishdate, p_snapmode);
        end if;
        --
        if logger.trace_enabled()
        then
            logger.trace('%s: succ end', p);
        end if;
        --
    end sync_snap_period;

    -----------------------------------------------------------------
    -- SYNC_AGG()
    --
    --     Синхронизация агрегата объекта для указанной даты
    --
    --     Параметры:
    --
    --         p_objname   Имя объекта
    --
    --         p_snapdate  Дата снимка
    --
    --         p_snapmode  Тип синхронизации снимка
    --
    procedure sync_agg(
                  p_objname  in  t_accmobjname,
                  p_aggdate  in  t_accmsnapdate,
                  p_aggmode  in  t_accmsyncmode default SYNCMODE_INCR)
    is
    p                constant varchar2(100) := PKG_CODE || '.syncagg';
    -- дата аггрегата
   -- l_aggdate   	date := trunc(p_aggdate);
    -- первый день периода
   -- l_startdate     date;
    -- последний день периода
   -- l_finishdate    date;
    -- максимальная банковская дата из fdat
   -- l_max_bankdate  date := bars_accm_snap.get_max_bankdate();
    --
    begin

null;
/*  if logger.trace_enabled()
	    then
            logger.trace('%s: entry point p_objname=>%s, p_aggdate=>%s, p_aggmode=>%s',
		        p, p_objname, to_char(p_aggdate, 'dd.mm.yyyy'), to_char(p_aggmode));
        end if;
        logger.info('Запущена процедура накопления баланса за '
                    ||case when p_objname = 'MONBAL' then 'месяц' when p_objname = 'YEARBAL' then 'год' end
                    ||' отчетная дата '||to_char(p_aggdate, 'dd.mm.yyyy')
                   );
        --
        if (p_objname = 'MONBAL') then
            -- первый день месяца
            l_startdate  := trunc(l_aggdate, 'mon');
            -- последний день месяца
            l_finishdate := add_months(l_startdate, 1) - 1;
            -- мы не должны формировать снимки в будущем
            l_finishdate := least(l_finishdate, l_max_bankdate);
            --
            bars_accm_calendar.sync_calendar;
            bars_accm_list.add_corrdocs;
            bars_accm_snap.snap_balance_period(l_startdate, l_finishdate, SYNCMODE_INCR);
            --
            bars_accm_agg.agg_monbal(p_aggdate, p_aggmode);
            --
        elsif (p_objname = 'YEARBAL') then
            -- первый день года
            l_startdate  := trunc(l_aggdate, 'year');
            -- последний день года
            l_finishdate := add_months(l_startdate, 12) - 1;
            -- мы не должны формировать снимки в будущем
            l_finishdate := least(l_finishdate, l_max_bankdate);
            --
            bars_accm_calendar.sync_calendar;
            bars_accm_list.add_corrdocs;
            -- делаем снимок только последнего дня года для получения остатков
            bars_accm_snap.snap_balance(l_finishdate, SYNCMODE_INCR);
            --
            bars_accm_agg.agg_yearbal(p_aggdate, p_aggmode);
            --
        end if;
        if logger.trace_enabled()
        then
            logger.trace('%s: succ end', p);
        end if;    */
    end sync_agg;




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
    function header_version return varchar2
    is
    begin
        return 'package header BARS_ACCM_SYNC ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция получения версии тела пакета
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_ACCM_SYNC ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


end bars_accm_sync;
/
 show err;
 
PROMPT *** Create  grants  BARS_ACCM_SYNC ***
grant EXECUTE                                                                on BARS_ACCM_SYNC  to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on BARS_ACCM_SYNC  to BARSUPL;
grant EXECUTE                                                                on BARS_ACCM_SYNC  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ACCM_SYNC  to BARS_SUP;
grant EXECUTE                                                                on BARS_ACCM_SYNC  to RPBN001;
grant EXECUTE                                                                on BARS_ACCM_SYNC  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_accm_sync.sql =========*** End 
 PROMPT ===================================================================================== 
 