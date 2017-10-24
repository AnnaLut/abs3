

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FORM_KFILE_BLOB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FORM_KFILE_BLOB ***

  CREATE OR REPLACE PROCEDURE BARS.FORM_KFILE_BLOB (
                                       p_kodz            number,
                                       p_encode          varchar2,
                                       p_reptype         number,
                                       p_date            date)
   is
   l_sqltxt varchar(3000);
   l_sqltxt_fname varchar(3000);
   l_sqltxt_ready varchar(3000);
   l_sqltxt_fname_ready varchar(3000);
   l_kodz   integer;
   l_trace    varchar2(1000) :=  'form_kfile_blob: ';
 begin
   select z.form_proc,
          z.namef
     into l_sqltxt,
          l_sqltxt_fname
     from zapros z
    where z.kodz = p_kodz;
   l_sqltxt       :=  replace(l_sqltxt, ':sFdat1', 'to_char(gl.bd,''dd/mm/yyyy'') ');
   l_sqltxt_fname :=  replace(l_sqltxt_fname, ':sFdat1', 'to_char(gl.bd,''dd/mm/yyyy'') ');
   for c0 in (select kc.kod_cli from kod_cli kc) loop
     l_sqltxt_ready := replace(l_sqltxt, ':KODK', c0.kod_cli);
     l_sqltxt_fname_ready := replace(l_sqltxt_fname, ':KODK', c0.kod_cli);
     declare
        l_authorization varchar2(4000);
        l_login         varchar2(400);
        l_password      varchar2(400);
        l_wallet_path   varchar2(4000);
        l_wallet_pass   varchar2(4000);
        l_request       clob;
        l_url           varchar2(4000);
        l_response      wsm_mgr.t_response;
     begin
          l_request := '{ "kodz": "' || p_kodz || '",  "encode": "' ||
                       p_encode || '",  "reptype": "' || p_reptype ||
                       '",  "PriorSQLStatement": "' || l_sqltxt_ready ||
                       '",  "FnameSQLStatement": "' || l_sqltxt_fname_ready ||
                       '",  "RepDate": "' || to_char(p_date,'yyyy-mm-dd') || '" }';
          dbms_output.put_line(l_request);

          l_url         := branch_attribute_utl.get_value('LINK_FOR_ABSBARS_WEBAPISERVICES') ||
                           'KFileFormPep/KfileFormReportBlob';
          l_wallet_path := branch_attribute_utl.get_value('TMS_WALLET_PATH');
          l_wallet_pass := branch_attribute_utl.get_value('TMS_WALLET_PASS');
          l_login       := nvl(branch_attribute_utl.get_value('TMS_LOGIN'), 'absadm01');
          l_password    := nvl(branch_attribute_utl.get_value('TMS_PASS'), 'qwerty');
          if (l_login is not null) then
            l_authorization := 'Basic ' ||
                               utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(l_login || ':' ||
                                                                                                     l_password)));
          end if;

          bars_audit.log_info('form_kfile_blob',
                               'l_url           : ' || l_url           || chr(10) ||
                               'l_wallet_path   : ' || l_wallet_path   || chr(10) ||
                               'l_wallet_pass   : ' || l_wallet_pass   || chr(10) ||
                               'l_login         : ' || l_login         || chr(10) ||
                               'l_password      : ' || l_password      || chr(10) ||
                               'l_authorization : ' || l_authorization,
                               p_make_context_snapshot => true);

          bars.wsm_mgr.prepare_request(p_url         => l_url,
                                       p_action      => null,
                                       p_http_method => bars.wsm_mgr.G_HTTP_POST,
                                       p_wallet_path => l_wallet_path,
                                       p_wallet_pwd  => l_wallet_pass,
                                       p_body        => l_request);

          if (l_authorization is not null) then
            bars.wsm_mgr.add_header(p_name  => 'Authorization',
                                    p_value => l_authorization);
          end if;
          wsm_mgr.add_header(p_name  => 'Content-Type',
                             p_value => 'application/json; charset=utf-8');
          bars.wsm_mgr.execute_api(l_response);
          bars_audit.info(l_trace || 'Сформирован кат.отчет №' || p_kodz ||
                          ' через веб сервис. Ответ:' || l_response.cdoc);
        end;
   end loop;
 end;
/
show err;

PROMPT *** Create  grants  FORM_KFILE_BLOB ***
grant EXECUTE                                                                on FORM_KFILE_BLOB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FORM_KFILE_BLOB.sql =========*** E
PROMPT ===================================================================================== 
