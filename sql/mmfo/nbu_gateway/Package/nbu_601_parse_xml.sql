PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/PACKAGE/nbu_gateway.nbu_601_parse_xml.sql =========*** Run *** 
PROMPT ===================================================================================== 

create or replace package nbu_601_parse_xml  as

 /*function check_request_id ( requst_id number )
  return varchar2;
*/
 procedure p_parse_person_fo (p_id in  NUMBER);
 procedure p_parse_document_fo (p_id in  NUMBER);
 procedure p_parse_address_fo (p_id in  NUMBER);
 procedure p_parse_person_uo (p_id in  NUMBER);
 procedure p_parse_finperformance_uo (p_id in  NUMBER);
 procedure p_parse_groupur_uo (p_id in NUMBER);
 procedure p_parse_finperformancegr_uo(p_id in NUMBER);
 procedure p_parse_finperformancepr_uo(p_id in NUMBER);
 procedure p_parse_ownerjur_uo (p_id in  NUMBER);
 procedure p_parse_ownerpp_uo (p_id in  NUMBER);
 procedure p_parse_partners_uo (p_id in  NUMBER);
 procedure p_parse_credit (p_id in  NUMBER);
 procedure p_parse_credit_pledge (p_id in NUMBER);
 procedure p_parse_pledge_dep (p_id in  NUMBER);
 procedure p_parse_credit_tranche (p_id in  NUMBER);

end nbu_601_parse_xml;

/
create or replace package body nbu_601_parse_xml  as

TYPE t_nbu_personal_fo         IS TABLE OF core_person_fo%ROWTYPE;
TYPE t_nbu_document_fo         IS TABLE OF core_document_fo%ROWTYPE;
TYPE t_nbu_address_fo          IS TABLE OF core_address_fo%ROWTYPE;
TYPE t_nbu_person_uo           IS TABLE OF core_person_uo%ROWTYPE;
TYPE t_nbu_finperformance_uo   IS TABLE OF core_finperformance_uo%ROWTYPE;
TYPE t_nbu_finperformancegr_uo IS TABLE OF core_finperformancegr_uo%ROWTYPE;
TYPE t_nbu_ownerjur_uo         IS TABLE OF core_ownerjur_uo%ROWTYPE;
TYPE t_nbu_ownerpp_uo          IS TABLE OF core_ownerpp_uo%ROWTYPE;
TYPE t_nbu_partners_uo         IS TABLE OF core_partners_uo%ROWTYPE;
TYPE t_nbu_credit              IS TABLE OF core_credit%ROWTYPE;
TYPE t_nbu_credit_pledge       IS TABLE OF core_credit_pledge%ROWTYPE;
TYPE t_nbu_pladge_dep          IS TABLE OF core_pledge_dep%ROWTYPE;
TYPE t_nbu_groupur_uo          IS TABLE OF core_groupur_uo%ROWTYPE;
TYPE t_nbu_finperformancepr_uo IS TABLE OF core_finperformancepr_uo%ROWTYPE;
TYPE t_nbu_credit_tranche       IS TABLE OF core_credit_tranche%rowtype;
--2
l_date varchar(10) :='dd.mm.yyyy';
l_cur_user varchar2(10);
l_data_rep date;
l_str1 varchar2(100);
l_date_cur date;
l_kf varchar2(6);
l_person_kf varchar2(6);
l_check_id int;
partition_doesnt_exist exception;
        pragma exception_init(partition_doesnt_exist, -2149);

/*function check_request_id ( requst_id number )
  return varchar2
  is
  l_check_table varchar2(50);
  l_check_kf varchar2(6);
  begin
  select t.data_type_code,r.kf
   into l_check_table,l_check_kf
   from bars.nbu_data_request_601 r, bars.nbu_data_type_601 t
 where r.data_type_id=t.id and r.id=requst_id;
  return l_check_table;
end;*/

 /*procedure run_parse_table ( requst_id number )
   is
   check_table varchar2 (50);
   begin
     check_table:=check_request_id(requst_id);
     if check_table='NBU_PERSON_FO' then
       p_parse_person_fo(check_request_id(requst_id),*/

 procedure p_parse_person_fo (p_id   in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header      dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_PERSON_FO   t_nbu_personal_fo:=t_nbu_personal_fo();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
   begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;

      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');

        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);
        l_cur_user:=dbms_xslprocessor.valueof(l_header,'CURRENT_USER/text()');
        
        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('PERSON',l_person_kf,l_date_cur, l_cur_user,l_data_rep);

        Begin
         --формируем список строк данных
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'PERSON_FO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_PERSON_FO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_PERSON_FO (l_PERSON_FO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'LASTNAME/text()', l_str);
             l_PERSON_FO (l_PERSON_FO.last).LASTNAME:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'FIRSTNAME/text()', l_str);
             l_PERSON_FO (l_PERSON_FO.last).FIRSTNAME:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'MIDDLENAME/text()', l_str);
             l_PERSON_FO (l_PERSON_FO.last).MIDDLENAME:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISREZ/text()', l_str);
             l_PERSON_FO (l_PERSON_FO.last).ISREZ:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'INN/text()', l_str);
             l_PERSON_FO (l_PERSON_FO.last).INN:= to_number(l_str);

             l_PERSON_FO (l_PERSON_FO.last).BIRTHDAY:= to_date(dbms_xslprocessor.valueof(l_row, 'BIRTHDAY/text()'), l_date);

             l_PERSON_FO (l_PERSON_FO.last).COUNTRYCODNEREZ:= to_number(dbms_xslprocessor.valueof(l_row, 'COUNTRYCODNEREZ/text()'),0);

             l_PERSON_FO (l_PERSON_FO.last).K060:=dbms_xslprocessor.valueof(l_row,'K060/text()');

             dbms_xslprocessor.valueof(l_row,'STATUS/text()',l_str);
             l_PERSON_FO (l_PERSON_FO.last).STATUS:=trim(l_str);

             dbms_xslprocessor.valueof(l_row,'KF/text()',l_str);
             l_PERSON_FO(l_PERSON_FO.last).KF:=trim(l_str);

         END LOOP;

           begin
            execute immediate 'alter table nbu_gateway.core_person_fo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_PERSON_FO IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_PERSON_FO.first .. l_PERSON_FO.last
                loop
                --    BEGIN
                    INSERT INTO nbu_gateway.core_person_fo(REQUEST_ID,
                                              rnk,
                                              lastname,
                                              firstname,
                                              middlename,
                                              isrez,
                                              inn,
                                              birthday,
                                              countrycodnerez,
                                              k060,
                                              status,
                                              kf)
                    VALUES (
                             l_check_id,
                             l_PERSON_FO(j).rnk,
                             l_PERSON_FO(j).lastname,
                             l_PERSON_FO(j).firstname,
                             l_PERSON_FO(j).middlename,
                             l_PERSON_FO(j).isrez,
                             l_PERSON_FO(j).inn,
                             l_PERSON_FO(j).birthday,
                             l_PERSON_FO(j).countrycodnerez,
                             l_PERSON_FO(j).k060,
                             l_PERSON_FO(j).status,
                             l_PERSON_FO(j).kf
                           );

               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
