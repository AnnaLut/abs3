create or replace package tms_webservices is

    -- Author  : VITALII.KHOMIDA
    -- Created : 30.01.2017 8:10:56
    -- Purpose :

    procedure run_soap(p_service_name IN VARCHAR2, p_method in varchar2, p_namespace in varchar2, p_branch in varchar2 default null);
    procedure load_nbu_cert;
    procedure run_soap_test(p_service_name IN VARCHAR2, p_method in varchar2, p_namespace in varchar2, p_branch in varchar2 default null, p_direct_path varchar2 default null) ;

    procedure load_insiders;
end tms_webservices;
/
create or replace package body tms_webservices is

  FUNCTION get_data_from_xml(p_dataxml xmltype, p_param varchar2)
  RETURN varchar2
  IS
    l_str   varchar2(254);
    l_value varchar2(254);
  BEGIN

    l_str :=  '/doc/'||trim(p_param)||'/text()';

    IF (p_dataxml.extract(l_str) IS NOT NULL) THEN
      l_value := p_dataxml.extract(l_str).getStringVal();
    ELSE
      l_value := NULL;
    END IF;

    RETURN l_value;

  END get_data_from_xml;


  procedure run_soap(p_service_name IN VARCHAR2, p_method in varchar2, p_namespace in varchar2, p_branch in varchar2 default null) is
    l_wallet_path   varchar2(4000);
    l_wallet_pass   varchar2(4000);
    l_request       clob;
    l_url           varchar2(4000);
    l_response      wsm_mgr.t_response;
    l_login varchar2(4000);
    l_password varchar2(4000);
    l_status_xml    xmltype;
    l_status        varchar2(32767 byte);
    l_message       varchar2(32767 byte);
    l_response_xml  xmltype;
    l_response_msg  varchar2(2000);
  begin
       bars_audit.info('tms_webservices.run_soap start to exec :'||p_service_name);

      l_url         := branch_attribute_utl.get_value('/', 'LINK_FOR_ABSBARS_SOAPWEBSERVICES')||p_service_name;
      l_wallet_path := branch_attribute_utl.get_value('TMS_WALLET_PATH');
      l_wallet_pass := branch_attribute_utl.get_value('TMS_WALLET_PASS');

      l_login       := branch_attribute_utl.get_value('TMS_LOGIN');
      l_password    := branch_attribute_utl.get_value('TMS_PASS');
      wsm_mgr.prepare_request(      p_url         => l_url,
                                    p_action      => null,
                                    p_http_method => bars.wsm_mgr.g_http_post,
                                    p_wallet_path => l_wallet_path,
                                    p_wallet_pwd  => l_wallet_pass,
                                    p_content_type => wsm_mgr.g_ct_xml,
                                    p_content_charset => wsm_mgr.g_cc_win1251,
                                    p_namespace => p_namespace,
                                    p_soap_method => p_method
                                  );

      wsm_mgr.add_parameter(p_name =>'UserName' , p_value =>l_login );
      wsm_mgr.add_parameter(p_name => 'Password' , p_value => l_password);

      if (p_branch is not null) then
          wsm_mgr.add_parameter(p_name => 'Branch', p_value => p_branch);
      end if;

      if (p_service_name = 'LoadCoursesService.asmx') then
          wsm_mgr.add_parameter(p_name =>'PathFrom' , p_value => branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_DIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1));
          wsm_mgr.add_parameter(p_name => 'PathTo' , p_value => branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_ARCDIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1));
      end if;


       bars_audit.log_info('tms_webservices.run_soap START:',
                          'p_service_name : ' || p_service_name || chr(10) ||
                          'p_method       : ' || p_method || chr(10) ||
                          'p_namespace    : ' || p_namespace || chr(10) ||
                          'l_url          : ' || l_url);

      -- позвать метод веб-сервиса
      bars.wsm_mgr.execute_soap(l_response);


      l_response_msg := dbms_lob.substr(l_response.cdoc, 2000, 1);
      bars_audit.log_info('tms_webservices.run_soap',
                          'p_service_name : ' || p_service_name || chr(10) ||
                          'p_method       : ' || p_method || chr(10) ||
                          'p_namespace    : ' || p_namespace || chr(10) ||
                          'l_login        : ' || l_login || chr(10) ||
                          'PathFrom       : ' || branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_DIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1) || chr(10) ||
                          'PathTo         : ' || branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_ARCDIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1) || chr(10) ||
                          'l_response     : ' || l_response_msg,
                          p_make_context_snapshot => true);

      bars_audit.info('tms_webservices.run_soap, response: '|| l_response_msg);

     if (p_service_name = 'RegInsidersService.asmx') then
         if instr(l_response_msg, '<Status>ERROR</Status>') > 0 and instr(l_response_msg, '<Message>OK</Message>') = 0 then
             raise_application_error (-20000, 'Помилка виконання: '||substr( l_response_msg, instr(l_response_msg, '<Message>')+ 9,  instr(l_response_msg,'</Message>')- instr(l_response_msg, '<Message>') - 8  ) );
         end if;
     end if;

  end;


  procedure run_soap_test(p_service_name IN VARCHAR2, p_method in varchar2, p_namespace in varchar2, p_branch in varchar2 default null, p_direct_path varchar2 default null) is
    l_wallet_path   varchar2(4000);
    l_wallet_pass   varchar2(4000);
    l_request       clob;
    l_url           varchar2(4000);
    l_response      wsm_mgr.t_response;
    l_login varchar2(4000);
    l_password varchar2(4000);
    l_status_xml    xmltype;
    l_status        varchar2(32767 byte);
    l_message       varchar2(32767 byte);
    l_response_xml  xmltype;
  begin

     if  p_direct_path is null then
        l_url         := getglobaloption('ABSBARS_WEBSERVER_PROTOCOL')||'://'||getglobaloption('ABSBARS_WEBSERVER_IP_ADRESS')||getglobaloption('PATH_FOR_ABSBARS_SOAPWEBSERVICES')||p_service_name;
      else
       l_url := p_direct_path;
      end if;

    l_wallet_path := branch_attribute_utl.get_value('TMS_WALLET_PATH');
      l_wallet_pass := branch_attribute_utl.get_value('TMS_WALLET_PASS');

      l_login       := branch_attribute_utl.get_value('TMS_LOGIN');
      l_password    := branch_attribute_utl.get_value('TMS_PASS');
      wsm_mgr.prepare_request(      p_url         => l_url,
                                    p_action      => null,
                                    p_http_method => bars.wsm_mgr.g_http_post,
                                    p_wallet_path => l_wallet_path,
                                    p_wallet_pwd  => l_wallet_pass,
                                    p_content_type => wsm_mgr.g_ct_xml,
                                    p_content_charset => wsm_mgr.g_cc_win1251,
                                    p_namespace => p_namespace,
                                    p_soap_method => p_method
                                  );

      wsm_mgr.add_parameter(p_name =>'UserName' , p_value =>l_login );
      wsm_mgr.add_parameter(p_name => 'Password' , p_value => l_password);

      if (p_branch is not null) then
          wsm_mgr.add_parameter(p_name => 'Branch', p_value => p_branch);
      end if;

      if (p_service_name = 'LoadCoursesService.asmx') then
          wsm_mgr.add_parameter(p_name =>'PathFrom' , p_value => branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_DIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1));
          wsm_mgr.add_parameter(p_name => 'PathTo' , p_value => branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_ARCDIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1));
      end if;

      -- позвать метод веб-сервиса
      bars.wsm_mgr.execute_soap(l_response);

      bars_audit.log_info('tms_webservices.run_soap',
                          'p_service_name : ' || p_service_name || chr(10) ||
                          'p_method       : ' || p_method || chr(10) ||
                          'p_namespace    : ' || p_namespace || chr(10) ||
                          'l_login        : ' || l_login || chr(10) ||
                          'PathFrom       : ' || branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_DIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1) || chr(10) ||
                          'PathTo         : ' || branch_attribute_utl.get_attribute_value(p_attribute_code => 'EXCHANGE_RATES_ARCDIR', p_branch_code => '/', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1) || chr(10) ||
                          'l_response     : ' || dbms_lob.substr(l_response.cdoc, 3000, 1),
                          p_make_context_snapshot => true);

    bars_audit.info('tms_webservices.run_soap, response: '|| dbms_lob.substr(l_response.cdoc, 3000, 1));



  end;



  procedure load_rates is
      l_wallet_path   varchar2(4000);
      l_wallet_pass   varchar2(4000);
      l_request       clob;
      l_url           varchar2(4000);
      l_response      wsm_mgr.t_response;
      l_login varchar2(4000);
      l_password varchar2(4000);
      l_status_xml    xmltype;
      l_status        varchar2(32767 byte);
      l_message       varchar2(32767 byte);
      l_response_xml  xmltype;
      l_web_usermap_row web_usermap%rowtype;
  begin
      l_url := branch_attribute_utl.get_attribute_value('/', 'ABSBARS_WEBSERVER_PROTOCOL') || '://' ||
               branch_attribute_utl.get_attribute_value('/', 'ABSBARS_WEBSERVER_IP_ADRESS') ||
               branch_attribute_utl.get_attribute_value('/', 'PATH_FOR_ABSBARS_SOAPWEBSERVICES') ||
               'LoadCoursesService.axmx';

      if (lower(l_url) like 'https%') then
          l_wallet_path := branch_attribute_utl.get_attribute_value('/', 'PATH_FOR_ABSBARS_WALLET');
          l_wallet_pass := branch_attribute_utl.get_attribute_value('/', 'PASS_FOR_ABSBARS_WALLET');
      end if;

      -- запускаємо веб-сервіс з правами користувача, який виконує процедури ВЗД (в якості пароля використовується значення, що збережене в web_usermap)
      l_login       := sys_context('bars_global', 'user_name');
      l_web_usermap_row := user_utl.read_web_user(l_login, p_raise_ndf => false);

      if (l_web_usermap_row.webuser is null) then
          raise_application_error(-20000, 'Користувачу {' || l_login || '} заборонена автентифікація через веб-сервіс, зверніться до адміністратора АБС');
      end if;

      wsm_mgr.prepare_request(p_url             => l_url,
                              p_action          => null,
                              p_http_method     => bars.wsm_mgr.g_http_post,
                              p_wallet_path     => l_wallet_path,
                              p_wallet_pwd      => l_wallet_pass,
                              p_content_type    => wsm_mgr.g_ct_xml,
                              p_content_charset => wsm_mgr.g_cc_win1251,
                              p_namespace       => 'http://ws.unity-bars.com.ua/',
                              p_soap_method     => 'LoadAllCourses');

      wsm_mgr.add_parameter(p_name => 'UserName' , p_value => l_login);
      wsm_mgr.add_parameter(p_name => 'Password' , p_value => coalesce(l_web_usermap_row.webpass, l_web_usermap_row.adminpass));
      wsm_mgr.add_parameter(p_name => 'PathFrom' , p_value => branch_attribute_utl.get_attribute_value(bars_context.current_branch_code(), 'EXCHANGE_RATES_DIR', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1));
      wsm_mgr.add_parameter(p_name => 'PathTo'   , p_value => branch_attribute_utl.get_attribute_value(bars_context.current_branch_code(), 'EXCHANGE_RATES_ARCDIR', p_check_exist => 1, p_parent_lookup => 1, p_raise_expt => 1));

      -- позвать метод веб-сервиса
      bars.wsm_mgr.execute_soap(l_response);

      bars_audit.log_info('tms_webservices.run_soap',
                          'l_response : ' || dbms_lob.substr(l_response.cdoc, 3000, 1));
