create or replace package EBKC_PACK
is

  g_header_version constant varchar2(64) := 'version 1.00 31/04/2016';

  -- типи клієнтів, що використовуються в ЕБК Корп
  LEGAL_PERSON      constant varchar2(1) := 'L';   -- Юр.особа
  PRIVATE_ENT       constant varchar2(1) := 'P';   -- ФОП

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  procedure save_into_hist(p_rnk in number);

  procedure clear_queue_rnk(p_rnk in number);

  function get_custtype(p_rnk in number) return varchar2;

  procedure sendcard_save_event(p_rnk in number);

  function get_wparam(p_key in varchar2) return varchar2;

  function get_group_id(p_rnk in number,
                      p_kf in varchar2) return number ;

  function get_last_modifc_date(p_rnk in number) return date;

  procedure send_request(
      p_action     in varchar2,
      p_session_id in integer,
      p_parameters in varchar2_list,
      p_values     in varchar2_list);

  procedure request_legal_dup_mass(p_batchId in varchar2,
                   p_kf in varchar2,
                   p_rnk in number,
                   p_duplicate_ebk in t_duplicate_ebk);

  procedure request_private_dup_mass(p_batchId in varchar2,
                   p_kf in varchar2,
                   p_rnk in number,
                   p_duplicate_ebk in t_duplicate_ebk);

  procedure request_legal_gcif_mass(p_batchId in varchar2,
                            p_kf in varchar2,
                            p_rnk in number,
                            p_gcif in varchar2,
                            p_slave_client_ebk in t_slave_client_ebk);

  procedure request_private_gcif_mass(p_batchId in varchar2,
                            p_kf in varchar2,
                            p_rnk in number,
                            p_gcif in varchar2,
                            p_slave_client_ebk in t_slave_client_ebk);

  procedure request_legal_updatecard_mass(p_batchId in varchar2,
                             p_kf in varchar2,
                             p_rnk in number,
                             p_anls_quality in number,
                             p_defaultGroupQuality in number,
                             p_tab_attr  t_rec_ebk,
                             p_rec_qlt_grp t_rec_qlt_grp);

  procedure request_private_updcard_mass(p_batchId in varchar2,
                             p_kf in varchar2,
                             p_rnk in number,
                             p_anls_quality in number,
                             p_defaultGroupQuality in number,
                             p_tab_attr  t_rec_ebk,
                             p_rec_qlt_grp t_rec_qlt_grp);

  procedure create_group_duplicate;

end EBKC_PACK;
/

show errors;

