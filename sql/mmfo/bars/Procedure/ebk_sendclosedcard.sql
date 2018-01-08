create or replace procedure BARS.EBK_SENDCLOSEDCARD
is
  /**
  <b>EBK_SENDCLOSEDCARD</b> - Виклик WEB сервісу надсилання даних про закриті РНК до ЄБК
  %param 
  
  %version  2.2
  %date     2017.02.24
  %modifier BAA
  %usage   
  */
  
  g_actn_nm      constant   varchar2(32) := 'SendCardClose';
  
  l_url          varchar2(128);
  l_ahr_val      varchar2(128);
  l_wallet_path  varchar2(128);
  l_wallet_pwd   varchar2(128);
  l_response     wsm_mgr.t_response;
  
  --
  -- Возвращает параметр из web_config
  --
  function f_get_param_webconfig
  ( par    varchar2
  ) return web_barsconfig.val%type 
  is
    l_res web_barsconfig.val%type;
  begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
  exception
    when no_data_found then
      raise_application_error( -20000, 'Не найден KEY=' || par || ' в таблице web_barsconfig!' );
  end f_get_param_webconfig;
  ---
begin
  
  bars_audit.trace( '%s: Entry.', $$PLSQL_UNIT );
  
--BARS.BC.SUBST_MFO(BARS.F_OURMFO_G);
  
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
  
  for x in ( select KF, RNK, CUSTTYPE, DATE_OFF 
               from EBK_CLOSED_CARD_V )
  loop
    
    bars_audit.trace( 'EBK_SENDCLOSEDCARD: RNK='|| to_char(x.rnk) );
    
    begin
      
      wsm_mgr.prepare_request
      ( p_url          => l_url,
        p_action       => g_actn_nm,
        p_http_method  => wsm_mgr.g_http_post,
        p_content_type => wsm_mgr.g_ct_json,
        p_wallet_path  => l_wallet_path,
        p_wallet_pwd   => l_wallet_pwd );
   
      wsm_mgr.add_header( p_name => 'Authorization', p_value => l_ahr_val );
      
      wsm_mgr.add_parameter( p_name => 'kf',       p_value => x.kf );
      wsm_mgr.add_parameter( p_name => 'rnk',      p_value => to_char(x.rnk) );
      wsm_mgr.add_parameter( p_name => 'custtype', p_value => x.custtype );
      wsm_mgr.add_parameter( p_name => 'dateOff',  p_value => to_char(x.date_off, 'yyyy-mm-dd') );
      
      wsm_mgr.execute_request(l_response);
      
    exception
      when others then 
        bars_audit.error( 'EBK_SENDCLOSEDCARD: '|| sqlerrm );
    end;
    
  end loop;
  
  bars_audit.trace( 'EBK_SENDCLOSEDCARD: Exit.' );
  
end ebk_SendClosedCard;
/

show err
