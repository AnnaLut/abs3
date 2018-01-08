
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/PFU/package/transport_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE PFU.TRANSPORT_UTL is

  TRANS_STATE_NEW            constant integer      := 1;
  TRANS_STATE_FAILED         constant integer      := 2;
  TRANS_STATE_SENT           constant integer      := 3;
  TRANS_STATE_DATA_NOT_READY constant integer      := 4;
  TRANS_STATE_RESPONDED      constant integer      := 5;
  TRANS_STATE_DONE           constant integer      := 6;

  TRANS_TYPE_REGEPP           constant varchar2(30) := 'REGEPP';
  TRANS_TYPE_CHECKISSUECARD   constant varchar2(30) := 'CHECKISSUECARD';
  TRANS_TYPE_ACTIVATEACC      constant varchar2(30) := 'ACTIVATEACC';
  TRANS_TYPE_CHECKSTATE       constant varchar2(30) := 'CHECKPAYMSTATE';
  TRANS_TYPE_GET_EBP          constant varchar2(30) := 'GET_EBP';
  TRANS_TYPE_CREATE_PAYM      constant varchar2(30) := 'CREATE_PAYM';
  TRANS_TYPE_GET_CARDKILL     constant varchar2(30) := 'GET_CARDKILL';
  TRANS_TYPE_GET_REPORT       constant varchar2(30) := 'GET_REPORT';
  TRANS_TYPE_GET_CM_ERROR     constant varchar2(30) := 'GET_CM_ERROR';
  TRANS_TYPE_GET_ACC_REST     constant varchar2(30) := 'GET_ACC_REST';
  TRANS_TYPE_CHECK_EPP_STATE  constant varchar2(30) := 'CHECK_EPP_STATE';
  TRANS_TYPE_RESTART_EPP      constant varchar2(30) := 'RESTART_EPP';
  TRANS_TYPE_GET_BRANCH       constant varchar2(30) := 'GET_BRANCH';
  TRANS_TYPE_SET_CARD_BLOCK   constant varchar2(30) := 'SET_CARD_BLOCK';
  TRANS_TYPE_SET_CARD_UNBLOCK constant varchar2(30) := 'SET_CARD_UNBLOCK';
  TRANS_TYPE_SET_DESTRUCT     constant varchar2(30) := 'SET_DESTRUCT';
  TRANS_TYPE_CHECKBACKSTATE   constant varchar2(30) := 'CHECKBACKSTATE';
  
  function create_transport_unit(p_unit_type_id in number,
                                 p_kf           in varchar2,
                                 p_receiver_url in varchar2,
                                 p_request_data in clob)
  return number;
  
  function create_transport_unit(p_unit_type_code in varchar2,
                                 p_kf           in varchar2,    
                                 p_receiver_url   in varchar2,
                                 p_request_data   in clob)
  return number;
  
  procedure set_transport_state(p_id               in integer,
                                p_state_id         in integer,
                                p_tracking_comment in varchar2,
                                p_stack_trace      in clob);
  
  function read_unit(
      p_unit_id in integer)
  return transport_unit%rowtype;
  
  function get_receiver_url(
      p_mfo in varchar2)
  return varchar2;
  
  procedure send_data(
      p_unit_row in transport_unit%rowtype);
  
  procedure check_unit_state(
      p_unit_row in transport_unit%rowtype);
  
  function get_unit_type_id(
      p_unit_type_code in varchar2)
  return number;
  
  procedure perform_transport_activities;
  
