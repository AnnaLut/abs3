

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PROFIX_SERVICE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PROFIX_SERVICE ***

  CREATE OR REPLACE PROCEDURE BARS.PROFIX_SERVICE (p_ref in number, p_transaction_id in varchar2, p_method in varchar2)
is
    l_request        soap_rpc.t_request;
    l_response       soap_rpc.t_response;
    l_tmp            xmltype;
    l_message        varchar2(4000);
    l_url            varchar2(4000);
    l_clob           clob;
    ret_             clob;
    l_status         varchar2(200);
    l_transfer_id    varchar2(200);
    l_transfer_state varchar2(200);
    l_transfer_num   varchar2(200);
    l_transfer_date  varchar2(200);
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
        select substr(val, 1, instr(val, '/', 1, 4)-1) || '/webservices/ProfixService.asmx' into l_url from params where par = 'REPORT_SERVER_URL';
    exception when no_data_found then
        raise_application_error(-20000, 'Параметр REPORT_SERVER_URL не задано');
    end;

    -- todo remove
    --l_url := 'http://10.10.10.97/barsroot/webservices/ProfixService.asmx';

    logger.info('profix_service:: begin call service ' || l_url || ' with method [' || p_method || '], ref => [' || p_ref || '] transaction_id =>[' || p_transaction_id || ']');
    --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => l_url,
                                      p_namespace   => 'http://ws.unity-bars.com.ua/',
                                      p_method      => 'CallConfirm',
                                      p_wallet_dir  => get_param_webconfig('VAL.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('VAL.Wallet_pass'));

    -- добавить параметры
    soap_rpc.add_parameter(l_request, 'Method', p_method);
    soap_rpc.add_parameter(l_request, 'SystemId', 'gk');
    soap_rpc.add_parameter(l_request, 'TransferId', p_transaction_id);
    soap_rpc.add_parameter(l_request, 'Bankdate', to_char(bankdate_g, 'DD.MM.YYYY'));

    -- позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);

    --Фикс неприятности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);
    -- проверка статуса
    l_status:= l_tmp.extract('/CallConfirmResponse/CallConfirmResult/Status/text()').getStringVal();
    if l_status = '0' then
        if (l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferId/text()') is not null) then
            l_transfer_id := l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferId/text()').getStringVal();
        end if;
        if (l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferState/text()') is not null) then
            l_transfer_state := l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferState/text()').getStringVal();
        end if;
        if (l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferNumber/text()') is not null) then
            l_transfer_num:= l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferNumber/text()').getStringVal();
        end if;
        if (l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferDate/text()') is not null) then
            l_transfer_date := l_tmp.extract('/CallConfirmResponse/CallConfirmResult/TransferDate/text()').getStringVal();
        end if;
        logger.info('profix_service:: response service TransferId=>' || l_transfer_id || ', TransferState=>' || l_transfer_state || ', TransferNumber=>' || l_transfer_num || ', TransferDate=>' || l_transfer_date);
    else
        l_clob := l_tmp.extract('/CallConfirmResponse/CallConfirmResult/ErrMessage/text()').getStringVal();
        logger.error('profix_service:: response error=' || l_clob);
        if get_param_webconfig('Profix.BlockOnError') = '1' then
            raise_application_error(-20000, 'Помилка у виклику сервісу Profix. Детальніше [ ' || l_clob || ']');
        end if;
    end if;
end profix_service;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PROFIX_SERVICE.sql =========*** En
PROMPT ===================================================================================== 
