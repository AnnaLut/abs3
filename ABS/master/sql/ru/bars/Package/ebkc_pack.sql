create or replace package EBKC_PACK
is
  --
  -- Customer Data Management (CDM)
  --
  g_header_version constant varchar2(64) := 'version 1.04 19/07/2018';

  -- типи клієнтів, що використовуються в ЕБК Корп
  LEGAL_ENTITY      constant varchar2(1) := 'L';   -- ЮО
  PRIVATE_ENT       constant varchar2(1) := 'P';   -- ФОП (Entepreneur)
  INDIVIDUAL        constant varchar2(1) := 'I';   -- ФО

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  function get_custtype(p_rnk in number) return varchar2;

  function get_wparam(p_key in varchar2) return varchar2;

  function get_group_id( p_rnk in number, p_kf in varchar2 ) return number ;

  function GET_LAST_CHG_DT
  ( p_rnk       in  number
  , p_cust_tp   in  varchar2 default null
  ) return date;

  function GET_LAST_MODIFC_DATE
  ( p_rnk       in  number
  ) return date;

  --
  -- ENQUEUE
  --
  procedure ENQUEUE
  ( p_rnk                 in  ebkc_queue_updatecard.rnk%type
  , p_cust_tp             in  ebkc_queue_updatecard.cust_type%type );

  --
  -- DEQUEUE
  --
  procedure DEQUEUE
  ( p_rnk                 in  ebkc_queue_updatecard.rnk%type );

  --
  -- DEQUEUE
  --
  procedure DEQUEUE
  ( p_kf                  in  ebkc_queue_updatecard.kf%type
  , p_rnk                 in  ebkc_queue_updatecard.rnk%type );

  procedure SEND_REQUEST
  ( p_action              in  varchar2
  , p_session_id          in  integer
  , p_parameters          in  varchar2_list
  , p_values              in  varchar2_list );

  procedure REQUEST_LEGAL_DUP_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_duplicate_ebk       in  t_duplicate_ebk );

  procedure REQUEST_PRIVATE_DUP_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_duplicate_ebk       in  t_duplicate_ebk );

  procedure REQUEST_INDIVIDUAL_DUP_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_duplicate_ebk       in  t_duplicate_ebk );

  procedure REQUEST_LEGAL_GCIF_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_gcif                in  varchar2
  , p_slave_client_ebk    in  t_slave_client_ebk );

  procedure REQUEST_PRIVATE_GCIF_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_gcif                in  varchar2
  , p_slave_client_ebk    in  t_slave_client_ebk );

  procedure REQUEST_INDIVIDUAL_GCIF_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_gcif                in  varchar2
  , p_slave_client_ebk    in  t_slave_client_ebk );


  procedure REQUEST_LEGAL_UPDATECARD_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_anls_quality        in  number
  , p_defaultGroupQuality in  number
  , p_tab_attr            in  t_rec_ebk
  , p_rec_qlt_grp         in  t_rec_qlt_grp );

  procedure REQUEST_PRIVATE_UPDCARD_MASS
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_anls_quality        in  number
  , p_defaultGroupQuality in  number
  , p_tab_attr            in  t_rec_ebk
  , p_rec_qlt_grp         in  t_rec_qlt_grp );

  procedure REQUEST_INDIVIDUAL_UPDATECARD
  ( p_batchId             in  varchar2
  , p_kf                  in  varchar2
  , p_rnk                 in  number
  , p_anls_quality        in  number
  , p_defaultGroupQuality in  number
  , p_tab_attr            in  t_rec_ebk
  , p_rec_qlt_grp         in  t_rec_qlt_grp );

  procedure CREATE_GROUP_DUPLICATE;

end EBKC_PACK;
/

show errors;

