create or replace procedure BARS.EBK_SENDCLOSEDCARD
is
  /**
  <b>EBK_SENDCLOSEDCARD</b> - Виклик WEB сервісу надсилання даних про закриті РНК до ЄБК
  %param 
  
  %version  2.3
  %date     2017.09.20
  %modifier BAA
  %usage   
  */
  
  g_actn_nm   constant   varchar2(32) := 'SendCardClose';
  
  l_url                  varchar2(128);
  l_ahr_val              varchar2(128);
  l_wallet_path          varchar2(128);
  l_wallet_pwd           varchar2(128);
  l_response             wsm_mgr.t_response;
  l_last_send_dt         date;
  
  --
  -- Возвращает параметр из web_config
  --
  function f_get_param_webconfig
  ( par    varchar2
  ) return web_barsconfig.val%type 
  is
    l_res web_barsconfig.val%type;
  begin
    
    select val
      into l_res
      from web_barsconfig
     where key = par;
    
    return trim(l_res);
    
  exception
    when no_data_found then
      raise_application_error( -20000, 'Не найден KEY=' || par || ' в таблице WEB_BARSCONFIG!' );
  end f_get_param_webconfig;
  ---
begin
  
  bars_audit.trace( '%s: Entry.', $$PLSQL_UNIT );
  
  l_url     := f_get_param_webconfig('EBK.Url'); -- branch_attribute_utl.get_value( 'ABSBARS_WEB_IP_ADRESS' );
  l_ahr_val := f_get_param_webconfig('EBK.UserPassword');
  l_ahr_val := 'Basic ' || utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw('wbarsebk:'||l_ahr_val)));
  
  bars_audit.trace( '%s: ( l_url=%s, l_ahr_val=%s ).', $$PLSQL_UNIT, l_url, l_ahr_val );
  
  -- SSL соединение выполняем через wallet
  if ( instr(lower(l_url), 'https://') > 0 )
  then
    l_wallet_path := f_get_param_webconfig('EBK.WalletDir');
    l_wallet_pwd  := f_get_param_webconfig('EBK.WalletPass');
    utl_http.set_wallet( l_wallet_path, l_wallet_pwd );
  end if;
  
  -- дата последней выгрузки закрытых карточек ФЛ
  select cast( max(ACTUAL_START_DATE) as date )
    into l_last_send_dt
    from ALL_SCHEDULER_JOB_RUN_DETAILS
   where JOB_NAME = 'EBK_CLOSED_CARD_JOB'
     and STATUS   = 'SUCCEEDED';
  
  if ( l_last_send_dt is null )
  then
    -- дата 1-ой пакетной выгрузки открытых карточек ФЛ
    select cast( max(ACTUAL_START_DATE) as date )
      into l_last_send_dt
      from ALL_SCHEDULER_JOB_RUN_DETAILS
     where JOB_NAME = 'EBK_CARD_PACAKGES_JOB'
       and STATUS   = 'SUCCEEDED';
  end if;
  
  for x in ( select cu.KF
                  , cu.RNK
                  , case
                      when ( cu.CUSTTYPE = 2 )
                      then 'corp'
                      when ( cu.CUSTTYPE = 3 and cu.K050 = '910' )
                      then 'personspd'
                      else 'person'
                    end as CUSTTYPE
                  , cu.DATE_OFF
               from CUSTOMER_UPDATE cu
              where cu.CUSTTYPE in ( 2, 3 )
                and cu.CHGACTION = 3
                and cu.DATE_OFF is not null
                and cu.CHGDATE > l_last_send_dt )
  loop
    
    bars_audit.trace( $$PLSQL_UNIT||': RNK='|| to_char(x.rnk) );
    
    begin
      
      wsm_mgr.prepare_request
      ( p_url          => l_url,
        p_action       => g_actn_nm,
        p_http_method  => wsm_mgr.g_http_post,
        p_content_type => wsm_mgr.g_ct_json,
        p_wallet_path  => l_wallet_path,
        p_wallet_pwd   => l_wallet_pwd );
   
      wsm_mgr.add_header( p_name => 'Authorization', p_value => l_ahr_val );
      
      wsm_mgr.add_parameter( p_name => 'kf',       p_value => x.KF );
      wsm_mgr.add_parameter( p_name => 'rnk',      p_value => to_char( EBK_WFORMS_UTL.CUT_RNK(x.RNK) ) );
      wsm_mgr.add_parameter( p_name => 'custtype', p_value => x.CUSTTYPE );
      wsm_mgr.add_parameter( p_name => 'dateOff',  p_value => to_char(x.DATE_OFF, 'yyyy-mm-dd') );
      
      wsm_mgr.execute_request(l_response);
      
    exception
      when others then 
        bars_audit.error( $$PLSQL_UNIT||': '|| sqlerrm );
    end;
    
  end loop;
  
  bars_audit.trace( '%s: Exit.', $$PLSQL_UNIT );
  
end ebk_SendClosedCard;
/

show err
