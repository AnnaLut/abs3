
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bms.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BMS is
    -- Author        : Unknown
    -- Current owner : Artem Yurchenko
    -- Purpose       : BMS - BARS Message Service
    --               : Розсилка та отримання службових та адміністративних повідомлень в рамках АБС

    G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.4 26/10/2015';

    MSG_TYPE_ORDINARY_MESSAGE      constant integer := 1; -- Звичайні повідомлення
    MSG_TYPE_BACK_OFFICE_REQUEST   constant integer := 2; -- Запити на бек-офіс
    MSG_TYPE_BORU_MESSAGE          constant integer := 3; -- Повідомлення для БОРУ
    MSG_TYPE_ASYNC_RUN_MESSAGE     constant integer := 4; -- Повідомлення про обробку асинхронних запитів
    MSG_TYPE_BARSNOTIFY_MESSAGE    constant integer := 5; -- Повідоплення про зміну банківської дати

    ----
    -- header_version - повертає версію заголовку пакета
    --
    function header_version
    return varchar2;

    ----
    -- body_version - повертає версію тіла пакета
    --
    function body_version
    return varchar2;

    ----
    -- add_subscriber - додає підписника на отримання повідомлень із черги
    -- @param p_userid - id користувача, що підписується на отримання повідомлень
    -- використовується в bars_useradm
    --
    procedure add_subscriber(
        p_userid in integer);

    ----
    -- remove_subscriber - видаляє підписника на отримання повідомлень із черги
    -- @param p_userid - id пользователя, що відписується від отримання повідомлень
    -- використовується в bars_useradm
    --
    procedure remove_subscriber(
        p_userid in integer);

    ----
    -- add_recipient - додає користувача до списку отримувачів майбутнього повідомлення (тимчасова таблиця bms_tmp_msg_uids)
    -- @param p_userid - id користувача
    -- використовується в barsnet.apl
    --
    procedure add_recipient(
        p_userid in integer);

    ----
    -- enqueue_msg - процедура для помещения сообщения в очередь
    -- @param p_msg - тело сообщения
    -- @param p_delay - кол-во секунд, после которых сообщение становится доступным для прочтения,
    --        по-умолчанию, сообщение доступно сразу
    -- @param p_expiration - длительность в секундах доступности сообщения,
    --        по-умолчанию, сообщение доступно неограниченное время
    -- @param p_recipient_id - id пользователя, получателя сообщения,
    --        если null, то список получателей составляется из таблицы tmp_msg_uids
    -- використовується в barsnet.apl
    --
    procedure enqueue_msg(
        p_msg          in varchar2,
        p_delay        in integer default dbms_aq.no_delay,
        p_expiration   in integer default dbms_aq.never,
        p_recipient_id in integer default null);

    ----
    -- dequeue_msg - получение сообщения из очереди
    -- @param p_msg - сообщение
    -- @param p_sender_id - id пользователя - отправителя сообщения
    -- @param p_enqueue_time - время рассылки сообщения
    -- використовується в barsnet.apl
    --
    procedure dequeue_msg(
        p_msg          out varchar2,
        p_sender_id    out integer,
        p_enqueue_time out date);

    procedure send_message(
        p_receiver_id     in integer,
        p_message_type_id in integer,
        p_message_text    in varchar2,
        p_delay           in integer,
        p_expiration      in integer);

    procedure receive_message(
        p_message_type_id in integer,
        p_message out varchar2,
        p_sender_id out integer,
        p_enqueue_time out date);

    ----
    -- clean_bars_queues_subscribers - очистка очередей BARS_MSG_QUEUE
    -- @param p_subs_cnt - количество удаляемых подписчиков за один раз
    -- викликається job'ом bars.bms_clean_subscribers
    --
    procedure clean_bars_queues_subscribers(
        p_subs_cnt in number default 500);

    ----
    -- push_msg_web - отправляет сообщение на веб-сервер
    -- @param p_user_login - login отримувача повідомлення
    -- @param p_message - текст повідомлення
    -- @param p_type_id - тип повідомлення (для використання в web)
    -- використовується в barsweb
    --
    procedure push_msg_web(
        p_user_login in varchar2,
        p_message in varchar2,
        p_type_id in number default MSG_TYPE_ORDINARY_MESSAGE);

    ----
    -- done_msg - сохраняет сообщение в таблицу user_messages
    -- використовується в barsweb
    --
    procedure done_msg(
        p_msg_id  in integer,
        p_comment in varchar2);

    ---
    -- set_bars_board зберігає/обновляє значенняя в таблиці bars_board
    -- використовується в barsweb
    --
    procedure set_bars_board(
        p_msg_title in varchar2,
        p_msg_text  in clob,
        p_writer    in varchar2,
        p_id        in number default null);

    ---
    -- del_bars_board видаляє значення в таблиці bars_board
    -- використовується в barsweb
    --
    procedure del_bars_board(
        p_id in number);
