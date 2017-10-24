
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bck_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BCK_UTL is

  -- Author  : OLEG
  -- Created : 23.12.2008 11:52:28
  -- Purpose : Пакет процедур для получения отчетов из кредитного бюро

  g_header_version constant varchar2(64) := 'version 1.04 03/02/2015';

  ----
  -- Возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- Возвращает версию тела пакета
  --
  function body_version return varchar2;

  ----
  -- процедура получения отчета
  --
  function get_report(p_bck_id   in wcs_bck.bck_id%type,
                      p_rep_type in wcs_bck_reports.rep_type%type,
                      p_okpo     in customer.okpo%type,
                      p_pserial  in varchar2,
                      p_pnumber  in varchar2) return number;

  ----
  -- Процедура разбора отчета
  --
  procedure process_report(p_rep_id in wcs_bck_reports.rep_id%type);

  ----
  -- проверка паспорта по базе утерянных паспортов
  --
  procedure get_pvbki_passp(p_ser         in varchar2,
                            p_num         in varchar2,
                            p_okpo        in varchar2,
                            p_f           in varchar2,
                            p_i           in varchar2,
                            p_o           in varchar2,
                            p_birth       in date,
                            p_passp_state out varchar2,
                            p_request_id  out number,
                            p_rescode     out varchar2,
                            p_resmsg      out varchar2);