create or replace package body EBKC_PACK
is

  -- Версія пакету
  g_body_version constant varchar2(64) := 'version 1.02 19/01/2018';
  g_dbgcode constant varchar2(20)      := 'ebkc_pack';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
  end header_version;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body '   || g_dbgcode || ' ' || g_body_version || '.';
  end body_version;

  --
  --
  --
  function is_legal_pers
  ( p_rnk  in     number
  ) return boolean
  is
    -- l_legal       boolean := false;
    -- cursor c_legal
    -- is
    -- select null
    --   from customer
    --   where rnk = p_rnk
    --     and custtype = 2;
    -- r_legal c_legal%ROWTYPE;
  begin
    -- OPEN c_legal;
    -- FETCH c_legal INTO r_legal;
    -- l_legal := c_legal%FOUND;
    -- CLOSE c_legal;
    for x in ( select 0
                 from customer
                where rnk = p_rnk
                  and custtype = 2 )
    loop
     return true;
    end loop;

    return false;

  end is_legal_pers;

  --
  --
  --
  function is_private_ent( p_rnk in number
  ) return boolean
  is
  begin
    for x in ( select 0
                 from customer
                where rnk = p_rnk
                  and custtype = 3
                  and sed = '91  ' )
    loop
      return true;
    end loop;

    return false;

  end is_private_ent;

  function get_custtype(p_rnk in number) return varchar2 is
  l_ret varchar2(1);
  begin
    if    is_legal_pers(p_rnk)  then l_ret := LEGAL_PERSON;
    elsif is_private_ent(p_rnk) then l_ret := PRIVATE_ENT;
    end if;
    return l_ret;
  end get_custtype;

  procedure save_into_hist(p_rnk in number) is
  begin
    insert into ebkc_sendcards_hist(rnk) values(p_rnk);
  end;

  procedure clear_queue_rnk(p_rnk in number) is
  begin
    delete from ebkc_queue_updatecard where rnk = p_rnk and status = 0;
  end;

  -- !!! для фоп брати person_update, для ЮО corps_update
  function get_last_modifc_date(p_rnk in number) return date
  is
  begin
    for x in ( select greatest( ( select trunc(max(cu.chgdate))
                                    from bars.customer_update cu
                                   where rnk = p_rnk )
                              , ( select trunc(max(cwu.chgdate))
                                    from bars.customerw_update cwu
                                   where rnk = p_rnk )
                              , ( select trunc(max(pu.chgdate))
                                    from bars.corps_update pu
                                   where rnk = p_rnk )
                              , ( select trunc(max(pu.chgdate))
                                    from bars.person_update pu
                                   where rnk = p_rnk )
                              ) as last_modifc_date from dual )
    loop
      return x.last_modifc_date;
    end loop;

  end get_last_modifc_date;

  procedure sendcard_save_event(p_rnk in number) is
  begin
    save_into_hist(p_rnk);
    clear_queue_rnk(p_rnk);
  end;

  function get_wparam(p_key in varchar2) return varchar2
  is
      l_value varchar2(4000 byte);
  begin
      select t.val
        into l_value
        from web_barsconfig t
       where t.key = p_key;

       return l_value;
  exception
      when no_data_found then
           return null;
  end;

  procedure send_request
  ( p_action     in varchar2,
    p_session_id in integer,
    p_parameters in varchar2_list,
    p_values     in varchar2_list
  ) is
    l_url               varchar2(4000 byte);
    l_walett_path       varchar2(4000 byte);
    l_walett_pass       varchar2(4000 byte);
    l_bars_login        varchar2(50 char);
    l_authorization_val varchar2(4000 byte);
    l_response          wsm_mgr.t_response;
    l integer;
  begin
      l_url := get_wparam('BARS_WS_URL');
      l_walett_path := get_wparam('BARS_WS_WALLET_PATH');
      l_walett_pass := get_wparam('BARS_WS_WALLET_PASS');
      l_bars_login := get_wparam('BARS_WS_LOGIN');

      if (l_bars_login is not null) then
          l_authorization_val := 'Basic ' || utl_raw.cast_to_varchar2(
                                      utl_encode.base64_encode(
                                          utl_raw.cast_to_raw(
                                              l_bars_login || ':' || get_wparam('BARS_WS_PASS'))));
      end if;

      if (substr(l_url, length(l_url)) <> '/') then
          l_url := l_url || '/';
      end if;

      bars.wsm_mgr.prepare_request(p_url          => l_url,
                                   p_action       => p_action || '?sessionid=' || p_session_id,
                                   p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                   p_content_type => bars.wsm_mgr.G_CT_JSON,
                                   p_wallet_path  => l_walett_path,
                                   p_wallet_pwd   => l_walett_pass);

      if (l_authorization_val is not null) then
          bars.wsm_mgr.add_header(p_name  => 'Authorization',
                                  p_value => l_authorization_val);
      end if;

      if (p_parameters is not null and p_parameters is not empty) then
          l := p_parameters.first;
          while (l is not null) loop
              bars.wsm_mgr.add_parameter(p_name  => p_parameters(l), p_value => p_values(l));

              l := p_parameters.next(l);
          end loop;
      end if;

    bars.wsm_mgr.execute_request(l_response);

  end;

  --
  -- !!! додати визначення групи в залежності від типу
  --
  function get_group_id
  ( p_rnk in number,
    p_kf  in varchar2
  ) return number
  is
    l_group_id number;
  begin
    select 1  -- для ЮО і ФОП одна група
      into l_group_id
      from dual;

   return l_group_id;
  end get_group_id;

  --
  -- дублікати по ЮО,ФОП отримані від ЕГАРа
  --
  procedure request_dup_mass
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_custtype in varchar2,
    p_duplicate_ebk in t_duplicate_ebk
  ) is
    l_rnk               customer.rnk%type;
  begin

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    bars_audit.info('save received dublicate for rnk='||l_rnk);

    insert
      into ebkc_duplicate
         ( KF, RNK, DUP_KF, DUP_RNK, CUST_TYPE )
    select p_kf, l_rnk, dup.kf, dup.rnk, p_custtype
      from table (p_duplicate_ebk) dup
     where not exists ( select null
                          from ebkc_duplicate
                         where kf  = p_kf
                           and rnk = l_rnk
                           and dup_kf = dup.kf
                           and rnk = dup.rnk );
  end request_dup_mass;

  --
  -- дублікати по ЮО, отримані від ЕГАРа
  --
  procedure request_legal_dup_mass(p_batchId in varchar2,
                     p_kf in varchar2,
                     p_rnk in number,
                     p_duplicate_ebk in t_duplicate_ebk) is
  begin
    request_dup_mass (p_batchId, p_kf, p_rnk, 'L', p_duplicate_ebk);
  end request_legal_dup_mass;

  --
  -- дублікати по ФОП, отримані від ЕГАРа
  --
  procedure request_private_dup_mass(p_batchId in varchar2,
                     p_kf in varchar2,
                     p_rnk in number,
                     p_duplicate_ebk in t_duplicate_ebk) is
  begin
    request_dup_mass (p_batchId, p_kf, p_rnk, 'P', p_duplicate_ebk);
  end request_private_dup_mass;

  --
  -- gcif по ЮО,ФОП отримані від ЕГАРа
  --
  procedure REQUEST_GCIF_MASS
  ( p_batchId          in     varchar2,
    p_kf               in     varchar2,
    p_rnk              in     number,
    p_gcif             in     varchar2,
    p_custtype         in     varchar2,
    p_slave_client_ebk in     t_slave_client_ebk
  ) is
    title          constant   varchar2(64) := $$PLSQL_UNIT||'.REQUEST_GCIF_MASS';
    l_sysdate                 date;
    l_rnk                     customer.rnk%type;
  begin

    l_sysdate := sysdate;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_policy_group('WHOLE');
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    -- перед загрузкой мастер-записи  с GCIF - ом и подчиненных записей,
    -- необходимо очистить старую загрузку подчиненных карточек по этой же мастер карточке,
    -- т.к. могли быть добавлены или уделены некоторые

    delete EBKC_SLAVE
     where gcif = p_gcif
        or gcif = (select gcif from ebkc_gcif where kf = p_kf and rnk = l_rnk) ;

    delete EBKC_GCIF
     where (kf = p_kf and rnk = l_rnk)
        or (gcif = p_gcif);

    -- записиваем присланную актуальную структуру
   insert into ebkc_gcif(kf, rnk, gcif, insert_date, cust_type)
   values (p_kf, l_rnk, p_gcif, l_sysdate, p_custtype);

   insert
     into ebkc_slave
        ( gcif, slave_kf, slave_rnk, cust_type )
   select p_gcif, sce.kf, sce.rnk, p_custtype
     from table( p_slave_client_ebk ) sce
    where not exists ( select null from ebkc_slave
                        where gcif = p_gcif
                          and slave_kf = sce.kf
                          and slave_rnk = sce.rnk
                          and cust_type = p_custtype );
   commit;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_context;
