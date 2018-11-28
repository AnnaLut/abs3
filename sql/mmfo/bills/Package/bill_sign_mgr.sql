
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/package/bill_sign_mgr.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BILLS.BILL_SIGN_MGR 
is
    --
    -- Функции работы с подписью
    --
    g_header_version      constant varchar2(64)  := 'version 1.0.1 25/06/2018';
    g_vega_provider       constant varchar2(32)  := 'CapiVegaDstu';
    g_enc_type_hex        constant varchar2(8)   := 'Hex';
    g_source_receivers    constant varchar2(12) := 'RECEIVERS';
    g_source_ca_receivers constant varchar2(12) := 'CA_RECEIVERS';
    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2;

    --
    -- Получить буфер данных для подписи по получателю
    --
    function get_receiver_buffer (p_exp_id in receivers.exp_id%type,
                                  p_source in varchar2 default g_source_receivers) 
    return clob;
    
    --
    -- Сохранить подпись по получателю
    --
    procedure store_receiver_sign (p_exp_id    in receivers.exp_id%type,
                                   p_signer    in receivers.signer%type,
                                   p_signature in receivers.signature%type);
    
    --
    -- Проверить подпись (вернет текст ошибки) - общий метод
    --
    function validate_signature (p_buffer in clob, p_sign in clob)
    return varchar2;
    
    --
    -- Проверить подпись на получателе (вернет текст ошибки)
    --
    function validate_signature (p_exp_id in receivers.exp_id%type,
                                 p_source in varchar2 default g_source_receivers)
    return varchar2;
    
    --
    -- Проверить подпись на получателе (бросает ошибку)
    --
    procedure validate_signature (p_exp_id in receivers.exp_id%type);