end;

procedure p_parse_document_fo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_DOCUMENT_FO  t_nbu_document_fo:=t_nbu_document_fo();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
    begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;

        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('PERSON_DOCUMENT',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
        --parse body!!!
        --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'DOCUMENT_FO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_DOCUMENT_FO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_DOCUMENT_FO (l_DOCUMENT_FO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'TYPED/text()', l_str);
             l_DOCUMENT_FO (l_DOCUMENT_FO.last).TYPED:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SERIYA/text()', l_str);
             l_DOCUMENT_FO (l_DOCUMENT_FO.last).SERIYA:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NOMERD/text()', l_str);
             l_DOCUMENT_FO (l_DOCUMENT_FO.last).NOMERD:=trim(l_str);

             l_DOCUMENT_FO (l_DOCUMENT_FO.last).DTD:= to_date(dbms_xslprocessor.valueof(l_row, 'DTD/text()'),l_date);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_DOCUMENT_FO (l_DOCUMENT_FO.last).KF:= trim(l_str);

         END LOOP;

          begin
            execute immediate 'alter table nbu_gateway.core_document_fo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_DOCUMENT_FO IS NOT EMPTY then
              BEGIN
                FOR j IN l_DOCUMENT_FO.first .. l_DOCUMENT_FO.last
                loop
                    INSERT INTO core_document_fo(REQUEST_ID,
                                                rnk,
                                                typed,
                                                seriya,
                                                nomerd,
                                                dtd,
                                                kf)
                    VALUES (l_check_id,
                             l_DOCUMENT_FO(j).rnk,
                             l_DOCUMENT_FO(j).typed,
                             l_DOCUMENT_FO(j).seriya,
                             l_DOCUMENT_FO(j).nomerd,
                             l_DOCUMENT_FO(j).dtd,
                             l_DOCUMENT_FO(j).kf

                           );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
  end;



 procedure p_parse_address_fo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_ADDRESS_FO  t_nbu_address_fo:=t_nbu_address_fo();


  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
       begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;

        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('PERSON_ADDRESS',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ADDRESS_FO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_ADDRESS_FO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'CODREGION/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).CODREGION:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'AREA/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).AREA:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ZIP/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).ZIP:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'CITY/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).CITY:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'STREETADDRESS/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).STREETADDRESS:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'HOUSENO/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).HOUSENO:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ADRKORP/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).ADRKORP:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'FLATNO/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).FLATNO:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_ADDRESS_FO (l_ADDRESS_FO.last).KF:= trim(l_str);

         END LOOP;

           begin
            execute immediate 'alter table nbu_gateway.core_address_fo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_ADDRESS_FO IS NOT EMPTY then
              BEGIN
                FOR j IN l_ADDRESS_FO.first .. l_ADDRESS_FO.last
                loop
                    INSERT INTO core_address_fo(REQUEST_ID,
                                                rnk,
                                                CODREGION,
                                                AREA,
                                                ZIP,
                                                CITY,
                                                STREETADDRESS,
                                                HOUSENO,
                                                ADRKORP,
                                                FLATNO,
                                               -- STATUS,
                                                kf)
                    VALUES ( l_check_id,
                             l_ADDRESS_FO(j).rnk,
                             l_ADDRESS_FO(j).CODREGION,
                             l_ADDRESS_FO(j).AREA,
                             l_ADDRESS_FO(j).ZIP,
                             l_ADDRESS_FO(j).CITY,
                             l_ADDRESS_FO(j).STREETADDRESS,
                             l_ADDRESS_FO(j).HOUSENO,
                             l_ADDRESS_FO(j).ADRKORP,
                             l_ADDRESS_FO(j).FLATNO,
                           --  l_ADDRESS_FO(j).STATUS,
                             l_ADDRESS_FO(j).KF

                     );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
end;