end;
/
CREATE OR REPLACE PACKAGE BODY PFU.TRANSPORT_UTL is

      MARGINAL_TRIES_COUNT constant integer := 15;
  
      function get_unit_type_id(p_unit_type_code in varchar2) return number is
        l_id number;
      begin
        select t.id
          into l_id
          from transport_unit_type t
         where upper(t.transport_type_code) = upper(p_unit_type_code);
        return l_id;
      exception
        when no_data_found then
          return null;
      end;
  
      procedure track_transport(p_id               in integer,
                                p_state_id         in integer,
                                p_tracking_comment in varchar2,
                                p_stack_trace      in clob) is
      begin
        insert into transport_tracking
          (id, unit_id, state_id, tracking_comment, stack_trace, sys_time)
        values
          (s_transport_tracking.nextval, p_id, p_state_id, p_tracking_comment,
           p_stack_trace, sysdate);
      end;
  
      function create_transport_unit(p_unit_type_id in number,
                                     p_kf           in varchar2,
                                     p_receiver_url in varchar2,
                                     p_request_data in clob) return number is
        l_id           number;
        l_blob         blob;
        l_warning      integer;
        l_dest_offset  integer := 1;
        l_src_offset   integer := 1;
        l_blob_csid    number := dbms_lob.default_csid;
        l_lang_context number := dbms_lob.default_lang_ctx;
      begin
        l_id := s_transport_unit.nextval;
  
        dbms_lob.createtemporary(lob_loc => l_blob,
                                 cache   => true,
                                 dur     => dbms_lob.call);
  
        dbms_lob.converttoblob(dest_lob     => l_blob,
                               src_clob     => p_request_data,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

        l_blob := utl_compress.lz_compress(l_blob);
  
        insert into transport_unit
          (id, unit_type_id, receiver_url, request_data, response_data,
           state_id, failures_count, upd_date, kf)
        values
          (l_id, p_unit_type_id, p_receiver_url, l_blob, null,
           transport_utl.trans_state_new, 0, sysdate, p_kf);
  
        track_transport(l_id, transport_utl.trans_state_new, null, null);
  
        return l_id;
  
      end;

      function create_transport_unit(p_unit_type_code in varchar2,
                                     p_kf           in varchar2,
                                     p_receiver_url in varchar2,
                                     p_request_data in clob) return number is
        l_id           number;
        l_blob         blob;
        l_warning      integer;
        l_dest_offset  integer := 1;
        l_src_offset   integer := 1;
        l_blob_csid    number := dbms_lob.default_csid;
        l_lang_context number := dbms_lob.default_lang_ctx;
        l_unit_type_id number;
      begin
        l_id := s_transport_unit.nextval;
  
        l_unit_type_id := get_unit_type_id(p_unit_type_code);
  
        dbms_lob.createtemporary(lob_loc => l_blob,
                                 cache   => true,
                                 dur     => dbms_lob.call);
  
        dbms_lob.converttoblob(dest_lob     => l_blob,
                               src_clob     => p_request_data,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

        l_blob := utl_compress.lz_compress(l_blob);
  
        insert into transport_unit
          (id, unit_type_id, receiver_url, request_data, response_data,
           state_id, failures_count, upd_date, kf)
        values
          (l_id, l_unit_type_id, p_receiver_url, l_blob, null,
           transport_utl.trans_state_new, 0, sysdate, p_kf);

        track_transport(l_id, transport_utl.trans_state_new, null, null);

        return l_id;

      end;

      procedure set_transport_state(p_id               in integer,
                                    p_state_id         in integer,
                                    p_tracking_comment in varchar2,
                                    p_stack_trace      in clob) is
      begin
  
        update transport_unit t
           set t.state_id = p_state_id,
               t.upd_date = sysdate
         where t.id = p_id;
  
        track_transport(p_id, p_state_id, p_tracking_comment, p_stack_trace);
      end;
  
      function read_syncru_params(
          p_mfo in varchar2)
      return pfu_syncru_params%rowtype
      is
          l_syncru_params_row pfu_syncru_params%rowtype;
      begin
          select *
          into   l_syncru_params_row
          from   pfu_syncru_params t
          where  t.kf = p_mfo;
  
          return l_syncru_params_row;
      exception
          when no_data_found then
               raise_application_error(-20000, 'Налаштування для синхронізації з регіональним відділенням {' || p_mfo || '} не знайдені');
      end;
  
      function read_unit_type(
          p_transport_id in integer)
      return transport_unit_type%rowtype
      is
          l_transport_unit_type_row transport_unit_type%rowtype;
      begin
          select *
          into   l_transport_unit_type_row
          from   transport_unit_type t
          where  t.id = p_transport_id;
  
          return l_transport_unit_type_row;
      exception
          when no_data_found then
               raise_application_error(-20000, 'Тип синхронізації з регіональним відділенням з ідентифікатором {' || p_transport_id || '} не знайдений');
      end;
  
      function read_unit(
          p_unit_id in integer)
      return transport_unit%rowtype
      is
          l_transport_unit_row transport_unit%rowtype;
      begin
          select *
          into   l_transport_unit_row
          from   transport_unit t
          where  t.id = p_unit_id;
  
          return l_transport_unit_row;
      exception
          when no_data_found then
               raise_application_error(-20000, 'Пакет синхронізації з регіональним відділенням з ідентифікатором {' || p_unit_id || '} не знайдений');
      end;
  
      function get_unit_type_code(
          p_transport_id in integer)
      return varchar2
      is
      begin
          return read_unit_type(p_transport_id).transport_type_code;
      end;
  
      function get_receiver_url(
          p_mfo in varchar2)
      return varchar2
      is
      begin
          return read_syncru_params(p_mfo).sync_service_url;
      end;
  
      procedure set_transport_failure(
          p_unit_row in transport_unit%rowtype,
          p_error_message in varchar2,
          p_stack_trace in clob)
      is
          l_failures_count integer;
      begin
          l_failures_count := nvl(p_unit_row.failures_count, 0) + 1;
          if (p_unit_row.failures_count >= MARGINAL_TRIES_COUNT) then
              set_transport_state(p_unit_row.id, transport_utl.TRANS_STATE_FAILED, p_error_message, p_stack_trace);
          else
              update transport_unit t
              set    t.failures_count = l_failures_count,
                     t.upd_date = sysdate
              where  t.id = p_unit_row.id;
  
              track_transport(p_unit_row.id, transport_utl.TRANS_STATE_FAILED, p_error_message, p_stack_trace);
          end if;
      end;

      procedure prepare_transport_request(
          p_unit_row in transport_unit%rowtype,
          p_our_endpoint in varchar2,
          p_receiver_endpoint in varchar2,
          p_body in blob)
      is
          l_url varchar2(4000 byte);
          l_walett_path varchar2(4000 byte);
          l_walett_pass varchar2(4000 byte);
           l_kf varchar2(10);
      begin
          l_url := pfu_utl.get_parameter('BARS_WS_URL');
          l_walett_path := pfu_utl.get_parameter('BARS_WS_WALLET_PATH');
          l_walett_pass := pfu_utl.get_parameter('BARS_WS_WALLET_PASS');
  
          bars.wsm_mgr.prepare_request(p_url          => l_url || p_our_endpoint,
                                       p_action       => null,
                                       p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                       p_content_type => bars.wsm_mgr.G_CT_XML,
                                       p_wallet_path  => l_walett_path,
                                       p_wallet_pwd   => l_walett_pass,
                                       p_blob_body    => p_body);
          /* select s.kf
            into l_kf
            from pfu.pfu_syncru_params s
           where s.sync_service_url = p_unit_row.receiver_url;*/
  
          bars.wsm_mgr.add_parameter(p_name => 'RedirectUrl', p_value => p_unit_row.receiver_url || p_receiver_endpoint);
          bars.wsm_mgr.add_parameter(p_name => 'PackageId', p_value => to_char(p_unit_row.id));
          bars.wsm_mgr.add_parameter(p_name => 'PackageMFO', p_value => to_char(p_unit_row.kf));
          bars.wsm_mgr.add_parameter(p_name => 'PackageName', p_value => get_unit_type_code(p_unit_row.unit_type_id));
      end;
  
      procedure send_data(
          p_unit_row in transport_unit%rowtype)
      is
          l_response bars.wsm_mgr.t_response;
          l_xml xmltype;
          l_state_code varchar2(32767 byte);
          l_error_message varchar2(32767 byte);
      begin
          savepoint before_request;
  
          prepare_transport_request(p_unit_row, '/pfuredirect/sendpackage', '/api/pfu/pfurequest/sendpackage', p_unit_row.request_data);
  
          bars.wsm_mgr.execute_api(l_response);
  
          l_xml := xmltype(l_response.cdoc);
  
          if (l_xml.extract('/ResponseData/Status/text()').getstringval() = '0') then
              l_state_code := l_xml.extract('/ResponseData/Result/State/text()').getstringval();
              if (l_state_code = '0') then
                  set_transport_state(p_unit_row.id, transport_utl.TRANS_STATE_SENT, null, null);
              else
                  l_error_message := l_xml.extract('/ResponseData/Result/Message/text()').getstringval();
                  set_transport_state(p_unit_row.id, transport_utl.TRANS_STATE_FAILED, 'Код помилки - ' || l_state_code || ' : ' || l_error_message, null);
              end if;
          else
              set_transport_failure(p_unit_row, l_xml.extract('/ResponseData/ErrorMessage/text()').getstringval(), null);
          end if;
      exception
          when others then
               rollback to before_request;
               set_transport_failure(p_unit_row, sqlerrm, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
      end;
  
      procedure get_receipt(
          p_unit_row in transport_unit%rowtype)
      is
          l_response bars.wsm_mgr.t_response;
          l_xml xmltype;
          l_state_code varchar2(32767 byte);
          l_clob clob;
          l_blob blob;
          l_error_message varchar2(32767 byte);
      begin
          prepare_transport_request(p_unit_row, '/pfuredirect/receiptpackage', '/api/pfu//pfurequest/receiptpackage', null);
  
          savepoint before_request;
  
          bars.wsm_mgr.execute_api(l_response);
  
          l_xml := xmltype(l_response.cdoc);
  
          if (l_xml.extract('/ResponseData/Status/text()').getstringval() = '0') then
              l_state_code := l_xml.extract('/ResponseData/Result/State/text()').getstringval();
              if (l_state_code = '0') then
                  l_clob := l_xml.extract('/ResponseData/Result/Data/text()').getclobval();
                  l_clob := pfu_utl.decodeclobfrombase64(l_clob);
                  l_blob := pfu_utl.clob_to_blob(l_clob);
                  -- l_blob := utl_compress.lz_uncompress(l_blob);
  
                  update transport_unit t
                  set    t.response_data = l_blob
                  where  t.id = p_unit_row.id;
  
                  set_transport_state(p_unit_row.id, transport_utl.TRANS_STATE_RESPONDED, null, null);
              else
                  l_error_message := l_xml.extract('/ResponseData/Result/Message/text()').getstringval();
                  set_transport_state(p_unit_row.id, transport_utl.TRANS_STATE_FAILED, 'Код помилки - ' || l_state_code || ' : ' || l_error_message, null);
              end if;
          else
              set_transport_failure(p_unit_row, l_xml.extract('/ResponseData/ErrorMessage/text()').getstringval(), null);
          end if;
      exception
          when others then
               rollback to before_request;
               set_transport_failure(p_unit_row, sqlerrm, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
      end;
  
      procedure check_unit_state(
          p_unit_row in transport_unit%rowtype)
      is
          l_response bars.wsm_mgr.t_response;
          l_xml xmltype;
          l_state_code varchar2(32767 byte);
          l_error_message varchar2(32767 byte);
      begin
          prepare_transport_request(p_unit_row, '/pfuredirect/checkpackage', '/api/pfu/pfurequest/checkpackage', null);
  
          savepoint before_request;
  
          bars.wsm_mgr.execute_api(l_response);
  
          l_xml := xmltype(l_response.cdoc);
  
          if (l_xml.extract('/ResponseData/Status/text()').getstringval() = '0') then
              l_state_code := l_xml.extract('/ResponseData/Result/State/text()').getstringval();
              if (l_state_code = '20') then
                  get_receipt(p_unit_row);
              elsif (l_state_code = '0') then
                  set_transport_state(p_unit_row.id, transport_utl.TRANS_STATE_DATA_NOT_READY, '', null);
              else
                  l_error_message := l_xml.extract('/ResponseData/Result/Message/text()').getstringval();
                  set_transport_state(p_unit_row.id, transport_utl.TRANS_STATE_FAILED, 'Код помилки - ' || l_state_code || ' : ' || l_error_message, null);
              end if;
          else
              set_transport_failure(p_unit_row, l_xml.extract('/ResponseData/ErrorMessage/text()').getstringval(), null);
          end if;
      exception
          when others then
               rollback to before_request;
               set_transport_failure(p_unit_row, sqlerrm, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
      end;

      procedure perform_transport_activities
      is
      begin
          for i in (select * from transport_unit t
                    where t.state_id = transport_utl.TRANS_STATE_NEW
                    for update skip locked) loop
              send_data(i);
          end loop;
  
          for i in (select * from transport_unit t
                    where t.state_id in (transport_utl.TRANS_STATE_SENT, transport_utl.TRANS_STATE_DATA_NOT_READY)
                    for update skip locked) loop
              check_unit_state(i);
          end loop;
      end;
end;
/
 show err;
 
PROMPT *** Create  grants  TRANSPORT_UTL ***
grant EXECUTE                                                                on TRANSPORT_UTL   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/PFU/package/transport_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 
  