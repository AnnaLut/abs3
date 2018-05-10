

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NOTARY_SYNCHRONIZATION.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NOTARY_SYNCHRONIZATION ***

  CREATE OR REPLACE PROCEDURE BARS.NOTARY_SYNCHRONIZATION (p_url_wapp          in varchar2 default null,
                                                    p_Authorization_val in varchar2 default null,
                                                    p_walett_path       in varchar2 default null,
                                                    p_walett_pass       in varchar2 default null,
                                                    p_amount               number   default 100 ,
                                                    p_cardsCount        in varchar2 default '20',
                                                    p_packSize          in varchar2 default '10')
IS
--l_id                     int               ;
--l_address                varchar2(256)     ;
--l_branch                 varchar2(30)      ;
--l_DATE_OF_BIRTH_s        varchar2(256)     ;
  l_DATE_OF_BIRTH          date              ;
  l_PASSPORTISSUED         date              ;
  l_CertIssueDate          date              ;
  l_CertCancDate           date              ;
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
  l_ret                    varchar2(4000)    ;
--l_close_day              date              ;
--accr
  l_id_accr                int               ;
--l_ACCREDITATION_type_id  int               ;
--l_START_DATE_s           varchar2(256)     ;
--l_expiry_DATE_s          varchar2(256)     ;
--l_close_DATE_s           varchar2(256)     ;
  l_START_DATE             date              ;
  l_expiry_DATE            date              ;
  l_close_DATE             date              ;
--l_account_number         varchar2(15)      ;
--l_account_mfo            varchar2(12)      ;
--l_state_id               int               ;
  l_branches               varchar2_list     ;
  l_segments_of_business   number_list       ;
--
  l_one                    int               ;
  l_err                    varchar2(4000)    ;
  l_1                      int               ;
  l_begin                  int               ;
  l_end                    int               ;
  l_count_notary           int               ;
  l_count_accr             int               ;
  l_result                 clob;--varchar2(32767)   ;
  l_clob                   clob              ;
  g_response               wsm_mgr.t_response;
  l_action                 varchar2(64)      ;

  l_xml                    xmltype           ;
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

  l_err_accr               int               ;

begin
  l_err_accr := 0;
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
  bars_audit.info('notary_synchronization: begin');
  begin
    wsm_mgr.prepare_request(p_url          => l_url_wapp        ,
                            p_action       => 'count'           ,
                            p_http_method  => wsm_mgr.g_http_get,
                            p_content_type => wsm_mgr.g_ct_json ,
                            p_wallet_path  => l_walett_path     ,
                            p_wallet_pwd   => l_walett_pass);
    wsm_mgr.add_header     (p_name  => 'Authorization',
                            p_value => l_Authorization_val);
    wsm_mgr.add_parameter  (p_name  => 'cardsCount',
                            p_value => p_cardsCount);
    wsm_mgr.add_parameter  (p_name  => 'packSize',
                            p_value => p_packSize);
    wsm_mgr.execute_request(g_response);
    l_result := g_response.cdoc; -- если есть ответ - в clob будет
    if substr(l_result,1,3) in ('400','401','404','500') and length(l_result)>3 then
      bars_audit.error('notary_synchronization: error (2) - '||l_result);
      return;
    end if;
  exception when others then
    bars_audit.error('notary_synchronization: error (1) - '||sqlerrm||' '||dbms_utility.format_error_backtrace);
    return;
  end;

--почистить таблицы NOTARY_ACCREDITATION и NOTARY

  begin
    delete from NOTARY_ACCREDITATION;
  exception when others then
    bars_audit.error('notary_synchronization: error (A) - '||sqlerrm||' '||dbms_utility.format_error_backtrace);
    return;
  end;

  begin
    delete from notary;
  exception when others then
    rollback;
    bars_audit.error('notary_synchronization: error (B) - '||sqlerrm||' '||dbms_utility.format_error_backtrace);
    return;
  end;

  l_count_accr   := 0;
  l_count_notary := to_number(l_result);
  l_begin        := 1;

  bars_audit.info('notary_synchronization: количество нотариусов = '||l_count_notary);

  while l_count_notary>0
  loop
    l_1      := least(p_amount,l_count_notary);
    l_end    := l_begin +l_1 -1;
    l_action := 'getsome/'||to_char(l_begin)||'-'||to_char(l_end);

    begin
