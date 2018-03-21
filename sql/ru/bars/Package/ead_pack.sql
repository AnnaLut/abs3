 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ead_pack.sql =========*** Run *** ==
 PROMPT ===================================================================================== 

  CREATE OR REPLACE PACKAGE BARS.EAD_PACK is

  -- Author  : TVSUKHOV
  -- Created : 12.06.2013 16:56:08
  -- Changed : 08.02.2016 A.Yurchenko
  -- Purpose : Взаємодія з ЕА

  -- Public type declarations
  -- type <TypeName> is <Datatype>;
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 2.12  01.10.2017';

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;
  -- Public constant declarations
  g_transfer_timeout constant number := 180;
  function g_process_actual_time return number;

  -- Public variable declarations
  -- <VariableName> <Datatype>;

  -- Public function and procedure declarations
  -- ==== Надруковані документи ====
  -- Створити надрукований документ
  function doc_create(p_type_id      in ead_docs.type_id%type,
                      p_template_id  in ead_docs.template_id%type,
                      p_scan_data    in ead_docs.scan_data%type,
                      p_ea_struct_id in ead_docs.ea_struct_id%type,
                      p_rnk          in ead_docs.rnk%type,
                      p_agr_id       in ead_docs.agr_id%type default null)
    return ead_docs.id%type;

  -- Надрукований документ підписано
  procedure doc_sign(p_doc_id in ead_docs.id%type);

  -- Кількість сторінок надрукованого документу
  procedure doc_page_count(p_doc_id     in ead_docs.id%type,
                           p_page_count in ead_docs.page_count%type);

  -- ==== Черга повідомлень для передачі в ЕА ====
  -- Установить статус сообщению "Повідомлення відправлено"
  procedure msg_set_status_send(p_sync_id      in ead_sync_queue.id%type,
                                p_message_id   in ead_sync_queue.message_id%type,
                                p_message_date in ead_sync_queue.message_date%type,
                                p_message      in ead_sync_queue.message%type);

  -- Установить статус сообщению "Відповідь отримано"
  procedure msg_set_status_received(p_sync_id  in ead_sync_queue.id%type,
                                    p_responce in ead_sync_queue.responce%type);

  -- Установить статус сообщению "Відповідь оброблено"
  procedure msg_set_status_parsed(p_sync_id       in ead_sync_queue.id%type,
                                  p_responce_id   in ead_sync_queue.responce_id%type,
                                  p_responce_date in ead_sync_queue.responce_date%type);

  -- Установить статус сообщению "Виконано"
  procedure msg_set_status_done(p_sync_id in ead_sync_queue.id%type);

  -- Установить статус сообщению "Помилка"
  procedure msg_set_status_error(p_sync_id  in ead_sync_queue.id%type,
                                 p_err_text in ead_sync_queue.err_text%type);

  -- Створити повідомлення
  function msg_create(p_type_id in ead_sync_queue.type_id%type,
                      p_obj_id  in ead_sync_queue.obj_id%type)
    return ead_sync_queue.id%type;

  procedure msg_create (p_type_id   IN ead_sync_queue.type_id%TYPE,
                        p_obj_id    IN ead_sync_queue.obj_id%TYPE);

  -- Отправить сообщение на прокси веб-сервис
  PROCEDURE msg_process (p_sync_id   IN ead_sync_queue.id%TYPE,
                         p_force     IN character default null); -- если нужно протолкнуть мес несмотя на то что он уже отправлен или устарел

  -- Удалить сообщение
  procedure msg_delete(p_sync_id in ead_sync_queue.id%type);

  -- Удалить сообщения старше даты
  function msg_delete_older(p_date in date) return number;

  -- Захват изменений - Клієнт
  procedure cdc_client;

  -- Захват изменений - Актуалізація ідент. документів
  procedure cdc_act;

  -- Захват изменений - Угода
  procedure cdc_agr;

  -- Захват изменений - Клієнт Юр.лицо
  procedure cdc_client_u;

  -- Захват изменений - Угода Юр.лиц
  procedure cdc_agr_u;

  -- Захват изменений - Счета Юр.лиц
  procedure cdc_acc;

  -- Захват изменений - Надрукований документ
  procedure cdc_doc;

  -- !!! Пока в ручном режиме DICT  Довідник  SetDictionaryData

  -- Передача в ЭА сообщение типа
  procedure type_process(p_type_id in ead_types.id%type);
  -- функция возвращает 0 если счет не в рамках ДБО, 1 если счет в рамках ДБО
  function get_acc_info(p_acc in accounts.acc%type) return int;
  -- функция возвращает 1 если это первый акцептированный счет в рамках ДБО, 0 - если не первый
  function is_first_accepted_acc(p_acc in accounts.acc%type) return int;

  -- функция возвращает nbs для открытого и псевдо - nbs для зарезервированного счета  
  function get_acc_nbs(p_acc in accounts.acc%type) return char;
  -- функция возвращает "2" для юрлиц и спд, "3" для фо  
  function get_custtype(p_rnk in customer.rnk%type) return number;

end ead_pack;
/
show errors


CREATE OR REPLACE PACKAGE BODY BARS.EAD_PACK IS

   g_body_version   constant varchar2 (64) := 'version 2.14  16.01.2018';

   function body_version return varchar2 is
   begin
      return 'Package body ead_pack ' || g_body_version;
   end body_version;

   function header_version return varchar2 is
   begin
      return 'Package body ead_pack ' || g_body_version;
   end header_version;

  function g_process_actual_time return number is
  begin
    return 1;
  end g_process_actual_time;

  function g_wsproxy_url return varchar2 is
    l_wsproxy_url varchar2(100);
  begin
    select min(b.val)
      into l_wsproxy_url
      from web_barsconfig b
     where b.key = 'ead.WSProxy.Url';
    return l_wsproxy_url;
  end g_wsproxy_url;

  function g_wsproxy_walletdir return varchar2 is
    l_wsproxy_walletdir varchar2(100);
  begin
    select min(val)
      into l_wsproxy_walletdir
      from web_barsconfig
     where key = 'ead.WSProxy.WalletDir';
    return l_wsproxy_walletdir;
  end g_wsproxy_walletdir;

  function g_wsproxy_walletpass return varchar2 is
    l_wsproxy_walletpass varchar2(100);
  begin
    select min(val)
      into l_wsproxy_walletpass
      from web_barsconfig
     where key = 'ead.WSProxy.WalletPass';
    return l_wsproxy_walletpass;
  end g_wsproxy_walletpass;

  function g_wsproxy_ns return varchar2 is
    l_wsproxy_ns varchar2(100);
  begin
    select min(val)
      into l_wsproxy_ns
      from web_barsconfig
     where key = 'ead.WSProxy.NS';
    return l_wsproxy_ns;
  end g_wsproxy_ns;

  function g_wsproxy_username return varchar2 is
    l_wsproxy_username varchar2(100);
  begin
    select min(val)
      into l_wsproxy_username
      from web_barsconfig
     where key = 'ead.WSProxy.UserName';
    return l_wsproxy_username;
  end g_wsproxy_username;

  function g_wsproxy_password return varchar2 is
    l_wsproxy_password varchar2(100);
  begin
    select min(val)
      into l_wsproxy_password
      from web_barsconfig
     where key = 'ead.WSProxy.Password';
    return l_wsproxy_password;
  end g_wsproxy_password;

  -- Private variable declarations
  -- < VariableName > < Datatype >;

  -- Function and procedure implementations

  -- ==== Надруковані документи ====
  -- Створити надрукований документ
  function doc_create(p_type_id      in ead_docs.type_id%type,
                      p_template_id  in ead_docs.template_id%type,
                      p_scan_data    in ead_docs.scan_data%type,
                      p_ea_struct_id in ead_docs.ea_struct_id%type,
                      p_rnk          in ead_docs.rnk%type,
                      p_agr_id       in ead_docs.agr_id%type default null)
    return ead_docs.id%type is
    l_id ead_docs.id%type;
    l_pens_count int := 0;
  begin
    begin
	  select count(*)
	    into l_pens_count
		from ead_docs
	   where rnk = p_rnk
	     and p_ea_struct_id = 143; -- пенсійне посвідчення передавати один раз
	exception when no_data_found then l_pens_count := 0;
	end;