end bck_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.BCK_UTL is

  G_BODY_VERSION constant varchar2(64) := 'version 1.04 03/02/2015';
  G_ERRMOD       constant varchar2(3) := 'BCK';

  G_WSPROXY_URL_TAG          constant varchar2(12) := 'PROXY_WS_URL';
  G_WSPROXY_NS_TAG           constant varchar2(12) := 'PROXY_WS_NS';
  G_WALLET_DIR               constant varchar2(100) := 'WALLET_DIR';
  G_WALLET_PASS              constant varchar2(100) := 'WALLET_PASS';

  G_OFFLINE_DAYS_TAG         constant varchar2(12) := 'OFFLINE_DAYS';
  G_RES_OK                   constant number := 0;
  G_RES_ERR                  constant number := -1;
  G_RES_OK_MSG               constant varchar2(2) := 'OK';
  G_GETREPORT_IDENT_PARAM    constant varchar2(5) := 'TaxId';
  G_GETREPORT_USERNAME_PARAM constant varchar2(12) := 'Username';
  G_GETREPORT_PASSWORD_PARAM constant varchar2(12) := 'Password';
  G_GETREPORT_URL_PARAM      constant varchar2(10) := 'ServiceUrl';
  G_GETREPORT_PSERIAL_PARAM  constant varchar2(10) := 'PSerial';
  G_GETREPORT_PNUMBER_PARAM  constant varchar2(10) := 'PNumber';
  G_GETREPORT_REPTYPE_PARAM  constant varchar2(10) := 'ReportType';

  g_cur_rep_id   number := -1;
  g_cur_block_id number := -1;
  g_is_error     boolean := false;

  ----
  -- Возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'package header bck_utl ' || g_header_version;
  end header_version;

  ----
  -- Возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'package body bck_utl ' || g_body_version;
  end body_version;

  ----
  -- получает значение параметра по его имени
  --
  function get_param_value(p_param_name in wcs_bck_params.param_name%type)
    return varchar2 is
    l_res wcs_bck_params.param_value%type;
  begin
    select param_value
      into l_res
      from wcs_bck_params
     where param_name = p_param_name;
    return trim(l_res);
  exception
    when no_data_found then
      bars_error.raise_nerror(g_errmod, 'PARAM_NOTFOUND', p_param_name);
  end;

  ----
  -- процедура получения отчета
  --
  function get_report(p_bck_id   in wcs_bck.bck_id%type,
                      p_rep_type in wcs_bck_reports.rep_type%type,
                      p_okpo     in customer.okpo%type,
                      p_pserial  in varchar2,
                      p_pnumber  in varchar2) return number is
    l_request      soap_rpc.t_request;
    l_response     soap_rpc.t_response;
    l_rescode      wcs_bck_reports.res_code%type;
    l_resmsg       wcs_bck_reports.res_message%type;
    l_rep_date     date;
    l_rep_id       number;
    l_res          number;
    l_method       wcs_bck.service_method%type;
    l_offline_days number;
    l_walletdir    varchar2(100);
    l_walletpass    varchar2(100);
  begin

    -- сколько дней отчет считается актуальным
    l_offline_days := get_param_value(G_OFFLINE_DAYS_TAG);
    -- обработка l_offline_days
    begin
      --найди дату и идентификатор последнего полученного отчета для этого ОКПО
      select rep_id, rep_date
        into l_rep_id, l_rep_date
        from wcs_bck_reports
       where bck_id = p_bck_id
         and okpo = p_okpo
         and rep_type = p_rep_type
         and res_code = 0
         and rep_date =
             (select max(rep_date) from wcs_bck_reports where okpo = p_okpo);
      --если последний раз получали меньше чем через l_offline_days выходим
      if sysdate - l_rep_date <= l_offline_days then
        return l_rep_id;
      end if;
    exception
      when no_data_found then
        null;
    end;

    -- получить URL веб-сервиса
    begin
      select service_method
        into l_method
        from wcs_bck
       where bck_id = p_bck_id;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_errmod, 'BCK_NOTFOUND', p_bck_id);
    end;

    -- вызов метода прокси-сервиса
    begin
      -- wallet параметры для SSL
      select param_value into l_walletdir from wcs_bck_params where param_name = G_WALLET_DIR;
      select param_value into l_walletpass from wcs_bck_params where param_name = G_WALLET_PASS;

      -- подготовить реквест
      l_request := soap_rpc.new_request(p_url       => get_param_value(G_WSPROXY_URL_TAG),
                                        p_namespace => get_param_value(G_WSPROXY_NS_TAG),
                                        p_method    => l_method,
                                        p_wallet_dir => l_walletdir,
                                        p_wallet_pass => l_walletpass);
      -- добавить параметры
      soap_rpc.add_parameter(l_request,
                             G_GETREPORT_REPTYPE_PARAM,
                             p_rep_type);
      soap_rpc.add_parameter(l_request, G_GETREPORT_IDENT_PARAM, p_okpo);
      soap_rpc.add_parameter(l_request,
                             G_GETREPORT_PSERIAL_PARAM,
                             p_pserial);
      soap_rpc.add_parameter(l_request,
                             G_GETREPORT_PNUMBER_PARAM,
                             p_pnumber);
      -- позвать метод веб-сервиса
      l_response := soap_rpc.invoke(l_request);
      -- ок
      l_rescode := G_RES_OK;
      l_resmsg  := G_RES_OK_MSG;
    exception
      when others then
        l_rescode := sqlcode;
        l_resmsg  := sqlerrm;
    end;
    -- сохранение результата
    select s_wcs_bck_reports.nextval into l_res from dual;
    begin
      insert into wcs_bck_reports
        (rep_id,
         bck_id,
         rep_type,
         rep_date,
         rep_user,
         res_code,
         res_message,
         okpo,
         report)
      values
        (l_res,
         p_bck_id,
         p_rep_type,
         sysdate,
         user_id,
         l_rescode,
         substr(l_resmsg, 1, 512),
         p_okpo,
         l_response.doc.getClobVal());
    exception
      when others then
        bars_error.raise_nerror(g_errmod, 'ERROR_STORE_REPORT', sqlerrm);
    end;
    return l_res;
  end;

  ----
  -- культурно получает значение XML тэга
  --
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

  function win2utf(p_str in varchar2) return raw is
  begin
    return utl_raw.cast_to_raw(convert(p_str, 'UTF8'));
  end;

  ----
  -- проверка паспорта по базе утерянных паспортов
  --
  procedure get_pvbki_passp(p_ser         in varchar2,
                            p_num         in varchar2,
                            p_okpo        in varchar2,
                            p_f           in varchar2,
                            p_i           in varchar2,
                            p_o           in varchar2,
                            p_birth       in date,
                            p_passp_state out varchar2,
                            p_request_id  out number,
                            p_rescode     out varchar2,
                            p_resmsg      out varchar2) is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_res      number;
    l_str      varchar2(4096);
    l_pos      number;
    l_lpos     number;
    l_tmp      clob;
    l_xmlt     xmltype;
    l_walletdir varchar2(100);
    l_walletpass varchar2(100);

    -- разбивает строку по раданому разделителю
    type str_array is table of varchar2(300) index by binary_integer;
    l_my_array str_array;

    function split(str in varchar2, delim in varchar2) return str_array is
      l_str_array str_array;

      l_pos number := 1;
      l_nth number := 1;
    begin
      while (instr(str, delim, 1, l_nth) > 0) loop
        l_str_array(l_nth) := substr(str,
                                     l_pos,
                                     instr(str, delim, 1, l_nth) - l_pos);
        l_pos := instr(str, delim, 1, l_nth) + length(delim);
        l_nth := l_nth + 1;
      end loop;

      l_str_array(l_nth) := substr(str, l_pos);

      return l_str_array;
    end split;
  begin

    -- вызов метода прокси-сервиса
    begin
      -- wallet параметры для SSL
      select param_value into l_walletdir from wcs_bck_params where param_name = G_WALLET_DIR;
      select param_value into l_walletpass from wcs_bck_params where param_name = G_WALLET_PASS;

      -- подготовить реквест
      l_request := soap_rpc.new_request(p_url       => get_param_value(G_WSPROXY_URL_TAG),
                                        p_namespace => get_param_value(G_WSPROXY_NS_TAG),
                                        p_method    => 'CheckPasspPVBKI',
                                        p_wallet_dir => l_walletdir,
                                        p_wallet_pass => l_walletpass);

      -- добавить параметры
      soap_rpc.add_parameter(l_request, 'Ser', to_char(win2utf(p_ser)));
      soap_rpc.add_parameter(l_request, 'Num', to_char(win2utf(p_num)));
      soap_rpc.add_parameter(l_request, 'Okpo', to_char(win2utf(p_okpo)));
      soap_rpc.add_parameter(l_request, 'F', to_char(win2utf(p_f)));
      soap_rpc.add_parameter(l_request, 'I', to_char(win2utf(p_i)));
      soap_rpc.add_parameter(l_request, 'O', to_char(win2utf(p_o)));
      soap_rpc.add_parameter(l_request,
                             'BirthDate',
                             to_char(p_birth, 'dd.mm.yyyy'));

      -- позвать метод веб-сервиса
      l_response := soap_rpc.invoke(l_request);

      -- Фикс неприятности в работе xpath при указанных xmlns
      l_tmp  := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
      l_xmlt := xmltype(l_tmp);

      l_str := extract(l_xmlt,
                       '/CheckPasspPVBKIResponse/CheckPasspPVBKIResult/text()',
                       null);

      -- Пример: 123456~~00~~OK~~Success! Response is 0
      l_my_array := split(l_str, '~~');

      p_request_id  := to_number(l_my_array(1));
      p_rescode     := l_my_array(2);
      p_passp_state := l_my_array(3);
      p_resmsg      := dbms_xmlgen.convert(l_my_array(4), 1);

    exception
      when others then
        p_request_id  := null;
        p_rescode     := sqlcode;
        p_resmsg      := sqlerrm;
        p_passp_state := 'UNKNOWN';
    end;

    -- сохранение результата
    select s_wcs_bck_reports.nextval into l_res from dual;
    begin
      insert into wcs_bck_reports
        (rep_id,
         bck_id,
         rep_type,
         rep_date,
         rep_user,
         res_code,
         res_message,
         okpo,
         report)
      values
        (l_res,
         2,
         'PSP',
         sysdate,
         user_id,
         decode(p_rescode, 'FF', -1, '00', 0, to_number(p_rescode)),
         substr(p_resmsg, 1, 512),
         nvl(p_okpo, 'не указан'),
         l_response.doc.getClobVal());
    exception
      when others then
        bars_error.raise_nerror(g_errmod, 'ERROR_STORE_REPORT', sqlerrm);
    end;
  end;

  ----
  -- разбирает блок XML и сохраняет результат в таблицу
  --
  procedure process_block(p_xml      in xmltype,
                          p_xpath    in varchar2,
                          p_block_id in number,
                          p_rep_id   in number) is
    l_tag_value varchar2(512);
    l_tag_name  varchar2(512);
    i           integer := 0;
    l_xpath     varchar2(256);
    l_block_tag varchar2(128);
  begin
    select block_tag
      into l_block_tag
      from wcs_bck_xmlblocks
     where block_id = p_block_id;
    loop
      -- счтетчик элементов последовательности
      i := i + 1;
      -- выйти из цикла при окончании последовательноси
      l_xpath := p_xpath || l_block_tag || '[' || i || ']';
      if p_xml.existsnode(l_xpath) = 0 then
        exit;
      end if;
      -- получить значения каждого тэга
      for q in (select t.tag_name, t.tag_block, t.tag_mandatory
                  from wcs_bck_tags t
                 where t.tag_block = p_block_id) loop
        l_tag_name  := l_xpath || '/@' || q.tag_name;
        l_tag_value := extract(p_xml, l_tag_name, q.tag_mandatory);
        -- признак ошибки
        if lower(q.tag_name) = 'errcode' then
          g_is_error := lower(l_tag_value) != 'null';
        end if;
        -- вставка результатов в таблицу
        if (l_tag_value is null) then
          null;
        else
          begin
            insert into wcs_bck_results
              (id, rep_id, tag_name, tag_block, tag_value, seq_id)
            values
              (s_wcs_bck_results.nextval,
               p_rep_id,
               q.tag_name,
               q.tag_block,
               substr(l_tag_value, 1, 512),
               i);
          exception
            when dup_val_on_index then
              bars_error.raise_nerror(g_errmod,
                                      'REPORT_ALREADY_PARSED',
                                      to_char(p_rep_id));
            when others then
              bars_error.raise_nerror(g_errmod,
                                      'RESULT_STORE_ERROR',
                                      to_char(p_rep_id),
                                      to_char(p_block_id),
                                      l_tag_name);
          end;
        end if;
      end loop;
    end loop;
  end;

  ----
  -- процедура обрабатывает полученный отчет
  --
  procedure process_report(p_rep_id in wcs_bck_reports.rep_id%type) is
    l_key         number;
    l_report_type wcs_bck_reports.rep_type%type;
    l_report      clob;
    l_xml         xmltype;
    l_xpath       varchar2(1024);
    i             number := 0;
  begin
    -- получить текст отчета
    begin
      select rep_type, report
        into l_report_type, l_report
        from wcs_bck_reports
       where rep_id = p_rep_id;
    exception
      when no_data_found then
        bars_error.raise_nerror(g_errmod,
                                'REPORT_NOT_FOUND',
                                to_char(p_rep_id));
    end;
    -- глобальная переменная текущего отчета
    g_cur_rep_id := p_rep_id;
    -- Фикс неприятности в работе xpath при указанных xmlns
    l_report := replace(l_report, 'xmlns', 'mlns');
    -- преобразовать отчет в xmltype
    l_xml := xmltype(l_report);
    loop
      -- счтетчик элементов последовательности
      i := i + 1;
      -- xpath выражение для поиска
      l_xpath := '/GetReportResponse/GetReportResult/doc/r[' || i || ']';
      -- выйти из цикла при окончании последовательноси
      if l_xml.existsnode(l_xpath) = 0 then
        exit;
      end if;
      --
      -- Вот такие мега-блоки могут быть в нашем иксемеле
      --
      -- key=”0”  Служебный блок  <errcode> <errtext>
      -- key=”1”  История запросов по клиенту <ZINTHIS>
      -- key=”2”  Информация по кредитным сделкам <DEAL>
      -- key=”3”  Кредитный балл <BL_LST>
      -- key=”4”  Заинтересованность клиентом <ZINT>
      -- key=”5”  Информация о субъекте кредитной истории <LST>
      -- key=”6”  История жизни кредитных сделок <CL_DEAL>
      -- key=”7”  Список утерянных паспортов <BLDOC_LST>
      --
      -- текущий блок
      l_key := to_number(l_xml.extract(l_xpath || '/@key').getStringVal());
      -- глобальная переменная текущего XML-блока
      g_cur_block_id := l_key;
      -- обработка только известных блоков
      if l_key in (0, 1, 2, 3, 4, 5, 6, 7) then
        process_block(l_xml, l_xpath, l_key, p_rep_id);
      else
        bars_error.raise_nerror(g_errmod,
                                'XMLBLOCK_NOT_FOUND',
                                to_char(l_key));
      end if;

    end loop;

  end;

end bck_utl;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bck_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 