create or replace package body EBKC_PACK
is

  -- Версія пакету
  g_body_version constant varchar2(64) := 'version 1.07 19/07/2018';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package '||$$PLSQL_UNIT||' header '||g_header_version||'.';
  end header_version;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package '||$$PLSQL_UNIT||' body '||g_body_version||'.';
  end body_version;

  function GET_CUSTTYPE
  ( p_rnk       in  number
  ) return varchar2
  is
    title  constant varchar2(64) := $$PLSQL_UNIT||'.GET_CUSTTYPE';
    l_cust_tp       varchar2(1);
  begin
    for x in ( select CUSTTYPE, trim(SED) as SED
                 from CUSTOMER
                where RNK = p_rnk )
    loop
      l_cust_tp := case
                   when ( x.CUSTTYPE = 2 )
                   then LEGAL_ENTITY
                   when ( x.CUSTTYPE = 3 )
                   then case 
                        when ( x.SED = '91' )
                        then PRIVATE_ENT
                        else INDIVIDUAL
                        end
                   else null
                   end;
    end loop;

    if ( l_cust_tp Is Null )
    then
      bars_audit.error( title||': Exit with null for p_rnk='||to_char(p_rnk)
                             ||chr(10)|| dbms_utility.format_call_stack() );
    end if;

    return l_cust_tp;

  end GET_CUSTTYPE;

  function GET_LAST_CHG_DT
  ( p_rnk       in  number
  , p_cust_tp   in  varchar2 default null
  ) return date
  is
    l_cust_tp       varchar2(1);
    l_last_chg_dt   date;
  begin

    if ( p_cust_tp Is Null )
    then
      l_cust_tp := GET_CUSTTYPE( p_rnk );
    else
      l_cust_tp := p_cust_tp;
    end if;

    case l_cust_tp
    when LEGAL_ENTITY
    then -- ЮО
      select GREATEST( ( select max(CHGDATE) from CUSTOMER_UPDATE  where RNK = p_rnk )
                     , ( select max(CHGDATE) from CUSTOMERW_UPDATE where RNK = p_rnk )
                     , ( select max(CHGDATE) from CORPS_UPDATE     where RNK = p_rnk )
                     , ( select max(CHGDATE)
                           from CUSTOMER_ADDRESS_UPDATE
                          where RNK = p_rnk
                            and TYPE_ID in ('1','2') ) )
        into l_last_chg_dt
        from dual;
    when PRIVATE_ENT
    then -- ФОП
      select GREATEST( ( select max(CHGDATE) from CUSTOMER_UPDATE  where RNK = p_rnk )
                     , ( select max(CHGDATE) from CUSTOMERW_UPDATE where RNK = p_rnk )
                     , ( select max(CHGDATE) from PERSON_UPDATE    where RNK = p_rnk )
                     , ( select max(CHGDATE)
                           from CUSTOMER_ADDRESS_UPDATE
                          where RNK = p_rnk
                            and TYPE_ID in ('1','2') ) )
        into l_last_chg_dt
        from dual;
    when INDIVIDUAL
    then -- ФО
      select GREATEST( ( select max(CHGDATE) from CUSTOMER_UPDATE  where RNK = p_rnk )
                     , ( select max(CHGDATE) from CUSTOMERW_UPDATE where RNK = p_rnk )
                     , ( select max(CHGDATE) from PERSON_UPDATE    where RNK = p_rnk )
                     , ( select max(CHGDATE)
                           from CUSTOMER_ADDRESS_UPDATE
                          where RNK = p_rnk
                            and TYPE_ID = '1' ) )
        into l_last_chg_dt
        from dual;
    else
      l_last_chg_dt := null;
    end case;

    return l_last_chg_dt;

  end GET_LAST_CHG_DT;

  --
  -- GET_LAST_MODIFC_DATE
  --
  function GET_LAST_MODIFC_DATE
  ( p_rnk  in  number
  ) return date
  is
  begin
    return GET_LAST_CHG_DT( p_rnk, null );
  end GET_LAST_MODIFC_DATE;

  --
  --
  --
  function GET_WPARAM
  ( p_key  in  varchar2
  ) return varchar2
  is
    l_value varchar2(4000 byte);
  begin
    begin
      select t.VAL
        into l_value
        from WEB_BARSCONFIG t
       where t.KEY = p_key;
    exception
      when no_data_found then
        l_value := null;
    end;
    return l_value;
  end GET_WPARAM;

  --
  -- ENQUEUE
  --
  procedure ENQUEUE
  ( p_rnk       in  ebkc_queue_updatecard.rnk%type
  , p_cust_tp   in  ebkc_queue_updatecard.cust_type%type
  ) is
  begin
    begin
      insert
        into EBKC_QUEUE_UPDATECARD
           ( RNK, CUST_TYPE )
      values
           ( p_rnk, p_cust_tp );
    exception
      when DUP_VAL_ON_INDEX then
        update EBKC_QUEUE_UPDATECARD
           set STATUS      = 0
             , INSERT_DATE = trunc(sysdate)
             , CUST_TYPE   = p_cust_tp
         where RNK = p_rnk;
    end;
  end ENQUEUE;

  --
  -- DEQUEUE
  --
  procedure DEQUEUE
  ( p_rnk       in  ebkc_queue_updatecard.rnk%type
  ) is
  begin
    delete EBKC_QUEUE_UPDATECARD
     where RNK = p_rnk;
  end DEQUEUE;

  --
  -- DEQUEUE
  --
  procedure DEQUEUE
  ( p_kf        in  ebkc_queue_updatecard.kf%type
  , p_rnk       in  ebkc_queue_updatecard.rnk%type
  ) is
  begin
    DEQUEUE( EBKC_WFORMS_UTL.GET_RNK( p_rnk, p_kf) );
  end DEQUEUE;

  --
  -- SEND_REQUEST
  --
  procedure SEND_REQUEST
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
  procedure REQUEST_DUP_MASS
  ( p_batchId       in varchar2,
    p_kf            in varchar2,
    p_rnk           in number,
    p_custtype      in varchar2,
    p_duplicate_ebk in t_duplicate_ebk
  ) is
    title           constant     varchar2(64) := $$PLSQL_UNIT||'.REQUEST_DUP_MASS';
    l_rnk                        customer.rnk%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_kf=%s, p_rnk=%s, p_custtype=%s ).', title, p_kf, to_char(p_rnk), p_custtype );

    case
    when ( p_kf is null )
    then raise_application_error( -20666,'Value for parameter [p_kf] must be specified!', true );
    when ( p_rnk is null )
    then raise_application_error( -20666,'Value for parameter [p_rnk] must be specified!', true );
    when ( p_custtype is null )
    then raise_application_error( -20666,'Value for parameter [p_custtype] must be specified!', true );
    when ( p_duplicate_ebk is null or p_duplicate_ebk.count = 0 )
    then raise_application_error( -20666,'Value for parameter [p_duplicate_ebk] must be specified!', true );
    else null;
    end case;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_policy_group('WHOLE');
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    bars_audit.info( title||': save received dublicate for rnk='||l_rnk );

    insert
      into EBKC_DUPLICATE
         ( KF, RNK, DUP_KF, DUP_RNK, CUST_TYPE )
    select p_kf, l_rnk, dup.kf