--	if (l_pens_count = 0 and p_ea_struct_id = 143) or p_ea_struct_id !=143
--	then
    -- последовательный номер 10... - АБС
    select to_number('10' || to_char(bars_sqnc.get_nextval('S_EADDOCS')))
      into l_id
      from dual;

    -- создаем запись
    insert into ead_docs
      (id,
       crt_date,
       crt_staff_id,
       crt_branch,
       type_id,
       template_id,
       scan_data,
       ea_struct_id,
       rnk,
       agr_id)
    values
      (l_id,
       sysdate,
       user_id,
       sys_context('bars_context', 'user_branch'),
       p_type_id,
       p_template_id,
       p_scan_data,
       p_ea_struct_id,
       p_rnk,
       p_agr_id);

    return l_id;
--	end if;
  end doc_create;

  -- Видалити надрукований документ
  procedure doc_del(p_doc_id in ead_docs.id%type) is
  begin
    delete from ead_docs d where d.id = p_doc_id;
  end doc_del;

  -- Надрукований документ підписано
  procedure doc_sign(p_doc_id in ead_docs.id%type) is
  begin
    update ead_docs d set d.sign_date = sysdate where d.id = p_doc_id;
  end doc_sign;

  -- Кількість сторінок надрукованого документу
  procedure doc_page_count(p_doc_id     in ead_docs.id%type,
                           p_page_count in ead_docs.page_count%type) is
  begin
    bars_audit.trace('tvSukhov: p_doc_id = ' || p_doc_id ||
                    ' p_page_count = ' || p_page_count);

    update ead_docs d
       set d.page_count = p_page_count
     where d.id = p_doc_id;
  end doc_page_count;

  -- ==== Черга повідомлень для передачі в ЕА ====
  -- Установить статус сообщению "Повідомлення відправлено"
  procedure msg_set_status_send(p_sync_id      in ead_sync_queue.id%type,
                                p_message_id   in ead_sync_queue.message_id%type,
                                p_message_date in ead_sync_queue.message_date%type,
                                p_message      in ead_sync_queue.message%type) is
  begin
    -- ставим статус "Повідомлення відправлено"
    update ead_sync_queue sq
       set sq.status_id    = 'MSG_SEND',
           sq.message_id   = p_message_id,
           sq.message_date = p_message_date,
           sq.message      = p_message,
           sq.err_text     = null
     where sq.id = p_sync_id;
    commit;
  end msg_set_status_send;

  -- Установить статус сообщению "Відповідь отримано"
  procedure msg_set_status_received(p_sync_id  in ead_sync_queue.id%type,
                                    p_responce in ead_sync_queue.responce%type) is
  begin
    -- ставим статус "Відповідь отримано"
    update ead_sync_queue sq
       set sq.status_id = 'RSP_RECEIVED',
           sq.responce  = p_responce,
           sq.err_text  = null
     where sq.id = p_sync_id;
    commit;
  end msg_set_status_received;

  -- Установить статус сообщению "Відповідь оброблено"
  procedure msg_set_status_parsed(p_sync_id       in ead_sync_queue.id%type,
                                  p_responce_id   in ead_sync_queue.responce_id%type,
                                  p_responce_date in ead_sync_queue.responce_date%type) is
  begin
    -- ставим статус "Відповідь оброблено"
    update ead_sync_queue sq
       set sq.status_id     = 'RSP_PARSED',
           sq.responce_id   = p_responce_id,
           sq.responce_date = p_responce_date,
           sq.err_text      = null
     where sq.id = p_sync_id;
    commit;
  end msg_set_status_parsed;

  -- Установить статус сообщению "Виконано"
  procedure msg_set_status_done(p_sync_id in ead_sync_queue.id%type) is
  begin
    -- ставим статус "Виконано"
    update ead_sync_queue sq
       set sq.status_id = 'DONE', sq.err_text = null
     where sq.id = p_sync_id;
    commit;
  end msg_set_status_done;

  -- Установить статус сообщению "Помилка"
  procedure msg_set_status_error(p_sync_id  in ead_sync_queue.id%type,
                                 p_err_text in ead_sync_queue.err_text%type) is
  begin
    -- ставим статус "Помилка"
    update ead_sync_queue sq
       set sq.status_id = 'ERROR', sq.err_text = p_err_text
     where sq.id = p_sync_id;
    commit;
  end msg_set_status_error;

  -- Установить статус сообщению "Вичерпано час актуальності"
  procedure msg_set_status_outdated(p_sync_id in ead_sync_queue.id%type) is
  begin
    -- ставим статус "Помилка"
    update ead_sync_queue sq
       set sq.status_id = 'OUTDATED'
     where sq.id = p_sync_id;
    commit;
  end msg_set_status_outdated;

  -- Створити повідомлення
  function msg_create(p_type_id in ead_sync_queue.type_id%type,
                      p_obj_id  in ead_sync_queue.obj_id%type)
    return ead_sync_queue.id%type is
    l_id ead_sync_queue.id%type;
  begin
    -- создаем запись
    insert into ead_sync_queue
      (id, crt_date, type_id, obj_id, status_id)
    values
      (bars_sqnc.get_nextval('S_EADSYNCQUEUE'), sysdate, p_type_id, p_obj_id, 'NEW')
    returning id into l_id;

    -- все предидущие записи по даному обїекту помечаем как устаревшие
    for cur in (select *
                  from ead_sync_queue sq
                 where sq.crt_date >
                       add_months(sysdate, -1 * g_process_actual_time)
                   and sq.type_id = p_type_id
                   and sq.obj_id = p_obj_id
                   and sq.id < l_id
                   and sq.status_id <> 'DONE') loop
      msg_set_status_outdated(cur.id);
    end loop;

    return l_id;
  end msg_create;

   PROCEDURE msg_create (p_type_id   IN ead_sync_queue.type_id%TYPE,
                         p_obj_id    IN ead_sync_queue.obj_id%TYPE) IS
   BEGIN
     tools.gn_dummy := msg_create(p_type_id, p_obj_id);
   END msg_create;

  -- Отправить сообщение на прокси веб-сервис
  PROCEDURE msg_process (p_sync_id   IN ead_sync_queue.id%TYPE,
                         p_force     IN character default null) -- если нужно протолкнуть мес несмотя на то что он уже отправлен или устарел
  is
  begin
    -- ставим статус "Обробка"
    -- проверка статуса на всякий случай, если мес отправили из другой сессии (например руками) раньше, чем job дошел
    UPDATE ead_sync_queue sq
       SET sq.status_id = 'PROC',
           sq.err_count = DECODE (sq.status_id, 'ERROR', NVL (sq.err_count, 0) + 1, 0)
     WHERE sq.id = p_sync_id and (status_id in ('NEW', 'ERROR') or p_force = 'F');

    -- выход, если сообщение уже обработано (status_id in (DONE, OUTDATED))
     if sql%rowcount = 0 then
       return;
     end if;

    commit;

    -- вызов метода прокси-сервиса
    declare
      l_err_text varchar2(4000);

      l_request  soap_rpc.t_request;
      l_response soap_rpc.t_response;
    begin
      -- подготовить реквест
      l_request := soap_rpc.new_request(p_url         => g_wsproxy_url,
                                        p_namespace   => g_wsproxy_ns,
                                        p_method      => 'MsgProcess',
                                        p_wallet_dir  => g_wsproxy_walletdir,
                                        p_wallet_pass => g_wsproxy_walletpass);
      -- добавить параметры
      soap_rpc.add_parameter(l_request, 'ID', to_char(p_sync_id));
      soap_rpc.add_parameter(l_request,
                             'WSProxyUserName',
                             g_wsproxy_username);
      soap_rpc.add_parameter(l_request,
                             'WSProxyPassword',
                             g_wsproxy_password);

      -- выполнить метод веб-сервиса
      l_response := soap_rpc.invoke(l_request);
    exception
      when others then
        l_err_text := 'Помилка на статусі PROC:' || chr(13) || chr(10) || dbms_utility.format_error_stack || dbms_utility.format_error_backtrace;
        -- ставим статус "Помилка"
        update ead_sync_queue sq
           set sq.status_id = 'ERROR', sq.err_text = l_err_text
         where sq.id = p_sync_id;
        commit;
    end;
  end msg_process;

  -- Удалить сообщение
  procedure msg_delete(p_sync_id in ead_sync_queue.id%type) is
  begin
    -- удаляем записи
    delete from ead_sync_queue sq where sq.id = p_sync_id;
    commit;
  end msg_delete;

  -- Удалить сообщения старше даты
  function msg_delete_older(p_date in date) return number is
    l_cnt number := 0;
  begin
    -- удаляем записи
    delete from ead_sync_queue sq where sq.crt_date < p_date;
    l_cnt := sql%rowcount;
    commit;

    -- сжимаем пространство
    begin
      execute immediate 'alter table ead_sync_queue shrink space';
    exception
      when others then
        null;
    end;

    -- возвращаем кол-во удаленных зап.
    return l_cnt;
  end msg_delete_older;
  --------------------------------- физлица ---------------------------------
  -- Захват изменений - Клієнт
  procedure cdc_client is
    l_type_id    ead_types.id%type := 'CLIENT';
    l_cdc_newkey ead_sync_sessions.cdc_lastkey%type;

    l_sync_id     ead_sync_queue.id%type;
    l_cdc_lastkey customer_update.idupd%type;
  begin
    -- находим ключ захвата изменений
    begin
      select to_number(ss.cdc_lastkey)
        into l_cdc_lastkey
        from ead_sync_sessions ss
       where ss.type_id = l_type_id;
    exception
      when no_data_found then
        select max(cu.idupd) into l_cdc_lastkey from customer_update cu;
    end;

    -- берем всех клиентов у которых есть депозит или трейтих лиц по депозитам,або є рахунки way4
    -- у которых было изменение в реквизитах
    for cur in (select cu.idupd, cu.rnk
                  from customer_update cu
                 where cu.idupd > l_cdc_lastkey
                   and get_custtype(cu.rnk) = 3
                   --/COBUSUPABS-5837
                  /* and ((exists
                        (select 1
                           from dpt_deposit_clos d
                          where d.rnk = cu.rnk
                            and nvl(d.archdoc_id, 0) > 0) or exists
                        (select 1
                           from dpt_trustee t
                          where t.rnk_tr = cu.rnk
                            and exists
                          (select 1
                                   from dpt_deposit_clos d
                                  where d.deposit_id = t.dpt_id
                                    and nvl(d.archdoc_id, 0) > 0)) or
                        trim(f_custw(cu.rnk, 'CRSRC')) = 'DPT')--є депозити
                        or
                        (	exists (select 1 from w4_acc wacc, accounts acc where WACC.ACC_PK = acc.acc and ACC.RNK = cu.rnk ) )--є карткові рахунки way4
                        	or
                        (	exists (select 1 from accounts acc where ACC.RNK = cu.rnk and ACC.nbs = '2620' and (ACC.dazs is null or ACC.DAZS>trunc(sysdate)) ) )--є рахунки 2620
                    )*/
                 order by cu.idupd) loop
      l_sync_id     := ead_pack.msg_create(l_type_id, to_char(cur.rnk));
      l_cdc_lastkey := cur.idupd;
    end loop;

    -- сохраняем ключ захвата
    l_cdc_newkey := to_char(l_cdc_lastkey);

    update ead_sync_sessions ss
       set ss.cdc_lastkey = l_cdc_newkey
     where ss.type_id = l_type_id;

    if (sql%rowcount = 0) then
      insert into ead_sync_sessions
        (type_id, cdc_lastkey)
      values
        (l_type_id, l_cdc_newkey);
    end if;

    commit;
  end cdc_client;

  -- Захват изменений - Актуалізація ідент. документів
  procedure cdc_act is
    l_type_id    ead_types.id%type := 'ACT';
    l_cdc_newkey ead_sync_sessions.cdc_lastkey%type;
    l_date_fmt   varchar2(100) := 'dd.mm.yyyy hh24:mi:ss';

    l_sync_id     ead_sync_queue.id%type;
    l_cdc_lastkey person_valid_document_update.chgdate%type;
  begin
    -- находим ключ захвата изменений
    begin
      select to_date(ss.cdc_lastkey, l_date_fmt)
        into l_cdc_lastkey
        from ead_sync_sessions ss
       where ss.type_id = l_type_id;
    exception
      when no_data_found then
        select nvl(max(pvd.chgdate), sysdate)
          into l_cdc_lastkey
          from person_valid_document_update pvd;
    end;

    -- берем все актуализации
    for cur in (select pvd.chgdate, pvd.rnk
                  from person_valid_document_update pvd
                 where get_custtype(pvd.rnk) = 3
                   and pvd.chgdate > l_cdc_lastkey
                 order by pvd.chgdate)
    loop
      -- клиент на всякий случай
      l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur.rnk));

      l_sync_id     := ead_pack.msg_create(l_type_id, to_char(cur.rnk));
      l_cdc_lastkey := cur.chgdate;
    end loop;

    -- сохраняем ключ захвата
    l_cdc_newkey := to_char(l_cdc_lastkey, l_date_fmt);

    update ead_sync_sessions ss
       set ss.cdc_lastkey = l_cdc_newkey
     where ss.type_id = l_type_id;

    if (sql%rowcount = 0) then
      insert into ead_sync_sessions
        (type_id, cdc_lastkey)
      values
        (l_type_id, l_cdc_newkey);
    end if;

    commit;
  end cdc_act;

  -- Захват изменений - Угода
  procedure cdc_agr is
    l_type_id    ead_types.id%type := 'AGR';
    l_cdc_newkey ead_sync_sessions.cdc_lastkey%type;

    l_sync_id ead_sync_queue.id%type;

    l_cdc_lastkey_dpt dpt_deposit_clos.idupd%type;
    l_cdc_lastkey_agr dpt_agreements.agrmnt_id%type;
    l_cdc_lastkey_way4 W4_ACC_UPDATE.IDUPD%type;
    l_cdc_lastkey_2620 ACCOUNTS_UPDATE.IDUPD%type;
  begin
    -- находим ключ захвата изменений
    begin
      select nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,1)),0),
              nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,2)),0),
              nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,3)),0),
              nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,4)),0)
        into l_cdc_lastkey_dpt, l_cdc_lastkey_agr, l_cdc_lastkey_way4, l_cdc_lastkey_2620
        from ead_sync_sessions ss
       where ss.type_id = l_type_id;
    exception
      when others then
        select max(dc.idupd)
          into l_cdc_lastkey_dpt
          from dpt_deposit_clos dc;
        select max(a.agrmnt_id)
          into l_cdc_lastkey_agr
          from dpt_agreements a;
        select max(W4.IDUPD )
          into l_cdc_lastkey_way4
          from w4_acc_update w4;
        select max(ACC.IDUPD )
          into l_cdc_lastkey_2620
          from ACCOUNTS_UPDATE ACC;
    end;


    -- депезиты по которым были изменения
    for cur in (select dc.idupd, deposit_id, dc.rnk
                  from dpt_deposit_clos dc join dpt_deposit d using (deposit_id)
                 where dc.idupd > l_cdc_lastkey_dpt
                   and nvl(dc.archdoc_id, 0) > 0
                   and d.wb = 'N'
                 order by dc.idupd) loop
      -- клиент
      l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur.rnk));

      -- связанные РНК
      for cur1 in (select distinct t.rnk_tr as rnk
                     from dpt_trustee t
                    where t.dpt_id = cur.deposit_id) loop
        l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur1.rnk));
      end loop;

      l_sync_id := ead_pack.msg_create(l_type_id, 'DPT;'||to_char(cur.deposit_id));

      l_cdc_lastkey_dpt := cur.idupd;
    end loop;

    -- депозиты по которым были допсоглашения
    for cur in (select a.agrmnt_id,
                       a.dpt_id,
--                       (SELECT DISTINCT FIRST_VALUE (dds.rnk) OVER (ORDER BY idupd DESC) FROM dpt_deposit_clos dds WHERE dds.deposit_id = a.dpt_id and nvl(dds.archdoc_id, 0) > 0) AS rnk
                       (select min(rnk) keep(dense_rank last order by idupd) from dpt_deposit_clos dds where dds.deposit_id = a.dpt_id AND nvl(dds.archdoc_id, 0) > 0) as rnk   -- последний владелец счета, причем в ЕБП archdoc_id >= 0
                from dpt_agreements a
                where a.agrmnt_id > l_cdc_lastkey_agr
		          AND a.agrmnt_type != 25 -- lypskykh #COBUMMFO-5263
                  and a.dpt_id in (select max(dc.deposit_id) KEEP (DENSE_RANK FIRST ORDER BY dc.when) as deposit_id
                                      from dpt_deposit_clos dc,
                                           dpt_deposit d 
                                        where dc.deposit_id = d.deposit_id(+)
                                        and nvl(dc.archdoc_id, 0) > 0
                                        and d.wb = 'N'
                                        and dc.deposit_id = a.dpt_id )
                                
                 order by a.agrmnt_id) loop
      -- клиент
      l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur.rnk));

      -- связанные РНК
      for cur1 in (select distinct t.rnk_tr as rnk
                     from dpt_trustee t
                    where t.dpt_id = cur.dpt_id) 
      loop
        l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur1.rnk));
      end loop;

      l_sync_id   := ead_pack.msg_create(l_type_id, 'DPT;'||to_char(cur.dpt_id));
      l_cdc_lastkey_agr := cur.agrmnt_id;
    end loop;

      -- рахунок(обробка не знаходження значення і заборона на передачу всіх змін в чергу)
      if (l_cdc_lastkey_way4 < 1)
      then
            select max(W4.IDUPD )
            into l_cdc_lastkey_way4
            from w4_acc_update w4;
      end if;

      -- рахунки way4 по которым были изменения
    for cur in (select w4.idupd, acc.rnk, w4.nd
                  from w4_acc_update w4 join accounts acc on W4.ACC_PK = acc.acc
                 where w4.idupd > l_cdc_lastkey_way4
                   and acc.nbs != '2605'    --/COBUSUPABS-4497 11.05.2016 pavlenko inga
                   and acc.rnk > 1 -- убираем резервирование
                 order by w4.idupd)
    loop
      -- клиент
          l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur.rnk));
          l_sync_id := ead_pack.msg_create(l_type_id, 'WAY;'||to_char(cur.nd));

          l_cdc_lastkey_way4 := cur.idupd;
    end loop;


    --рахунки 2620 ФО
    -- рахунок(обробка не знаходження значення і заборона на передачу всіх змін в чергу)
      if (l_cdc_lastkey_2620 < 1)
      then
          select max(ACC.IDUPD)
          into l_cdc_lastkey_2620
          from ACCOUNTS_UPDATE ACC;
      end if;

      -- рахунки 2620, заведені за останній період
      for cur in (SELECT IDUPD AS idupd, RNK AS rnk, ead_pack.get_acc_nbs(acc) AS nbs
                    FROM accounts_update
                   WHERE idupd > l_cdc_lastkey_2620
                     AND CHGACTION = 1
                     AND ead_pack.get_custtype(rnk) = 3
                     AND nbs = '2620'
                   ORDER BY idupd) LOOP
        -- надсилати лише клієнта ФО при заведенні рахунку. В подальшому всі зміни передавати лише при зміні атрибутів клієнта/*COBUSUPABS-4045*/
        IF (cur.nbs = '2620') THEN
          l_sync_id := ead_pack.msg_create('CLIENT', TO_CHAR(cur.rnk));
        END IF;
      
        l_cdc_lastkey_2620 := cur.idupd;
      END LOOP;

    -- сохраняем ключ захвата
    l_cdc_newkey := to_char(l_cdc_lastkey_dpt) || ';' ||
                    to_char(l_cdc_lastkey_agr) || ';' ||
                    to_char(l_cdc_lastkey_way4) || ';' ||
                    to_char(l_cdc_lastkey_2620);

    update ead_sync_sessions ss
       set ss.cdc_lastkey = l_cdc_newkey
     where ss.type_id = l_type_id;

    if (sql%rowcount = 0) then
      insert into ead_sync_sessions
        (type_id, cdc_lastkey)
      values
        (l_type_id, l_cdc_newkey);
    end if;

    commit;
  end cdc_agr;

  -- Захват изменений - Надрукований документ
  procedure cdc_doc is
    l_type_id    ead_types.id%type := 'DOC';
    l_cdc_newkey ead_sync_sessions.cdc_lastkey%type;

    l_sync_id     ead_sync_queue.id%type;
    l_cdc_lastkey ead_docs.id%type;
    l_cdc_last_time ead_sync_sessions.sync_end%type;
  begin
    -- находим ключ захвата изменений
    begin
      select to_number(ss.cdc_lastkey), ss.sync_end
        into l_cdc_lastkey, l_cdc_last_time
        from ead_sync_sessions ss
       where ss.type_id = l_type_id;
    exception
      when no_data_found then
        select nvl(max(d.id), 0) into l_cdc_lastkey from ead_docs d;
    end;

    -- берем все документы
    for cur in (select d.id, d.rnk, agr_id
                  from ead_docs d
                 where 1=1
--                   and d.id > l_cdc_lastkey
--                   and (d.sign_date IS NOT NULL OR d.type_id = 'SCAN') --отбираем только подписанные документы или сканкопии.
                   and (d.type_id = 'SCAN' and d.id > l_cdc_lastkey
                     or d.type_id = 'DOC' and d.sign_date > (l_cdc_last_time - interval '15' minute)
                       and not exists (select 1 from ead_sync_queue where obj_id = to_char(d.id) and type_id = 'DOC' and CRT_DATE > trunc(sysdate))) --отбираем только подписанные документы или сканкопии.
                   and lnnvl(d.template_id = 'WB_CREATE_DEPOSIT')  -- все кроме онлайн-депозитов
                 order by d.id) loop
      --насильно отправляем клиента
      l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur.rnk));
      --а также договор по подписанному документу, если такой имеется
      if cur.agr_id is not null then
        l_sync_id := msg_create ('AGR', 'DPT;' || TO_CHAR (cur.agr_id));
      end if;
      --и теперь документы
      l_sync_id     := ead_pack.msg_create(l_type_id, to_char(cur.id));
      l_cdc_lastkey := cur.id;
    end loop;

    -- сохраняем ключ захвата
    l_cdc_newkey := to_char(l_cdc_lastkey);

    update ead_sync_sessions ss
       set ss.cdc_lastkey = l_cdc_newkey
     where ss.type_id = l_type_id;

    if (sql%rowcount = 0) then
      insert into ead_sync_sessions
        (type_id, cdc_lastkey)
      values
        (l_type_id, l_cdc_newkey);
    end if;

    commit;
  end cdc_doc;
  --------------------------------- юрлица ---------------------------------
  -- Захват изменений - Клієнт Юр.Лицо
  procedure cdc_client_u is
    l_sync_id ead_sync_queue.id%type;

    l_cdc_lastkey_cu_corp  customer_update.idupd%type;
    l_cdc_newkey_cu_corp   customer_update.idupd%type;
    l_cdc_lastkey_cpu_corp corps_update.idupd%type;
    l_cdc_newkey_cpu_corp  corps_update.idupd%type;
    l_cdc_lastkey_cu_rel   customer_update.idupd%type;
    l_cdc_newkey_cu_rel    customer_update.idupd%type;
    l_cdc_lastkey_pu_rel   person_update.idupd%type;
    l_cdc_newkey_pu_rel    person_update.idupd%type;
    l_cdc_lastkey_cru_rel  customer_rel_update.idupd%type;
    l_cdc_newkey_cru_rel   customer_rel_update.idupd%type;

    -- получение ключей захвата изменений
    procedure get_cdc_lastkeys(p_cu_corp  out customer_update.idupd%type,
                               p_cpu_corp out corps_update.idupd%type,
                               p_cu_rel   out customer_update.idupd%type,
                               p_pu_rel   out person_update.idupd%type,
                               p_cru_rel  out customer_rel_update.idupd%type) is
      l_cdc_lastkey ead_sync_sessions.cdc_lastkey%type;
    begin
      select ss.cdc_lastkey
        into l_cdc_lastkey
        from ead_sync_sessions ss
       where ss.type_id = 'UCLIENT';

      p_cu_corp  := to_number(substr(l_cdc_lastkey,
                                     1,
                                     instr(l_cdc_lastkey, ';', 1, 1) - 1));
      p_cpu_corp := to_number(substr(l_cdc_lastkey,
                                     instr(l_cdc_lastkey, ';', 1, 1) + 1,
                                     instr(l_cdc_lastkey, ';', 1, 2) -
                                     instr(l_cdc_lastkey, ';', 1, 1) - 1));
      p_cu_rel   := to_number(substr(l_cdc_lastkey,
                                     instr(l_cdc_lastkey, ';', 1, 2) + 1,
                                     instr(l_cdc_lastkey, ';', 1, 3) -
                                     instr(l_cdc_lastkey, ';', 1, 2) - 1));
      p_pu_rel   := to_number(substr(l_cdc_lastkey,
                                     instr(l_cdc_lastkey, ';', 1, 3) + 1,
                                     instr(l_cdc_lastkey, ';', 1, 4) -
                                     instr(l_cdc_lastkey, ';', 1, 3) - 1));
      p_cru_rel  := to_number(substr(l_cdc_lastkey,
                                     instr(l_cdc_lastkey, ';', 1, 4) + 1));
    exception
      when others then
        select max(cu.idupd), max(cu.idupd)
          into p_cu_corp, p_cu_rel
          from customer_update cu;
        select max(cpu.idupd) into p_cpu_corp from corps_update cpu;
        select max(pu.idupd) into p_pu_rel from person_update pu;
        select max(cru.idupd) into p_cru_rel from customer_rel_update cru;
    end get_cdc_lastkeys;
    -- сохранение ключей захвата изменений
    procedure set_cdc_newkeys(p_cu_corp  in customer_update.idupd%type,
                              p_cpu_corp in corps_update.idupd%type,
                              p_cu_rel   in customer_update.idupd%type,
                              p_pu_rel   in person_update.idupd%type,
                              p_cru_rel  in customer_rel_update.idupd%type) is
      l_cdc_newkey ead_sync_sessions.cdc_lastkey%type;
    begin
      -- делаем составной ключ путем конкатенации
      l_cdc_newkey := to_char(p_cu_corp) || ';' || to_char(p_cpu_corp) || ';' ||
                      to_char(p_cu_rel) || ';' || to_char(p_pu_rel) || ';' ||
                      to_char(p_cru_rel);

      update ead_sync_sessions ss
         set ss.cdc_lastkey = l_cdc_newkey
       where ss.type_id = 'UCLIENT';

      if (sql%rowcount = 0) then
        insert into ead_sync_sessions
          (type_id, cdc_lastkey)
        values
          ('UCLIENT', l_cdc_newkey);
      end if;
    end set_cdc_newkeys;
  begin
    -- получаем ключи захвата изменений
    get_cdc_lastkeys(l_cdc_lastkey_cu_corp,
                     l_cdc_lastkey_cpu_corp,
                     l_cdc_lastkey_cu_rel,
                     l_cdc_lastkey_pu_rel,
                     l_cdc_lastkey_cru_rel);

    -- берем всех клиентов ЮЛ, у которых было изменение в реквизитах
    select max(cu.idupd) into l_cdc_newkey_cu_corp from customer_update cu;
    select max(cpu.idupd) into l_cdc_newkey_cpu_corp from corps_update cpu;
    for cur in (select cu.rnk from customer_update cu
                 where cu.idupd > l_cdc_lastkey_cu_corp
                   and cu.idupd <= l_cdc_newkey_cu_corp
                   and cu.date_off is null
                   and ead_pack.get_custtype(cu.rnk) = 2
                union
                select cpu.rnk from corps_update cpu
                 where cpu.idupd > l_cdc_lastkey_cpu_corp
                   and cpu.idupd <= l_cdc_newkey_cpu_corp)
    loop
      l_sync_id := ead_pack.msg_create('UCLIENT', to_char(cur.rnk));
    end loop;

    -- берем всех клиентов ЮЛ и ФЛ, у которых было изменение в реквизитах и которые есть связанными лицами с ЮЛ
    select max(cu.idupd) into l_cdc_newkey_cu_rel from customer_update cu;
    select max(pu.idupd) into l_cdc_newkey_pu_rel from person_update pu;
    for cur in (select cr.rnk,
                       cr.rel_id,
                       cr.rel_rnk
                  from customer_rel cr, customer c
                 where cr.rel_rnk = c.rnk
                   and cr.rel_id > 0
                   --and cr.rel_intext = 1 --лише клієнти банку
                   and cr.rnk in
                       (select c.rnk
                          from customer c
                         where ead_pack.get_custtype(c.rnk) = 2
                           and date_off is null)
                   and cr.rel_rnk in
                       (select cu.rnk
                          from customer_update cu
                         where cu.idupd > l_cdc_lastkey_cu_rel
                           and cu.idupd <= l_cdc_newkey_cu_rel
                        union all
                        select pu.rnk
                          from person_update pu
                         where pu.idupd > l_cdc_lastkey_pu_rel
                           and pu.idupd <= l_cdc_newkey_pu_rel
                         union all
                        select ce.id
                          from customer_extern_update ce
                         where ce.idupd > l_cdc_lastkey_pu_rel
                           and ce.idupd <= l_cdc_newkey_pu_rel)   ) 
    loop
      -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
      if (ead_pack.get_custtype(cur.rel_rnk) = 2) then
        l_sync_id := ead_pack.msg_create('UCLIENT', to_char(cur.rel_rnk));
      else
        l_sync_id := ead_pack.msg_create('CLIENT', to_char(cur.rel_rnk));
      end if;
    end loop;

    -- берем всех клиентов, у которых были добавлены 3-и лица за период от последней отправки
    select max(cru.idupd)
      into l_cdc_newkey_cru_rel
      from customer_rel_update cru;

   for cur in (select distinct cru.rnk
                  from customer_rel_update cru
                 where cru.idupd > l_cdc_lastkey_cru_rel
                   and cru.idupd <= l_cdc_newkey_cru_rel
                   and cru.rel_id > 0
                   and ead_pack.get_custtype(cru.rnk) = 2)
    loop
      -- поочередно отправляем карточки 3х лиц
      for cur1 in (select cru.rnk,
                          cru.rel_rnk
                     from customer_rel_update cru
                    where cru.idupd > l_cdc_lastkey_cru_rel
                      and cru.idupd <= l_cdc_newkey_cru_rel
                      and cru.rel_id > 0
                      and cru.rel_intext = 1--лише кліенти банку, не клієнти відправляються в масиві (id, name, okpo) пов'язаними особами на UCLIENT'
                      and cru.rnk = cur.rnk) loop
        -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
        if (get_custtype(cur1.rel_rnk) = 2) 
        then l_sync_id := msg_create('UCLIENT', to_char(cur1.rel_rnk));
        else l_sync_id := msg_create('CLIENT',  to_char(cur1.rel_rnk));
        end if;
      end loop;

      for cur2 in (select cr.rnk,
                          cr.rel_rnk
                     from customer_extern_update cext, customer_rel cr
                    where cext.idupd > l_cdc_lastkey_cru_rel
                      and cext.idupd <= l_cdc_newkey_cru_rel
                      and cr.rel_id > 0
                      and cr.rel_rnk = cext.id
                      and cr.rnk = cur.rnk) loop
        -- в зависимости от типа найденого клиента (ФЛ/ЮЛ) ставим в очередь синхронизации разные объекты
        if (get_custtype(cur2.rel_rnk) = 2) 
        then l_sync_id := msg_create('UCLIENT', to_char(cur2.rel_rnk));
        else l_sync_id := msg_create('CLIENT',  to_char(cur2.rel_rnk));
        end if;
      end loop;
      -- добавляем основного клиента
      l_sync_id := ead_pack.msg_create('UCLIENT', to_char(cur.rnk));--не клієнти відправляться тут, якщо вони були додані.
    end loop;

    -- сохраняем ключи захвата
    set_cdc_newkeys(l_cdc_newkey_cu_corp,
                    l_cdc_newkey_cpu_corp,
                    l_cdc_newkey_cu_rel,
                    l_cdc_newkey_pu_rel,
                    l_cdc_newkey_cru_rel);

    commit;
  end cdc_client_u;

  -- Захват изменений - Угода Юр.лица.
  procedure cdc_agr_u is
    l_sync_id ead_sync_queue.id%type;

    l_cdc_lastkey_dpt dpu_deal_update.idu%type;--для депозитів деп.модуля
    l_cdc_newkey_dpt  dpu_deal_update.idu%type;
    l_cdc_lastkey_acc accounts_update.idupd%type;--поточні рахунки
    l_cdc_newkey_acc  accounts_update.idupd%type;
    l_cdc_lastkey_specparam specparam_update.idupd%type;
    l_cdc_newkey_specparam  specparam_update.idupd%type;
    l_cdc_lastkey_dpt_old accounts_update.idupd%type;--для депозитів поза деп.модулем
    l_cdc_newkey_dpt_old  accounts_update.idupd%type;


    -- получение ключей захвата изменений
    procedure get_cdc_lastkeys(p_dpt out dpu_deal_update.idu%type,
                               p_acc out accounts_update.idupd%type,
                               p_dpt_old out accounts_update.idupd%type,
                               p_specparam out specparam_update.idupd%type ) is
      l_cdc_lastkey ead_sync_sessions.cdc_lastkey%type;
    begin
      select  nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,1)),0),
              nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,2)),0),
              nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,3)),0),
              nvl(to_number(regexp_substr(SS.CDC_LASTKEY,'[^;]+',1,4)),0)
             into p_dpt, p_acc, p_dpt_old, p_specparam
               from ead_sync_sessions ss
       where ss.type_id = 'UAGR';
    exception
      when others then
        select max(ddu.idu) into p_dpt from dpu_deal_update ddu;
        select max(au.idupd) into p_acc from accounts_update au;
        select max(au.idupd) into p_dpt_old from accounts_update au;
        select max(su.idupd) into p_specparam from specparam_update su;
    end get_cdc_lastkeys;
    -- сохранение ключей захвата изменений
    procedure set_cdc_newkeys(p_dpt in dpu_deal_update.idu%type,
                              p_acc in accounts_update.idupd%type,
                              p_dpt_old in accounts_update.idupd%type,
                              p_specparam in specparam_update.idupd%type ) is
      l_cdc_newkey ead_sync_sessions.cdc_lastkey%type;
    begin
      -- делаем составной ключ путем конкатенации
      l_cdc_newkey := to_char(p_dpt) || ';' || to_char(p_acc)|| ';' || to_char(p_dpt_old)|| ';' || to_char(p_specparam);

      update ead_sync_sessions ss
         set ss.cdc_lastkey = l_cdc_newkey
       where ss.type_id = 'UAGR';

      if (sql%rowcount = 0) then
        insert into ead_sync_sessions
          (type_id, cdc_lastkey)
        values
          ('UAGR', l_cdc_newkey);
      end if;
    end set_cdc_newkeys;
  begin
    -- получение ключей захвата изменений
    get_cdc_lastkeys(l_cdc_lastkey_dpt, l_cdc_lastkey_acc,l_cdc_lastkey_dpt_old, l_cdc_lastkey_specparam);

    -- депезиты по которым были изменения(заведені в деп.модулі)
    select max(ddu.idu) into l_cdc_newkey_dpt from dpu_deal_update ddu;
    for cur in (select 'DPT' as agr_type, ddu.dpu_id, ddu.rnk
                  from dpu_deal_update ddu
                 where ddu.idu > l_cdc_lastkey_dpt
                   and ddu.idu <= l_cdc_newkey_dpt
                   and (
                          EXISTS
                              (SELECT 1
                                 FROM accounts acc
                                WHERE        DDU.ACC = acc.ACC
                                         AND ((  (acc.NBS = '2600' AND acc.ob22 = '05'))
                                              OR (acc.NBS IN (select nbs from EAD_NBS where custtype = 2))) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                         AND acc.TIP = 'DEP')
                          or
                          exists(
                                 select 1 from accounts acc
                                 where DDU.ACC = acc.ACC
                                            AND acc.TIP = 'NL8'
                                 )
                        )
                   ) 
    loop
      -- на всякий передаем клиента
      l_sync_id := ead_pack.msg_create('UCLIENT', to_char(cur.rnk));
      -- за ним сделку
      l_sync_id := ead_pack.msg_create('UAGR',
                                       cur.agr_type || ';' ||
                                       to_char(cur.dpu_id));
    end loop;

