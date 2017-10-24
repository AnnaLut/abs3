

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MAKE_REPORT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MAKE_REPORT ***

  CREATE OR REPLACE PROCEDURE BARS.MAKE_REPORT (p_kodz    varchar2,
                                        p_encode  varchar2,
                                        p_reptype number) is
l_authorization varchar2(4000);
  l_login         varchar2(400);
  l_password      varchar2(400);
  l_wallet_path varchar2(4000);
  l_wallet_pass   varchar2(4000);
  l_request       clob;
  l_url           varchar2(4000);
  l_response      wsm_mgr.t_response;

begin

  l_request := '{ "kodz": "'||p_kodz||'",  "encode": "'||p_encode||'" }';
  dbms_output.put_line(l_request);
  l_url := getglobaloption('TMS_REP_URL');
  --l_url         := 'http://10.1.81.80/barsroot/api/FormReport/FormReportBlob';

  l_wallet_path := getglobaloption('TMS_WALLET_PATH');
  l_wallet_pass := getglobaloption('TMS_WALLET_PASS');
  l_login       := nvl(getglobaloption('TMS_LOGIN'),'absadm01');
  l_password    := nvl(getglobaloption('TMS_PASS'), 'qwerty');
  if (l_login is not null) then
    l_authorization := 'Basic ' ||
                       utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(l_login || ':' ||
                                                                                             l_password)));
  end if;

  bars.wsm_mgr.prepare_request(p_url          => l_url,
                               p_action       => null,
                               p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                               p_wallet_path  => l_wallet_path,
                               p_wallet_pwd   => l_wallet_pass,
                               p_body         => l_request);

  if (l_authorization is not null) then
    bars.wsm_mgr.add_header(p_name  => 'Authorization',
                            p_value => l_authorization);
  end if;
  wsm_mgr.add_header(p_name  => 'Content-Type',
                     p_value => 'application/json; charset=utf-8');
  bars.wsm_mgr .execute_api(l_response);

  if l_response.cdoc <> empty_clob() then
    RAISE_APPLICATION_ERROR(-20000, l_response.cdoc);
  end if;
end;
/
show err;

PROMPT *** Create  grants  MAKE_REPORT ***
grant EXECUTE                                                                on MAKE_REPORT     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MAKE_REPORT.sql =========*** End *
PROMPT ===================================================================================== 
