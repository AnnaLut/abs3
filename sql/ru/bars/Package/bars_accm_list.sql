create or replace package BARS_ACCM_LIST
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет заполнения таблиц списков                 --
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
    VERSION_HEADER       constant varchar2(64)  := 'version 0.1 15.07.2009';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';

    -----------------------------------------------------------------
    -- ADD_CORRDOCS()
    --
    --     Добавление/обновление списка корректирующих проводок
    --
    --
    --
    procedure add_corrdocs;

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


end BARS_ACCM_LIST;
/

show errors;

create or replace package body BARS_ACCM_LIST
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет заполнения таблиц состояний               --
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

    VERSION_BODY       constant varchar2(64)  := 'version 0.3 27.05.2010';
    VERSION_BODY_DEFS  constant varchar2(512) := '';

    -- Код модуля
    MODCODE            constant varchar2(3)   := 'ACM';

    -----------------------------------------------------------------
    -- ADD_CORRDOCS()
    --
    --     Добавление/обновление списка корректирующих проводок
    --
    --
    --
    procedure add_corrdocs
    is
    p                constant varchar2(64) := 'BARS_ACCM_LIST.ADD_CORRDOCS';
    --
    type t_listnum  is table of number;
    --
    l_listref  t_listnum;    -- список документов в очереди синхронизации
    l_dummy    number;       -- буфер
    l_rowcnt   number := 0;  -- счетчик кол-ва строк
    --
    row_processed exception; -- документ уже обработан другим процессом
    --
    begin
        bars_audit.trace('%s: entry point', p);

        -- Читаем очередь документов
        select ref bulk collect into l_listref
          from accm_queue_corrdocs;
        bars_audit.trace('%s: corr docs count in queue is %s',p, to_char(l_listref.count));
       
        -- Проходим по очереди документов
        for i in 1..l_listref.count
        loop
            bars_audit.trace('%s: processing document ref %s...', p, to_char(l_listref(i)));

            begin
                -- Блокируем документ в очереди
                begin
                    select 1 into l_dummy
                      from accm_queue_corrdocs
                     where ref = l_listref(i)
                    for update;
                exception
                    when NO_DATA_FOUND then raise row_processed;
                end;
                bars_audit.trace('%s: document ref %s locked in queue', p, to_char(l_listref(i)));

                -- Удаляем проводки из списка, если таковой уже был
                delete from accm_list_corrdocs
                 where ref = l_listref(i);
                l_rowcnt := l_rowcnt + sql%rowcount;
                bars_audit.trace('%s: document ref %s delete from list, row(s) count %s', p, to_char(l_listref(i)), to_char(sql%rowcount));

                -- Добавляем проводки документа в список
                insert into accm_list_corrdocs(caldt_id, cordt_id, cor_type, acc, dos, dosq, kos, kosq, ref)
                select (case
                         when (s.tt like 'ZG%' and vob not in (96, 99) and to_char(c2.bankdt_date, 'ddmm') = '0101')  then
                              c2.bankdt_id - 1
                         else c2.bankdt_id
                        end)                         caldt_id, 
                       (case
                         when (s.tt like 'ZG%' and vob not in (96, 99))  then
                              c2.bankdt_id
                         else c1.caldt_id
                        end)                         cordt_id,
                       (case
                         when (s.tt like 'ZG%') then
                              decode(s.vob, 96, 4, 99, 4, 3)
                         else decode(s.vob, 96, 1, 99, 2)
                        end)                         cor_type,
                       s.acc                         acc,
                       s.dos                         dos,
                       s.dosq                        dosq,
                       s.kos                         kos, 
                       s.kosq                        kosq,
                       s.ref
                  from (select o.ref, o.vob, o.tt,
                               add_months(add_months(trunc(p2.fdat, 'month'), -1), 1)-1 cor_date, 
                               p1.fdat, p1.acc, p1.dos, p1.dosq, p1.kos, p1.kosq
                          from oper o,
                               (select p.fdat, p.acc, 
                                       sum(nvl(decode(p.dk, 0, p.s),  0)) dos,
                                       sum(nvl(decode(p.dk, 0, p.sq), 0)) dosq,
                                       sum(nvl(decode(p.dk, 1, p.s),  0)) kos,
                                       sum(nvl(decode(p.dk, 1, p.sq), 0)) kosq
                                  from opldok p
                                 where p.ref = l_listref(i)
                                group by p.fdat, p.acc)    p1,
                               (select max(fdat) fdat
                                  from opldok
                                 where ref = l_listref(i)) p2
                         where o.ref = l_listref(i)
                           and (o.vob in (96, 99) or o.tt like 'ZG%')  ) s,
                       accm_calendar c1, accm_calendar c2
                 where s.cor_date = c1.caldt_date
                   and s.fdat = c2.caldt_date;
                l_rowcnt := l_rowcnt + sql%rowcount;
                bars_audit.trace('%s: document ref %s inserted in list, row(s) count %s', p, to_char(l_listref(i)), to_char(sql%rowcount));

                -- Получаем список дат по данному документу
                for c in (select distinct value 
                            from (select decode(lv, 1, caldt_date1, caldt_date2) value
                                    from (select c1.caldt_date caldt_date1, c2.caldt_date caldt_date2, d.acc 
                                            from accm_list_corrdocs d, accm_calendar c1, accm_calendar c2
                                           where d.ref = l_listref(i)
                                             and d.caldt_id = c1.caldt_id
                                             and d.cordt_id = c2.caldt_id) d,
                                         (select level lv from dual connect by level <= 2) l
                                 )
                         )
                loop
                    bars_accm_sync.enqueue_monbal(c.value);
                    bars_accm_sync.enqueue_yearbal(c.value);
                end loop;
                bars_audit.trace('%s: cr dates inserted into monbal queue', p);

                -- Удаляем документ из очереди
                delete from accm_queue_corrdocs
                 where ref = l_listref(i);
                bars_audit.trace('%s: document ref %s deleted from queue.', p, to_char(l_listref(i)));

            exception
                when row_processed then
                    bars_audit.trace('%s: document ref %s already processed, nothing to do', p, to_char(l_listref(i)));
            end;
            commit;
            bars_audit.trace('%s: document ref %s processed.', p, to_char(l_listref(i)));

        end loop;
        bars_audit.trace('%s: corr docs queue processed.', p);
        bars_audit.trace('%s: succ end', p);

    end add_corrdocs;

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
        return 'package header BARS_ACCM_LIST ' || VERSION_HEADER || chr(10) ||
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
        return 'package body BARS_ACCM_LIST ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


end bars_accm_list;
/

show errors;