end bill_sign_mgr;
/
CREATE OR REPLACE PACKAGE BODY BILLS.BILL_SIGN_MGR 
is
    g_body_version      constant varchar2(64)  := 'Version 1.1.1 20/07/2018';
    G_TRACE             constant varchar2(20)  := 'bill_sign_mgr.';

    g_crypto_schema     constant varchar2(128) := 'http://schemas.datacontract.org/2004/07/bars.services.core.modules.security';
    g_in_nmsps          constant varchar2(256) := 'xmlns="http://schemas.datacontract.org/2004/07/bars.services.core.modules.security" xmlns:i="http://www.w3.org/2001/XMLSchema-instance"';
    g_crypto_url                 varchar2(128);
    
    g_sign_status                integer := get_bill_param('SIGN_STATUS');
    --
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2 is
    begin
        return 'Package header '||G_TRACE|| g_header_version;
    end header_version;

    --
    -- body_version - возвращает версию тела пакета
    --
    function body_version return varchar2 is
    begin
        return 'Package body '||G_TRACE|| g_body_version;
    end body_version;

    --
    -- Получить буфер данных для подписи по получателю
    --
    function get_receiver_buffer (p_exp_id in receivers.exp_id%type,
                                  p_source in varchar2 default g_source_receivers)
    return clob
        is
    l_xml_data xmltype;
    l_result clob;
    begin
        if p_source = g_source_receivers then
            select xmlelement("RECEIVER",
               xmlelement("NAME", r.name),
               xmlelement("INN", r.inn),
               xmlelement("DOC_DATE", to_char(r.doc_date, 'dd.mm.yyyy')),
               xmlelement("DOC_WHO", r.doc_who),
               xmlelement("CURRENCY", r.currency),
               xmlelement("CUR_RATE", r.cur_rate),
               xmlelement("AMOUNT", r.amount*100), /*издержки хранения суммы в не-целом виде*/
               xmlelement("PHONE", r.phone)
            ) data
            into l_xml_data
            from receivers r
            where exp_id = p_exp_id
            for update nowait;
        elsif p_source = g_source_ca_receivers then
            select xmlelement("RECEIVER",
               xmlelement("NAME", r.name),
               xmlelement("INN", r.inn),
               xmlelement("DOC_DATE", to_char(r.doc_date, 'dd.mm.yyyy')),
               xmlelement("DOC_WHO", r.doc_who),
               xmlelement("CURRENCY", r.currency),
               xmlelement("CUR_RATE", r.cur_rate),
               xmlelement("AMOUNT", r.amount),
               xmlelement("PHONE", r.phone)
            ) data
            into l_xml_data
            from ca_receivers r
            where exp_id = p_exp_id
            for update nowait;
        else
            return null;
        end if;
        l_result := to_clob(rawtohex(utl_raw.cast_to_raw(l_xml_data.getStringVal)));
        return l_result;
    end get_receiver_buffer;
    
    --
    -- Сохранить подпись по получателю
    --
    procedure store_receiver_sign (p_exp_id    in receivers.exp_id%type,
                                   p_signer    in receivers.signer%type,
                                   p_signature in receivers.signature%type)
        is
    begin
        update receivers
        set signer = p_signer,
            signature = p_signature,
            sign_date = systimestamp
        where exp_id = p_exp_id;
    end store_receiver_sign;
    
    --
    -- Проверить подпись (вернет текст ошибки) - общий метод
    --
    function validate_signature (p_buffer in clob, p_sign in clob)
    return varchar2
        is
    l_checkRequest_xml XMLtype;
    l_response         wsm_mgr.t_response;
    l_errmsg varchar2(1024);
    begin
        if g_sign_status = 0 then
          return null;
        end if;
        select xmlelement("CheckSignData", xmlattributes(g_crypto_schema as "xmlns"),
                xmlelement("Buffer", p_buffer),
                xmlelement("EncType", g_enc_type_hex),
                xmlelement("Id", 'BILLS'),
                xmlelement("IgnoreOSCP", 'true'),
                xmlelement("ProviderType", g_vega_provider),
                xmlelement("SignedBuffer", p_sign)
               )
        into l_checkRequest_xml
        from dual;
        wsm_mgr.prepare_request(p_url             => g_crypto_url,
                                p_action          => 'CheckSignSingle',
                                p_http_method     => wsm_mgr.g_http_post,
                                p_content_type    => wsm_mgr.g_ct_xml,
                                p_content_charset => wsm_mgr.g_cc_utf8,
                                p_wallet_path     => bsm.g_wallet_path,
                                p_wallet_pwd      => bsm.g_wallet_pwd,
                                p_body            => l_checkRequest_xml.getClobVal);
        wsm_mgr.execute_request(p_response => l_response);
        l_errmsg := case when l_response.xdoc.extract('//ErrorMessage/text()', g_in_nmsps) is not null then 
                                                        l_response.xdoc.extract('//ErrorMessage/text()', g_in_nmsps).getStringVal
                         else '' end;
        return l_errmsg;
    end validate_signature;
    
    --
    -- Проверить подпись на получателе (вернет текст ошибки)
    --
    function validate_signature (p_exp_id in receivers.exp_id%type,
                                 p_source in varchar2 default g_source_receivers)
    return varchar2
        is
    l_signature clob;
    l_buffer clob;
    begin
        if g_sign_status = 0 then
          return null;
        end if;
        if p_source = g_source_receivers then
            select signature into l_signature from receivers where exp_id = p_exp_id;
        elsif p_source = g_source_ca_receivers then
            select signature into l_signature from ca_receivers where exp_id = p_exp_id;
        end if;
        if l_signature is null then
            return 'Помилка перевірки підпису: ЕЦП не знайдено!';
        end if;
        l_buffer := get_receiver_buffer(p_exp_id, p_source);
        return validate_signature(p_buffer => l_buffer,
                                  p_sign => l_signature);
    end validate_signature;
    
    --
    -- Проверить подпись на получателе (бросает ошибку)
    --
    procedure validate_signature (p_exp_id in receivers.exp_id%type)
        is
    l_check_result varchar2(256);
    begin
        l_check_result := substr(validate_signature(p_exp_id), 1, 255);
        bill_audit_mgr.trace(p_action => 'CheckSignInternal',
                             p_key    => p_exp_id,
                             p_params => '',
                             p_result => nvl(l_check_result, 'Success'));
        if l_check_result is not null then
            raise_application_error(-20000, l_check_result);
        end if;
    end validate_signature;

    procedure init
        is
    begin
        g_crypto_url := get_bill_param('CRYPTO_URL');
        if g_crypto_url is null then 
            raise_application_error(-20000, 'Не заповнено параметр CRYPTO_URL - URL сервісу криптографічних перетворень');
        end if;
    end init;

begin
    init;
end bill_sign_mgr;
/
 show err;
 
PROMPT *** Create  grants  BILL_SIGN_MGR ***
grant EXECUTE                                                                on BILL_SIGN_MGR   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/package/bill_sign_mgr.sql =========*** End 
 PROMPT ===================================================================================== 
 