procedure p_parse_person_uo (p_id in  NUMBER)
  is
   -- title        varchar2(100) := 'pkg_SW_COMPARE.parse_sw_data. ';
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_PERSON_UO  t_nbu_person_uo:=t_nbu_person_uo();


  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);

      begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;


      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'PERSON_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_PERSON_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).RNK   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NAMEUR/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).NAMEUR   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISREZ/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).ISREZ    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'CODEDRPOU/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).CODEDRPOU   :=trim(l_str);

             l_PERSON_UO (l_PERSON_UO.last).REGISTRYDAY:=to_date(dbms_xslprocessor.valueof(l_row,'REGISTRYDAY/text()'),l_date);

             dbms_xslprocessor.valueof(l_row, 'NUMBERREGISTRY/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).NUMBERREGISTRY   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'K110/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).K110:= trim(l_str);

             l_PERSON_UO (l_PERSON_UO.last).EC_YEAR:=to_date(dbms_xslprocessor.valueof(l_row, 'EC_YEAR/text()'), l_date);

             --raise_application_error (-20001,dbms_xslprocessor.valueof(l_row,'COUNTRYCODNEREZ/text()'));
             l_PERSON_UO (l_PERSON_UO.last).COUNTRYCODNEREZ  := to_number(dbms_xslprocessor.valueof(l_row, 'COUNTRYCODNEREZ/text()'),0);

             dbms_xslprocessor.valueof(l_row, 'ISMEMBER/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).ISMEMBER   :=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISCONTROLLER/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).ISCONTROLLER := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISPARTNER/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).ISPARTNER   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISAUDIT/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).ISAUDIT:=trim(l_str);

             --raise_application_error (-20001,dbms_xslprocessor.valueof(l_row,'K060/text()'));
             l_PERSON_UO (l_PERSON_UO.last).K060 :=dbms_xslprocessor.valueof(l_row,'K060/text()');

             --dbms_xslprocessor.valueof(l_row, 'STATUS/text()', l_str);
             --l_PERSON_UO (l_PERSON_UO.last).STATUS := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_PERSON_UO (l_PERSON_UO.last).KF := trim(l_str);

         END LOOP;

           begin
            execute immediate 'alter table nbu_gateway.core_person_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_PERSON_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_PERSON_UO.first .. l_PERSON_UO.last
                loop
                    BEGIN
                    INSERT INTO core_person_uo(REQUEST_ID,
                                              rnk,
                                              nameur,
                                              isrez,
                                              codedrpou,
                                              registryday,
                                              numberregistry,
                                              k110,
                                              ec_year,
                                              countrycodnerez,
                                              ismember,
                                              iscontroller,
                                              ispartner,
                                              isaudit,
                                              k060,
                                             -- status,
                                              kf)
                    VALUES (l_check_id,
                             l_PERSON_UO(j).rnk,
                             l_PERSON_UO(j).nameur,
                             l_PERSON_UO(j).isrez,
                             l_PERSON_UO(j).codedrpou,
                             l_PERSON_UO(j).registryday,
                             l_PERSON_UO(j).numberregistry,
                             l_PERSON_UO(j).k110,
                             l_PERSON_UO(j).ec_year,
                             l_PERSON_UO(j).countrycodnerez,
                             l_PERSON_UO(j).ismember,
                             l_PERSON_UO(j).iscontroller,
                             l_PERSON_UO(j).ispartner,
                             l_PERSON_UO(j).isaudit,
                             l_PERSON_UO(j).k060,
                             --l_PERSON_UO(j).status,
                             l_PERSON_UO(j).kf
                     );
                     exception when dup_val_on_index then null;
                     end;
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
end;

procedure p_parse_finperformance_uo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_FINPERFORMANCE_UO  t_nbu_finperformance_uo:=t_nbu_finperformance_uo();

  begin
    begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
    end;
      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY_PERFORMANCE',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'FINPERFORMANCE_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_FINPERFORMANCE_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_FINPERFORMANCE_UO (l_FINPERFORMANCE_UO.last).RNK   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SALES/text()', l_str);
             l_FINPERFORMANCE_UO (l_FINPERFORMANCE_UO.last).SALES   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'EBIT/text()', l_str);
             l_FINPERFORMANCE_UO (l_FINPERFORMANCE_UO.last).EBIT    := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'EBITDA/text()', l_str);
             l_FINPERFORMANCE_UO (l_FINPERFORMANCE_UO.last).EBITDA   :=to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'TOTALDEBT/text()', l_str);
             l_FINPERFORMANCE_UO (l_FINPERFORMANCE_UO.last).TOTALDEBT    := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_FINPERFORMANCE_UO (l_FINPERFORMANCE_UO.last).KF := to_number(l_str);

         END LOOP;

            begin
            execute immediate 'alter table nbu_gateway.core_finperformance_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_FINPERFORMANCE_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_FINPERFORMANCE_UO.first .. l_FINPERFORMANCE_UO.last
                loop
                    INSERT INTO core_finperformance_uo(REQUEST_ID,
                                                       rnk,
                                                       sales,
                                                       ebit,
                                                       ebitda,
                                                       totaldebt,
                                                        kf)
                    VALUES (l_check_id,
                             l_FINPERFORMANCE_UO(j).rnk,
                             l_FINPERFORMANCE_UO(j).sales,
                             l_FINPERFORMANCE_UO(j).ebit,
                             l_FINPERFORMANCE_UO(j).ebitda,
                             l_FINPERFORMANCE_UO(j).totaldebt,
                             l_FINPERFORMANCE_UO(j).kf
                     );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
  end;

 procedure p_parse_groupur_uo (p_id in NUMBER)
   is
    l_clob clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_GROUPUR_UO  t_nbu_groupur_uo:=t_nbu_groupur_uo();


  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
       begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;
      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY_GROUP',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
        --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'GROUPUR_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_GROUPUR_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_GROUPUR_UO (l_GROUPUR_UO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'WHOIS/text()', l_str);
             l_GROUPUR_UO (l_GROUPUR_UO.last).WHOIS:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISREZGR/text()', l_str);
             l_GROUPUR_UO (l_GROUPUR_UO.last).ISREZGR:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'CODEDRPOUGR/text()', l_str);
             l_GROUPUR_UO (l_GROUPUR_UO.last).CODEDRPOUGR:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NAMEURGR/text()', l_str);
             l_GROUPUR_UO (l_GROUPUR_UO.last).NAMEURGR:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'COUNTRYCODGR/text()', l_str);
             l_GROUPUR_UO (l_GROUPUR_UO.last).COUNTRYCODGR:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_GROUPUR_UO (l_GROUPUR_UO.last).KF:= to_number(l_str);

         END LOOP;

           begin
            execute immediate 'alter table nbu_gateway.core_groupur_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_GROUPUR_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_GROUPUR_UO.first .. l_GROUPUR_UO.last
                loop
                    INSERT INTO core_groupur_uo(request_id,
                                                rnk,
                                                whois,
                                                isrezgr,
                                                codedrpougr,
                                                nameurgr,
                                                countrycodgr,
                                                kf)
                    VALUES ( l_check_id,
                             l_GROUPUR_UO(j).RNK,
                             l_GROUPUR_UO(j).WHOIS,
                             l_GROUPUR_UO(j).ISREZGR,
                             l_GROUPUR_UO(j).CODEDRPOUGR,
                             l_GROUPUR_UO(j).NAMEURGR,
                             l_GROUPUR_UO(j).COUNTRYCODGR,
                             l_GROUPUR_UO(j).kf
                     );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;

   end;