<<afterbegin>>
      wsm_mgr.prepare_request(p_url          => l_url_wapp        ,
                              p_action       => l_action          ,
                              p_http_method  => wsm_mgr.g_http_get,
--                            p_content_type => wsm_mgr.g_ct_xml  ,
                              p_content_type => 'application/xml' ,
                              p_wallet_path  => l_walett_path     ,
                              p_wallet_pwd   => l_walett_pass);
      wsm_mgr.add_header     (p_name  => 'Authorization',
                              p_value => l_Authorization_val);
      wsm_mgr.add_header     (p_name  => 'Accept',
                              p_value => 'application/xml');
      wsm_mgr.add_parameter  (p_name  => 'cardsCount',
                              p_value => p_cardsCount);
      wsm_mgr.add_parameter  (p_name  => 'packSize',
                              p_value => p_packSize);
      begin
        wsm_mgr.execute_request(g_response);
      exception when others then
        l_1 := trunc((l_end-l_begin+1)/2);
        if l_1=0 then
          bars_audit.error('notary_synchronization: error (5) - '||sqlerrm);
          return;
        end if;
        l_end    :=l_begin +l_1 -1;
        l_action := 'getsome/'||to_char(l_begin)||'-'||to_char(l_end);
        goto afterbegin;
      end;
      l_result := g_response.cdoc; -- если есть ответ - в clob будет
      if substr(l_result,1,3) in ('400','401','404','500') and length(l_result)>3 then
        bars_audit.error('notary_synchronization: error (4) - '||l_result);
        return;
      end if;
    exception when others then
      bars_audit.error('notary_synchronization: error (3) - '||sqlerrm||' '||dbms_utility.format_error_backtrace);
      return;
    end;

--  bars_audit.info('notary_synchronization: l_result(01) = '||substr(l_result,    1,3000));
--  bars_audit.info('notary_synchronization: l_result(02) = '||substr(l_result, 3001,3000));
--  bars_audit.info('notary_synchronization: l_result(03) = '||substr(l_result, 6001,3000));
--  bars_audit.info('notary_synchronization: l_result(04) = '||substr(l_result, 9001,3000));
--  bars_audit.info('notary_synchronization: l_result(05) = '||substr(l_result,12001,3000));
--  bars_audit.info('notary_synchronization: l_result(06) = '||substr(l_result,15001,3000));
--  bars_audit.info('notary_synchronization: l_result(07) = '||substr(l_result,18001,3000));
--  bars_audit.info('notary_synchronization: l_result(08) = '||substr(l_result,21001,3000));
--  bars_audit.info('notary_synchronization: l_result(09) = '||substr(l_result,24001,3000));
--  bars_audit.info('notary_synchronization: l_result(10) = '||substr(l_result,27001,3000));
--  bars_audit.info('notary_synchronization: l_result(11) = '||substr(l_result,30001,2000));

    l_clob := l_result;
    l_xml  := xmltype(l_clob);

--  обработка clob (l_clob)

--  l_parser := xmlparser.newparser;
--  xmlparser.parseCLOB(l_parser,l_clob);
--  l_doc    := xmlparser.getDocument(l_parser);

    for k in (select extractValue(value(dtl),'Notary/Id'               )              Id                      ,
                     extractValue(value(dtl),'Notary/Tin'              )              Tin                     ,
                     extractValue(value(dtl),'Notary/FirstName'        )              FirstName               ,
                     extractValue(value(dtl),'Notary/MiddleName'       )              MiddleName              ,
                     extractValue(value(dtl),'Notary/LastName'         )              LastName                ,
                     extractValue(value(dtl),'Notary/DateOfBirth'      )              DateOfBirth             ,
                     extractValue(value(dtl),'Notary/PassportSeries'   )              PassportSeries          ,
                     extractValue(value(dtl),'Notary/PassportNumber'   )              PassportNumber          ,
                     extractValue(value(dtl),'Notary/Address'          )              Address                 ,
                     extractValue(value(dtl),'Notary/PassportIssuer'   )              PassportIssuer          ,
                     extractValue(value(dtl),'Notary/PassportIssued'   )              PassportIssued          ,
                     extractValue(value(dtl),'Notary/PhoneNumber'      )              PhoneNumber             ,
                     extractValue(value(dtl),'Notary/MobilePhoneNumber')              MobilePhoneNumber       ,
                     extractValue(value(dtl),'Notary/Email'            )              Email                   ,
                     extractValue(value(dtl),'Notary/NotaryType'       )              NotaryType              ,
                     extractValue(value(dtl),'Notary/CertNumber'       )              CertNumber              ,
                     extractValue(value(dtl),'Notary/CertIssueDate'    )              CertIssueDate           ,
                     extractValue(value(dtl),'Notary/CertCancDate'     )              CertCancDate            ,
                     extractValue(value(dtl),'Notary/RNK'              )              RNK                     ,
                     extractValue(value(dtl),'Notary/MFORNK'           )              MFORNK                  ,
                     extractValue(value(dtl),'Notary/DOCUMENT_TYPE'    )              DOCUMENT_TYPE           ,
                     extractValue(value(dtl),'Notary/IDCARD_DOCUMENT_NUMBER')         IDCARD_DOCUMENT_NUMBER  ,
                     extractValue(value(dtl),'Notary/IDCARD_NOTATION_NUMBER')         IDCARD_NOTATION_NUMBER  ,
                     extractValue(value(dtl),'Notary/PASSPORT_EXPIRY'  )              PASSPORT_EXPIRY         ,
                     extractValue(value(subdtl),'Accreditation/Id'                  ) Accr_Id                 ,
                     extractValue(value(subdtl),'Accreditation/AccreditationTypeId' ) Accr_AccreditationTypeId,
                     extractValue(value(subdtl),'Accreditation/StartDate'           ) Accr_StartDate          ,
                     extractValue(value(subdtl),'Accreditation/ExpiryDate'          ) Accr_ExpiryDate         ,
                     extractValue(value(subdtl),'Accreditation/CloseDate'           ) Accr_CloseDate          ,
                     extractValue(value(subdtl),'Accreditation/AccountNumber'       ) Accr_AccountNumber      ,
                     extractValue(value(subdtl),'Accreditation/AccountMfo'          ) Accr_AccountMfo         ,
                     extractValue(value(subdtl),'Accreditation/StateId'             ) Accr_StateId            ,
                     extractValue(value(subdtl),'Accreditation/branches'            ) Accr_branches           ,
                     extractValue(value(subdtl),'Accreditation/segments_of_business') Accr_segments_of_business
              from   table(XMLSequence(l_xml.extract('ArrayOfNotary/Notary')))                        dtl,
                     table(XMLSequence(value(dtl).extract('Notary/Accreditations/Accreditation')))(+) subdtl
             )
    loop