$if EBK_PARAMS.CUT_RNK $then
         , EBKC_WFORMS_UTL.GET_RNK(dup.RNK,dup.KF)
$else
         , dup.RNK
$end
         , p_custtype
      from table (p_duplicate_ebk) dup
     where not exists ( select null
                          from EBKC_DUPLICATE
                         where KF      = p_kf
                           and RNK     = l_rnk
$if EBK_PARAMS.CUT_RNK $then
                           and DUP_RNK = EBKC_WFORMS_UTL.GET_RNK(dup.RNK,dup.KF)
$else
                           and DUP_KF  = dup.KF
$end
                           and DUP_RNK = dup.RNK
                      );

    commit;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_context;
$end

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
$if EBK_PARAMS.CUT_RNK $then
      bc.set_context;
$end
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk)
                              || ', p_duplicate_ebk.count='||to_char(p_duplicate_ebk.count) );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_DUP_MASS;

  --
  -- дублікати по ЮО
  --
  procedure REQUEST_LEGAL_DUP_MASS
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_duplicate_ebk in t_duplicate_ebk
  ) is
  begin
    REQUEST_DUP_MASS( p_batchId, p_kf, p_rnk, LEGAL_ENTITY, p_duplicate_ebk );
  end REQUEST_LEGAL_DUP_MASS;

  --
  -- дублікати по ФОП
  --
  procedure REQUEST_PRIVATE_DUP_MASS
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_duplicate_ebk in t_duplicate_ebk
  ) is
  begin
    REQUEST_DUP_MASS( p_batchId, p_kf, p_rnk, PRIVATE_ENT, p_duplicate_ebk );
  end REQUEST_PRIVATE_DUP_MASS;

  --
  -- дублікати по ФО
  --
  procedure REQUEST_INDIVIDUAL_DUP_MASS
  ( p_batchId             in varchar2
  , p_kf                  in varchar2
  , p_rnk                 in number
  , p_duplicate_ebk       in t_duplicate_ebk
  ) is
  begin
    REQUEST_DUP_MASS( p_batchId, p_kf, p_rnk, INDIVIDUAL, p_duplicate_ebk );
  end REQUEST_INDIVIDUAL_DUP_MASS;

  --
  -- GCIF по ФО, ЮО та ФОП
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
    l_sys_dt                  ebkc_gcif.insert_date%type := sysdate;
    l_rnk                     customer.rnk%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_kf=%s, p_rnk=%s, p_gcif=%s, p_slaves.count=%s ).'
                    , title, p_kf, to_char(p_rnk), p_gcif, to_char(p_slave_client_ebk.count) );

    case
    when ( p_kf is null )
    then raise_application_error( -20666,'Value for parameter [p_kf] must be specified!', true );
    when ( p_rnk is null )
    then raise_application_error( -20666,'Value for parameter [p_rnk] must be specified!', true );
    when ( p_gcif is null )
    then raise_application_error( -20666,'Value for parameter [p_gcif] must be specified!', true );
    else null;
    end case;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_policy_group('WHOLE');