procedure p_parse_finperformancepr_uo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_FINPERFORMANCEPR_UO  t_nbu_finperformancepr_uo:=t_nbu_finperformancepr_uo();


  begin
       begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;
      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY_GROUP_PERFORMANCE',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
        --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'FINPERFORMANCEPR_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_FINPERFORMANCEPR_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_FINPERFORMANCEPR_UO (l_FINPERFORMANCEPR_UO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SALES/text()', l_str);
             l_FINPERFORMANCEPR_UO (l_FINPERFORMANCEPR_UO.last).SALES:= to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'EBIT/text()', l_str);
             l_FINPERFORMANCEPR_UO (l_FINPERFORMANCEPR_UO.last).EBIT:= to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'EBITDA/text()', l_str);
             l_FINPERFORMANCEPR_UO (l_FINPERFORMANCEPR_UO.last).EBITDA:=to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'TOTALDEBT/text()', l_str);
             l_FINPERFORMANCEPR_UO (l_FINPERFORMANCEPR_UO.last).TOTALDEBT:= to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_FINPERFORMANCEPR_UO (l_FINPERFORMANCEPR_UO.last).KF:= to_number(l_str);

         END LOOP;

           begin
            execute immediate 'alter table nbu_gateway.core_finperformancepr_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_FINPERFORMANCEPR_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_FINPERFORMANCEPR_UO.first .. l_FINPERFORMANCEPR_UO.last
                loop
                    INSERT INTO core_finperformancepr_uo(REQUEST_ID,
                                                         RNK,
                                                         SALES,
                                                         EBIT,
                                                         EBITDA,
                                                         TOTALDEBT,
                                                         KF)
                    VALUES ( l_check_id,
                             l_FINPERFORMANCEPR_UO(j).RNK,
                             l_FINPERFORMANCEPR_UO(j).SALES,
                             l_FINPERFORMANCEPR_UO(j).EBIT,
                             l_FINPERFORMANCEPR_UO(j).EBITDA,
                             l_FINPERFORMANCEPR_UO(j).TOTALDEBT,
                             l_FINPERFORMANCEPR_UO(j).kf
                          );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
  end;

 procedure p_parse_finperformancegr_uo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_FINPERFORMANCEGR_UO  t_nbu_finperformancegr_uo:=t_nbu_finperformancegr_uo();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
       begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;
      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY_GROUP_PERFORMANCE',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
        --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'FINPERFORMANCEGR_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_FINPERFORMANCEGR_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_FINPERFORMANCEGR_UO (l_FINPERFORMANCEGR_UO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SALESGR/text()', l_str);
             l_FINPERFORMANCEGR_UO (l_FINPERFORMANCEGR_UO.last).SALESGR:= to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'EBITGR/text()', l_str);
             l_FINPERFORMANCEGR_UO (l_FINPERFORMANCEGR_UO.last).EBITGR:= to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'EBITDAGR/text()', l_str);
             l_FINPERFORMANCEGR_UO (l_FINPERFORMANCEGR_UO.last).EBITDAGR:=to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'TOTALDEBTGR/text()', l_str);
             l_FINPERFORMANCEGR_UO (l_FINPERFORMANCEGR_UO.last).TOTALDEBTGR:= to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'CLASSGR/text()', l_str);
             l_FINPERFORMANCEGR_UO (l_FINPERFORMANCEGR_UO.last).CLASSGR:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_FINPERFORMANCEGR_UO (l_FINPERFORMANCEGR_UO.last).KF:= to_number(l_str);

         END LOOP;

           begin
            execute immediate 'alter table nbu_gateway.core_finperformancegr_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_FINPERFORMANCEGR_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_FINPERFORMANCEGR_UO.first .. l_FINPERFORMANCEGR_UO.last
                loop
                    INSERT INTO core_finperformancegr_uo(REQUEST_ID,
                                                         RNK,
                                                         SALESGR,
                                                         EBITGR,
                                                         EBITDAGR,
                                                         TOTALDEBTGR,
                                                         CLASSGR,
                                                         KF)
                    VALUES ( l_check_id,
                             l_FINPERFORMANCEGR_UO(j).RNK,
                             l_FINPERFORMANCEGR_UO(j).SALESGR,
                             l_FINPERFORMANCEGR_UO(j).EBITGR,
                             l_FINPERFORMANCEGR_UO(j).EBITDAGR,
                             l_FINPERFORMANCEGR_UO(j).TOTALDEBTGR,
                             l_FINPERFORMANCEGR_UO(j).CLASSGR,
                             l_FINPERFORMANCEGR_UO(j).kf
                     );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
  end;

 procedure p_parse_ownerjur_uo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_OWNERJUR_UO  t_nbu_ownerjur_uo :=t_nbu_ownerjur_uo ();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
       begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;

      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY_OWNER_COMPANY',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'OWNERJUR_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_OWNERJUR_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'RNKB/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).RNKB:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NAMEOJ/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).NAMEOJ:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISREZOJ/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).ISREZOJ:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'CODEDRPOUOJ/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).CODEDRPOUOJ:= trim(l_str);

             l_OWNERJUR_UO (l_OWNERJUR_UO.last).REGISTRYDAYOJ:= to_date(dbms_xslprocessor.valueof(l_row, 'REGISTRYDAYOJ/text()'), l_date);

             dbms_xslprocessor.valueof(l_row, 'NUMBERREGISTRYOJ/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).NUMBERREGISTRYOJ:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'COUNTRYCODOJ/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).COUNTRYCODOJ:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PERCENTOJ/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).PERCENTOJ:=to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_OWNERJUR_UO (l_OWNERJUR_UO.last).KF:= to_number(l_str);

         END LOOP;

            begin
            execute immediate 'alter table nbu_gateway.core_ownerjur_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_OWNERJUR_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_OWNERJUR_UO.first .. l_OWNERJUR_UO.last
                loop
                    INSERT INTO core_ownerjur_uo(REQUEST_ID,
                                                 rnk,
                                                 rnkb,
                                                 nameoj,
                                                 isrezoj,
                                                 codedrpouoj,
                                                 registrydayoj,
                                                 numberregistryoj,
                                                 countrycodoj,
                                                 percentoj,
                                                 kf)
                    VALUES ( l_check_id,
                             l_OWNERJUR_UO(j).rnk,
                             l_OWNERJUR_UO(j).rnkb,
                             l_OWNERJUR_UO(j).nameoj,
                             l_OWNERJUR_UO(j).isrezoj,
                             l_OWNERJUR_UO(j).codedrpouoj,
                             l_OWNERJUR_UO(j).registrydayoj,
                             l_OWNERJUR_UO(j).numberregistryoj,
                             l_OWNERJUR_UO(j).countrycodoj,
                             l_OWNERJUR_UO(j).percentoj,
                             l_OWNERJUR_UO(j).kf
                     );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
  end;


  procedure p_parse_ownerpp_uo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_OWNERPP_UO  t_nbu_ownerpp_uo :=t_nbu_ownerpp_uo ();
    
  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
         begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;
      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY_OWNER_PERSON',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'OWNERPP_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_OWNERPP_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'RNKB/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).RNKB:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'LASTNAME/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).LASTNAME:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'FIRSTNAME/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).FIRSTNAME:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'MIDDLENAME/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).MIDDLENAME:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISREZ/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).ISREZ:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'INN/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).INN:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'COUNTRYCOD/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).COUNTRYCOD:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PERCENT/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).PERCENT:=to_number(l_str,'99990,99');

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_OWNERPP_UO (l_OWNERPP_UO.last).KF := to_number(l_str);

         END LOOP;

            begin
            execute immediate 'alter table nbu_gateway.core_ownerpp_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_OWNERPP_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_OWNERPP_UO.first .. l_OWNERPP_UO.last
                loop
                    INSERT INTO core_ownerpp_uo(REQUEST_ID,
                                                rnk,
                                                rnkb,
                                                lastname,
                                                firstname,
                                                middlename,
                                                isrez,
                                                inn,
                                                countrycod,
                                                percent,
                                                kf)
                    VALUES ( l_check_id,
                             l_OWNERPP_UO(j).rnk,
                             l_OWNERPP_UO(j).rnkb,
                             l_OWNERPP_UO(j).lastname,
                             l_OWNERPP_UO(j).firstname,
                             l_OWNERPP_UO(j).middlename,
                             l_OWNERPP_UO(j).isrez,
                             l_OWNERPP_UO(j).inn,
                             l_OWNERPP_UO(j).countrycod,
                             l_OWNERPP_UO(j).percent,
                             l_OWNERPP_UO(j).kf
                            );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
  end;

  procedure p_parse_partners_uo (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_PARTNERS_UO t_nbu_partners_uo :=t_nbu_partners_uo ();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
        begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;
      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('COMPANY_PARTNER',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'PARTNERS_UO');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_PARTNERS_UO.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_PARTNERS_UO (l_PARTNERS_UO.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ISREZPR/text()', l_str);
             l_PARTNERS_UO (l_PARTNERS_UO.last).ISREZPR:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'CODEDRPOUPR/text()', l_str);
             l_PARTNERS_UO (l_PARTNERS_UO.last).CODEDRPOUPR:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NAMEURPR/text()', l_str);
             l_PARTNERS_UO (l_PARTNERS_UO.last).NAMEURPR:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'COUNTRYCODPR/text()', l_str);
             l_PARTNERS_UO (l_PARTNERS_UO.last).COUNTRYCODPR:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_PARTNERS_UO (l_PARTNERS_UO.last).KF:= to_number(l_str);

         END LOOP;

            begin
            execute immediate 'alter table nbu_gateway.core_partners_uo truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_PARTNERS_UO IS NOT EMPTY then
              BEGIN
                FOR j IN l_PARTNERS_UO.first .. l_PARTNERS_UO.last
                loop
                    INSERT INTO core_partners_uo( REQUEST_ID,
                                                  rnk,
                                                  isrezpr,
                                                  codedrpoupr,
                                                  nameurpr,
                                                  countrycodpr,
                                                  kf)
                    VALUES ( l_check_id,
                             l_PARTNERS_UO(j).rnk,
                             l_PARTNERS_UO(j).isrezpr,
                             l_PARTNERS_UO(j).codedrpoupr,
                             l_PARTNERS_UO(j).nameurpr,
                             l_PARTNERS_UO(j).countrycodpr,
                             l_PARTNERS_UO(j).kf
                     );
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
  end;

