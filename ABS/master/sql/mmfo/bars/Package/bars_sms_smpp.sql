
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms_smpp.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SMS_SMPP is
----
--  Package BARS_SMS_SMPP - ����� �������� ��� �������� SMS �� SMPP ��������
--                              (������������ �������)
--
-- MOS, 31/07/2013
--

g_header_version  constant varchar2(64)  := 'version 1.0 31/07/2013';

g_awk_header_defs constant varchar2(512) := '';

g_transfer_timeout constant number := 180;

---
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2;

----
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2;

---
-- ���������� �������� �� web_config
--
function get_param_webconfig(par varchar2) return web_barsconfig.val%type;

----
-- �����
--
  function invoke(p_req in out nocopy soap_rpc.t_request) return soap_rpc.t_response;

----
-- submit_msg - ��������� ������� ���������
--
procedure submit_msg(p_msgid in msg_submit_data.msg_id%type);

----
-- query_status - ��������� �������� �������
--
procedure query_status(p_smsid in sms_query_data.sms_id%type);

----
-- set_msg_status - ������������ ������� ����������� ����� ���-����� �� ������ �������� ����������
--
procedure set_msg_status(p_msg_ref in msg_submit_data.ref%type, p_status in msg_submit_data.status%type);

----
-- set_msg_ref - ������������ ��������� ����������� ���������� ���� �������� �����������  �� ������ �������� ����������
--
procedure set_msg_ref(p_msg_id in msg_submit_data.msg_id%type, p_msg_ref in msg_submit_data.ref%type, p_status in msg_submit_data.status%type);

----
-- save_log - log execptions
--
procedure save_log(p_log_txt in sec_audit.REC_MESSAGE%type);

end bars_sms_smpp;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SMS_SMPP 
is
----
--  Package BARS_SMS_SMPP - ����� �������� ��� �������� SMS �� SMPP ���������
--                              (������������ �������)
--
--  MOS 31/07/2013
--

g_body_version  constant varchar2(64)  := 'version 1.01 25/08/2015';

g_awk_body_defs constant varchar2(512) := '';

g_cur_rep_id   number := -1;

g_cur_block_id number := -1;

G_ERRMOD       constant varchar2(3) := 'BCK';

g_is_error     boolean := false;

G_XMLHEAD      constant varchar2(100) := '<?xml version="1.0" encoding="utf-8"?>';

----
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2 is
begin
  return 'Package header BARS_SMS_SMPP '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
end header_version;

----
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2 is
begin
  return 'Package body BARS_SMS_SMPP '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
end body_version;

 function extract(p_xml       in xmltype,
                       p_xpath     in varchar2,
                       p_mandatory in number) return varchar2 is
      begin
        begin
          return p_xml.extract(p_xpath).getStringVal();
        exception
          when others then
            if p_mandatory is null or g_is_error then
              return null;
            else
              if sqlcode = -30625 then
                bars_error.raise_nerror(g_errmod,
                                        'XMLTAG_NOT_FOUND',
                                        p_xpath,
                                        g_cur_block_id,
                                        g_cur_rep_id);
              else
                raise;
              end if;
            end if;
        end;
      end;

---
-- ���������� �������� �� web_config
--
function get_param_webconfig(par varchar2) return web_barsconfig.val%type
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
      raise_application_error(-20000, '�� ������ KEY='||par||' � ������� web_barsconfig!');
  end;
----
-- canonize_phone_number - ������������ ����� ��������, ������ ���� � ������ � ������ �����������
--
function canonize_phone_number(p_phone in varchar2)
return varchar2
is
    l_canonized_phone   varchar2(13);
    l_length            number;
    l_pos               number;
    l_char              varchar2(1);
