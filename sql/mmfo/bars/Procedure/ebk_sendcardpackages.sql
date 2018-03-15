create or replace procedure EBK_SENDCARDPACKAGES
( p_action_name      in     varchar2
, p_cardsCount       in     varchar2
, p_packSize         in     varchar2
) is
  /**
  <b>EBK_SENDCARDPACKAGES</b> - Виклик WEB сервісу надсилання даних до ЄБК
  %param p_action_name - 
  %param p_cardsCount  - 
  %param p_packSize    - 
  
  %version  2.4
  %date     2018.02.12
  %modifier BAA
  %usage   
  */
  
  l_url          varchar2(128);
  l_ahr_val      varchar2(128);
  l_wallet_path  varchar2(128);
  l_wallet_pwd   varchar2(128);
  l_response     wsm_mgr.t_response;
  l_pkg_sz       number(8);
  l_rsp          number(1);
  l_kf           varchar2(6) := sys_context('bars_context','user_mfo');

  --
  -- Возвращает параметр из web_config
  --
  function get_param_webconfig
  ( par    varchar2
  ) return web_barsconfig.val%type
  is
    l_res web_barsconfig.val%type;
  begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
  exception
    when no_data_found then
      raise_application_error( -20000, 'Не найден KEY=' || par || ' в таблице WEB_BARSCONFIG!' );
  end get_param_webconfig;

  --
  -- повертає розмір черги для відправки на три букви (ЄБК)
  --
  function GET_QUEUE_SIZE
    return number
  is
    l_q_sz number(38);
  begin

    case p_action_name
    when 'SendCardPackages'
    then
      select count(RNK)
        into l_q_sz
        from EBK_QUEUE_UPDATECARD
       where KF = l_kf
         and STATUS = 0;
    when 'SendCardPackagesLegal'
    then
      select count(RNK)
        into l_q_sz
        from EBKC_QUEUE_UPDATECARD
       where KF = l_kf
         and STATUS = 0
         and CUST_TYPE = 'L';
    when 'SendCardPackagesPrivateEn'
    then
      select count(RNK)
        into l_q_sz
        from EBKC_QUEUE_UPDATECARD
       where KF = l_kf
         and STATUS = 0
         and CUST_TYPE = 'P';
    else
      l_q_sz := 0;
    end case;

    return l_q_sz;
    
  end GET_QUEUE_SIZE;

  --
  --
  --
  function SET_REQUEST
  return number
  -- 0 - все ок 
  -- 1 - проблема з бд
  -- 2 - проблема не з бд
  is
  begin

    WSM_MGR.prepare_request( p_url          => l_url,
                             p_action       => p_action_name,
                             p_http_method  => WSM_MGR.g_http_post,
                             p_content_type => WSM_MGR.g_ct_json,
                             p_wallet_path  => l_wallet_path,
                             p_wallet_pwd   => l_wallet_pwd );

    WSM_MGR.add_header( p_name => 'Authorization', p_value => l_ahr_val );

    WSM_MGR.add_parameter( p_name => 'cardsCount', p_value => p_cardsCount );
    WSM_MGR.add_parameter( p_name => 'packSize',   p_value => to_char(l_pkg_sz) );
    WSM_MGR.add_parameter( p_name => 'kf',         p_value => l_kf );

    WSM_MGR.execute_request(l_response);
--  WSM_MGR.execute_api(l_response);

    bars_audit.trace( '%s: response=%s.', $$PLSQL_UNIT, DBMS_LOB.substr(l_response.cdoc,3000) );

    return nvl(to_number(dbms_lob.substr(l_response.cdoc,1)),0);

--  l_result := l_response.cdoc; -- если есть ответ - в clob будет

  end SET_REQUEST;

  --
  -- розпаралелити відправку по МФО та типах клієнтів
  --
  procedure SEND_CARDS
  is
    l_qty   number(8);
  begin

    loop

      l_qty := GET_QUEUE_SIZE();

      l_rsp := SET_REQUEST();

      exit when l_qty = 0 or l_rsp = 2;

      if ( l_rsp = 1 and l_qty = GET_QUEUE_SIZE() )
      then -- розмір черги не змінився

        if ( l_pkg_sz > 1 )
        then -- зменшуємо розмір пакету

          l_pkg_sz := greatest(trunc(l_pkg_sz/10),1);

        else -- l_pkg_sz = 1

          -- виключаємо "поганий" РНК з передачі в ЄБК
          case p_action_name
          when 'SendCardPackages'
          then
            update EBK_QUEUE_UPDATECARD
               set STATUS = 9
             where ROWID = ( select min(ROWID)
                               from EBK_QUEUE_UPDATECARD
                              where KF = l_kf
                                and STATUS = 0 );
          when 'SendCardPackagesLegal'
          then
            update EBKC_QUEUE_UPDATECARD
               set STATUS = 9
             where ROWID = ( select min(ROWID)
                             from EBKC_QUEUE_UPDATECARD
                            where KF = l_kf
                              and STATUS = 0
                              and CUST_TYPE = 'L' );
          when 'SendCardPackagesPrivateEn'
          then
            update EBKC_QUEUE_UPDATECARD
               set STATUS = 9
             where ROWID = ( select min(ROWID)
                               from EBKC_QUEUE_UPDATECARD
                              where KF = l_kf
                                and STATUS = 0
                                and CUST_TYPE = 'P' );
          else
            null;
          end case;

          -- по наївності надіємося, що "поганий" РНК тільки один
          l_pkg_sz := to_number( p_packSize );

        end if;

      end if;

    end loop;

  end SEND_CARDS;
  ---
begin

  bars_audit.trace( '%s: Entry with ( p_action_name=%s, p_cardsCount=%s, p_packSize=%s ).'
                  , $$PLSQL_UNIT, p_action_name, p_cardsCount, p_packSize );

  l_url     := get_param_webconfig('EBK.Url'); -- branch_attribute_utl.get_value( 'ABSBARS_WEB_IP_ADRESS' );
  l_ahr_val := get_param_webconfig('EBK.UserPassword');
  l_ahr_val := 'Basic ' || utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('wbarsebk:'||l_ahr_val)));

  bars_audit.trace( '%s: ( l_url=%s, l_ahr_val=%s ).', $$PLSQL_UNIT, l_url, l_ahr_val );

  -- SSL соединение выполняем через wallet
  if ( instr(lower(l_url), 'https://') > 0 )
  then
    l_wallet_path := get_param_webconfig('EBK.WalletDir');
    l_wallet_pwd  := get_param_webconfig('EBK.WalletPass');
    utl_http.set_wallet( l_wallet_path, l_wallet_pwd );
  end if;
  
  l_pkg_sz := to_number( p_packSize );
  
  if ( l_kf Is Null )
  then
    for i in ( select KF
                 from BARS.MV_KF )
    loop
      l_kf := i.KF;
      SEND_CARDS;
    end loop;
  else
    SEND_CARDS;
  end if;
  
  bars_audit.trace( '%s: Exit.', $$PLSQL_UNIT );
  
end EBK_SENDCARDPACKAGES;
/

show err