procedure p_parse_credit (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_NBU_CREDIT t_nbu_credit :=t_nbu_credit ();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
       begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;
      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('LOAN',l_person_kf,l_date_cur,l_cur_user,l_data_rep);

        Begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'NBU_CREDIT');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_NBU_CREDIT.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ND/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).ND:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ORDERNUM/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).ORDERNUM:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'FLAGOSOBA/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).FLAGOSOBA:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'TYPECREDIT/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).TYPECREDIT:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NUMDOG/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).NUMDOG:= trim(l_str);
             
             l_NBU_CREDIT (l_NBU_CREDIT.last).DOGDAY:=to_date(dbms_xslprocessor.valueof(l_row, 'DOGDAY/text()'), l_date);

             l_NBU_CREDIT (l_NBU_CREDIT.last).ENDDAY:=to_date(dbms_xslprocessor.valueof(l_row, 'ENDDAY/text()'), l_date);

             dbms_xslprocessor.valueof(l_row, 'SUMZAGAL/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).SUMZAGAL:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'R030/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).R030:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PROCCREDIT/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).PROCCREDIT:= to_number(l_str,'99990.99');

             dbms_xslprocessor.valueof(l_row, 'SUMPAY/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).SUMPAY:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PERIODBASE/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).PERIODBASE:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PERIODPROC/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).PERIODPROC:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SUMARREARS/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).SUMARREARS:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ARREARBASE/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).ARREARBASE:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ARREARPROC/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).ARREARPROC:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'DAYBASE/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).DAYBASE:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'DAYPROC/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).DAYPROC:=trim(l_str);

             l_NBU_CREDIT (l_NBU_CREDIT.last).FACTENDDAY:= to_date(dbms_xslprocessor.valueof(l_row, 'FACTENDDAY/text()'), l_date);

             dbms_xslprocessor.valueof(l_row, 'FLAGZ/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).FLAGZ:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KLASS/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).KLASS:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'RISK/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).RISK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'FLAGINSURANCE/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).FLAGINSURANCE:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_NBU_CREDIT (l_NBU_CREDIT.last).KF:= to_number(l_str);

         END LOOP;

            begin
            execute immediate 'alter table nbu_gateway.core_credit truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_NBU_CREDIT IS NOT EMPTY then
              BEGIN
                FOR j IN l_NBU_CREDIT.first .. l_NBU_CREDIT.last
                loop
                    begin
                    INSERT INTO core_credit(REQUEST_ID,
                                            rnk,
                                            nd,
                                            ordernum,
                                            flagosoba,
                                            typecredit,
                                            numdog,
                                            dogday,
                                            endday,
                                            sumzagal,
                                            r030,
                                            proccredit,
                                            sumpay,
                                            periodbase,
                                            periodproc,
                                            sumarrears,
                                            arrearbase,
                                            arrearproc,
                                            daybase,
                                            dayproc,
                                            factendday,
                                            flagz,
                                            klass,
                                            risk,
                                            flaginsurance,
                                            kf)
                    VALUES ( l_check_id,
                             l_NBU_CREDIT(j).rnk,
                             l_NBU_CREDIT(j).nd,
                             l_NBU_CREDIT(j).ordernum,
                             l_NBU_CREDIT(j).flagosoba,
                             l_NBU_CREDIT(j).typecredit,
                             l_NBU_CREDIT(j).numdog,
                             l_NBU_CREDIT(j).dogday,
                             l_NBU_CREDIT(j).endday,
                             l_NBU_CREDIT(j).sumzagal,
                             l_NBU_CREDIT(j).r030,
                             l_NBU_CREDIT(j).proccredit,
                             l_NBU_CREDIT(j).sumpay,
                             l_NBU_CREDIT(j).periodbase,
                             l_NBU_CREDIT(j).periodproc,
                             l_NBU_CREDIT(j).sumarrears,
                             l_NBU_CREDIT(j).arrearbase,
                             l_NBU_CREDIT(j).arrearproc,
                             l_NBU_CREDIT(j).daybase,
                             l_NBU_CREDIT(j).dayproc,
                             l_NBU_CREDIT(j).factendday,
                             l_NBU_CREDIT(j).flagz,
                             l_NBU_CREDIT(j).klass,
                             l_NBU_CREDIT(j).risk,
                             l_NBU_CREDIT(j).flaginsurance,
                             l_NBU_CREDIT(j).kf
                     );
                      EXCEPTION WHEN DUP_VAL_ON_INDEX  THEN NULL;
               END;
               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
       commit;