/* 17.10.2017  По счету nbs=2600, ob22=1, tip=ODB  вылезло 2 договора (UAGR;DPT_OLD  UAGR;DBO).
   Сам счет был по dbo. Поэтому выкашываем это старье, пока не вылезет чтото что должно было бы проехать через это

    -- депезиты по которым были изменения(заведені поза  деп.модулем)
    select max(au.idupd) into l_cdc_newkey_dpt_old from accounts_update au;
    for cur in (SELECT DISTINCT 'DPT_OLD' AS agr_type,
                                TRUNC (au.daos) AS date_open,
                                au.nls,
                                au.acc,
                                au.rnk
                  FROM accounts_update au
                 WHERE     au.idupd > l_cdc_lastkey_dpt_old
                       AND au.idupd <= l_cdc_newkey_dpt_old
                       and au.CHGDATE >= (SELECT MIN (t1.CHGDATE)
                                       FROM accounts_update t1
                                      WHERE t1.idupd > l_cdc_lastkey_dpt_old
                                        AND CHGDATE >= LAST_DAY (ADD_MONTHS (SYSDATE, -3)))                     
                       AND get_custtype (au.rnk) = 2
                       AND (   (get_acc_nbs(au.acc) = '2600' AND au.ob22 = '05')
                            OR (get_acc_nbs(au.acc) IN (SELECT nbs FROM EAD_NBS WHERE custtype = 2))-- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                           )
                       AND au.TIP NOT IN ('DEP', 'NL8'))  
    loop
      -- на всякий передаем клиента
      l_sync_id := ead_pack.msg_create('UCLIENT', to_char(cur.rnk));
      -- за ним сделку
      l_sync_id := ead_pack.msg_create('UAGR',
                                       cur.agr_type || ';' || cur.nls || '|' ||
                                       to_char(cur.date_open, 'yyyymmdd') || '|' ||
                                       to_char(cur.acc));
    end loop;
*/

    -- текущие счета клиентов ЮЛ по которым были изменения
    select max(au.idupd) into l_cdc_newkey_acc from accounts_update au;
    select max(su.idupd) into l_cdc_newkey_specparam from specparam_update su;

    if (l_cdc_lastkey_acc = 0) then
      l_cdc_lastkey_acc := l_cdc_newkey_acc;
    end if;

    if (l_cdc_lastkey_specparam = 0) then
      l_cdc_lastkey_specparam := l_cdc_newkey_specparam;
    end if;

    --перероблено на одну відпрвку по одному рахунку при змінах в accounts or specparam
    for cur in (select distinct 'ACC' as agr_type,
                       au.acc as acc,
                       au.rnk as rnk
                  from accounts_update au
                 where au.idupd > l_cdc_lastkey_acc
                   and au.idupd <= l_cdc_newkey_acc
                   and au.CHGDATE >= (SELECT MIN (t1.CHGDATE)
                                       FROM accounts_update t1
                                      WHERE t1.idupd > l_cdc_lastkey_acc
                                        AND CHGDATE >= LAST_DAY (ADD_MONTHS (SYSDATE, -3))) 
                   and get_custtype(au.rnk) = 2 
                   and not exists (select 1 from dpu_accounts da where da.accid = au.acc)
                   and exists (select 1
                                 from accounts a
                                where a.acc = au.acc
                                  and (   get_acc_nbs(a.acc) in (select nbs from EAD_NBS where custtype = 2) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                       or get_acc_nbs(a.acc) = '2600' and a.ob22 in ('01', '02', '10')
                                      )
                   and au.tip not in ('DEP', 'DEN', 'NL8'))
          union
                           select distinct 'ACC' as agr_type,
                       su.acc as acc,
                       (select rnk from accounts where acc = su.acc) as rnk
                  from specparam_update su
                 where su.idupd > l_cdc_lastkey_specparam
                   and su.idupd <= l_cdc_newkey_specparam                    
                   and not exists (select 1 from dpu_accounts da where da.accid = su.acc)
                   and exists (select 1
                                 from accounts a
                                where a.acc = su.acc
                                  and get_custtype(a.rnk) = 2
                                  and REGEXP_LIKE(su.nkd ,'\d{7}-\d{6}-\d{6}')
                                  and a.tip not in ('DEP', 'DEN', 'NL8')
                                  and (   get_acc_nbs(a.acc) in (select nbs from EAD_NBS where custtype = 2) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" (до 11 мая 2017)
                                       or get_acc_nbs(a.acc) = '2600' and a.ob22 in ('01', '02', '10')                                    
                                      )                                     
                   )  
                 ) loop
      -- на всякий передаем клиента
	  bars_audit.info('ead_pack.msg_create(''UCLIENT'', '||to_char(cur.rnk));
      l_sync_id := ead_pack.msg_create('UCLIENT', to_char(cur.rnk));
      -- за ним сделку, если это "старый счет" = не в рамках ДБО
	  if get_acc_info(cur.acc) = 0
	  THEN
	  bars_audit.info('ead_pack.msg_create(''UAGR'', '||cur.agr_type||','||to_char(cur.acc));
      l_sync_id := ead_pack.msg_create('UAGR',
                                       cur.agr_type || ';' || to_char(cur.acc) );
      else
		  if is_first_accepted_acc(cur.acc) = 1
		  then
		   l_sync_id := ead_pack.msg_create('UAGR', 'DBO;'||to_char(cur.rnk));
		  end if;
	  end if;
    end loop;

    -- сохранение ключей захвата изменений
    set_cdc_newkeys(l_cdc_newkey_dpt, l_cdc_newkey_acc,l_cdc_newkey_dpt_old,l_cdc_newkey_specparam);

    commit;
  end cdc_agr_u;

  -- Захват изменений - счета клієнта Юр.Лицо
  procedure cdc_acc is
    l_sync_id ead_sync_queue.id%type;

    l_cdc_lastkey_acc accounts_update.idupd%type;
    l_cdc_newkey_acc  accounts_update.idupd%type;

    -- получение ключей захвата изменений
    procedure get_cdc_lastkeys(p_acc out accounts_update.idupd%type) is
      l_cdc_lastkey ead_sync_sessions.cdc_lastkey%type;
    begin
      select ss.cdc_lastkey
        into l_cdc_lastkey
        from ead_sync_sessions ss
       where ss.type_id = 'ACC';

      p_acc := to_number(l_cdc_lastkey);
    exception
      when no_data_found then
        select max(au.idupd) into p_acc from accounts_update au;
    end get_cdc_lastkeys;
    -- сохранение ключей захвата изменений
    procedure set_cdc_newkeys(p_acc in accounts_update.idupd%type) is
      l_cdc_newkey ead_sync_sessions.cdc_lastkey%type;
    begin
      -- делаем составной ключ путем конкатенации
      l_cdc_newkey := to_char(p_acc);

      update ead_sync_sessions ss
         set ss.cdc_lastkey = l_cdc_newkey
       where ss.type_id = 'ACC';

      if (sql%rowcount = 0) then
        insert into ead_sync_sessions
          (type_id, cdc_lastkey)
        values
          ('ACC', l_cdc_newkey);
      end if;
    end set_cdc_newkeys;
  begin
    -- получение ключей захвата изменений
    get_cdc_lastkeys(l_cdc_lastkey_acc);

    -- берем все изменения по счетам клиентов
    select max(au.idupd) into l_cdc_newkey_acc from accounts_update au;
    for cur in (
      select agr_type, acc from 
        (select 
        case when (nbs = '2600' and ob22 = '05') OR (TIP IN ('DEP', 'NL8') AND EXISTS (SELECT 1 FROM dpu_accounts da WHERE da.accid = acc)) 
             then 'DPT'
             when (nbs = '2600' and ob22 IN ('01', '02', '10')) OR (tip NOT IN ('DEP', 'DEN', 'NL8') AND NOT EXISTS (SELECT 1 FROM dpu_accounts da WHERE da.accid = acc))
             then 'ACC'
             when (ob22 = '05' AND TIP NOT IN ('DEP', 'NL8'))
             then 'DPT_OLD' 
        end agr_type,
        acc
        from (
                SELECT  distinct au.acc, get_acc_nbs (au.acc) nbs,
                        (select ob22 from accounts where acc = au.acc) ob22, 
                        (select tip from accounts where acc = au.acc) tip                        
                  FROM accounts_update au
                 WHERE     au.idupd > l_cdc_lastkey_acc
                       AND au.idupd <= l_cdc_newkey_acc          
                       and au.CHGDATE >= (SELECT MIN (t1.CHGDATE)
                                       FROM accounts_update t1
                                      WHERE t1.idupd > l_cdc_lastkey_acc
                                        AND CHGDATE >= LAST_DAY (ADD_MONTHS (SYSDATE, -3)))                      
                       AND (   (get_acc_nbs (au.acc) = '2600')
                            OR (get_acc_nbs (au.acc) IN (SELECT nbs FROM EAD_NBS WHERE custtype = 2))) -- "2" это и СПД и Юрлица, раньше СПД в справочнике числились как "3" 
                      ) t) 
           where agr_type is not null
     ) 
    loop
      l_sync_id := ead_pack.msg_create('ACC',cur.agr_type || ';' || to_char(cur.acc));
    end loop;

    -- сохранение ключей захвата изменений
    set_cdc_newkeys(l_cdc_newkey_acc);

    commit;
  end cdc_acc;

  -- !!! Пока в ручном режиме DICT  Довідник  SetDictionaryData

  -- Передача в ЭА сообщение типа
  procedure type_process(p_type_id in ead_types.id%type) is
    l_t_row ead_types%rowtype;
    l_s_row ead_sync_sessions%rowtype;
    l_rows  pls_integer; --ограничение кол-ва строк обработки за один запуск
  begin
    -- параметры
      select * into l_t_row from ead_types where id = p_type_id;

      begin
        select * into l_s_row from ead_sync_sessions where type_id = p_type_id;
      exception
        when no_data_found then
          bars_audit.info('type_process: не найдено ключа=' || p_type_id);
      end;

    -- дата/время старта
    l_s_row.sync_start := sysdate;
    --кол-во строк за один пробег
    begin
      select nvl(val, 1000)
        into l_rows
        from PARAMS$GLOBAL
       where par = 'EAD_ROWS';
    EXCEPTION
      WHEN NO_DATA_FOUND then
        l_rows := 1000;
    end;
    -- обработка каждого запроса по отдельности
    for cur in (select * from (select id, crt_date, type_id, status_id,
                               -- дата|час повторної передачі, зростає у арифметичній прогресії по кількості помилок
                               crt_date + l_t_row.msg_retry_interval * nvl(err_count, 0) * (nvl(err_count, 0) + 1) / (2 * 60 * 24) as trans_date
                          FROM bars.ead_sync_queue
                         WHERE type_id = p_type_id
                           AND status_id IN ('NEW', 'ERROR')
                           AND nvl(err_count, 0) < 30
--                             and regexp_like(err_text, 'rnk \d+ not found', 'i')
--                           AND crt_date > ADD_MONTHS(SYSDATE, -g_process_actual_time)
                           and crt_date > sysdate - interval '15' day
                         order by status_id  desc, trans_date asc, id asc)
                 where ROWNUM < NVL(l_rows, 1000)
--                   and trans_date <= l_s_row.sync_start)
                   and trans_date <= sysdate)
    loop
      msg_process(cur.id);