begin

     if (TRANSLATE(p_phone,chr(0)||'+0123456789',chr(0))) is not null
     then
        raise_application_error(-20000, '� ������ �������� ���������� ������������ ������: '||(TRANSLATE(p_phone,chr(0)||'+0123456789',chr(0))));
    end if;

    l_pos := 1;
    l_length := length(p_phone);
    while l_pos <= l_length
    loop
        l_char := substr(p_phone, l_pos, 1);
        if l_char in ('0','1','2','3','4','5','6','7','8','9')
        then
            if length(l_canonized_phone) > 12
            then
                raise_application_error(-20000, '����� �������� ����� ����������� ��������� 12 ������. �������� �����: '||p_phone);
            end if;
            l_canonized_phone := l_canonized_phone || l_char;
        end if;
        l_pos := l_pos + 1;
    end loop;

    if length(l_canonized_phone)=10
        then l_canonized_phone:='38'||l_canonized_phone;
     elsif length(l_canonized_phone)=9
        then l_canonized_phone:='380'||l_canonized_phone;
     end if;
    --
    return l_canonized_phone;
end;

 procedure generate_envelope(p_req in out nocopy soap_rpc.t_request,
                              p_env in out nocopy varchar2) as
  begin
    p_env := G_XMLHEAD || '<soap:Envelope ' ||
             'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' ||
             'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' ||
             'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">' ||
             '<soap:Body>' || '<' || p_req.method || ' xmlns="' ||
             p_req.namespace || '">' || p_req.body || '</' || p_req.method || '>' ||
             '</soap:Body>' || '</soap:Envelope>';
  end;

  ----
  -- �������� ������ � ������� � ���������� ����������
  --
  procedure check_fault(p_resp in out nocopy soap_rpc.t_response) as
    l_fault_node   xmltype;
    l_fault_code   varchar2(256);
    l_fault_string varchar2(32767);
  begin
    l_fault_node := p_resp.doc.extract('/soap:Fault',
                                       'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/');
    if (l_fault_node is not null) then
      l_fault_code   := l_fault_node.extract('/soap:Fault/faultcode/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                        .getstringval();
      l_fault_string := l_fault_node.extract('/soap:Fault/faultstring/child::text()','xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/')
                        .getstringval();
      raise_application_error(-20000,
                              l_fault_code || ' - ' || l_fault_string);
    end if;
  end;

   function invoke(p_req in out nocopy soap_rpc.t_request) return soap_rpc.t_response as
    l_env       varchar2(32767);
    l_line      varchar2(32767);
    l_res       clob;
    l_http_req  utl_http.req;
    l_http_resp utl_http.resp;
    l_resp      soap_rpc.t_response;
  begin
    generate_envelope(p_req, l_env);

    utl_http.set_transfer_timeout(g_transfer_timeout);

	 -- SSL ���������� ��������� ����� wallet
    if (instr(lower(p_req.url), 'https://') > 0) then
      utl_http.set_wallet(p_req.wallet_dir, p_req.wallet_pass);
    end if;

    l_http_req := utl_http.begin_request(p_req.url, 'POST', 'HTTP/1.0');
    --utl_http.set_header(l_http_req, 'Content-Type', 'application/x-www-form-urlencoded;');
    utl_http.set_header(l_http_req, 'Content-Type', 'text/xml;');
    utl_http.set_header(l_http_req, 'Content-Length', length(l_env));
    utl_http.set_header(l_http_req,
                        'SOAPAction',
                        p_req.namespace || p_req.method);
    utl_http.write_text(l_http_req, l_env);

    l_http_resp := utl_http.get_response(l_http_req);
    l_res       := null;
    begin
      loop
        utl_http.read_text(l_http_resp, l_line);
        l_res := l_res || l_line;
      end loop;
    exception
      when utl_http.end_of_body then
        null;
    end;
    utl_http.end_response(l_http_resp);

    l_resp.doc := xmltype.createxml(l_res);
    l_resp.doc := l_resp.doc.extract('/soap:Envelope/soap:Body/child::node()',
                                     'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
    check_fault(l_resp);
    return l_resp;
  end;

----
-- submit_msg - ��������� ������� ���������
--
procedure submit_msg(p_msgid in msg_submit_data.msg_id%type) is
    l_msg       msg_submit_data%rowtype;
    l_addr      varchar2(200);
    l_sqlerrm   varchar2(4000);
    l_mail      bars.t_bars_mail;
    l_msgid     raw(16);
    l_charset   varchar2(30);
    l_request      soap_rpc.t_request;
    l_response     soap_rpc.t_response;
    l_tmp          xmltype;
    --l_status       varchar2(64);
    l_message      varchar2(8000);
    l_clob         clob;

begin
    logger.trace('bars_sms_smpp.submit_msg(p_msgid=>'||p_msgid||'): start');
    -- �������� ���� ���������
    begin
        select *
          into l_msg
          from msg_submit_data
         where msg_id=p_msgid
        for update nowait;
    exception when no_data_found then
        raise_application_error(-20000, '���������(MSG_ID='||p_msgid||') �� �������', true);
    end;
    --
    savepoint sp;
    -- ��������
    if l_msg.status not in ('NEW', 'ERROR')
    then
        raise_application_error(-20000, '������������ ������('||l_msg.status||') ���������(MSG_ID='||p_msgid||')', true);
    end if;
    if l_msg.expiration_time<sysdate
    then
        update msg_submit_data
           set status = 'EXPIRED',
               status_time = sysdate
         where msg_id = p_msgid;
        return;
    end if;
    -- �������� ���������
    begin
        l_addr := canonize_phone_number(l_msg.phone);
        --
        if l_msg.encode='lat'
        then
           l_msg.msg_text:=  substr(f_translate_kmu(l_msg.msg_text),1,160);
        else
           l_msg.msg_text:=  substr(f_translate_kmu(l_msg.msg_text),1,160);
           --l_msg.msg_text:=  substr(convert(l_msg.msg_text,'UTF8', 'CL8MSWIN1251'),1,70);
        end if;

          -- ����� ������ Send ������-������� Send_sms.asmx

          IF (get_param_webconfig ('SMS.Use') = 'Y')
         THEN
           -- ����������� �������
            l_request :=
               soap_rpc.new_request (
                  p_url           => get_param_webconfig ('SMS.Url'),
                  p_namespace     => get_param_webconfig ('SMS.NS'),
                  p_method        => 'websmssend',
                  p_wallet_dir    => get_param_webconfig ('SMS.Wallet_dir'),
                  p_wallet_pass   => get_param_webconfig ('SMS.Wallet_pass'));

            -- �������� ���������
            soap_rpc.ADD_PARAMETER (l_request, 'msg_id', to_char(p_msgid));
            soap_rpc.ADD_PARAMETER (l_request, 'oa', get_param_webconfig ('SMS.Sender'));
            soap_rpc.ADD_PARAMETER (l_request, 'da', l_addr);
            soap_rpc.ADD_PARAMETER (l_request, 'sms_text', l_msg.msg_text);

         ELSE

           -- ����������� �������
            l_request :=
               soap_rpc.new_request (
                  p_url           => get_param_webconfig ('SMPP.Url'),
                  p_namespace     => get_param_webconfig ('SMPP.NS'),
                  p_method        => 'Send',
                  p_wallet_dir    => get_param_webconfig ('SMPP.Wallet_dir'),
                  p_wallet_pass   => get_param_webconfig ('SMPP.Wallet_pass'));

            -- �������� ���������
            soap_rpc.ADD_PARAMETER (l_request, 'phone', l_addr);
            soap_rpc.ADD_PARAMETER (l_request, 'text', l_msg.msg_text);

         END IF;


          -- ������� ����� ���-�������
          l_response := soap_rpc.invoke(l_request);

          -- ���� ������������ � ������ xpath ��� ��������� xmlns
          l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
          l_tmp  := xmltype(l_clob);


          /*l_status := extract(l_tmp,
                           '/SendResponse/SendResult/Status/text()',
                           null);*/

          l_message := extract(l_tmp,
                           '/SendResponse/SendResult/ErrorMessage/text()',

                        null);
     -- ������ �� web �������
     if length (l_message) >0 and lower(l_message) not like '%delivery receipt processing%'
       then
         begin
           update msg_submit_data
           set smpp_error_msg= l_message,
               status          = 'ERROR',
               status_time     = sysdate
           where msg_id = p_msgid;
         end;
     else
           begin
            --���� ��� ������ �� ������� ������� ��� ��� ��
            update msg_submit_data
               set status          = 'SUBMITTED',
                   status_time     = sysdate,
                   submit_code     = null,
                   last_error      = null,
                   smpp_error_msg  = null
             where msg_id = p_msgid;
           end;
     end if;


       --���� �� ������ �� ������ ����� exception � ����������� ������ � last_error
    exception
        when others then
            rollback to sp;
            l_sqlerrm := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(),1,4000);
            update msg_submit_data
               set status          = 'ERROR',
                   status_time     = sysdate,
                   last_error      = l_sqlerrm
             where msg_id = p_msgid;
            logger.error('bars_sms_smpp.submit_msg(p_msgid=>'||p_msgid||')'||chr(10)||l_sqlerrm);
    end;
    --
    logger.trace('bars_sms_smpp.submit_msg(p_msgid=>'||p_msgid||'): finish');
    --
end submit_msg;

----
-- query_status - ��������� �������� �������
--
procedure query_status(p_smsid in sms_query_data.sms_id%type) is
begin
    null;
end query_status;

   ----
   -- set_msg_status - ������������ ������� ����������� ����� ���-����� �� ������ �������� ����������
   --
   PROCEDURE set_msg_status (p_msg_ref   IN msg_submit_data.REF%TYPE,
                             p_status    IN msg_submit_data.status%TYPE)
   IS
      l_sqlerrm   VARCHAR2 (4000);
   BEGIN
    logger.info (
                  'bars_sms_smpp.set_msg_status(p_msg_ref=>'
               || p_msg_ref
               || ',p_status=>'
               || p_status
               || ')'
               || CHR (10)
               );


     UPDATE msg_submit_data t1
         SET t1.status = p_status
       WHERE t1.ref = p_msg_ref;
         IF SQL%ROWCOUNT = 0
         THEN
            raise_application_error (
               -20000,
                  '���������(p_msg_ref='
               || p_msg_ref
               || ') �� �������',
               TRUE);
         END IF;
   END set_msg_status;

   ----
   -- set_msg_ref - ������������ ��������� �� ������� ����������� ���������� ���� �������� �����������  �� ������ �������� ����������
   --
   PROCEDURE set_msg_ref (p_msg_id    IN msg_submit_data.msg_id%TYPE,
                          p_msg_ref   IN msg_submit_data.REF%TYPE,
                          p_status    IN msg_submit_data.status%TYPE)
   IS
      l_sqlerrm   VARCHAR2 (4000);
   BEGIN
    logger.info (
                  'bars_sms_smpp.set_msg_ref(p_msg_id=>'
               || p_msg_id
               || ',p_msg_ref=>'
               || p_msg_ref
               || ',p_status=>'
               || p_status
               || ')'
               || CHR (10)
               );
      UPDATE msg_submit_data t1
         SET t1.ref = p_msg_ref, t1.status = p_status
       WHERE t1.msg_id = p_msg_id;
         IF SQL%ROWCOUNT = 0
         THEN
         logger.info (
               '���������(p_msg_id='
               || p_msg_id
               || ') �� �������');

           raise_application_error (
               -20000,
                  '���������(p_msg_id='
               || p_msg_id
               || ') �� �������',
               TRUE);
         END IF;
   END set_msg_ref;

   ----
   -- save_log - log execptions
   --
   PROCEDURE save_log (p_log_txt IN sec_audit.REC_MESSAGE%TYPE)
   IS
   BEGIN
      logger.info ('bars_sms_smpp: ' || p_log_txt);

   END save_log;



end bars_sms_smpp;
/
 show err;
 
PROMPT *** Create  grants  BARS_SMS_SMPP ***
grant DEBUG,EXECUTE                                                          on BARS_SMS_SMPP   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sms_smpp.sql =========*** End *
 PROMPT ===================================================================================== 
 