--    bars_audit.info('notary_synchronization: l_id = '                   ||k.Id);
--    bars_audit.info('notary_synchronization: l_id_accr = '              ||k.Accr_Id);
--    bars_audit.info('notary_synchronization: l_ACCREDITATION_type_id = '||k.Accr_AccreditationTypeId);

--    bars_audit.info('Id = '                    ||k.Id                       );
--    bars_audit.info('Tin = '                   ||k.Tin                      );
--    bars_audit.info('FirstName = '             ||k.FirstName                );
--    bars_audit.info('MiddleName = '            ||k.MiddleName               );
--    bars_audit.info('LastName = '              ||k.LastName                 );
--    bars_audit.info('DateOfBirth = '           ||k.DateOfBirth              );
--    bars_audit.info('PassportSeries = '        ||k.PassportSeries           );
--    bars_audit.info('PassportNumber = '        ||k.PassportNumber           );
--    bars_audit.info('Address = '               ||k.Address                  );
--    bars_audit.info('PassportIssuer = '        ||k.PassportIssuer           );
--    bars_audit.info('PassportIssued = '        ||k.PassportIssued           );
--    bars_audit.info('PhoneNumber = '           ||k.PhoneNumber              );
--    bars_audit.info('MobilePhoneNumber = '     ||k.MobilePhoneNumber        );
--    bars_audit.info('Email = '                 ||k.Email                    );
--    bars_audit.info('NotaryType = '            ||k.NotaryType               );
--    bars_audit.info('CertNumber = '            ||k.CertNumber               );
--    bars_audit.info('CertIssueDate = '         ||k.CertIssueDate            );
--    bars_audit.info('CertCancDate = '          ||k.CertCancDate             );
--    bars_audit.info('RNK = '                   ||k.RNK                      );
--    bars_audit.info('MFORNK = '                ||k.MFORNK                   );
--    bars_audit.info('Accr_Id = '               ||k.Accr_Id                  );
--    bars_audit.info('Accr_AccreditationTypeId' ||k.Accr_AccreditationTypeId );
--    bars_audit.info('Accr_StartDate = '        ||k.Accr_StartDate           );
--    bars_audit.info('Accr_ExpiryDate = '       ||k.Accr_ExpiryDate          );
--    bars_audit.info('Accr_CloseDate = '        ||k.Accr_CloseDate           );
--    bars_audit.info('Accr_AccountNumber = '    ||k.Accr_AccountNumber       );
--    bars_audit.info('Accr_AccountMfo = '       ||k.Accr_AccountMfo          );
--    bars_audit.info('Accr_StateId = '          ||k.Accr_StateId             );
--    bars_audit.info('Accr_branches = '         ||k.Accr_branches            );
--    bars_audit.info('Accr_segments_of_business'||k.Accr_segments_of_business);

      l_DATE_OF_BIRTH  := to_date(k.DateOfBirth,    'DD.MM.YYYY');
      l_PASSPORTISSUED := to_date(substr(k.PassportIssued, 1, 10), 'YYYY-MM-DD');
      l_START_DATE     := to_date(k.Accr_StartDate ,'DD.MM.YYYY');
      l_expiry_DATE    := to_date(k.Accr_ExpiryDate,'DD.MM.YYYY');
      l_close_DATE     := to_date(k.Accr_CloseDate ,'DD.MM.YYYY');
      l_CertIssueDate  := to_date(k.CertIssueDate  ,'DD.MM.YYYY');
      l_CertCancDate   := to_date(k.CertCancDate   ,'DD.MM.YYYY');

