

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NOTARY_RU2CA_PROFIT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NOTARY_RU2CA_PROFIT ***

  CREATE OR REPLACE PROCEDURE BARS.NOTARY_RU2CA_PROFIT (p_url_wapp          in varchar2 default null,
                                                 p_Authorization_val in varchar2 default null,
                                                 p_walett_path       in varchar2 default null,
                                                 p_walett_pass       in varchar2 default null)
                                               --p_amount               number   default 100 ,
                                               --p_cardsCount        in varchar2 default '20',
                                               --p_packSize          in varchar2 default '10',
IS
--l_id                     int               ;
--l_address                varchar2(256)     ;
--l_branch                 varchar2(30)      ;
--l_DATE_OF_BIRTH_s        varchar2(256)     ;
--l_DATE_OF_BIRTH          date              ;
--l_PASSPORTISSUED         date              ;
--l_CertIssueDate          date              ;
--l_CertCancDate           date              ;
--l_email                  varchar2(128)     ;
--l_FIRST_NAME             varchar2(64)      ;
--l_LAST_NAME              varchar2(64)      ;
--l_MFORNK                 varchar2(6)       ;
--l_MIDDLE_NAME            varchar2(64)      ;
--l_MOBILE_PHONE_NUMBER    varchar2(64)      ;
--l_NLS                    varchar2(15)      ;
--l_TIN                    varchar2(15)      ;
--l_PASSPORT_NUMBER        varchar2(32)      ;
--l_PASSPORT_SERIES        varchar2(32)      ;
--l_PHONE_NUMBER           varchar2(64)      ;
--l_RNK                    int               ;
--l_ret                    varchar2(4000)    ;
--l_close_day              date              ;
--accr
--l_id_accr                int               ;
--l_ACCREDITATION_type_id  int               ;
--l_START_DATE_s           varchar2(256)     ;
--l_expiry_DATE_s          varchar2(256)     ;
--l_close_DATE_s           varchar2(256)     ;
--l_START_DATE             date              ;
--l_expiry_DATE            date              ;
--l_close_DATE             date              ;
--l_account_number         varchar2(15)      ;
--l_account_mfo            varchar2(12)      ;
--l_state_id               int               ;
--l_branches               varchar2_list     ;
--l_segments_of_business   number_list       ;
--
--l_one                    int               ;
--l_err                    varchar2(4000)    ;
--l_1                      int               ;
--l_begin                  int               ;
--l_end                    int               ;
--l_count_notary           int               ;
--l_count_accr             int               ;
  l_result                 varchar2(32767)   ;
--l_clob                   clob              ;
  l_count                  int               ;
  g_response               wsm_mgr.t_response;
  l_action                 varchar2(64)      ;

--l_xml                    xmltype           ;
  l_url_wapp               varchar2(4000)    ;
  l_Authorization_val      varchar2(4000)    ;

  l_walett_path            varchar2(4000)    ;
  l_walett_pass            varchar2(4000)    ;

--l_parser                 xmlparser.parser  ;
--l_doc                    xmldom.domdocument;
--l_NOTARY                 xmldom.domnodelist;
--l_ACCRED                 xmldom.domnodelist;
--l_NOTARYelement          xmldom.DOMNode    ;
--l_ACCREDelement          xmldom.DOMNode    ;

--l_xslelem                xmldom.DOMElement ;
--l_nspace                 varchar2(50)      ;
--l_xslcmds                xmldom.DOMNodeList;

