

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LOAD_RATES_FROM_NBU.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LOAD_RATES_FROM_NBU ***

  CREATE OR REPLACE PROCEDURE BARS.P_LOAD_RATES_FROM_NBU is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_clob     clob;
    l_result   clob;
      --
    l_parser       dbms_xmlparser.parser;
    l_doc          dbms_xmldom.domdocument;
    l_analyticlist dbms_xmldom.DOMNodeList;
    l_analytic     dbms_xmldom.DOMNode;
    --
    l_date varchar2(10);
    l_kv number;
    l_rate number;
    l_bsum number;

  function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
    l_res web_barsconfig.val%type;
  begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
  exception
    when no_data_found then
      raise_application_error(-20000,
                              'Не найден KEY=' || par ||
                              ' в таблице web_barsconfig!');
  end;

  function extract(p_xml       in xmltype,
                   p_xpath     in varchar2,
                   p_mandatory in number) return varchar2 is
  begin
    begin
      return p_xml.extract(p_xpath).getStringVal();
    exception
      when others then
        if p_mandatory is null or false then
          return null;
        else
          if sqlcode = -30625 then
            bars_error.raise_nerror('BCK',
                                    'XMLTAG_NOT_FOUND',
                                    p_xpath,
                                    -1,
                                    -1);
          else
            raise;
          end if;
        end if;
    end;
  end;



begin
     --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => get_param_webconfig('Rates.url'),
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'Get',
                                      p_wallet_dir  => get_param_webconfig('Rates.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('Rates.Wallet_pass'));
    -- позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);


     --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_clob:=replace(l_clob, '&lt;', '<');
    l_clob:=replace(l_clob, '&gt;', '>');
    l_clob:=replace(l_clob, '&quot;', '');
    l_clob:=replace(l_clob, 'рі', '__');
    l_clob:=replace(l_clob,'<?xml version=1.0 encoding=UTF-8?>','');



    l_tmp  := xmltype(l_clob);

    -- Получили готовый текст
    l_result:=extract(l_tmp, '/GetResponse/GetResult/node()', null);


    -- Дальше танцы с бубном по разбору

     l_parser := dbms_xmlparser.newparser;

    dbms_xmlparser.parseclob(l_parser, l_result);

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'currency');

   begin

    for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1

    loop

     l_analytic := dbms_xmldom.item(l_analyticlist, i);

     dbms_xslprocessor.valueof(l_analytic, 'exchangedate/text()', l_date      );
     dbms_xslprocessor.valueof(l_analytic, 'r030/text()', l_kv   );
     dbms_xslprocessor.valueof(l_analytic, 'rate/text()', l_rate);

     begin
       select t.nominal
       into l_bsum from tabval t
       where t.kv=l_kv;
     exception when no_data_found then l_bsum:=1;
     end;

     begin
     p_rates(p_sdat   => to_char(to_date(l_date, 'dd.mm.yyyy'),'dd/mm/yyyy'),
             p_kv     => l_kv,
             p_bsum   => l_bsum,
             p_rate_o => l_rate*l_bsum);

     exception when others then 
                if  sqlcode = 1 then 
                     bars_audit.info('Офіційний курс валют за '||to_char(to_date(l_date, 'dd.mm.yyyy'),'dd/mm/yyyy')||' вже було завантажено!');
                elsif sqlcode = -02291 then -- integrity constraint (BARS.FK_CURRATES$BASE_TABVAL) violated - parent key not found
                       null;
                end if;
         end;
    end loop;

    end;

end p_load_rates_from_nbu;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LOAD_RATES_FROM_NBU.sql ========
PROMPT ===================================================================================== 