$end

    for c in ( select t1.KF, t1.RNK
                 from ( select KF, RNK
                          from table( p_slave_client_ebk )
                         union all
                        select p_kf, p_rnk
                          from dual
                      ) t1
                 join MV_KF t2
                   on ( t2.KF = t1.KF )
             )
    loop

      bars_audit.trace( '%s: c.KF=%s, c.RNK=%s.', title, c.KF, to_char(c.RNK) );

$if EBK_PARAMS.CUT_RNK $then
      l_rnk := EBKC_WFORMS_UTL.GET_RNK( c.RNK, c.KF );
$else
      l_rnk := c.RNK;
$end

      delete EBKC_GCIF
       where RNK = l_rnk
          or ( KF = c.KF and GCIF = p_gcif );

      insert
        into EBKC_GCIF
           ( KF, RNK, GCIF, CUST_TYPE, INSERT_DATE )
      values
           ( c.KF, l_rnk, p_gcif, p_custtype, l_sys_dt );

   end loop;

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
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='      ||p_kf      ||', p_rnk='                ||to_char(p_rnk)
                              || ', p_gcif=' ||p_gcif   ||', p_custtype='||p_custtype||', p_slave_clients.count='||to_char(p_slave_client_ebk.count) );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_GCIF_MASS;

  --
  --
  --
  procedure REQUEST_LEGAL_GCIF_MASS
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_gcif in varchar2,
    p_slave_client_ebk in t_slave_client_ebk
  ) is
  begin
    REQUEST_GCIF_MASS(p_batchId, p_kf, p_rnk, p_gcif, LEGAL_ENTITY, p_slave_client_ebk);
  end REQUEST_LEGAL_GCIF_MASS;

  --
  --
  --
  procedure REQUEST_PRIVATE_GCIF_MASS
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_gcif in varchar2,
    p_slave_client_ebk in t_slave_client_ebk
  ) is
  begin
    request_gcif_mass(p_batchId, p_kf, p_rnk, p_gcif, PRIVATE_ENT, p_slave_client_ebk);
  end REQUEST_PRIVATE_GCIF_MASS;

  --
  --
  --
  procedure REQUEST_INDIVIDUAL_GCIF_MASS
  ( p_batchId             in varchar2
  , p_kf                  in varchar2
  , p_rnk                 in number
  , p_gcif                in varchar2
  , p_slave_client_ebk    in t_slave_client_ebk
  ) is
  begin
    REQUEST_GCIF_MASS( p_batchId, p_kf, p_rnk, p_gcif, INDIVIDUAL, p_slave_client_ebk );
  end REQUEST_INDIVIDUAL_GCIF_MASS;

  --
  --
  --
  procedure REQUEST_UPDATECARD_MASS
  ( p_batchId             in     varchar2,
    p_kf                  in     varchar2,
    p_rnk                 in     number,
    p_anls_quality        in     number,
    p_defaultGroupQuality in     number,
    p_custtype            in     varchar2,
    p_tab_attr            in     t_rec_ebk,
    p_rec_qlt_grp         in     t_rec_qlt_grp
  ) is
    title           constant     varchar2(64) := $$PLSQL_UNIT||'.REQUEST_UPDATECARD_MASS';
    l_rnk               customer.rnk%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_kf=%s, p_rnk=%s, p_custtype=%s, p_anls_quality=%s, p_defaultGroupQuality=%s ).'
                    , title, p_kf, to_char(p_rnk), p_custtype, to_char(p_anls_quality), to_char(p_defaultGroupQuality) );