end;

procedure p_parse_credit_pledge (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_NBU_CREDIT_PLEDGE t_nbu_credit_pledge :=t_nbu_credit_pledge ();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
        begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;

      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('LOAN_PLEDGE',l_person_kf,l_date_cur,l_cur_user,l_data_rep);
        begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'CREDIT_PLADGE');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_NBU_CREDIT_PLEDGE.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_NBU_CREDIT_PLEDGE (l_NBU_CREDIT_PLEDGE.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ND/text()', l_str);
             l_NBU_CREDIT_PLEDGE (l_NBU_CREDIT_PLEDGE.last).ND:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ACC/text()', l_str);
             l_NBU_CREDIT_PLEDGE (l_NBU_CREDIT_PLEDGE.last).ACC:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SUMPLEDGE/text()', l_str);
             l_NBU_CREDIT_PLEDGE (l_NBU_CREDIT_PLEDGE.last).SUMPLEDGE:= to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'PRICEPLEDGE/text()', l_str);
             l_NBU_CREDIT_PLEDGE (l_NBU_CREDIT_PLEDGE.last).PRICEPLEDGE:=to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_NBU_CREDIT_PLEDGE (l_NBU_CREDIT_PLEDGE.last).KF:= to_number(l_str);

         END LOOP;

             begin
            execute immediate 'alter table nbu_gateway.core_credit_pledge truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_NBU_CREDIT_PLEDGE IS NOT EMPTY then
              BEGIN
                FOR j IN l_NBU_CREDIT_PLEDGE.first .. l_NBU_CREDIT_PLEDGE.last
                loop
                    INSERT INTO core_credit_pledge(REQUEST_ID,
                                                   rnk,
                                                   nd,
                                                   acc,
                                                   sumpledge,
                                                   pricepledge,
                                                   kf)
                    VALUES ( l_check_id,
                             l_NBU_CREDIT_PLEDGE(j).rnk,
                             l_NBU_CREDIT_PLEDGE(j).nd,
                             l_NBU_CREDIT_PLEDGE(j).acc,
                             l_NBU_CREDIT_PLEDGE(j).sumpledge,
                             l_NBU_CREDIT_PLEDGE(j).pricepledge,
                             l_NBU_CREDIT_PLEDGE(j).kf
                            );


               end loop;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
         exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
      commit;
