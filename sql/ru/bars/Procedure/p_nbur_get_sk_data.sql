CREATE OR REPLACE procedure BARS.p_nbur_get_sk_data(p_ReportDateFrom in date, p_ReportDateTo in date, p_kf in varchar2)
is
  title            VARCHAR2(100) := 'P_NBUR_GET_SK_DATA.';

  l_request        soap_rpc.t_request;
  l_response       soap_rpc.t_response;
  l_url            varchar2(4000);
  l_xml_resp       xmltype;
  l_errtxt         clob;
  l_params         varchar2(4000);

  l_clob           clob;

  function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
      l_res web_barsconfig.val%type;
  begin
      select val into l_res from web_barsconfig where key = par;
      return trim(l_res);
  exception
      when no_data_found then
        raise_application_error(-20000, 'Не найден KEY=' || par || ' в таблице web_barsconfig!');
  end;
begin
  begin
      select substr(val, 1, instr(val, '/', 1, 4)-1) || '/webservices/QuickMoneyService.asmx' into l_url from web_barsconfig  where key = 'QuickMoney.Url';
  exception when no_data_found then
      raise_application_error(-20000, 'Параметр REPORT_SERVER_URL не задано');
  end;

--  l_url:= replace(l_url, 'https', 'http');

--  l_url:= 'http://10.10.10.35:1212/barsroot/webservices/QuickMoneyService.asmx'; --jeka потом убрать

  logger.info(title||'profix_service: begin call service ' || l_url || ' with method [ Te9xreport ]');

  --подготовить реквест
  l_request := soap_rpc.new_request(p_url         => l_url,
                                    p_namespace   => 'http://ws.unity-bars.com.ua/',
                                    p_method      => 'TransactionShortReport',
                                    p_wallet_dir  => get_param_webconfig('VAL.Wallet_dir'),
                                    p_wallet_pass => get_param_webconfig('VAL.Wallet_pass'));

  l_params:='<' || 'DATEFROM' || '>'||to_char(p_ReportDateFrom, 'DD.MM.YYYY')||'</' || 'DATEFROM' || '>';

  l_params:=l_params||'<' || 'REPORTDATE' || '>'||to_char(p_ReportDateTo, 'DD.MM.YYYY')||'</' || 'REPORTDATE' || '>';

  soap_rpc.add_parameter(l_request, 'Parameters', l_params);
  soap_rpc.add_parameter(l_request, 'ServiceMethod', '1');

  -- позвать метод веб-сервиса
  l_response := soap_rpc.invoke(l_request);

  --Фикс неприятности в работе xpath при указанных xmlns
  l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
  l_clob := l_response.doc.getClobVal();

  begin
    l_xml_resp := xmltype(l_clob);
    select l_xml_resp.extract('//TransactionShortReportResult/text()','xmlns="http://ws.unity-bars.com.ua/"').getstringval
      into l_errtxt
      from dual;
  exception
    when others then null;
  end;

  l_clob := dbms_xmlgen.convert(l_clob, 1);

  delete from NBUR_TMP_E9_CLOB where report_date = p_ReportDateTo and kf = p_kf;

  insert into NBUR_TMP_E9_CLOB(report_date, kf, xml_file)
  values (p_ReportDateTo, p_kf, l_clob);
  
  if instr(l_errtxt,'Exception') >0 then
     raise_application_error(-20100, l_errtxt);
  end if;

end;
/