/*
       IF (cur.status_id = 'NEW')
       THEN
          -- новые отправляем
          msg_process (cur.id, cur.kf);
       ELSE
          IF ( (l_s_row.sync_start - cur.crt_date) * 24 * 60 >=
                 l_t_row.msg_lifetime)
          THEN
             -- если вышло время актуальности, то сбрасываем в OUTDATED
             msg_set_status_outdated (cur.id, cur.kf);
          ELSIF ( (l_s_row.sync_start - cur.crt_date) * 24 * 60 >=
                      l_t_row.msg_retry_interval
                    * get_sum (cur.err_count + 1))
          THEN
             -- смотрим пришло ли время повторного запроса
             msg_process (cur.id, cur.kf);
          END IF;
       END IF;
*/
    end loop;

    -- дата/время финиша
    l_s_row.sync_end := sysdate;

    -- сохраняем
    update ead_sync_sessions s
       set s.sync_start = l_s_row.sync_start, s.sync_end = l_s_row.sync_end
     where s.type_id = p_type_id;
    commit;
  end type_process;

 function get_acc_info(p_acc in accounts.acc%type) return int
 is
 l_result int := 0;
 l_ndbo varchar2(50);
 l_sdbo varchar2(50);
 l_daos date;
 begin
  -- узнать, является ли счет - счетом в рамках ДБО
  --1) наличие у клиента ДБО-договора
  select kl.get_customerw (rnk, 'NDBO'), kl.get_customerw (rnk, 'DDBO'), daos
    into l_ndbo, l_sdbo, l_daos
	from accounts
   where acc = p_acc;
  --2) если нет договора ДБО - то точно это обычный, резалт еще 0
  --3) если ДБО оформлен, счет может быть открыт до ДБО, его считаем "старым"
    if (l_ndbo is not null and trunc(l_daos) >= to_date(replace(l_sdbo,'.','/'), 'dd/mm/yyyy'))
	then l_result := 1;
	end if;
  return l_result;
 end;