/*
      if (p_service_name = 'LoadCoursesService.asmx') then
          l_response_xml := xmltype(l_response.cdoc);
          if (l_response_xml is not null) then
              l_status_xml := l_response_xml.extract('//status/text()', p_namespace);
              if (l_status_xml is not null) then
                  l_status := l_status_xml.getStringVal();
                  if (upper(l_status) <> 'OK') then
                      l_message := l_response_xml.extract('//message/text()', p_namespace).getStringVal();
                      raise_application_error(-20000, 'Статус обробки файлу курсів: ' || l_status || ' - ' || l_message);
                  end if;
              else
                  raise_application_error(-20000, 'Сервіс прийняття курсів не повернув статус обробки');
              end if;


          else
              raise_application_error(-20000, 'Сервіс прийняття курсів не повернув статус обробки');
          end if;
      end if;
*/
  end;

  procedure load_nbu_cert
  is
      l_wallet_path   varchar2(4000);
      l_wallet_pass   varchar2(4000);
      l_request       clob;
      l_url           varchar2(4000);
      l_response      wsm_mgr.t_response;
      l_login varchar2(4000);
      l_password varchar2(4000);
      l_status_xml    xmltype;
      l_status        varchar2(32767 byte);
      l_message       varchar2(32767 byte);
      l_response_xml  xmltype;
      l_web_usermap_row web_usermap%rowtype;
  begin
      l_url := branch_attribute_utl.get_attribute_value('/', 'LINK_FOR_ABSBARS_SOAPWEBSERVICES') ||
               'CertificatesService.asmx';

      if (lower(l_url) like 'https%') then
          l_wallet_path := branch_attribute_utl.get_attribute_value('/', 'PATH_FOR_ABSBARS_WALLET');
          l_wallet_pass := branch_attribute_utl.get_attribute_value('/', 'PASS_FOR_ABSBARS_WALLET');
      end if;

      wsm_mgr.prepare_request(p_url             => l_url,
                              p_action          => null,
                              p_http_method     => bars.wsm_mgr.g_http_post,
                              p_wallet_path     => l_wallet_path,
                              p_wallet_pwd      => l_wallet_pass,
                              p_content_type    => wsm_mgr.g_ct_xml,
                              p_content_charset => wsm_mgr.g_cc_win1251,
                              p_namespace       => 'http://tempuri.org/',
                              p_soap_method     => 'ProcessRsca');

      wsm_mgr.add_parameter(p_name => 'sDate', p_value => to_char(gl.bd(), 'yyyy/mm/dd') || ' 20:20:20');

      -- позвать метод веб-сервиса
      bars.wsm_mgr.execute_soap(l_response);

      bars_audit.log_info('tms_webservices.load_nbu_cert',
                          'l_response : ' || dbms_lob.substr(l_response.cdoc, 3000, 1));
  end;

    procedure accept_insiders(
        p_file_name in varchar2,
        p_file in clob,
        p_response_code out integer,
        p_response_message out varchar2)
    is
        l_clob              clob;

        l_parser            xmlparser.parser := xmlparser.newparser;
        l_doc               xmldom.domdocument;
        l_head              xmldom.domnodelist;
        l_row               xmldom.domnodelist;
        l_head_element      xmldom.domnode;
        l_row_element       xmldom.domnode;

        l_fname             varchar2(12);
        l_fdate             varchar2(12);
        l_ftime             varchar2(12);
        l_rnum              varchar2(12);
        l_file_check_sum    varchar2(254);
        l_local_check_sum   number;

        l_idcode            varchar2(12);
        l_doct              varchar2(2);
        l_docs              varchar2(10);
        l_docn              varchar2(10);
        l_insform           varchar2(12);
        l_k060              varchar2(12);

        l_dateri            date;
    begin
        bars_audit.log_info('tms_webservices.accept_insiders',
                            '',
                            p_object_id => p_file_name,
                            p_auxiliary_info => p_file,
                            p_make_context_snapshot => true);

        p_response_code := 0;
        p_response_message := null;

        if (p_file is null) then
            p_response_code := -7;
            p_response_message := 'Помилка при завантаженні файлу ' || p_file_name || ' - відсутні дані для обробки';
            return;
        end if;

        dbms_lob.createtemporary(l_clob, false);

        l_clob := replace(
                      replace(
                          replace(p_file, chr(38),
                                     chr(38) || 'amp;'),
                          chr(38) || chr(38) || 'amp;',
                          chr(38) || 'amp;'),
                      chr(38) || 'amp;amp;',
                      chr(38) || 'amp;');

        -- очистка customer_ri
        begin
            delete customer_ri;
        exception when others then
            bars_audit.error('tms_webservices.accept_insiders(-8): ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace);
            p_response_code := -8;
            p_response_message := 'Помилка -10008: при виконанні очистки таблиці реєстра інсайдерів: ' || sqlerrm;
            return;
        end;

        xmlparser.parseclob(l_parser, l_clob);

        l_doc := xmlparser.getdocument(l_parser);

        l_head := xmldom.getelementsbytagname(l_doc, 'HEAD');

        for m in 0..xmldom.getlength(l_head) - 1 loop
            l_head_element := xmldom.item(l_head, m);

            xslprocessor.valueof(l_head_element, 'FNAME/text()', l_fname);
            xslprocessor.valueof(l_head_element, 'FSIGN/text()', l_file_check_sum);
            xslprocessor.valueof(l_head_element, 'FDATE/text()', l_fdate);
            xslprocessor.valueof(l_head_element, 'FTIME/text()', l_ftime);
            xslprocessor.valueof(l_head_element, 'RNUM/text()' , l_rnum);
        end loop;

        if l_fname is null then
            p_response_code := -1;
            p_response_message := 'Помилка -10001: не заповнений тег FNAME';
            return;
        end if;

        if upper(l_fname) <> upper(p_file_name) then
            p_response_code := -5;
            p_response_message := 'Помилка -10005: значення тега FNAME не співпадає з іменем XML-файлу';
            return;
        end if;

        if l_fdate is null then
            p_response_code := -2;
            p_response_message := 'Помилка -10002: не заповнений тег FDATE';
            return;
        end if;

        if l_ftime is null then
            p_response_code := -3;
            p_response_message := 'Помилка -10003: не заповнений тег FTIME';
            return;
        end if;

        if l_file_check_sum is null then
            p_response_code := -4;
            p_response_message := 'Помилка -10004: не заповнений тег FSIGN';
            return;
        end if;

        l_local_check_sum := sumascii(l_fname) + sumascii(l_fdate) + sumascii(l_ftime) + sumascii(l_rnum);

        l_row := xmldom.getelementsbytagname(l_doc, 'RIROW');

        for i in 0..xmldom.getlength(l_row)-1 loop

            l_row_element := xmldom.item(l_row, i);
            xslprocessor.valueof(l_row_element, 'IDCODE/text()', l_idcode);

            begin
                xslprocessor.valueof(l_row_element, 'DOCT/text()', l_doct);
            exception when others then
                l_doct := null;
            end;

            begin
                xslprocessor.valueof(l_row_element, 'DOCS/text()', l_docs);
            exception when others then
                l_docs := null;
            end;

            if ascii(l_docs)=10 then
                l_docs := null;
            end if;

            begin
                xslprocessor.valueof(l_row_element, 'DOCN/text()', l_docn);
            exception when others then
                l_docn := null;
            end;

            if ascii(l_docn) = 10 then
                l_docn := null;
            end if;

            xslprocessor.valueof(l_row_element, 'INSFORM/text()', l_insform);
            xslprocessor.valueof(l_row_element, 'K060/text()', l_k060);

            if l_idcode is null then
                p_response_code := -9;
                p_response_message := 'Помилка -10009: не заповнене IDCODE - ROW = ' || to_char(i + 1);
                return;
            end if;

            if not isnumber(l_idcode) then
                p_response_code := -10;
                p_response_message := 'Помилка -10010: IDCODE не числове - ROW = ' || to_char(i + 1);
                return;
            end if;

            if l_insform is null then
                p_response_code := -11;
                p_response_message := 'Помилка -10011: не заповнене INSFORM - ROW = ' || to_char(i + 1);
                return;
            end if;

            if l_insform not in ('0','1') then
                p_response_code := -12;
                p_response_message := 'Помилка -10012: неприпустиме значення INSFORM - ROW = ' || to_char(i + 1);
                return;
            end if;

            if l_k060 is null then
                p_response_code := -13;
                p_response_message := 'Помилка -10013: не заповнене K060 - ROW = ' || to_char(i + 1);
                return;
            end if;

            if l_file_check_sum is not null then
                l_local_check_sum := l_local_check_sum + sumascii(l_idcode) + sumascii(l_doct) + sumascii(l_docs) + sumascii(l_docn) + sumascii(l_insform) + sumascii(l_k060);
            end if;

            begin
                l_dateri := to_date(substr(p_file_name, 3, 6), 'DDMMYY');
            exception when others then
                l_dateri := trunc(sysdate);
            end;

            begin
                insert into customer_ri
                values (bars_sqnc.get_nextval('s_customer_ri'),        -- id        number 
                        l_idcode,                                      -- idcode    varchar2(10)   Код за ЄДРПОУ/ДРФО
                        l_doct,                                        -- doct      number(2)      Тип документа
                        l_docs,                                        -- docs      varchar2(10)   Серія документа
                        l_docn,                                        -- docn      varchar2(10)   Номер документа
                        l_insform,                                     -- insform   number(1)      Ознака наявності анкети інсайдера (0-ні,1-так)
                        l_k060,                                        -- k060      number(2)      Код ознаки інсайдера
                        p_file_name,                                   -- fileri    varchar2(12)   файл
                        l_dateri);                                     -- dateri    date           дата файлу
            exception
                when dup_val_on_index then
                     null; -- дублирование ключа игнорируется
                when others then
                     bars_audit.error('GET_XML_RI(-16): ' || sqlerrm || ' ' || dbms_utility.format_error_backtrace);
                     p_response_code := -16;
                     p_response_message := 'Помилка -10016: при вставці в таблицю реєстра інсайдерів: ' || sqlerrm;
                     return;
            end;
        end loop;

        if l_file_check_sum != to_char(l_local_check_sum) then
            p_response_code := -15;
            p_response_message := 'Помилка -10015: невірна контрольна сума (не рівна значенню тега FSIGN)';
        end if;
    end;

    procedure build_insiders_receipt(
        p_insiders_file_name in varchar2,
        p_response_code in integer,
        p_response_message in varchar2,
        p_receipt_file_name out varchar2,
        p_receipt_body out clob)
    is
        l_receipt_date           varchar2(12);
        l_receipt_time           varchar2(12);
        l_receipt_file_check_sum varchar2(254);
        l_header                 xmltype;
        l_xml_data               xmltype;
        l_ku                     varchar2(32767 byte);
    begin
        bars_audit.log_info('tms_webservices.build_insiders_receipt',
                            'p_insiders_file_name : ' || p_insiders_file_name || chr(10) ||
                            'p_response_code      : ' || p_response_code      || chr(10) ||
                            'p_response_message   : ' || p_response_message,
                            p_make_context_snapshot => true);

        select decode(mfo, '300465', '27', substr(to_char(ku + 100), -2))
        into   l_ku
        from   rcukru
        where  mfo = bars_context.current_mfo();

        p_receipt_file_name := substr(p_insiders_file_name, 1, instr(p_insiders_file_name, '.', -1) - 1) || 'P' || l_ku ||
                               substr(p_insiders_file_name, instr(p_insiders_file_name, '.', -1));

        l_receipt_date := to_char(sysdate,'dd.mm.yyyy');
        l_receipt_time := to_char(sysdate,'hh24:mi:ss');
        l_receipt_file_check_sum := to_char(sumascii(p_receipt_file_name) + sumascii(l_ku) + sumascii(l_receipt_date) + sumascii(l_receipt_time));

        --сформировать квитанцию xml в таблицу tmp_ri_clob !!!
        select xmlelement("HEAD", xmlforest(p_receipt_file_name        "FNAME",
                                            l_receipt_file_check_sum   "FSIGN",
                                            l_ku                       "KU",
                                            l_receipt_date             "FDATE",
                                            l_receipt_time             "FTIME"))
        into   l_header
        from   dual;

        select xmlelement("DECLARATION",
                          xmlattributes('RI_P.XSD' as "xsi:noNamespaceSchemaLocation",
                                        'http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi"),
               xmlconcat(l_header,
                         xmlelement("PROCBODY",
                                    xmlconcat(xmlelement("RIFNAME"     , p_insiders_file_name),
                                              xmlelement("PROC_ERR"    , case when p_response_code = 0 then 0 else 1 end),
                                              xmlelement("PROC_COMMENT", nvl(p_response_message, 'OK')),
                                              xmlelement("PROC_INFO",
                                              xmlagg(xmlelement("CUSTOMER",
                                                     xmlelement("RNK"             , rnk             ),
                                                     xmlelement("BRANCH"          , branch          ),
                                                     xmlelement("CUSTTYPE"        , custtype        ),
                                                     xmlelement("OKPO"            , okpo            ),
                                                     xmlelement("PASSP"           , passp           ),
                                                     xmlelement("SER"             , ser             ),
                                                     xmlelement("NUMDOC"          , numdoc          ),
                                                     xmlelement("PRINSIDER"       , prinsider       ),
                                                     xmlelement("INSFO"           , insfo           ),
                                                     xmlelement("PRINSIDER_BEFORE", prinsider_before),
                                                     xmlelement("INSFO_BEFORE"    , insfo_before    ))))))))
        into   l_xml_data
        from   (select distinct * from tmp_ri_cust);

        delete tmp_ri_cust;

        dbms_lob.createtemporary(p_receipt_body,false);
        dbms_lob.append(p_receipt_body,'<?xml version="1.0" encoding="windows-1251"?>');
        dbms_lob.append(p_receipt_body, l_xml_data.getclobval());
    end;

    procedure load_insiders
    is
        l_file_clob             clob;
        l_receipt_clob          clob;
        l_receipt_file_name     varchar2(32767 byte);

        l_source_file_path      varchar2(4000 byte);
        l_archive_file_path     varchar2(4000 byte);
        l_receipt_file_path     varchar2(4000 byte);

        l_insiders_file_list    string_list;
        l_file_name             varchar2(32767 byte);

        l_response_code         integer;
        l_response_message      varchar2(32767 byte);

        i                       integer;
    begin
        bars_audit.log_info('tms_webservices.load_insiders',
                            '',
                            p_make_context_snapshot => true);

        l_response_code := 0;
        l_response_message := null;

        l_source_file_path := branch_attribute_utl.get_value('/', 'RIXML_PATH_IN');
        l_archive_file_path := branch_attribute_utl.get_value('/', 'RIXML_PATH_ARC');

        if (l_source_file_path is null) then
            raise_application_error(-20000, 'Не вказаний шлях до каталогу файлів інсайдерів');
        end if;

        l_insiders_file_list := ext_file_mgr.list_files(l_source_file_path, p_include_subfolders => 1, p_file_mask => 'ri*.xml');

        if (l_insiders_file_list is not null and l_insiders_file_list is not empty) then

            i := l_insiders_file_list.first;
            while (i is not null) loop
                l_file_clob := ext_file_mgr.get_file_text(l_insiders_file_list(i));

                l_file_name := substr(l_insiders_file_list(i), instr(l_insiders_file_list(i), '\', -1) + 1);

                accept_insiders(l_file_name, l_file_clob, l_response_code, l_response_message);

                for j in (select kf from mv_kf) loop
                    bars_context.go(j.kf);

                    l_receipt_file_path := branch_attribute_utl.get_value('RIXML_PATH_OUT');

                    if (l_receipt_file_path is null) then
                        raise_application_error(-20000, 'Не вказаний шлях до каталогу квитанцій обробки файлів інсайдерів');
                    end if;

                    -- основна обробка всіх клієнтів AБС
                    if l_response_code = 0 then
                        begin
                            get_ri;
                        exception when others then
                            bars_audit.error('GET_XML_RI: ' || sqlerrm || ' ' || dbms_utility.format_error_backtrace);
                            l_response_code := -17;
                            l_response_message := 'Помилка ' || to_char(l_response_code) ||
                                     ' при виконанні GET_RI (занесення даних по інсайдерам)';
                        end;
                    end if;

                    build_insiders_receipt(l_file_name, l_response_code, l_response_message, l_receipt_file_name, l_receipt_clob);

                    if (l_receipt_file_path not like '%\') then
                        l_receipt_file_path := l_receipt_file_path || '\';
                    end if;

                    ext_file_mgr.put_file_text(l_receipt_clob, l_receipt_file_path || l_receipt_file_name, p_overwrite => 1);
                end loop;


                if (l_archive_file_path is not null) then
                    if (l_archive_file_path not like '%\') then
                        l_archive_file_path := l_archive_file_path || '\';
                    end if;

                    ext_file_mgr.put_file_text(l_file_clob, l_archive_file_path || l_file_name, p_overwrite => 1);
                end if;

                ext_file_mgr.remove_file(l_insiders_file_list(i));

                i := l_insiders_file_list.next(i);
            end loop;
        else
            bars_audit.log_warning('tms_webservices.load_insiders', 'Не знайдено жодного файлу з реєстром інсайдерів для каталогу: ' || l_source_file_path, p_make_context_snapshot => true);
        end if;
    end;
end tms_webservices;
/
 show err;