--    l_branches             := '''||k.Accr_branches||''';
--    l_segments_of_business := '''||k.Accr_segments_of_business||''';

--
      savepoint edit_nota;
      begin
        select 1
        into   l_one
        from   notary
        where  id=to_number(k.Id);
      exception when no_data_found then
        insert
        into   notary (id)
               values (to_number(k.Id));
      end;
--    update notary
      begin
        nota.edit_nota(to_number(k.Id)        ,
                       k.TIN                  ,  -- ОКПО
                       k.Address              ,
                       l_DATE_OF_BIRTH        ,  -- дата рождения
                       k.Email                ,
                       k.LastName             ,  -- фамилия
                       k.FirstName            ,  -- имя
                       k.MiddleName           ,  -- отчество
                       k.PhoneNumber          ,
                       k.MobilePhoneNumber    ,
                       k.PassportSeries       ,
                       k.PassportNumber       ,
                       k.PassportIssuer       ,
                       l_PASSPORTISSUED       ,
                       to_number(k.NotaryType),
                       k.CertNumber           ,
                       l_CertIssueDate        ,
                       l_CertCancDate         ,
                       k.RNK                  ,
                       k.MFORNK               ,
                       k.DOCUMENT_TYPE        ,
                       k.IDCARD_DOCUMENT_NUMBER, 
                       k.IDCARD_NOTATION_NUMBER, 
                       k.PASSPORT_EXPIRY,
                       l_err);
        if l_err is not null then
          bars_audit.error('notary_synchronization: (0) ошибка - id = '||k.Id||', '||l_err);
          rollback to edit_nota;
          k.Accr_id := null;
        end if;
--      return;
      exception when others then
        if l_err is not null then
          bars_audit.error('notary_synchronization: (6) ошибка - '||l_err);
        else
          bars_audit.error('notary_synchronization: (7) ошибка - '||sqlerrm||' '||dbms_utility.format_error_backtrace);
        end if;
        rollback to edit_nota;
        return;
      end;

      savepoint edit_accr;
      if k.Accr_Id is not null then
        begin
          select 1
          into   l_one
          from   notary_accreditation
          where  id=k.Accr_Id;
        exception when no_data_found then
          insert
          into   notary_accreditation (id,
                                       notary_id)
                               values (k.Accr_Id,
                                       k.Id);
        end;

--      update notary_accreditation
        begin
          nota.edit_accr (to_number(k.Accr_Id)                 ,
                          to_number(k.Accr_AccreditationTypeId),
                          l_START_DATE                         ,
                          l_expiry_DATE                        ,
                          k.Accr_AccountNumber                 ,
                          k.Accr_AccountMfo                    ,
                          to_number(k.Accr_StateId)            ,
                          l_branches                           ,
                          l_segments_of_business               ,
                          l_err);
          if l_err is not null then
            bars_audit.error('notary_synchronization: (8) ошибка - '||l_err);
            rollback to edit_accr;
            l_err_accr := 1;
          else
            if l_close_DATE is not null then
              attribute_utl.set_value(to_number(k.Accr_Id),nota.ATTR_CODE_ACCR_CLOSE_DATE,l_close_DATE);
            end if;
            l_count_accr := l_count_accr + 1;
          end if;
        exception when others then
          if l_err is not null then
            bars_audit.error('notary_synchronization: (9) ошибка - '||l_err);
          else
            bars_audit.error('notary_synchronization: (C) ошибка - '||sqlerrm||' '||dbms_utility.format_error_backtrace);
          end if;
          rollback;
          bars_audit.info('notary_synchronization: rollback');
          return;
        end;
      end if;
--
    end loop;

    l_count_notary := l_count_notary - l_1;
    l_begin        := l_end + 1;

  end loop;

  if l_count_accr = 0 or l_err_accr = 1 then
--  выбросить exception
    bars_audit.info('notary_synchronization: has errors');
    rollback;
    bars_audit.info('notary_synchronization: rollback');
    raise_application_error(-20371,'Ошибки при выполнении процедуры, см. в журнале (таблица SEC_AUDIT)!');
  else
    bars_audit.info('notary_synchronization: количество аккредитаций = '||l_count_accr);
    commit;
    bars_audit.info('notary_synchronization: commit');
  end if;
  bars_audit.info('notary_synchronization: end');

end notary_synchronization;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NOTARY_SYNCHRONIZATION.sql =======
PROMPT ===================================================================================== 