-- функция возвращает 1 если это первый акцептированный счет в рамках ДБО, 0 - если не первый
  function is_first_accepted_acc(p_acc in accounts.acc%type) return int
  is
  l_result int := 0;
  l_rnk customer.rnk%type;
  l_count int := 0;
  begin
   if (get_acc_info(p_acc) = 1) -- счет в рамках ДБО
   then
    begin
		select rnk
		  into l_rnk
		  from accounts
		 where acc = p_acc
		   and nbs is not null  -- это значит, что счет точно не в статусе "зарезервирован"
		   and nbs in (select nbs from EAD_NBS);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_rnk := NULL;
         END;
   end if;

    if l_rnk is not null
	then
	select count(acc)
	  into l_count
	  from accounts
	 where rnk = l_rnk
	   and nbs in (select nbs from EAD_NBS) -- значит счет не в статусе "зарезервирован", раз у него есть НБС
	   and get_acc_info(acc) = 1  -- значит другие счета относятся к договору ДБО
	   and acc != p_acc;
    end if;

      IF l_count = 0 and kl.get_customerw (l_rnk, 'SDBO') is not null THEN
         l_result := 1;
      END IF;

   return l_result;
  end is_first_accepted_acc; 

     -- функция возвращает nbs для открытого и псевдо - nbs для зарезервированного счета  
  function get_acc_nbs(p_acc in accounts.acc%type) return char is
    l_nbs char(4);
  begin
    select case
             when acc.daos = trunc(acc.dazs) and acc.nbs is null then
              substr(acc.nls, 1, 4)
             else
              acc.nbs
           end
      into l_nbs
      from accounts acc
     where acc.acc = p_acc;
    return l_nbs;
  end get_acc_nbs;

  -- функция возвращает "2" для юрлиц и спд, "3" для физлиц
  function get_custtype(p_rnk in customer.rnk%type) return number is
    l_custtype number(1);
  begin
    select case
             when custtype in (1, 2) then 2
             when custtype = 3 and rtrim(sed) = '91' /*and ise in ('14100', '14101', '14200', '14201')*/ then 2
             else 3
           end
      into l_custtype
      from customer
     where rnk = p_rnk;
    return l_custtype;
  end get_custtype;


end ead_pack;
/
show errors


 
PROMPT *** Create  grants  EAD_PACK ***
grant EXECUTE                                                                on BARS.EAD_PACK        to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ead_pack.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