begin
  tokf;
  if p_url_wapp is null then
    l_url_wapp := GetGlobalOption('NOTA_URL_CA');
    if substr(l_url_wapp,-1,1)<>'/' then
      l_url_wapp := l_url_wapp||'/';
    end if;
  else
    l_url_wapp := p_url_wapp;
  end if;
  if p_Authorization_val is null then
    l_Authorization_val := 'Basic '||utl_raw.cast_to_varchar2(utl_encode.base64_encode(
                           utl_raw.cast_to_raw(GetGlobalOption('NOTA_LOGIN_CA')||':'||
                           GetGlobalOption('NOTA_PASS_CA'))));
  else
    l_Authorization_val := p_Authorization_val;
  end if;
  if p_walett_path is null then
    l_walett_path := GetGlobalOption('NOTA_WALLET_PATH_CA');
  else
    l_walett_path := p_walett_path;
  end if;
  if p_walett_pass is null then
    l_walett_pass := GetGlobalOption('NOTA_WALLET_PASS_CA');
  else
    l_walett_pass := p_walett_pass;
  end if;
  bars_audit.info('notary_ru2ca_profit: begin');
  begin
    l_count := 0;
    for k in (select na.notary_id               ,
                     na.id              accr_id ,
                     o.branch                   ,
                     substr(c.prod,1,6) nbsob22 ,
                     o.ref              ref_oper,
                     o.vdat             dat_oper,
                     p.s                profit
              from   oper                 o ,
                     opldok               p ,
                     operw                w1,
                     operw                w2,
                     cc_deal              c ,
                     nd_txt               n ,
                     notary_accreditation na
              where  o.tt in ('40M','40N')                                   and
                     o.vdat>=c.sdate                                         and
                     o.sos>=5                                                and
                     p.ref=o.ref                                             and
                     p.dk=0                                                  and
                     p.tt='G0N'                                              and
                     w1.ref=o.ref                                            and
                     w1.tag='N_CRD'                                          and
                     w2.ref=o.ref                                            and
                     w2.tag='D_CRD'                                          and
                     to_char(c.nd)=w1.value                                  and
                     (to_char(c.sdate,'DD.MM.YYYY')=replace(w2.value,'/','.') or
                      to_char(c.sdate,'DD.MM.YY')=replace(w2.value,'/','.')) and
                     n.nd=c.nd                                               and
                     n.tag='FION'                                            and
                     to_char(na.id)=n.txt                                    and
                     o.ref in (select object_id
                               from   notary_queue
                               where  object_type='REF' and
                                      dat_done is null)
             )
    loop
      begin
        wsm_mgr.prepare_request(p_url          => l_url_wapp         ,
                                p_action       => 'add_profit'       ,
                                p_http_method  => wsm_mgr.G_HTTP_POST,
                                p_content_type => wsm_mgr.g_ct_json  ,
                                p_wallet_path  => l_walett_path      ,
                                p_wallet_pwd   => l_walett_pass);
        wsm_mgr.add_header     (p_name  => 'Authorization', p_value => l_Authorization_val             );
--      wsm_mgr.add_parameter  (p_name  => 'cardsCount'   , p_value => p_cardsCount                    );
--      wsm_mgr.add_parameter  (p_name  => 'packSize'     , p_value => p_packSize                      );
        wsm_mgr.add_parameter  (p_name  => 'NOTARY_ID'    , p_value => to_char(k.notary_id)            );
        wsm_mgr.add_parameter  (p_name  => 'ACCR_ID'      , p_value => to_char(k.accr_id)              );
        wsm_mgr.add_parameter  (p_name  => 'BRANCH'       , p_value => k.branch                        );
        wsm_mgr.add_parameter  (p_name  => 'NBSOB22'      , p_value => k.nbsob22                       );
        wsm_mgr.add_parameter  (p_name  => 'REF_OPER'     , p_value => to_char(k.ref_oper)             );
        wsm_mgr.add_parameter  (p_name  => 'DAT_OPER'     , p_value => to_char(k.dat_oper,'YYYY-MM-DD'));
        wsm_mgr.add_parameter  (p_name  => 'PROFIT'       , p_value => to_char(k.profit)               );
        wsm_mgr.execute_request(g_response);
        l_result := g_response.cdoc; -- если есть ответ - в clob будет
        l_result := replace(l_result,'"');
        if substr(l_result,1)='-' and length(l_result)>3 then
          bars_audit.error('notary_ru2ca_profit: error ('||
                           substr(l_result,1,instr(l_result,' ')-1)||') - '||
                           substr(l_result,instr(l_result,' ')+1));
          rollback;
          return;
        end if;
      exception when others then
        bars_audit.error('notary_ru2ca_profit: error (1) - '||sqlerrm);
        rollback;
        return;
      end;
      begin
        update notary_queue
        set    dat_done=sysdate
        where  object_id=k.ref_oper and
               object_type='REF';
      exception when others then
        bars_audit.error('notary_ru2ca_profit: error (2) - '||sqlerrm);
        rollback;
        return;
      end;
      l_count := l_count + 1;
    end loop;

  end loop;

  if l_count>0 then
    bars_audit.info('notary_ru2ca_profit: кількість документів = '||l_count);
    commit;
    bars_audit.info('notary_ru2ca_profit: commit');
  end if;
  bars_audit.info('notary_ru2ca_profit: end');

end notary_ru2ca_profit;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NOTARY_RU2CA_PROFIT.sql =========*
PROMPT ===================================================================================== 
