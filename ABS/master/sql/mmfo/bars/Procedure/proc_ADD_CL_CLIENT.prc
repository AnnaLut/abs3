CREATE OR REPLACE PROCEDURE BARS.ADD_CL_CLIENT(p_date_start date,
                                          p_date_end   date) is
    l_url         varchar2(4000 byte);
    l_walett_path varchar2(4000 byte);
    l_walett_pass varchar2(4000 byte);
    l_response    bars.wsm_mgr.t_response;
    l_parser      dbms_xmlparser.parser;
        l_doc     dbms_xmldom.domdocument;
        l_rows    dbms_xmldom.domnodelist;
        l_row     dbms_xmldom.domnode;
    l_xml     clob;
    l_mfo     customer.kf%type;
    l_okpo    customer.okpo%type;
    l_rnk     customer.rnk%type;
    l_date_cl    date;
    l_date_start date;
    l_date_end   date;
    l_nmk  varchar2(4000);
    l_branch_name varchar2(4000);
    l_banks   varchar2(4000);
    l_userlogname varchar2(100) := 'absadm01';

    --select * from web_usermap where webuser like '%tech%'

begin
        l_date_start := p_date_start;
        l_date_end   := p_date_end;

       -- видалення даних з таблиці по USER_ID
        BEGIN
           DELETE FROM CLIENT_ZVT
                 WHERE USER_ID =
                          (SELECT SYS_CONTEXT ('bars_global', 'user_id') FROM DUAL);
        COMMIT;
        END;

/**************CorpLight Start******************/
    begin

        l_url         := getglobaloption('REPORT_CORPLIGHT_URL');--'https://tbarsweb-00-01.oschadbank.ua:44302/barsroot/api/';  --URL web сервіса CorpLight
        
        select val  into l_walett_path from birja where PAR = 'Wlt_dir';
        select val  into l_walett_pass from birja where PAR = 'Wlt_pass';

        --l_walett_path := pfu.pfu_utl.get_parameter('BARS_WS_WALLET_PATH');
        --l_walett_pass := pfu.pfu_utl.get_parameter('BARS_WS_WALLET_PASS');

        bars.wsm_mgr.prepare_request(p_url          => l_url ||
                                                         'corpLight/getClients',
                                       p_action       => null,
                                       p_http_method  => bars.wsm_mgr.g_http_get,
                                       p_content_type => bars.wsm_mgr.G_CT_XML,
                                       p_wallet_path  => l_walett_path,
                                       p_wallet_pwd   => l_walett_pass,
                                       p_body         => null);

        for c0 in (select t.kf from kf_ru t)  --по всім РУ
        loop
           l_banks := l_banks||case when (l_banks is null or l_banks = '') then '' else ',' end ||c0.kf;
        end loop;

        wsm_mgr.add_parameter(p_name => 'dateFrom', p_value => to_char(l_date_start,'dd.mm.yyyy'));
        wsm_mgr.add_parameter(p_name => 'dateTo', p_value => to_char(l_date_end,'dd.mm.yyyy'));
        wsm_mgr.add_parameter(p_name => 'banks', p_value => l_banks);
        wsm_mgr.add_parameter(p_name => 'logName', p_value => l_userlogname);


        bars.wsm_mgr.execute_api(l_response);


        l_xml := substr(l_response.cdoc,2);
        l_xml := substr(l_xml,1,length(l_xml)-1);

        l_xml := replace(l_xml,'\r\n','');
        l_xml := replace(l_xml,'\','');

        l_parser := dbms_xmlparser.newparser;
            dbms_xmlparser.parseclob(l_parser, l_xml);
            l_doc := dbms_xmlparser.getdocument(l_parser);

            l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'Customers');

        dbms_output.put_line(dbms_xmldom.getlength(l_rows));

            for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
               loop
                l_row := dbms_xmldom.item(l_rows, i);
                l_mfo  := dbms_xslprocessor.valueof(l_row, 'MFO/text()');
                l_rnk  := dbms_xslprocessor.valueof(l_row, 'RNK/text()');
                l_date_cl  := to_date(substr(dbms_xslprocessor.valueof(l_row, 'ADD_DATE/text()'),1,10),'yyyy-mm-dd');
                    begin
                    select okpo,
                           nmk,
                           -- select * from banks_ru
                           (select name from banks_ru b where b.mfo = cust.kf) as branch_name
                            into l_okpo, l_nmk, l_branch_name  from customer cust  where cust.rnk = l_rnk and cust.kf = l_mfo and date_off is null;
                     exception when no_data_found then begin
                                                        logger.info('CORPLIGHT RNK: '||l_rnk);
                                                        logger.info('CORPLIGHT MFO: '||l_mfo);
                                                        select name into l_branch_name from banks_ru where  mfo = l_mfo;        
                                                        insert into CLIENT_ZVT (rnk, okpo, nmk, branch_name, first_date_corplight, user_id)
                                                        values (l_rnk, null, null, l_branch_name, l_date_cl, sys_context('bars_global','user_id'));
                                                        commit;
                                                        continue;
                            end;
                    end;
                insert into CLIENT_ZVT (rnk, okpo, nmk, branch_name, first_date_corplight, user_id)
                     values (l_rnk, l_okpo, l_nmk, l_branch_name, l_date_cl, sys_context('bars_global','user_id'));
                     commit;


            end loop;
     --exception when others then if sqlcode = -20001 then null;    end if ;

    end;
/**************CorpLight END******************/

/***************Corp2 Start******************************/
   merge into CLIENT_ZVT cz
    using (select cc.rnk,
          cc.cust_code,
          cc.name,
          -- select * from banks_ru
          (select name from banks_ru b where b.mfo = cc.bank_id) as branch_name,
          cc.create_date,
          sys_context('bars_global','user_id') as user_id
          from barsaq.V_CLIENT_CREATE cc
            where cc.bank_id in (select t.mfo from banks_ru t)
            and CC.CREATE_DATE between l_date_start and l_date_end ) cc1
   on (cz.rnk=cc1.rnk and cz.okpo=cc1.cust_code and cc1.user_id = cz.user_id)
   when matched then
                update
                set cz.first_date_corp2 = cc1.create_date
   when not matched then

   insert (rnk, okpo, nmk, branch_name, first_date_corp2, user_id)
   values (cc1.rnk,
          cc1.cust_code,
          cc1.name,
          cc1.branch_name,
          cc1.create_date,
          cc1.user_id);

 /***************Corp2 end******************************/


            /*
              insert into CLIENT_ZVT (rnk, okpo, nmk, branch_name, first_date_corp2, user_id)
   select cc.rnk,
          cc.cust_code,
          cc.name,
          (select name from branch b where b.branch=cc.bank_id ) as branch_name,
          cc.create_date,
          sys_context('bars_global','user_id')
          from barsaq.V_CLIENT_CREATE cc
            where cc.bank_id in (select t.kf from mv_kf t);

            */
    commit;
  end;
/