
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ext_file_mgr.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.EXT_FILE_MGR is

    function list_folders(
        p_folder_path in varchar2,
        p_scan_depth in integer default null)
    return string_list;

    function check_whether_folder_exists(
        p_folder_path in varchar2)
    return integer;

    procedure create_folder(
        p_folder_path in varchar2);

    procedure remove_folder(
        p_folder_path in varchar2);

    function list_files(
        p_folder_path in varchar2,
        p_include_subfolders in integer default 1,
        p_file_mask in varchar2 default null)
    return string_list;

    function check_whether_file_exists(
        p_file_path in varchar2)
    return integer;

    function get_file_body(
        p_file_path in varchar2)
    return blob;

    function get_file_text(
        p_file_path in varchar2,
        p_file_encoding in varchar2 default null)
    return clob;

    procedure put_file_body(
        p_file in blob,
        p_file_path in varchar2,
        p_overwrite in integer default 1);

    procedure put_file_text(
        p_file in clob,
        p_file_path in varchar2,
        p_file_encoding in varchar2 default null,
        p_overwrite in integer default 1);

    procedure append_file_body(
        p_file in blob,
        p_file_path in varchar2,
        p_overwrite in integer default 1);

    procedure append_file_text(
        p_file in clob,
        p_file_path in varchar2,
        p_overwrite in integer default 1);

    procedure remove_file(
        p_file_path in varchar2);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.EXT_FILE_MGR as

    g_service_name constant varchar2(30 char) := 'ExternalFileManager.asmx';
    g_service_namespace constant varchar2(30 char) := 'http://ws.unity-bars.com.ua/';

    function list_folders(
        p_folder_path in varchar2,
        p_scan_depth in integer default null)
    return string_list
    is
    begin
        raise_application_error(-20000, 'Not implemented for now - reserved for future use');
    end;

    function check_whether_folder_exists(
        p_folder_path in varchar2)
    return integer
    is
    begin
        raise_application_error(-20000, 'Not implemented for now - reserved for future use');
    end;

    procedure create_folder(
        p_folder_path in varchar2)
    is
    begin
        raise_application_error(-20000, 'Not implemented for now - reserved for future use');
    end;

    procedure remove_folder(
        p_folder_path in varchar2)
    is
    begin
        raise_application_error(-20000, 'Not implemented for now - reserved for future use');
    end;

    function list_files(
        p_folder_path in varchar2,
        p_include_subfolders in integer default 1,
        p_file_mask in varchar2 default null)
    return string_list
    is
        l_file_list string_list;
        l_url varchar2(32767 byte);
        l_wallet_path varchar2(32767 byte);
        l_wallet_pass varchar2(32767 byte);
        l_login varchar2(32767 byte);
        l_password varchar2(32767 byte);
        l_response wsm_mgr.t_response;
        l_xml xmltype;
        l_response_code varchar2(32767 byte);
        l_response_message varchar2(32767 byte);
        l_files_list_xml xmltype;
    begin
        bars_audit.log_info('ext_file_mgr.scan_files',
                            'p_folder_path        : ' || p_folder_path || chr(10) ||
                            'p_include_subfolders : ' || p_include_subfolders || chr(10) ||
                            'p_file_mask          : ' || p_file_mask);

        l_url         := branch_attribute_utl.get_value('/', 'LINK_FOR_ABSBARS_SOAPWEBSERVICES') || g_service_name;
        -- l_url         := 'http://10.10.10.79:90/barsroot/webservices/' || g_service_name;
        l_wallet_path := branch_attribute_utl.get_value('/', 'PATH_FOR_ABSBARS_WALLET');
        l_wallet_pass := branch_attribute_utl.get_value('/', 'PASS_FOR_ABSBARS_WALLET');

        l_login       := branch_attribute_utl.get_value('/', 'TMS_LOGIN');
        l_password    := branch_attribute_utl.get_value('/', 'TMS_PASS');

        wsm_mgr.prepare_request(p_url             => l_url,
                                p_action          => null,
                                p_http_method     => bars.wsm_mgr.g_http_post,
                                p_wallet_path     => l_wallet_path,
                                p_wallet_pwd      => l_wallet_pass,
                                p_content_type    => wsm_mgr.g_ct_xml,
                                p_content_charset => wsm_mgr.g_cc_utf8,
                                p_namespace       => g_service_namespace,
                                p_soap_method     => 'ListFiles');

        wsm_mgr.add_header(p_name => 'UserName', p_value => l_login);
        wsm_mgr.add_header(p_name => 'Password', p_value => l_password);

        wsm_mgr.add_parameter(p_name => 'FolderPath', p_value => p_folder_path);
        wsm_mgr.add_parameter(p_name => 'WithSubfolders', p_value => tools.boolean_to_string(tools.int_to_boolean(p_include_subfolders)));
        wsm_mgr.add_parameter(p_name => 'FileMask', p_value => p_file_mask);

        bars.wsm_mgr.execute_soap(l_response);

        --l_xml := l_response.xdoc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
        l_xml := xmltype(l_response.cdoc).extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
        
        l_response_code := l_xml.extract('/ListFilesResponse/ListFilesResult/ResponseCode/text()').GetStringVal();

        if (upper(l_response_code) = 'SUCCESS') then

            l_files_list_xml := l_xml.extract('/ListFilesResponse/ListFilesResult/FilesList/node()');

            if (l_files_list_xml is not null) then
                dbms_output.put_line(l_files_list_xml.getStringVal());

                select extract(column_value, '/string/text()').GetStringVal()
                bulk collect into l_file_list
                from   table(xmlsequence(extract(l_files_list_xml, '/string'))) t;
            end if;

        elsif (upper(l_response_code) = 'ERROR') then

            l_response_message := l_xml.extract('/ListFilesResponse/ListFilesResult/ResponseMessage/text()').GetStringVal();

            if (l_response_message is null) then
                raise_application_error(-20000, 'Помилка отримання списку файлів для каталогу: ' || p_folder_path);
            else
                raise_application_error(-20000, l_response_message);
            end if;
        else
            raise_application_error(-20000, 'Неочікуваний код відповіді {' || l_response_code ||
                                            '} при отриманні списку файлів для каталогу: ' || p_folder_path);
        end if;

        return l_file_list;
    end;

    function check_whether_file_exists(
        p_file_path in varchar2)
    return integer
    is
    begin
        raise_application_error(-20000, 'Not implemented for now - implementation is coming soon. Please be patient...');
    end;

    function get_file_body(
        p_file_path in varchar2)
    return blob
    is
        l_url varchar2(32767 byte);
        l_wallet_path varchar2(32767 byte);
        l_wallet_pass varchar2(32767 byte);
        l_login varchar2(32767 byte);
        l_password varchar2(32767 byte);
        l_response wsm_mgr.t_response;
        l_xml xmltype;
        l_response_code varchar2(32767 byte);
        l_response_message varchar2(32767 byte);

        l_base64_clob clob;
        l_compressed_blob blob;
        l_file_body blob;
    begin
        bars_audit.log_info('ext_file_mgr.get_file_body',
                            'p_file_path        : ' || p_file_path);

        l_url         := branch_attribute_utl.get_value('/', 'LINK_FOR_ABSBARS_SOAPWEBSERVICES') || g_service_name;
        -- l_url         := 'http://10.10.10.79:90/barsroot/webservices/' || g_service_name;
        l_wallet_path := branch_attribute_utl.get_value('/', 'PATH_FOR_ABSBARS_WALLET');
        l_wallet_pass := branch_attribute_utl.get_value('/', 'PASS_FOR_ABSBARS_WALLET');

        l_login       := branch_attribute_utl.get_value('/', 'TMS_LOGIN');
        l_password    := branch_attribute_utl.get_value('/', 'TMS_PASS');

        wsm_mgr.prepare_request(p_url             => l_url,
                                p_action          => null,
                                p_http_method     => bars.wsm_mgr.g_http_post,
                                p_wallet_path     => l_wallet_path,
                                p_wallet_pwd      => l_wallet_pass,
                                p_content_type    => wsm_mgr.g_ct_xml,
                                p_content_charset => wsm_mgr.g_cc_utf8,
                                p_namespace       => g_service_namespace,
                                p_soap_method     => 'GetFile');

        wsm_mgr.add_header(p_name => 'UserName', p_value => l_login);
        wsm_mgr.add_header(p_name => 'Password', p_value => l_password);

        wsm_mgr.add_parameter(p_name => 'FilePath', p_value => p_file_path);

        bars.wsm_mgr.execute_soap(l_response);

        --l_xml := l_response.xdoc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
		l_xml := xmltype(l_response.cdoc).extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
		

        l_response_code := l_xml.extract('/GetFileResponse/GetFileResult/ResponseCode/text()').GetStringVal();

        if (upper(l_response_code) = 'SUCCESS') then

            if (l_xml.existsNode('/GetFileResponse/GetFileResult/FileBody') = 1) then

                l_base64_clob := l_xml.extract('/GetFileResponse/GetFileResult/FileBody/text()').GetClobVal();

                l_compressed_blob := lob_utl.decode_base64(l_base64_clob);

                l_file_body := utl_compress.lz_uncompress(l_compressed_blob);
            else
                raise_application_error(-20000, 'Сервіс не повернув тіло файла по шляху: ' || p_file_path);
            end if;

        elsif (upper(l_response_code) = 'ERROR') then

            l_response_message := l_xml.extract('/GetFileResponse/GetFileResult/ResponseMessage/text()').GetStringVal();

            if (l_response_message is null) then
                raise_application_error(-20000, 'Помилка отримання файлів по шляху: ' || p_file_path);
            else
                raise_application_error(-20000, l_response_message);
            end if;
        else
            raise_application_error(-20000, 'Неочікуваний код відповіді {' || l_response_code ||
                                            '} при отриманні файлів по шляху: ' || p_file_path);
        end if;

        return l_file_body;
    end;

    function get_file_text(
        p_file_path in varchar2,
        p_file_encoding in varchar2 default null)
    return clob
    is
        l_file_body blob;
        l_file_text clob;
        l_dest_offset integer := 1;
        l_src_offset integer := 1;
        l_charset_id integer := case when p_file_encoding is null then dbms_lob.DEFAULT_CSID
                                     else nls_charset_id(p_file_encoding)
                                end;
        l_language_context integer := dbms_lob.DEFAULT_LANG_CTX;
        l_warning varchar2(32767 byte);
    begin
        if (l_charset_id is null) then
            raise_application_error(-20000, 'Кодова сторінка ' || p_file_encoding || ' не знайдена');
        end if;

        l_file_body := get_file_body(p_file_path);

        if (l_file_body is null) then
            return null;
        end if;

        dbms_lob.createtemporary(l_file_text, false);
        dbms_lob.convertToClob(l_file_text,
                               l_file_body,
                               dbms_lob.LOBMAXSIZE,
                               l_dest_offset,
                               l_src_offset,
                               l_charset_id,
                               l_language_context,
                               l_warning);

        return l_file_text;
    end;

    procedure put_file_body(
        p_file in blob,
        p_file_path in varchar2,
        p_overwrite in integer default 1)
    is
        l_url varchar2(32767 byte);
        l_wallet_path varchar2(32767 byte);
        l_wallet_pass varchar2(32767 byte);
        l_login varchar2(32767 byte);
        l_password varchar2(32767 byte);
        l_response wsm_mgr.t_response;
        l_xml xmltype;
        l_response_code varchar2(32767 byte);
        l_response_message varchar2(32767 byte);

        l_base64_clob clob;
        l_compressed_blob blob;
        l_file_body blob;
    begin
        bars_audit.log_info('ext_file_mgr.put_file_body',
                            'p_file_path        : ' || p_file_path);

        l_url         := branch_attribute_utl.get_value('/', 'LINK_FOR_ABSBARS_SOAPWEBSERVICES') || g_service_name;
        -- l_url         := 'http://10.10.10.79:90/barsroot/webservices/' || g_service_name;
        l_wallet_path := branch_attribute_utl.get_value('/', 'PATH_FOR_ABSBARS_WALLET');
        l_wallet_pass := branch_attribute_utl.get_value('/', 'PASS_FOR_ABSBARS_WALLET');

        l_login       := branch_attribute_utl.get_value('/', 'TMS_LOGIN');
        l_password    := branch_attribute_utl.get_value('/', 'TMS_PASS');

        wsm_mgr.prepare_request(p_url             => l_url,
                                p_action          => null,
                                p_http_method     => bars.wsm_mgr.g_http_post,
                                p_wallet_path     => l_wallet_path,
                                p_wallet_pwd      => l_wallet_pass,
                                p_content_type    => wsm_mgr.g_ct_xml,
                                p_content_charset => wsm_mgr.g_cc_utf8,
                                p_namespace       => g_service_namespace,
                                p_soap_method     => 'PutFile');

        wsm_mgr.add_header(p_name => 'UserName', p_value => l_login);
        wsm_mgr.add_header(p_name => 'Password', p_value => l_password);

        dbms_lob.createtemporary(l_compressed_blob, false);
        utl_compress.lz_compress(p_file, l_compressed_blob);
        l_base64_clob := lob_utl.encode_base64(l_compressed_blob);

        wsm_mgr.add_parameter(p_name => 'FileBody', p_value => l_base64_clob);
        wsm_mgr.add_parameter(p_name => 'FilePath', p_value => p_file_path);
        wsm_mgr.add_parameter(p_name => 'Overwrite', p_value => tools.boolean_to_string(tools.int_to_boolean(p_overwrite)));

        bars.wsm_mgr.execute_soap(l_response);

        --l_xml := l_response.xdoc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
		l_xml := xmltype(l_response.cdoc).extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');

		
        l_response_code := l_xml.extract('/PutFileResponse/PutFileResult/ResponseCode/text()').GetStringVal();

        if (upper(l_response_code) = 'SUCCESS') then
            return;
        elsif (upper(l_response_code) = 'ERROR') then

            l_response_message := l_xml.extract('/PutFileResponse/PutFileResult/ResponseMessage/text()').GetStringVal();

            if (l_response_message is null) then
                raise_application_error(-20000, 'Помилка збереження файлів по шляху: ' || p_file_path);
            else
                raise_application_error(-20000, l_response_message);
            end if;
        else
            raise_application_error(-20000, 'Неочікуваний код відповіді {' || l_response_code ||
                                            '} при збереженні файлу по шляху: ' || p_file_path);
        end if;
    end;

    procedure put_file_text(
        p_file in clob,
        p_file_path in varchar2,
        p_file_encoding in varchar2 default null,
        p_overwrite in integer default 1)
    is
        l_file_body blob;
        l_dest_offset integer := 1;
        l_src_offset integer := 1;
        l_charset_id integer := case when p_file_encoding is null then dbms_lob.DEFAULT_CSID
                                     else nls_charset_id(p_file_encoding)
                                end;
        l_language_context integer := dbms_lob.DEFAULT_LANG_CTX;
        l_warning varchar2(32767 byte);
    begin
        if (l_charset_id is null) then
            raise_application_error(-20000, 'Кодова сторінка ' || p_file_encoding || ' не знайдена');
        end if;

        if (p_file is null) then
            raise_application_error(-20000, 'Відсутні дані для збереження у файл');
        end if;

        dbms_lob.createtemporary(l_file_body, false);
        dbms_lob.convertToBlob(l_file_body,
                               p_file,
                               dbms_lob.LOBMAXSIZE,
                               l_dest_offset,
                               l_src_offset,
                               l_charset_id,
                               l_language_context,
                               l_warning);

        put_file_body(l_file_body, p_file_path, p_overwrite);
    end;

    procedure append_file_body(
        p_file in blob,
        p_file_path in varchar2,
        p_overwrite in integer default 1)
    is
    begin
        raise_application_error(-20000, 'Not implemented for now - implementation is coming soon. Please be patient...');
    end;

    procedure append_file_text(
        p_file in clob,

        p_file_path in varchar2,
        p_overwrite in integer default 1)
    is
    begin
        raise_application_error(-20000, 'Not implemented for now - implementation is coming soon. Please be patient...');
    end;

    procedure remove_file(
        p_file_path in varchar2)
    is
        l_url varchar2(32767 byte);
        l_wallet_path varchar2(32767 byte);
        l_wallet_pass varchar2(32767 byte);
        l_login varchar2(32767 byte);
        l_password varchar2(32767 byte);
        l_response wsm_mgr.t_response;
        l_xml xmltype;
        l_response_code varchar2(32767 byte);
        l_response_message varchar2(32767 byte);
    begin
        bars_audit.log_info('ext_file_mgr.remove_file',
                            'p_file_path        : ' || p_file_path);

        l_url         := branch_attribute_utl.get_value('/', 'LINK_FOR_ABSBARS_SOAPWEBSERVICES') || g_service_name;
        -- l_url         := 'http://10.10.10.79:90/barsroot/webservices/' || g_service_name;
        l_wallet_path := branch_attribute_utl.get_value('/', 'PATH_FOR_ABSBARS_WALLET');
        l_wallet_pass := branch_attribute_utl.get_value('/', 'PASS_FOR_ABSBARS_WALLET');

        l_login       := branch_attribute_utl.get_value('/', 'TMS_LOGIN');
        l_password    := branch_attribute_utl.get_value('/', 'TMS_PASS');

        wsm_mgr.prepare_request(p_url             => l_url,
                                p_action          => null,
                                p_http_method     => bars.wsm_mgr.g_http_post,
                                p_wallet_path     => l_wallet_path,
                                p_wallet_pwd      => l_wallet_pass,
                                p_content_type    => wsm_mgr.g_ct_xml,
                                p_content_charset => wsm_mgr.g_cc_utf8,
                                p_namespace       => g_service_namespace,
                                p_soap_method     => 'RemoveFile');

        wsm_mgr.add_header(p_name => 'UserName', p_value => l_login);
        wsm_mgr.add_header(p_name => 'Password', p_value => l_password);

        wsm_mgr.add_parameter(p_name => 'FilePath', p_value => p_file_path);

        bars.wsm_mgr.execute_soap(l_response);

        --l_xml := l_response.xdoc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
		l_xml := xmltype(l_response.cdoc).extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
         
		
        l_response_code := l_xml.extract('/RemoveFileResponse/RemoveFileResult/ResponseCode/text()').GetStringVal();

        if (upper(l_response_code) = 'SUCCESS') then
            return;
        elsif (upper(l_response_code) = 'ERROR') then
            l_response_message := l_xml.extract('/RemoveFileResponse/RemoveFileResult/ResponseMessage/text()').GetStringVal();

            if (l_response_message is null) then
                raise_application_error(-20000, 'Помилка отримання файлів по шляху: ' || p_file_path);
            else
                raise_application_error(-20000, l_response_message);
            end if;
        else
            raise_application_error(-20000, 'Неочікуваний код відповіді {' || l_response_code ||
                                            '} при отриманні файлів по шляху: ' || p_file_path);
        end if;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  EXT_FILE_MGR ***
grant EXECUTE                                                                on EXT_FILE_MGR    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ext_file_mgr.sql =========*** End **
 PROMPT ===================================================================================== 
 