$end

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
      rollback;
$if EBK_PARAMS.CUT_RNK $then
      bc.set_context;
$end
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk)||', p_gcif='||p_gcif );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_GCIF_MASS;

  --
  --
  --
  procedure request_legal_gcif_mass(p_batchId in varchar2,
                              p_kf in varchar2,
                              p_rnk in number,
                              p_gcif in varchar2,
                              p_slave_client_ebk in t_slave_client_ebk) is
  begin
    request_gcif_mass(p_batchId, p_kf, p_rnk, p_gcif, 'L', p_slave_client_ebk);
  end request_legal_gcif_mass;

  --
  --
  --
  procedure request_private_gcif_mass(p_batchId in varchar2,
                              p_kf in varchar2,
                              p_rnk in number,
                              p_gcif in varchar2,
                              p_slave_client_ebk in t_slave_client_ebk) is
  begin
    request_gcif_mass(p_batchId, p_kf, p_rnk, p_gcif, 'P', p_slave_client_ebk);
  end request_private_gcif_mass;

  --
  --
  --
  procedure request_updatecard_mass
  ( p_batchId             in     varchar2,
    p_kf                  in     varchar2,
    p_rnk                 in     number,
    p_anls_quality        in     number,
    p_defaultGroupQuality in     number,
    p_custtype            in     varchar2,
    p_tab_attr            in     t_rec_ebk,
    p_rec_qlt_grp         in     t_rec_qlt_grp
  ) is
    l_rnk               customer.rnk%type;
  begin