end;

procedure p_parse_pledge_dep (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_NBU_PLEDGE_DEP t_nbu_pladge_dep:=t_nbu_pladge_dep ();

  begin
   -- bars_audit.info(title || 'Start '||'p_id = '||p_id);
        begin
       select x.d_clob
        into l_clob
       from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;

      --  l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('PLEDGE',l_person_kf,l_date_cur,l_cur_user,l_data_rep);
        begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'PLEDGE_DEP');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_NBU_PLEDGE_DEP.extend;

             dbms_xslprocessor.valueof(l_row, 'RNK/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).RNK:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ACC/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).ACC:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ORDERNUM/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).ORDERNUM:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NUMBERPLEDGE/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).NUMBERPLEDGE:= trim(l_str);

             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).PLEDGEDAY:=to_date(dbms_xslprocessor.valueof(l_row,'PLEDGEDAY/text()'),l_date);

             dbms_xslprocessor.valueof(l_row, 'S031/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).S031:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'R030/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).R030:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SUMPLEDGE/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).SUMPLEDGE:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'PRICEPLEDGE/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).PRICEPLEDGE:= trim(l_str);

             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).LASTPLEDGEDAY:=to_date(dbms_xslprocessor.valueof(l_row,'LASTPLEDGEDAY/text()'),l_date);

             dbms_xslprocessor.valueof(l_row, 'CODREALTY/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).CODREALTY:=to_number(l_str);

             dbms_xslprocessor.valueof(l_row,'ZIPREALTY/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).ZIPREALTY:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SQUAREREALTY/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).SQUAREREALTY:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'REAL6INCOME/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).REAL6INCOME:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NOREAL6INCOME/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).NOREAL6INCOME:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'FLAGINSURANCEPLEDGE/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).FLAGINSURANCEPLEDGE:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'NUMDOGDP/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).NUMDOGDP:=trim(l_str);

             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).DOGDAYDP:=to_date(dbms_xslprocessor.valueof(l_row,'DOGDAYDP/text()'),l_date);

             dbms_xslprocessor.valueof(l_row, 'R030DP/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).R030DP:=trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'SUMDP/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).SUMDP:= trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'KF/text()', l_str);
             l_NBU_PLEDGE_DEP (l_NBU_PLEDGE_DEP.last).KF:= to_number(l_str);

         END LOOP;

             dbms_output.put_line(l_NBU_PLEDGE_DEP.count);

             begin
            execute immediate 'alter table nbu_gateway.core_pledge_dep truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_NBU_PLEDGE_DEP IS NOT EMPTY then
              BEGIN
                FOR j IN l_NBU_PLEDGE_DEP.first .. l_NBU_PLEDGE_DEP.last
                loop
                    INSERT INTO core_pledge_dep(request_id,
                                                rnk,
                                                acc,
                                                ordernum,
                                                numberpledge,
                                                pledgeday,
                                                s031,
                                                r030,
                                                sumpledge,
                                                pricepledge,
                                                lastpledgeday,
                                                codrealty,
                                                ziprealty,
                                                squarerealty,
                                                real6income,
                                                noreal6income,
                                                flaginsurancepledge,
                                                numdogdp,
                                                dogdaydp,
                                                r030dp,
                                                sumdp,
                                                kf)

                    VALUES ( l_check_id,
                             l_NBU_PLEDGE_DEP(j).rnk,
                             l_NBU_PLEDGE_DEP(j).acc,
                             l_NBU_PLEDGE_DEP(j).ordernum,
                             l_NBU_PLEDGE_DEP(j).numberpledge,
                             l_NBU_PLEDGE_DEP(j).pledgeday,
                             l_NBU_PLEDGE_DEP(j).s031,
                             l_NBU_PLEDGE_DEP(j).r030,
                             l_NBU_PLEDGE_DEP(j).sumpledge,
                             l_NBU_PLEDGE_DEP(j).pricepledge,
                             l_NBU_PLEDGE_DEP(j).lastpledgeday,
                             l_NBU_PLEDGE_DEP(j).codrealty,
                             l_NBU_PLEDGE_DEP(j).ziprealty,
                             l_NBU_PLEDGE_DEP(j).squarerealty,
                             l_NBU_PLEDGE_DEP(j).real6income,
                             l_NBU_PLEDGE_DEP(j).noreal6income,
                             l_NBU_PLEDGE_DEP(j).flaginsurancepledge,
                             l_NBU_PLEDGE_DEP(j).numdogdp,
                             l_NBU_PLEDGE_DEP(j).dogdaydp,
                             l_NBU_PLEDGE_DEP(j).r030dp,
                             l_NBU_PLEDGE_DEP(j).sumdp,
                             l_NBU_PLEDGE_DEP(j).kf
                            );


               end loop;
             END;
            end if;
     nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
     BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
        exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
      commit;