end bms;
/
CREATE OR REPLACE PACKAGE BODY BARS.BMS is

    G_BODY_VERSION                 constant varchar2(64) := 'version 1.5 28/09/2017';

    G_WSPROXY_URL_TAG              constant varchar2(12) := 'PROXY_WS_URL';
    G_WSPROXY_NS_TAG               constant varchar2(12) := 'PROXY_WS_NS';
    G_WSPROXY_METHOD               constant varchar2(22) := 'PushMessage';

    G_WSPROXY_USERLOGIN_PARAM      constant varchar2(10) := 'UserLogin';
    G_WSPROXY_MESSAGE_PARAM        constant varchar2(10) := 'Message';
    G_WSPROXY_MESSAGETYPE_PARAM    constant varchar2(10) := 'TypeId';

    G_MODULE                       constant varchar2(3) := 'BMS';

    RECEIVER_TYPE_SID              constant varchar2(10 char) := 'SID';
    RECEIVER_TYPE_USERID           constant varchar2(10 char) := 'USERID';

    BMS_MODE_QUEUES                constant varchar2(1 char) := '1';
    BMS_MODE_INTERNAL_TABLE        constant varchar2(1 char) := '2';

    g_bms_mode                     integer;

    function header_version
    return varchar2
    is
    begin
        return 'Package header BMS ' || G_HEADER_VERSION || '.';
    end;

    function body_version
    return varchar2
    is
    begin
        return 'Package body BMS ' || G_BODY_VERSION || '.';
    end;

    function read_web_usermap(
        p_web_user_login in varchar2,
        p_raise_ndf in boolean default true)
    return web_usermap%rowtype
    is
        l_web_user_row web_usermap%rowtype;
    begin
        select *
        into   l_web_user_row
        from   web_usermap t
        where  t.webuser = p_web_user_login;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Користувач web з логіном {' || p_web_user_login || '} не знайдений');
             else return null;
             end if;
    end;

    function read_staff$base(
        p_user_id in integer,
        p_raise_ndf in boolean default true)
    return staff$base%rowtype
    result_cache relies_on (staff$base)
    is
        l_staff_row staff$base%rowtype;
    begin
        select *
        into   l_staff_row
        from   staff$base t
        where  t.id = p_user_id;

        return l_staff_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Користувач з ідентифікатором {' || p_user_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_staff$base(
        p_user_login in varchar2,
        p_raise_ndf in boolean default true)
    return staff$base%rowtype
    result_cache relies_on (staff$base)
    is
        l_staff_row staff$base%rowtype;
    begin
        select *
        into   l_staff_row
        from   staff$base t
        where  t.logname = p_user_login;

        return l_staff_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Користувач з логіном {' || p_user_login || '} не знайдений');
             else return null;
             end if;
    end;

    -- получает id пользователя по его логину
    function get_webuserid_by_userlogin(
        p_user_login in varchar2)
    return number
    is
        l_res number;
    begin
        bars_audit.trace('bms.get_webuserid_by_userlogin: entry point');

        begin
            select s.id
            into   l_res
            from   staff$base s,
                   web_usermap m
            where  s.logname = m.dbuser and
                   lower(m.webuser) = lower(p_user_login);
        exception
            when no_data_found then
                 return null;
        end;

        return l_res;
    end;

    -- получает логин пользователя по его user_id
    function get_webuserlogin_by_userid(
        p_userid in integer)
    return varchar2
    is
        l_res web_usermap.webuser%type;
    begin
        bars_audit.trace('bms.get_webuserlogin_by_userid: entry point');

        begin
            select m.webuser
            into   l_res
            from   staff$base s, web_usermap m
            where  s.logname = m.dbuser and
                   s.id = p_userid and
                   rownum = 1;
        exception
            when no_data_found then
                 return null;
        end;

        return l_res;
    end;

    procedure ensure_appropriate_bms_mode(p_bms_mode in varchar2)
    is
    begin
        if (p_bms_mode not in (BMS_MODE_QUEUES, BMS_MODE_INTERNAL_TABLE)) then
            raise_application_error(-20000, 'Неочікуваний режим роботи механізму розсилки повідомлень {' || p_bms_mode || '}');
        end if;
    end;

    procedure add_subscriber(
        p_userid in integer)
    is
        l_agentname varchar2(30);
        l_subscriber sys.aq$_agent;
        max_number_exceeded exception;
        pragma exception_init(max_number_exceeded, -24067);
    begin
        ensure_appropriate_bms_mode(g_bms_mode);

        if (g_bms_mode = BMS_MODE_QUEUES) then
            -- имя агента состоит из префикса и его ID из таблицы staff
            l_agentname := 'BARS_' || p_userid;

            -- создаем агента
            dbms_aqadm.create_aq_agent(agent_name => l_agentname);

            -- создаем подписчика
            l_subscriber := sys.aq$_agent(l_agentname, null, null);

            -- добавляем подписчика в очередь
            --если достигнуто 1024 подписчика переходим к следующей очереди
            begin
                dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue', subscriber => l_subscriber);
            exception when max_number_exceeded then
                begin
                    dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue2', subscriber => l_subscriber);
                exception when max_number_exceeded then
                    begin
                        dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue3', subscriber => l_subscriber);
                    exception when max_number_exceeded then
                        begin
                            dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue4', subscriber => l_subscriber);
                        exception when max_number_exceeded then
                            begin
                                dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue5', subscriber => l_subscriber);
                            exception when max_number_exceeded then
                                begin
                                    dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue6', subscriber => l_subscriber);
                                exception when max_number_exceeded then
                                    begin
                                        dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue7', subscriber => l_subscriber);
                                    exception when max_number_exceeded then
                                        begin
                                            dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue8', subscriber => l_subscriber);
                                        exception when max_number_exceeded then
                                            begin
                                                dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue9', subscriber => l_subscriber);
                                            exception when max_number_exceeded then
                                                begin
                                                    dbms_aqadm.add_subscriber(queue_name => 'bars.bars_msg_queue10', subscriber => l_subscriber);
                                                exception when max_number_exceeded then
                                                    bars_error.raise_error(G_MODULE, 1, '5');
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end if;
    end;

    procedure remove_subscriber(
        p_userid in integer)
    is
        l_agentname varchar2(30);
        l_subscriber sys.aq$_agent;

        not_a_subscriber exception;
        pragma exception_init(not_a_subscriber, -24035);
        agent_not_exist exception;
        pragma exception_init(agent_not_exist, -24088);

        -- Типы для списка названий очередей
        type t_queue_names is table of varchar2(30);
        l_queue_names t_queue_names;
    begin
        ensure_appropriate_bms_mode(g_bms_mode);

        if (g_bms_mode = BMS_MODE_QUEUES) then
            -- имя агента состоит из префикса и его ID из таблицы staff
            l_agentname := 'BARS_' || p_userid;

            -- создаем подписчика
            l_subscriber := sys.aq$_agent(l_agentname, null, null);

            -- удаляем подписчика из очереди
            begin
                select t.queue_name
                bulk collect into l_queue_names
                from   all_queue_subscribers t
                where  t.owner = 'BARS' and
                       t.consumer_name = l_agentname;

                if (l_queue_names is not null and l_queue_names.count > 0) then
                    for k in l_queue_names.first .. l_queue_names.last loop
                        begin
                            dbms_aqadm.remove_subscriber(queue_name => 'bars.' || l_queue_names(k),
                                                         subscriber => l_subscriber);
                        exception
                            when not_a_subscriber then
                                 null;
                        end;
                    end loop;
                end if;
            end;

            -- удаляем агента
            begin
                dbms_aqadm.drop_aq_agent(agent_name => l_agentname);
            exception
                when agent_not_exist then
                     null;
            end;
        end if;
    end;

    procedure add_recipient(p_userid in integer)
    is
    begin
        insert into tmp_msg_uids values (p_userid);
    end;

    function read_bms_message(
        p_message_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return bms_message%rowtype
    is
        l_message_row bms_message%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_message_row
            from   bms_message t
            where  t.id = p_message_id
            for update wait 60;
        else
            select *
            into   l_message_row
            from   bms_message t
            where  t.id = p_message_id;
        end if;

        return l_message_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Повідомлення з ідентифікатором {' || p_message_id || '} не знайдено');
             else return null;
             end if;
    end;

    function read_bms_message_type(
        p_message_type_id in integer)
    return bms_message_type%rowtype
    result_cache relies_on (bms_message_type)
    is
        l_message_type_row bms_message_type%rowtype;
    begin
        select *
        into   l_message_type_row
        from   bms_message_type t
        where  t.id = p_message_type_id;

        return l_message_type_row;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Тип повідомлення з ідентифікатором {' || p_message_type_id || '} не знайдений');
    end;

    function create_bms_message(
        p_sender_id in integer,
        p_receiver_id in varchar2,
        p_receiver_name in varchar2,
        p_message_type_id in integer,
        p_message in varchar2,
        p_effective_time in date,
        p_expiration_time in date)
    return integer
    is
        l_message_id integer;
        l_effective_time date default p_effective_time;
        l_expiration_time date default p_expiration_time;
    begin
        if (l_effective_time is null) then
            l_effective_time := sysdate;
        end if;

        if (l_expiration_time is null) then
            -- за замовчанням, повідомлення втрачає свою актуальність через 1 добу
            l_expiration_time := l_effective_time + 1;
        end if;

        insert into bms_message
        values (bms_message_seq.nextval,
                p_sender_id,
                p_receiver_id,
                p_receiver_name,
                p_message_type_id,
                p_message,
                sysdate,
                l_effective_time,
                l_expiration_time,
                null,
                null)
        returning id
        into l_message_id;

        return l_message_id;
    end;

    function get_next_bms_message_row(
        p_message_type_id in integer,
        p_receiver_id in varchar2)
    return bms_message%rowtype
    is
        l_message_row bms_message%rowtype;
    begin
        select d.*
        into   l_message_row
        from   bms_message d
        where  d.rowid = (select min(t.rowid) keep (dense_rank first order by t.id)
                          from   bms_message t
                          where  t.receiver_id = p_receiver_id and
                                 t.message_type_id = p_message_type_id and
                                 t.effective_time <= sysdate and
                                 t.expiration_time >= sysdate and
                                 t.processing_time is null);
        return l_message_row;
    exception
        when no_data_found then
             return null;
    end;

    procedure process_bms_message(
        p_message_id in integer,
        p_processing_comment in varchar2)
    is
        l_message_row bms_message%rowtype;
        l_message_type_row bms_message_type%rowtype;
    begin
        l_message_row := read_bms_message(p_message_id, p_lock => true);

        if (l_message_row.processing_time is not null) then
            return;
        end if;

        update bms_message t
        set    t.processing_time = sysdate,
               t.processing_comment = p_processing_comment
        where  t.id = p_message_id;

        l_message_type_row := read_bms_message_type(l_message_row.message_type_id);

        if (l_message_type_row.is_persisted = 'N') then

            -- видаляємо повідомлення, що були:
            delete bms_message t
            where  (t.message_type_id = l_message_type_row.id and
                    (t.expiration_time < sysdate - 1 or -- а) прострочені понад 1 добу
                    	t.processing_time < sysdate - 1)); -- б) оброблені більше 1 доби тому

        end if;
    end;

    procedure send_message(
        p_receiver_id     in integer,
        p_message_type_id in integer,
        p_message_text    in varchar2,
        p_delay           in integer,
        p_expiration      in integer)
    is
        l_que_msg_enq  sys.dbms_aq.enqueue_options_t; -- Опции постановки в очередь
        l_que_msg_prop sys.dbms_aq.message_properties_t; -- Опции сообщения
        l_que_msg_id   raw(16); -- Идентификатор сообщения в очереди
        i              integer;
        l_bms_message_id integer;
        l_receivers_list varchar2_list;
        l integer;
    begin
        bars_audit.trace('bms.enqueue_msg_sid : entry point' || chr(10) ||
                         'p_receiver_id     : ' || p_receiver_id     || chr(10) ||
                         'p_message_type_id : ' || p_message_type_id || chr(10) ||
                         'p_message_text    : ' || p_message_text    || chr(10) ||
                         'p_delay           : ' || p_delay           || chr(10) ||
                         'p_expiration      : ' || p_expiration);

        ensure_appropriate_bms_mode(g_bms_mode);

        if (p_receiver_id is null) then
            select user_id
            bulk collect into l_receivers_list
            from tmp_msg_uids;
        else
            l_receivers_list := varchar2_list(p_receiver_id);
        end if;

        l := l_receivers_list.first;
        while (l is not null) loop
            l_bms_message_id := create_bms_message(user_id(),
                                                   l_receivers_list(l),
                                                   null,
                                                   p_message_type_id,
                                                   p_message_text,
                                                   sysdate + (p_delay / 24 / 60 / 60),
                                                   sysdate + (p_expiration / 24 / 60 / 60));
            l := l_receivers_list.next(l);
        end loop;

        if (g_bms_mode = BMS_MODE_QUEUES) then
            l_que_msg_prop.delay      := p_delay;
            l_que_msg_prop.expiration := p_expiration;
            l_que_msg_prop.sender_id  := sys.aq$_agent('BARS_' || user_id(), null, null);

            for i in (select 'BARS_' || t.column_value recipient_id,
                             nvl(s.queue_name, 'bars_msg_queue') queue_name
                      from   table(l_receivers_list) t
                      left join all_queue_subscribers s on s.owner = 'BARS' and
                                                           s.consumer_name = 'BARS_' || t.column_value) loop

                l_que_msg_prop.recipient_list(0) := sys.aq$_agent('BARS_' || i.recipient_id, null, null);

                dbms_aq.enqueue(queue_name         => 'bars.' || i.queue_name,
                                enqueue_options    => l_que_msg_enq,
                                message_properties => l_que_msg_prop,
                                payload            => sys.anydata.ConvertVarchar2(p_message_text),
                                msgid              => l_que_msg_id);
            end loop;
        end if;
    end;

    procedure receive_message(
        p_message_type_id in integer,
        p_message out varchar2,
        p_sender_id out integer,
        p_enqueue_time out date)
    is
        pragma autonomous_transaction;
        l_que_msg_deq  sys.dbms_aq.dequeue_options_t; -- Опции чтения из очереди
        l_que_msg_prop sys.dbms_aq.message_properties_t; -- Опции сообщения
        l_que_msg_id   raw(16); -- Идентификатор сообщения в очереди
        l_obj          sys.anydata;
        l_queue_name   varchar2(70);
        l_message_type_row bms_message_type%rowtype;
        l_message_row  bms_message%rowtype;
    begin
        ensure_appropriate_bms_mode(g_bms_mode);

        l_message_type_row := read_bms_message_type(p_message_type_id);

        if (g_bms_mode = BMS_MODE_QUEUES) then
            begin
                if (l_message_type_row.receiver_id_type = RECEIVER_TYPE_SID) then
                    l_que_msg_deq.consumer_name := 'BARS_' || userenv('sessionid');
                else
                    l_que_msg_deq.consumer_name := 'BARS_' || user_id();
                end if;

                -- T SHEDENKO если нет подписчика - добавить
                declare
                    l_chk number := 0;
                begin
                    select count(*)
                    into   l_chk
                    from   all_queue_subscribers
                    where  owner = 'BARS' and
                           queue_name like 'BARS_MSG_QUEUE%' and
                           consumer_name = l_que_msg_deq.consumer_name;

                    if (l_chk = 0) then
                        bms.add_recipient(case when l_message_type_row.receiver_id_type = RECEIVER_TYPE_SID then userenv('sessionid')
                                                else user_id()
                                          end);
                    end if;
                end; -- если нет подписчика - добавить

                l_que_msg_deq.wait          := dbms_aq.no_wait;
                l_que_msg_deq.navigation    := dbms_aq.first_message;

                begin
                    select queue_name
                    into   l_queue_name
                    from   all_queue_subscribers
                    where  owner = 'BARS' and
                           consumer_name = l_que_msg_deq.consumer_name;
                exception
                    when no_data_found then
                         l_queue_name := 'bars_msg_queue';
                end;

                dbms_aq.dequeue(queue_name         => 'bars.' || l_queue_name,
                                dequeue_options    => l_que_msg_deq,
                                message_properties => l_que_msg_prop,
                                payload            => l_obj,
                                msgid              => l_que_msg_id);

                p_message      := l_obj.AccessVarchar2();
                p_sender_id    := to_number(substr(l_que_msg_prop.sender_id.name, 6));
                p_enqueue_time := l_que_msg_prop.enqueue_time;

                if (l_message_type_row.receiver_id_type = RECEIVER_TYPE_SID) then
                    bms.remove_subscriber(p_userid => userenv('sessionid'));
                else
                    bms.remove_subscriber(p_userid => user_id);
                end if;

            exception
                when others then
                     -- При ошибке чтения сообщения так же нужно удалять подписчика
                     if (l_message_type_row.receiver_id_type = RECEIVER_TYPE_SID) then
                         bms.remove_subscriber(p_userid => userenv('sessionid'));
                     else
                         bms.remove_subscriber(p_userid => user_id);
                     end if;

                     -- timeout or end-of-fetch during message dequeue from BARS.BARS_MSG_QUEUE
                     if (sqlcode = -25228) then null;
                     else raise;
                     end if;
            end;
        else
            if (l_message_type_row.receiver_id_type = RECEIVER_TYPE_SID) then
                l_message_row := get_next_bms_message_row(p_message_type_id, userenv('sessionid'));
            else
                l_message_row := get_next_bms_message_row(p_message_type_id, user_id());
            end if;

            if (l_message_row.id is not null) then
                process_bms_message(l_message_row.id, null);

                p_message      := l_message_row.message_text;
                p_sender_id    := l_message_row.sender_id;
                p_enqueue_time := l_message_row.sending_time;
            end if;
        end if;

        commit;
    end;

    procedure enqueue_msg(
        p_msg          in varchar2,
        p_delay        in integer default dbms_aq.no_delay,
        p_expiration   in integer default dbms_aq.never,
        p_recipient_id in integer default null) is
    begin
        send_message(p_recipient_id, MSG_TYPE_ORDINARY_MESSAGE, p_msg, p_delay, p_expiration);
    end;

    procedure dequeue_msg(
        p_msg          out varchar2,
        p_sender_id    out integer,
        p_enqueue_time out date)
    is
    begin
        receive_message(bms.MSG_TYPE_ORDINARY_MESSAGE, p_msg, p_sender_id, p_enqueue_time);
    end;

    -- отправляет сообщение на веб-сервер
    procedure push_msg_web(
        p_user_login in varchar2,
        p_message in varchar2,
        p_type_id in number default MSG_TYPE_ORDINARY_MESSAGE)
    is
        l_request  soap_rpc.t_request;
        l_response soap_rpc.t_response;
        l_namespace varchar2(250 char);
        l_message_type_row bms_message_type%rowtype;
        l_user_id integer;
        l_message_id integer;
        l_wallet_dir  web_barsconfig.val%type;
        l_wallet_pass web_barsconfig.val%type;
    begin
        bars_audit.trace('bms.push_msg_web: p_user_login=%s, p_message=%s',
                         p_user_login,
                         p_message);

        if (p_user_login is null) then
            return;
        end if;

        l_namespace := getglobaloption(G_WSPROXY_NS_TAG);
        select max(val) into l_wallet_dir from web_barsconfig where key = 'SMPP.Wallet_dir';
        select max(val) into l_wallet_pass from web_barsconfig where key = 'SMPP.Wallet_pass';

        for c in (select val
                  from   params$global
                  where  par like G_WSPROXY_URL_TAG || '%') loop

            -- вызов метода прокси-сервиса
            -- подготовить реквест
            l_request := soap_rpc.new_request(p_url       => c.val,
                                              p_namespace => l_namespace,
                                              p_method    => G_WSPROXY_METHOD,
                                              p_wallet_dir => l_wallet_dir,
                                              p_wallet_pass => l_wallet_pass);
            -- добавить параметры
            soap_rpc.add_parameter(l_request,
                                   G_WSPROXY_USERLOGIN_PARAM,
                                   p_user_login);
            soap_rpc.add_parameter(l_request,
                                   G_WSPROXY_MESSAGE_PARAM,
                                   p_message);
            soap_rpc.add_parameter(l_request, G_WSPROXY_MESSAGETYPE_PARAM, to_char(p_type_id));
            -- позвать метод веб-сервиса
            l_response := soap_rpc.invoke(l_request);
        end loop;

        l_user_id := get_webuserid_by_userlogin(p_user_login);

        if l_user_id is null then
            bars_audit.warning('Користувач АБС не визначений для web-користувача з логіном {' || p_user_login ||
                               '} - повідомлення відправлено на веб-сервіс, але не збережено в таблиці bms_message');
            return;
        end if;

        l_message_type_row := read_bms_message_type(p_type_id);

        l_message_id := create_bms_message(user_id(),
                                           l_user_id,
                                           p_user_login,
                                           p_type_id,
                                           p_message,
                                           sysdate,
                                           sysdate + l_message_type_row.validity_period);
    end;

    procedure done_msg(
        p_msg_id  in integer,
        p_comment in varchar2)
    is
        l_message_row bms_message%rowtype;
        type t_bms_messages is table of bms_message%rowtype;
        l_bms_messages t_bms_messages;
        l integer;
    begin
        bars_audit.trace('bms.done_msg: entry point');

        l_message_row := read_bms_message(p_msg_id, p_lock => true);

        if (l_message_row.message_type_id = bms.MSG_TYPE_BACK_OFFICE_REQUEST) then
            select *
            bulk collect into l_bms_messages
            from   bms_message m
            where  m.sender_id = l_message_row.sender_id and
                   m.message_type_id = l_message_row.message_type_id and
                   m.message_text = l_message_row.message_text and
                   m.processing_time is null
            for update wait 60;
        else
            l_bms_messages := t_bms_messages(l_message_row);
        end if;

        l := l_bms_messages.first;
        while (l is not null) loop
            process_bms_message(l_bms_messages(l).id, p_comment);
            l := l_bms_messages.next(l);
        end loop;

        if (l_message_row.message_type_id = bms.MSG_TYPE_BACK_OFFICE_REQUEST) then
            bms.push_msg_web(get_webuserlogin_by_userid(l_message_row.sender_id), 'Ваш запит оброблено Бек-офісом!', 3); -- відправляємо підтвердження обробки
        end if;

        bars_audit.trace('bms.done_msg: message done');
    end;

    --------------------------------------------------------------------------------
    -- clean_bars_queues_subscribers - очистка очередей BARS_MSG_QUEUE
    -- p_subscrb_cnt   - количество удаляемых подписчиков за одит раз
    procedure clean_bars_queues_subscribers(
        p_subs_cnt in number default 500)
    is
        l_trace  varchar2(200) := 'BMS.clean_queues: ';
        l_userid number;
        type id_tt is table of varchar2(30);
        l_ids id_tt; -- Коллекция ID подписчиков для удаления
    begin
        ensure_appropriate_bms_mode(g_bms_mode);

        if (g_bms_mode = BMS_MODE_QUEUES) then
            -- Т.К. запуск из Планировщика, Залогиниться БАРСом
            select id
            into l_userid
            from staff$base
            where logname = 'BARS';
            bars_login.login_user(substr(sys_guid(), 1, 32), l_userid, userenv('terminal'), 'BMS_JOB');

            bars_audit.info(l_trace||'Старт удаления подписчиков');
            -- Спиок подписчиков для удаления
            select subs_id
            bulk collect into l_ids
            from (select substr (consumer_name, 6) subs_id
                  from all_queue_subscribers
                  where owner = 'BARS'
                  and queue_name like 'BARS_MSG_QUEUE%'
                  and consumer_name like 'BARS%'
                  order by queue_name, consumer_name)
            where rownum <= p_subs_cnt;

            -- Обход списка подписчиков с удалением
            if (l_ids is not null and l_ids.count > 0) then
                for i in l_ids.first .. l_ids.last loop

                    begin
                        bms.remove_subscriber(l_ids(i));
                        commit;
                    exception
                        when others then
                             rollback;
                    end;

                end loop;

                bars_audit.info(l_trace||'Удалено '||l_ids.count||' подписчика(ов)');
            else
                bars_audit.info(l_trace||'Подписчиков для удаления не найдено');
            end if;
        end if;
    end;

    procedure set_bars_board(
        p_msg_title in varchar2,
        p_msg_text  in clob,
        p_writer    in varchar2,
        p_id        in number default null)
    is
        l_id number := p_id;
    begin

        if l_id is null then
           l_id := s_bars_board.nextval;
        end if;

        merge into bars_board b
        using (select l_id id, p_msg_title msg_title, p_msg_text msg_text,
                      nvl(p_writer, user) writer
                 from dual) s
        on (b.id = s.id)
        when matched then
          update
             set b.msg_title = s.msg_title,
                 b.msg_text  = s.msg_text
        when not matched then
          insert
            (b.id, b.msg_title, b.msg_text, b.writer)
          values
            (s.id, s.msg_title, s.msg_text, s.writer);
    end;

    procedure del_bars_board(
        p_id in number)
    is
    begin
        delete from bars_board where id = p_id;
    end;

begin
    g_bms_mode := getglobaloption('BMS_MODE');

    if (g_bms_mode is null) then
        g_bms_mode := BMS_MODE_INTERNAL_TABLE;
    end if;
end bms;
/
 show err;
 
PROMPT *** Create  grants  BMS ***
grant EXECUTE                                                                on BMS             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BMS             to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bms.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 