$if EBK_PARAMS.CUT_RNK $then
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    -- не храним предыдущие рекомендации по конкретному kf, rnk,
    -- новый пакет рекомендаций стирает старые рекомендации по
    bars_audit.info('process recommendation for rnk='||l_rnk);

    --удаление неактуальных более рекомендаций
    delete from ebkc_req_updcard_attr
     where kf = p_kf
       and rnk = l_rnk
       and cust_type = p_custtype
       and name in (select name
                      from table(p_tab_attr) b
                     where b.quality = 'C'
                        or b.name is not null);

    if sql%rowcount > 0 then
       delete
         from ebkc_req_updatecard u
        where u.kf = p_kf
          and u.rnk = l_rnk
          and not exists (select 1
                            from ebkc_req_updcard_attr a
                           where a.kf = u.kf
                             and a.rnk = u.rnk);
    end if;

    -- сохраняем только ошибки и предупреждения
    -- только одна рекомендация может быть у реквизита
        insert into ebkc_req_updcard_attr( kf, rnk, quality, name, value, recommendValue, descr, cust_type)
                                    select p_kf, l_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr, p_custtype
                                    from table(p_tab_attr) ms
                                    where --ms.quality <> 'C'
                                      (ms.recommendvalue is not null or ms.descr is not null)
                                      and not exists ( select null from ebkc_req_updcard_attr
                                                        where kf = p_kf
                                                          and rnk = l_rnk
                                                          and name = ms.name
                                                     )
                                      -- !!! для теста - приймаємо все!
                                      --and exists -- не грузим рекомендации по которым не прописаны действия  в EBKC_CARD_ATTRIBUTES.ACTION
                                      --        ( select null from ebkc_card_attributes where name = ms.name and action is not null and cust_type = p_custtype)
                                              ;
       -- создаем мастер запись если заполнился выше детаил
       if sql%rowcount > 0 then

        insert into ebkc_req_updatecard( batchId, kf , rnk, quality, defaultGroupQuality, group_id )
                                   select p_batchId, p_kf, l_rnk,  p_anls_quality, p_defaultGroupQuality
                                          ,get_group_id(l_rnk,p_kf) as group_id
                                     from dual where not exists (select null from ebkc_req_updatecard
                                                                  where kf = p_kf
                                                                    and rnk = l_rnk
                                                                );
        end if;
    -- удаляем ранее загруженные проценты качества
    delete from ebkc_qualityattr_groups
     where kf = p_kf and rnk = l_rnk;
    -- сохраняем отдельно проценты качества в любом случае, т.к. далее понадобятся в дедубликации
    -- качества приходят по всей карточке, по основной группе или по умолчанию обязательно ,
    -- а также динамически созд-ым группам
    insert into ebkc_qualityattr_groups( batchid ,kf ,rnk , name , quality, cust_type )
     select p_batchId, p_kf, l_rnk , 'card', p_anls_quality, p_custtype  from dual
     union all
     select p_batchId, p_kf, l_rnk, 'default', p_defaultGroupQuality, p_custtype  from dual
     union all
     select p_batchId, p_kf ,l_rnk ,gr.name, gr.quality, p_custtype from table(p_rec_qlt_grp) gr
     where gr.name is not null;

    --Заполняем таблицу-справочник групп
    insert into  ebkc_quality_groups
    select s_ebk_quality_groups.nextval, g.name, p_custtype
      from table(p_rec_qlt_grp) g
     where not exists (select 1
                         from ebkc_quality_groups qg
                        where qg.qg_name = g.name and cust_type= p_custtype);

    --commit;
   exception
     when others then rollback; raise;
  end request_updatecard_mass;

  --
  --
  --
  procedure request_legal_updatecard_mass
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_anls_quality in number,
    p_defaultGroupQuality in number,
    p_tab_attr  t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  ) is
  begin
    request_updatecard_mass(p_batchId, p_kf, p_rnk, p_anls_quality, p_defaultGroupQuality,  'L', p_tab_attr,p_rec_qlt_grp);
  end request_legal_updatecard_mass;

  --
  --
  --
  procedure request_private_updcard_mass
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_anls_quality in number,
    p_defaultGroupQuality in number,
    p_tab_attr  t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  ) is
  begin
    request_updatecard_mass(p_batchId, p_kf, p_rnk, p_anls_quality, p_defaultGroupQuality,  'P', p_tab_attr,p_rec_qlt_grp);
  end request_private_updcard_mass;

  --
  -- run from JOB
  --
  procedure create_group_duplicate
  is
    l_trace  varchar2(500) := g_dbgcode || 'create_group_duplicate: ';
    l_kf varchar2(6);
    l_cycle integer;
    l_lock VARCHAR2(30);
    l_status NUMBER;
    ---
    procedure create_group_duplicate_kf
    is
    begin

      bars_audit.info(l_trace||' Entry with KF='||l_kf);

      for r in ( select distinct rnk
                   from ebkc_duplicate
                  where kf = l_kf
                     or kf = dup_kf
                  order by rnk )
      loop

        dbms_application_info.set_client_info(l_trace|| ' set MC for rnk=' || r.rnk);

        -- устанавливаем основную карточку
        -- выбор по правилу наивыcшего - продукт,дата последней модификации, качество картки клиента
        for x in ( select rnk, dup_rnk,  product_id, last_modifc_date, quality
                        , row_number() over (partition by rnk order by product_id asc, last_modifc_date desc nulls last ,quality desc) as master_queue
                        from ( select d.rnk, d.dup_rnk
                                      , ebkc_pack.get_group_id(d.dup_rnk, l_kf)   as product_id
                                      , ebkc_pack.get_last_modifc_date(d.dup_rnk) as last_modifc_date
                                      , nvl( (select max(quality)
                                                from EBKC_QUALITYATTR_GROUPS
                                               where kf = l_kf
                                                 and rnk = d.dup_rnk
                                                 and name = 'card'), 0 ) as quality
                               from ( select distinct rnk, dup_rnk
                                        from ebkc_duplicate
                                       where rnk=r.rnk
                                         and kf = l_kf
                                       union
                                      select distinct rnk, rnk as dup_rnk
                                        from ebkc_duplicate
                                       where rnk=r.rnk
                                         and kf = l_kf
                                    ) d
                             )
                    )
        loop

            bars_audit.trace(l_trace||'set master card for rnk = %s, dup_rnk = %s, last_modifc_date=%s, quality=%s, master_card=%s',
                               to_char(x.rnk), to_char(x.dup_rnk), to_char(x.last_modifc_date), to_char(x.quality), to_char(x.master_queue));
            if x.master_queue = 1
            then -- это наша основная карточка
               update ebkc_duplicate
               set rnk = x.dup_rnk
               where rnk = x.rnk;

               update ebkc_duplicate
               set dup_rnk = x.rnk
               where rnk = x.dup_rnk and dup_rnk = x.dup_rnk;
            end if;
          end loop;
      end loop;

      bars_audit.info(l_trace||' Exit.');

    end create_group_duplicate_kf;
    ---
  begin

    bars_audit.info(l_trace||' Start');

    l_kf := sys_context('bars_context','user_mfo');

    -- только один процесс может быть запущен
    dbms_lock.allocate_unique('LegalDuplicateGroups', l_lock);
    l_status := dbms_lock.request(l_lock, dbms_lock.x_mode,180,true);

    bars_audit.trace('dbms_lock status for LegalDuplicateGroups = %s', to_char(l_status));

    if l_status = 0
    THEN
      -- блокируем таблицу с загруженными дубликатами на время создания групп
      -- после создания групп очищаем от данных участвующие в создании групп и освобождаем таблицу
      lock table ebkc_duplicate in exclusive mode;

      -- -- удаляем карточки из чужих РУ
      -- delete from ebkc_duplicate where kf <> l_kf or kf<> dup_kf;

      if ( l_kf Is Null )
      then
        for i in ( select KF
                   from BARS.MV_KF )
        loop
          l_kf := i.KF;
          create_group_duplicate_kf;
        end loop;
      else
        create_group_duplicate_kf;
      end if;

      -- заполняем группами дедубликаций
      insert into ebkc_duplicate_groups (m_rnk, d_rnk, cust_type, kf)
      select distinct rnk, dup_rnk, cust_type, kf
        from ebkc_duplicate
       where rnk <> dup_rnk
         and not exists (select null from ebkc_duplicate_groups where m_rnk = rnk and d_rnk = dup_rnk );

      --очищаем от обработанных
      delete from ebkc_duplicate;

      --очищаем от закрытых дочерних
      delete from ebkc_duplicate_groups e
       where exists ( select null from customer where rnk = e.d_rnk and date_off is not null);

     commit; --фиксация, освобождение ebkc_duplicate от блокировки

   end if;
   l_status := dbms_lock.release(l_lock);
   bars_audit.info(l_trace||' finished');
   exception
     when others then
       rollback;
       raise;
  end create_group_duplicate;



begin
  null;
end EBKC_PACK;
/

show errors;

grant EXECUTE on EBKC_PACK to BARS_ACCESS_DEFROLE;