$if EBK_PARAMS.CUT_RNK $then
    bc.set_policy_group('WHOLE');
    l_rnk := EBKC_WFORMS_UTL.GET_RNK(p_rnk,p_kf);
$else
    l_rnk := p_rnk;
$end

    -- не храним предыдущие рекомендации по конкретному kf, rnk,
    -- новый пакет рекомендаций стирает старые рекомендации по
    bars_audit.info( title||': process recommendation for rnk='||l_rnk );

    -- удаление неактуальных более рекомендаций
    delete EBKC_REQ_UPDCARD_ATTR
     where kf  = p_kf
       and rnk = l_rnk
       and cust_type = p_custtype
       and name in (select name
                      from table(p_tab_attr) b
                     where b.quality = 'C'
                        or b.name is not null);

    if ( sql%rowcount > 0 )
    then

      delete EBKC_REQ_UPDATECARD u
       where u.kf  = p_kf
         and u.rnk = l_rnk
         and not exists (select 1
                           from EBKC_REQ_UPDCARD_ATTR a
                          where a.kf  = u.kf
                            and a.rnk = u.rnk );
    end if;

    -- сохраняем только ошибки и предупреждения
    -- только одна рекомендация может быть у реквизита
    insert
      into EBKC_REQ_UPDCARD_ATTR
         ( KF, RNK, QUALITY, NAME, VALUE, RECOMMENDVALUE, DESCR, CUST_TYPE )
    select p_kf, l_rnk, ms.quality, ms.name, ms.value, ms.recommendvalue, ms.descr, p_custtype
      from table(p_tab_attr) ms
     where ( ms.recommendvalue is not null or ms.descr is not null )
       and not exists ( select null 
                          from EBKC_REQ_UPDCARD_ATTR
                         where kf   = p_kf
                           and rnk  = l_rnk
                           and name = ms.name )
                                      -- !!! для теста - приймаємо все!
                                      --and exists -- не грузим рекомендации по которым не прописаны действия  в EBKC_CARD_ATTRIBUTES.ACTION
                                      --        ( select null from ebkc_card_attributes where name = ms.name and action is not null and cust_type = p_custtype)
    ;
    
    -- создаем мастер запись если заполнился выше детаил
    if ( sql%rowcount > 0 )
    then

      insert
        into EBKC_REQ_UPDATECARD
           ( BATCHID, KF , RNK, QUALITY, DEFAULTGROUPQUALITY, GROUP_ID )
      select p_batchId, p_kf, l_rnk,  p_anls_quality, p_defaultGroupQuality
           , get_group_id(l_rnk,p_kf) as group_id
        from dual
       where not exists ( select null
                            from ebkc_req_updatecard
                           where kf  = p_kf
                             and rnk = l_rnk );
    end if;

    -- удаляем ранее загруженные проценты качества
    delete EBKC_QUALITYATTR_GROUPS
     where KF  = p_kf
       and RNK = l_rnk;

    -- сохраняем отдельно проценты качества в любом случае, т.к. далее понадобятся в дедубликации
    -- качества приходят по всей карточке, по основной группе или по умолчанию обязательно ,
    -- а также динамически созд-ым группам
    insert
      into EBKC_QUALITYATTR_GROUPS
         ( BATCHID ,KF ,RNK , NAME , QUALITY, CUST_TYPE )
    select p_batchId, p_kf, l_rnk , 'card', p_anls_quality, p_custtype
      from DUAL
     union all
    select p_batchId, p_kf, l_rnk, 'default', p_defaultGroupQuality, p_custtype
      from DUAL
     union all
    select p_batchId, p_kf ,l_rnk ,gr.name, gr.quality, p_custtype
      from table(p_rec_qlt_grp) gr
     where gr.name is not null;

    --Заполняем таблицу-справочник групп
    insert into ebkc_quality_groups
    select s_ebk_quality_groups.nextval, g.name, p_custtype
      from table(p_rec_qlt_grp) g
     where not exists (select 1
                         from ebkc_quality_groups qg
                        where qg.qg_name = g.name and cust_type= p_custtype);