end;

procedure p_parse_credit_tranche (p_id in  NUMBER)
  is
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_header       dbms_xmldom.DOMNode;
    l_str         VARCHAR2(2000);
    l_NBU_CREDIT_TRANCHE t_nbu_credit_tranche:=t_nbu_credit_tranche();

  begin
       begin
        select x.d_clob
        into l_clob
        from BARSTRANS.TRANSP_RECEIVE_DATA x where x.id=p_id;
       end;
       
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
       -- bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
       -- bars_audit.trace(title || 'getdocument done');
        --parse header!!!
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'ROOT');
        l_header := dbms_xmldom.item(l_rowlist, 0);

        l_cur_user:=dbms_xslprocessor.valueof(l_header, 'CURRENT_USER/text()');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_TIME/text()',l_str);
        l_data_rep:=to_date(l_str,'dd.mm.yyyy hh24:mi:ss');

        dbms_xslprocessor.valueOf(l_header, 'REPORTING_DATE/text()',l_str1);
        l_date_cur:=to_date(l_str1,'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_header, 'USER_KF/text()',l_kf);
        l_person_kf:=trim (l_kf);

        l_check_id:=nbu_gateway.nbu_core_service.get_active_data_request_id('LOAN_TRANCHE',l_person_kf,l_date_cur,l_cur_user,l_data_rep);
        begin
         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'CREDIT_TRANCHE');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_NBU_CREDIT_TRANCHE.extend;
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).REQUEST_ID:=l_check_id;
              
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).RNK:= trim(dbms_xslprocessor.valueof(l_row, 'RNK/text()'));

             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).ND:= trim(dbms_xslprocessor.valueof(l_row, 'ND/text()'));

             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).NUMDOGTR:=to_number(dbms_xslprocessor.valueof(l_row, 'NUMDOGTR/text()'));
            
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).DOGDAYTR:= to_date((dbms_xslprocessor.valueof(l_row, 'DOGDAYTR/text()')),'dd.mm.yy');
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).ENDDAYTR:= to_date((dbms_xslprocessor.valueof(l_row, 'ENDDAYTR/text()')),'dd.mm.yy');
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).SUMZAGALTR:=trim(dbms_xslprocessor.valueof(l_row,'SUMZAGALTR/text()'));
               
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).R030TR:=to_number(dbms_xslprocessor.valueof(l_row, 'R030TR/text()'));
            
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).PROCCREDITTR:=to_number(dbms_xslprocessor.valueOf(l_row,'PROCCREDITTR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).PERIODBASETR:=to_number(dbms_xslprocessor.valueOf(l_row,'PERIODBASETR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).PERIODPROCTR:=to_number(dbms_xslprocessor.valueOf(l_row,'PERIODPROCTR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).SUMARREARSTR:=to_number(dbms_xslprocessor.valueOf(l_row,'SUMARREARSTR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).ARREARBASETR:=to_number(dbms_xslprocessor.valueOf(l_row,'ARREARBASETR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).ARREARPROCTR:=to_number(dbms_xslprocessor.valueOf(l_row,'ARREARPROCTR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).DAYBASETR:=to_number(dbms_xslprocessor.valueOf(l_row,'DAYBASETR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).DAYPROCTR:=to_number(dbms_xslprocessor.valueOf(l_row,'DAYPROCTR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).FACTENDDAYTR:=to_date((dbms_xslprocessor.valueOf(l_row,'FACTENDDAYTR/text()')),'dd.mm.yy');
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).KLASSTR:=to_number(dbms_xslprocessor.valueOf(l_row,'KLASSTR/text()'));
             
             l_NBU_CREDIT_TRANCHE (l_NBU_CREDIT_TRANCHE.last).DAYPROCTR:=to_number(dbms_xslprocessor.valueOf(l_row,'RISKTR/text()'));
             
             END LOOP;

             begin
            execute immediate 'alter table nbu_gateway.core_credit_tranche truncate partition for (' || l_check_id || ') reuse storage';
        exception
            when partition_doesnt_exist then
                 null;
           end;

             if l_NBU_CREDIT_TRANCHE IS NOT EMPTY then
             BEGIN
                FORALL j IN l_NBU_CREDIT_TRANCHE.first .. l_NBU_CREDIT_TRANCHE.last
                    INSERT INTO core_credit_tranche         
                           VALUES l_NBU_CREDIT_TRANCHE(j);            
                           l_NBU_CREDIT_TRANCHE.delete;
             END;
            end if;
        nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_DATA_DELIVERED,null);
        BARSTRANS.TRANSP_UTL.resive_status_ok(p_id);
         exception
            when others then
            nbu_core_service.set_data_request_state(l_check_id,nbu_gateway.nbu_core_service.REQ_STATE_TRANSFER_DATA_FAIL,sqlerrm||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
            BARSTRANS.TRANSP_UTL.resive_status_err(p_id,'ERROR:' || DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
       end;
      commit;
end;

end;
/

grant execute on  nbu_gateway.nbu_601_parse_xml to bars_access_defrole;
grant execute on  nbu_gateway.nbu_601_parse_xml to barstrans;


PROMPT ===================================================================================== 
PROMPT *** End*** ========== Scripts /Sql/BARS/PACKAGE/nbu_gateway.nbu_601_parse_xml.sql =========*** end*** 
PROMPT ===================================================================================== 