--  commit;

$if EBK_PARAMS.CUT_RNK $then
    bc.set_context;
$end

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
      ROLLBACK;
$if EBK_PARAMS.CUT_RNK $then
      bc.set_context;
$end
      bars_audit.error( title || ': p_batch='||p_batchid||', p_kf='||p_kf||', p_rnk='||to_char(p_rnk)
                              || ', p_tab_attr.count='||to_char(p_tab_attr.count) );
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
      raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end REQUEST_UPDATECARD_MASS;

  --
  --
  --
  procedure REQUEST_LEGAL_UPDATECARD_MASS
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_anls_quality in number,
    p_defaultGroupQuality in number,
    p_tab_attr  t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  ) is
  begin
    REQUEST_UPDATECARD_MASS( p_batchId, p_kf, p_rnk, p_anls_quality, p_defaultGroupQuality, LEGAL_ENTITY, p_tab_attr,p_rec_qlt_grp );
  end REQUEST_LEGAL_UPDATECARD_MASS;

  --
  --
  --
  procedure REQUEST_PRIVATE_UPDCARD_MASS
  ( p_batchId in varchar2,
    p_kf in varchar2,
    p_rnk in number,
    p_anls_quality in number,
    p_defaultGroupQuality in number,
    p_tab_attr  t_rec_ebk,
    p_rec_qlt_grp t_rec_qlt_grp
  ) is
  begin
    REQUEST_UPDATECARD_MASS( p_batchId, p_kf, p_rnk, p_anls_quality, p_defaultGroupQuality, PRIVATE_ENT, p_tab_attr,p_rec_qlt_grp );
  end REQUEST_PRIVATE_UPDCARD_MASS;

  --
  --
  --
  procedure REQUEST_INDIVIDUAL_UPDATECARD
  ( p_batchId              in  varchar2
  , p_kf                   in  varchar2
  , p_rnk                  in  number
  , p_anls_quality         in  number
  , p_defaultGroupQuality  in  number
  , p_tab_attr             in  t_rec_ebk
  , p_rec_qlt_grp          in  t_rec_qlt_grp
  ) is
  begin
    REQUEST_UPDATECARD_MASS( p_batchId, p_kf, p_rnk, p_anls_quality, p_defaultGroupQuality, INDIVIDUAL, p_tab_attr,p_rec_qlt_grp );
  end REQUEST_INDIVIDUAL_UPDATECARD;

  --
  -- run from JOB
  --
  procedure CREATE_GROUP_DUPLICATE
  is
    title   constant   varchar2(64) := $$PLSQL_UNIT||'.CREATE_GROUP_DUPLICATE';
    l_kf               varchar2(6);
    l_lock             varchar2(30);
    l_status           number;
    ---
    procedure create_group_duplicate_kf
    is
    begin

      bars_audit.info( title||': Entry with KF='||l_kf);

      for r in ( select distinct rnk
                   from ebkc_duplicate
                  where kf = l_kf
                     or kf = dup_kf
                  order by rnk )
      loop

        dbms_application_info.set_client_info( title||': set MC for rnk=' || r.rnk);

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

            bars_audit.trace( title||': set master card for rnk = %s, dup_rnk = %s, last_modifc_date=%s, quality=%s, master_card=%s',
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

      bars_audit.info( title||': Exit.');

    end create_group_duplicate_kf;
    ---
  begin

    bars_audit.info( title||': Started.');

    l_kf := sys_context('bars_context','user_mfo');

    -- только один процесс может быть запущен
    dbms_lock.allocate_unique('LegalDuplicateGroups', l_lock);
    l_status := dbms_lock.request(l_lock, dbms_lock.x_mode,180,true);

    bars_audit.trace( '%s: dbms_lock status for LegalDuplicateGroups = %s', title, to_char(l_status));

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
   bars_audit.info( title||': Finished.');
   exception
     when others then
       ROLLBACK;
       bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );
       raise_application_error( -20666, title || ': ' || SQLERRM, true );
  end CREATE_GROUP_DUPLICATE;



begin
  null;
end EBKC_PACK;
/

show errors;

grant EXECUTE on EBKC_PACK to BARS_ACCESS_DEFROLE;
