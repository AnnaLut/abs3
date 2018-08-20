
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/PFU/package/pfu_epp_utl.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE PFU.PFU_EPP_UTL is

    LINE_STATE_NEW                 constant integer := 1;
    LINE_STATE_ACCEPTED            constant integer := 2;
    LINE_STATE_INCORRECT_DATA      constant integer := 3;
    LINE_STATE_FAILED              constant integer := 4;
    LINE_STATE_PFU_RECEIPT_SENT    constant integer := 5;

    LINE_STATE_SENT_TO_BANK        constant integer := 6;
    LINE_STATE_ACCOUNT_CLAIM_FAIL  constant integer := 7;
    LINE_STATE_ACCOUNT_OPENED      constant integer := 8;
    LINE_STATE_DECLINED_BY_CBS     constant integer := 9;
    LINE_STATE_PROCESSED_BY_CBS    constant integer := 10;
    LINE_STATE_PERSONALIZED        constant integer := 11;
    LINE_STATE_W4_ACTIVATED        constant integer := 12;
    LINE_STATE_ACTIVATED           constant integer := 13;
    LINE_STATE_SENT_TO_PFU         constant integer := 14;
    LINE_STATE_DECLINED_BY_PFU     constant integer := 15;
    LINE_STATE_PROCESSED_BY_PFU    constant integer := 16;
    LINE_STATE_CARD_BLOCKED        constant integer := 17;
    LINE_STATE_CARD_UNBLOCKED      constant integer := 18;
    LINE_STATE_DESTRUCTED          constant integer := 19;
    LINE_STATE_CLAIM_WAIT_FOR_SEND constant integer := 20;
    LINE_STATE_ACTIVATION_CLAIMED  constant integer := 21;
    LINE_STATE_ACTIVATION_FAILED   constant integer := 22;
    LINE_STATE_ACTIVATION_CLAIM_ER constant integer := 23;
    LINE_STATE_CARD_BLOCKED_DBLK   constant integer := 24;
    LINE_STATE_CARD_UNBLOCKED_DBLK constant integer := 25;

    -- тип для валідації рядків файлу для відкриття рахунку в Банку та атрибутів файлу з інформацією по ЕПП, які потребують перевипуску
    type t_epp_lines is table of pfu_epp_line%rowtype index by pls_integer;
    -- тип для валідації ОПІКУНІВ рядків файлу для відкриття рахунку в Банку та атрибутів файлу з інформацією по ЕПП, які потребують перевипуску
    type t_epp_line_guardian is table of pfu_epp_line_guardian%rowtype index by pls_integer;

    function read_epp_batch_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_epp_batch_list_request%rowtype;

    function read_epp_batch_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_epp_batch_request%rowtype;

    function create_epp_batch_list_request(
        p_date_from in date,
        p_date_to   in date)
    return integer;

    function create_epp_batch_request(
        p_batch_list_request_id in integer,
        p_pfu_batch_id in integer,
        p_batch_date in date,
        p_batch_lines_count in integer)
    return integer;

    procedure set_epp_rnk(
        p_line_id in integer,
        p_rnk in integer);

    procedure set_batch_response_data(
        p_request_id in integer,
        p_response_data in clob,
        p_batch_sign in varchar2);

    procedure set_line_state(
        p_line_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2,
        p_stack_trace in clob);

    function get_line_buffer(
        p_line_row in pfu_epp_line%rowtype)
    return raw;

    procedure set_epp_activate(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date,
        p_sign_pass_change_flag number);

    procedure set_epp_destruct(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date);

    procedure set_epp_block(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date);

    procedure set_acc_block_dblk(
        p_nls varchar2,
        p_kf  varchar2,
        p_tracking_comment in varchar2,
        p_date in date
        );

    procedure set_acc_unblock_dblk(
        p_nls varchar2,
        p_kf  varchar2,
        p_tracking_comment in varchar2,
        p_date in date
        );

    procedure set_epp_block_dblk(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date);

    procedure set_epp_unblock_dblk(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date
        );

    procedure set_epp_unblock(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date);

    function calc_line_sign(
        p_epp_line in pfu_epp_line%rowtype)
    return raw;

    procedure r_regepp_procesing(p_file_data in clob,
                                 p_file_id   in number);

    procedure r_checkissuecard_procesing(p_file_data in clob,
                                         p_file_id   in number);

    procedure r_activateacc_procesing(p_file_data in clob,
                                      p_file_id   in number);

    procedure r_card_block_procesing(p_file_data in clob,
                                     p_file_id   in number);

    procedure r_card_unblock_procesing(p_file_data in clob,
                                       p_file_id   in number);

    procedure r_check_epp_state_procesing(p_file_data in clob,
                                 p_file_id   in number);

    procedure sign_line(
        p_epp_line in pfu_epp_line%rowtype);
end;
/
CREATE OR REPLACE PACKAGE BODY PFU.PFU_EPP_UTL as

    function read_epp_batch_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_epp_batch_list_request%rowtype
    is
        l_epp_batch_list_request_row pfu_epp_batch_list_request%rowtype;
    begin
        select *
        into   l_epp_batch_list_request_row
        from   pfu_epp_batch_list_request t
        where  t.id = p_request_id;

        return l_epp_batch_list_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит на отримання списку пакетів на випуск ЕПП з ідентифікатором {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_epp_batch_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_epp_batch_request%rowtype
    is
        l_epp_batch_request_row pfu_epp_batch_request%rowtype;
    begin
        select *
        into   l_epp_batch_request_row
        from   pfu_epp_batch_request t
        where  t.id = p_request_id;

        return l_epp_batch_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит на отримання пакету на випуск ЕПП з ідентифікатором {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

    function create_epp_batch_list_request(
        p_date_from in date,
        p_date_to   in date)
    return integer
    is
        l_request_id integer;
    begin
        l_request_id := pfu_utl.create_request(pfu_utl.REQ_TYPE_EPP_BATCH_LIST);

        insert into pfu_epp_batch_list_request
        values (l_request_id, p_date_from, p_date_to);

        pfu_utl.track_request(l_request_id,
                              pfu_utl.REQ_STATE_NEW,
                              'Запит на отримання переліку пакетів ЕПП за період {' ||
                                  to_char(p_date_from, 'dd.mm.yyyy') || ' - ' ||
                                  to_char(p_date_to, 'dd.mm.yyyy') ||
                                  '} зареєстрований');

        return l_request_id;
    end;

    function create_epp_batch_request(
        p_batch_list_request_id in integer,
        p_pfu_batch_id in integer,
        p_batch_date in date,
        p_batch_lines_count in integer)
    return integer
    is
        l_request_id integer;
    begin
        l_request_id := pfu_utl.create_request(pfu_utl.REQ_TYPE_EPP_BATCH, p_batch_list_request_id);

        insert into pfu_epp_batch_request
        values (l_request_id, p_pfu_batch_id, p_batch_date, p_batch_lines_count, null, null);

        pfu_utl.track_request(l_request_id,
                              pfu_utl.REQ_STATE_NEW,
                              'Запит на отримання пакету ЕПП {' || p_pfu_batch_id || '} за дату {' ||
                                  to_char(p_batch_date, 'dd.mm.yyyy') || '} зареєстрований');

        return l_request_id;
    end;

    procedure set_batch_response_data(
        p_request_id in integer,
        p_response_data in clob,
        p_batch_sign in varchar2)
    is
    begin
        update pfu_epp_batch_request t
        set    t.batch_data = p_response_data,
               t.data_sign = p_batch_sign
        where  t.id = p_request_id;

        pfu_utl.track_request(p_request_id, pfu_utl.REQ_STATE_DATA_IS_RECEIVED, 'Дані пакету для реєстрації ЕПП отримані');
    end;

    procedure track_line(
        p_line_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2,
        p_stack_trace in clob)
    is
    begin
        insert into pfu_epp_line_tracking
        values (pfu_epp_line_tracking_seq.nextval,
                p_line_id,
                p_state_id,
                sysdate,
                substrb(p_tracking_comment, 1, 4000),
                p_stack_trace);

    end;

    procedure set_epp_rnk(
        p_line_id in integer,
        p_rnk in integer)
    is
    begin
        update pfu_epp_line t
        set    t.rnk = p_rnk
        where  t.id = p_line_id;
    end;

    procedure set_line_state(
        p_line_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2,
        p_stack_trace in clob)
    is
    begin
        update pfu_epp_line t
        set    t.state_id = p_state_id
        where  t.id = p_line_id;

        track_line(p_line_id, p_state_id, p_tracking_comment, p_stack_trace);
    end;

    procedure set_epp_activate(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date,
        p_sign_pass_change_flag number
        )
    is
    begin
        update pfu_epp_line t
        set    t.state_id = pfu_epp_utl.LINE_STATE_W4_ACTIVATED,
               t.activation_date = p_date,
               t.sign_pass_change_flag = p_sign_pass_change_flag
        where  t.id = p_line_id;

        track_line(p_line_id, pfu_epp_utl.LINE_STATE_W4_ACTIVATED, p_tracking_comment, null);
    end;

    procedure set_epp_destruct(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date
        )
    is
    begin
        update pfu_epp_line t
        set    t.state_id = pfu_epp_utl.LINE_STATE_DESTRUCTED,
               t.destruction_date = p_date
        where  t.id = p_line_id;

        track_line(p_line_id, pfu_epp_utl.LINE_STATE_DESTRUCTED, p_tracking_comment, null);
    end;

    procedure set_epp_block(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date
        )
    is
    begin
        update pfu_epp_line t
        set    t.state_id = pfu_epp_utl.LINE_STATE_CARD_BLOCKED,
               t.block_date = p_date
        where  t.id = p_line_id;

        track_line(p_line_id, pfu_epp_utl.LINE_STATE_CARD_BLOCKED, p_tracking_comment, null);
    end;

    procedure set_epp_block_dblk(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date
        )
    is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_mfo               pfu_epp_line.bank_mfo%type;
    begin

        update pfu_epp_line t
        set    t.state_id = pfu_epp_utl.LINE_STATE_CARD_BLOCKED_DBLK
        where  t.id = p_line_id
        returning t.bank_mfo into l_mfo;


        l_doc       := dbms_xmldom.newDomDocument;
        l_root_node := dbms_xmldom.makeNode(l_doc);
        l_root_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'root')));

        l_header_node := dbms_xmldom.appendChild(l_root_node,

                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'header')));
        l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'body')));

        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'epp', 1);
        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'id', p_line_id);

        begin
          --TRANS_TYPE_ACTIVATEACC ставимо тип - '3'    ACTIVATEACC     Активація рахунку
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_SET_CARD_BLOCK,
                                                                     l_mfo,
                                                                     transport_utl.get_receiver_url(l_mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());

          track_line(p_line_id, pfu_epp_utl.LINE_STATE_CARD_BLOCKED_DBLK, p_tracking_comment, null);
        end;
    end;

    procedure set_epp_unblock_dblk(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date
        )
    is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_mfo               pfu_epp_line.bank_mfo%type;
    begin

        update pfu_epp_line t
        set    t.state_id = pfu_epp_utl.LINE_STATE_CARD_UNBLOCKED_DBLK
        where  t.id = p_line_id
        returning t.bank_mfo into l_mfo;


        l_doc       := dbms_xmldom.newDomDocument;
        l_root_node := dbms_xmldom.makeNode(l_doc);
        l_root_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'root')));

        l_header_node := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'header')));
        l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'body')));

        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'epp', 1);
        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'id', p_line_id);

        begin
          --TRANS_TYPE_ACTIVATEACC ставимо тип - '3'    ACTIVATEACC     Активація рахунку
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK,
                                                                     l_mfo,
                                                                     transport_utl.get_receiver_url(l_mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());

          track_line(p_line_id, pfu_epp_utl.LINE_STATE_CARD_UNBLOCKED_DBLK, p_tracking_comment, null);
        end;
    end;

    procedure set_acc_block_dblk(
        p_nls varchar2,
        p_kf  varchar2,
        p_tracking_comment in varchar2,
        p_date in date
        )
    is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
--    l_mfo               pfu_epp_line.bank_mfo%type;
    begin

        update pfu_pensacc t
           set t.state = 'BLOCKED'
         where t.nls = p_nls
           and t.kf = p_kf;

        l_doc       := dbms_xmldom.newDomDocument;
        l_root_node := dbms_xmldom.makeNode(l_doc);
        l_root_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'root')));

        l_header_node := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'header')));
        l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'body')));
        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'epp', 0);
        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'nls', p_nls);

        begin
          --TRANS_TYPE_ACTIVATEACC ставимо тип - '3'    ACTIVATEACC     Активація рахунку
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_SET_CARD_BLOCK,
                                                                     p_kf,
                                                                     transport_utl.get_receiver_url(p_kf),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());

          --track_line(p_line_id, pfu_epp_utl.LINE_STATE_CARD_BLOCKED_DBLK, p_tracking_comment, null);
        end;
    end;

    procedure set_acc_unblock_dblk(
        p_nls varchar2,
        p_kf  varchar2,
        p_tracking_comment in varchar2,
        p_date in date
        )
    is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
--    l_mfo               pfu_epp_line.bank_mfo%type;
    begin

        update pfu_pensacc t
           set t.state = 'UNBLOCKED'
         where t.nls = p_nls
           and t.kf = p_kf;

        l_doc       := dbms_xmldom.newDomDocument;
        l_root_node := dbms_xmldom.makeNode(l_doc);
        l_root_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'root')));

        l_header_node := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'header')));
        l_body_node   := dbms_xmldom.appendChild(l_root_node,
                                                 dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                'body')));
        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'epp', 0);
        pfu_service_utl.add_text_node_utl(l_doc, l_body_node, 'nls', p_nls);

        begin
          --TRANS_TYPE_ACTIVATEACC ставимо тип - '3'    ACTIVATEACC     Активація рахунку
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK,
                                                                     p_kf,
                                                                     transport_utl.get_receiver_url(p_kf),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());

          --track_line(p_line_id, pfu_epp_utl.LINE_STATE_CARD_BLOCKED_DBLK, p_tracking_comment, null);
        end;
    end;

    procedure set_epp_unblock(
        p_line_id in integer,
        p_tracking_comment in varchar2,
        p_date in date
        )
    is
    begin
        update pfu_epp_line t
        set    t.state_id = pfu_epp_utl.LINE_STATE_CARD_UNBLOCKED,
               t.unblock_date = p_date
        where  t.id = p_line_id;

        track_line(p_line_id, pfu_epp_utl.LINE_STATE_CARD_UNBLOCKED, p_tracking_comment, null);
    end;

    procedure set_epp_account_number(p_line_id          in integer,
                                     p_tracking_comment in varchar2,
                                     p_account_number   in varchar2,
                                     p_type_card        in varchar2,
                                     p_term_card        in number,
                                     p_rnk              in number) is
    begin
      update pfu_epp_line t
         set t.state_id       = pfu_epp_utl.LINE_STATE_ACCOUNT_OPENED,
             t.account_number = p_account_number,
             t.type_card = p_type_card,
             t.term_card = p_term_card,
             t.rnk = p_rnk
       where t.id = p_line_id
         and t.state_id not in (12, 13, 14);

      track_line(p_line_id, pfu_epp_utl.line_state_account_opened, p_tracking_comment, null);
    end;

    function get_line_buffer(
        p_line_row in pfu_epp_line%rowtype)
    return raw
    is
    begin
        return utl_i18n.string_to_raw(lpad(p_line_row.id                               ,  10, '0') ||
                                      rpad(nvl(p_line_row.epp_number             , ' '),  12) ||
                                      rpad(nvl(p_line_row.epp_expiry_date        , ' '),   8) ||
                                      rpad(nvl(p_line_row.person_record_number   , ' '),  10) ||
                                      rpad(nvl(p_line_row.last_name              , ' '),  70) ||
                                      rpad(nvl(p_line_row.first_name             , ' '),  50) ||
                                      rpad(nvl(p_line_row.middle_name            , ' '),  50) ||
                                      rpad(nvl(p_line_row.gender                 , ' '),   1) ||
                                      rpad(nvl(p_line_row.date_of_birth          , ' '),   8) ||
                                      rpad(nvl(p_line_row.phone_numbers          , ' '),  30) ||
                                      rpad(nvl(p_line_row.embossing_name         , ' '), 172) ||
                                      rpad(nvl(p_line_row.tax_registration_number, ' '),  10) ||
                                      rpad(nvl(p_line_row.document_type          , ' '),   2) ||
                                      rpad(nvl(p_line_row.document_id            , ' '),  10) ||
                                      rpad(nvl(p_line_row.document_issue_date    , ' '),   8) ||
                                      rpad(nvl(p_line_row.document_issuer        , ' '), 100) ||
                                      rpad(nvl(p_line_row.displaced_person_flag  , ' '),   1) ||
                                      rpad(nvl(p_line_row.legal_country          , ' '),  50) ||
                                      rpad(nvl(p_line_row.legal_zip_code         , ' '),   6) ||
                                      rpad(nvl(p_line_row.legal_region           , ' '),  50) ||
                                      rpad(nvl(p_line_row.legal_district         , ' '), 100) ||
                                      rpad(nvl(p_line_row.legal_settlement       , ' '), 100) ||
                                      rpad(nvl(p_line_row.legal_street           , ' '), 100) ||
                                      rpad(nvl(p_line_row.legal_house            , ' '),   5) ||
                                      rpad(nvl(p_line_row.legal_house_part       , ' '),   2) ||
                                      rpad(nvl(p_line_row.legal_apartment        , ' '),   5) ||
                                      rpad(nvl(p_line_row.actual_country         , ' '),  50) ||
                                      rpad(nvl(p_line_row.actual_zip_code        , ' '),   6) ||
                                      rpad(nvl(p_line_row.actual_region          , ' '),  50) ||
                                      rpad(nvl(p_line_row.actual_district        , ' '), 100) ||
                                      rpad(nvl(p_line_row.actual_settlement      , ' '), 100) ||
                                      rpad(nvl(p_line_row.actual_street          , ' '), 100) ||
                                      rpad(nvl(p_line_row.actual_house           , ' '),   5) ||
                                      rpad(nvl(p_line_row.actual_house_part      , ' '),   2) ||
                                      rpad(nvl(p_line_row.actual_apartment       , ' '),   5) ||
                                      rpad(nvl(p_line_row.bank_mfo               , ' '),   6) ||
                                      rpad(nvl(p_line_row.bank_num               , ' '),  30) ||
                                      rpad(nvl(p_line_row.bank_name              , ' '), 100)||
                                      rpad(nvl(p_line_row.branch                 , ' '),  30)||
                                      rpad(nvl(p_line_row.pens_type              , ' '),   1));
    end;

    function calc_line_sign(
        p_epp_line in pfu_epp_line%rowtype)
    return raw
    is
    begin
        return dbms_crypto.mac(
                   pfu_epp_utl.get_line_buffer(p_epp_line),
                   dbms_crypto.HMAC_SH1,
                   pfu_utl.get_salt());
    end;

    procedure sign_line(
        p_epp_line in pfu_epp_line%rowtype)
    is
        l_sign raw(128);
    begin
        l_sign := calc_line_sign(p_epp_line);

        update pfu_epp_line t
        set    t.line_sign = l_sign
        where  t.id = p_epp_line.id;
    end;

    -----------------------------------------------------------------------------------------
    --  insert_epp_line_bnk_state2
    --
    --    Наповнення таблиці для квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2)
    --
    --      p_request_id - id запиту
    --
    procedure insert_epp_line_bnk_state2(p_epp_line_id in pfu_epp_line.id%type,
                                         p_state_id    in pfu_epp_line.state_id%type,
                                         p_type_card   in pfu_epp_line_bnk_state2.type_card%type,
                                         p_comm        in varchar2,
                                         p_create_date in date default trunc(sysdate))
    is
      l_error_stack varchar2(4000);
    begin
      begin
        select substr(tr.error_stack,1,2000)
          into l_error_stack
          from pfu_epp_line_tracking tr
         where tr.line_id = p_epp_line_id
           and tr.rowid in (select min(track.rowid) keep(dense_rank last order by tr.id desc)
                             from pfu_epp_line_tracking track
                            where track.line_id = p_epp_line_id
                              and track.state_id = 3);
      exception
        when no_data_found then
          l_error_stack := null;
        when others then
          raise;
      end;
      insert into pfu_epp_line_bnk_state2 (epp_line_id, batch_request_id, type_card, epp_expiry_date, state_id, create_date, comm,
                                           stage_ticket, error_stack, epp_number, ps_type, rn)
      select p_epp_line_id,
             batch_request_id,
             p_type_card,
             null,
             p_state_id,
             p_create_date,
             p_comm,
             case when p_state_id not in (20) then 1 else null end,
             l_error_stack,
             e.epp_number,
             /*case when p_type_card like '%NSMEP%' and e.displaced_person_flag = '1' and e.pens_type in ('1','2') then '1'
                  when p_type_card like '%MWORLDEBPP_EPP%' and e.displaced_person_flag = '0' and e.pens_type in ('1','2') then '0'
                  else '' end,*/
             case when p_type_card like '%NSMEP%' then '0' else '1' end as ps_type,
             line_id
        from pfu_epp_line e
       where id = p_epp_line_id;

    exception
      when others then
        raise_application_error(-20001, 'pfu_epp_utl.insert_epp_line_bnk_state2 err - Помилка наповнення таблиці для квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2) ' || sqlerrm || chr(10) ||dbms_utility.format_error_backtrace());
    end insert_epp_line_bnk_state2;

    procedure r_regepp_procesing(p_file_data in clob,
                                 p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_clob     clob;
      l_id       number;
      l_state_id number;
      l_message  varchar2(4000);
      l_nls      varchar2(15);
      l_card_type varchar2(4000);
      l_cntm      number(3);
      l_rnk       number(38);
    begin
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row       := dbms_xmldom.item(l_rows, i);
        l_id        := to_number(dbms_xslprocessor.valueof(l_row, 'id/text()'));
        l_state_id  := to_number(dbms_xslprocessor.valueof(l_row, 'state_id/text()'));
        l_message   := dbms_xslprocessor.valueof(l_row, 'message/text()');
        l_nls       := dbms_xslprocessor.valueof(l_row, 'nls/text()');
        l_card_type := dbms_xslprocessor.valueof(l_row, 'card_type/text()');
        l_cntm      := dbms_xslprocessor.valueof(l_row, 'cntm/text()');
        l_rnk       := dbms_xslprocessor.valueof(l_row, 'rnk/text()');
        if l_state_id = 20 then
          set_epp_account_number(l_id, l_message, l_nls, l_card_type, l_cntm, l_rnk);
        else
          set_line_state(p_line_id          => l_id,
                         p_state_id         => line_state_account_claim_fail,
                         p_tracking_comment => l_message,
                         p_stack_trace      => null);
        end if;
          -- Наповнення таблиці для квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2)
          insert_epp_line_bnk_state2(p_epp_line_id => l_id,
                                     p_state_id    => case l_state_id when 20 then l_state_id else line_state_account_claim_fail end,
                                     p_type_card   => l_card_type,
                                     p_comm        => l_message);
      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => sqlerrm || chr(10) ||dbms_utility.format_error_backtrace());

    end;

    procedure r_check_epp_state_procesing(p_file_data in clob,
                                 p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_clob     clob;
      l_epp_num  varchar2(12);
      l_state_id number;
      l_message  varchar2(4000);
    begin
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row       := dbms_xmldom.item(l_rows, i);
        l_epp_num   := to_number(dbms_xslprocessor.valueof(l_row, 'epp_num/text()'));
        l_state_id  := to_number(dbms_xslprocessor.valueof(l_row, 'state_id/text()'));

        update pfu_epp_line t
           set t.state_id = case l_state_id when 21 then 24
                                         when 22 then 25
                                         when 23 then 26 end
         where t.epp_number = l_epp_num
           and t.state_id != 3;
      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => sqlerrm || chr(10) ||dbms_utility.format_error_backtrace());

    end;

    procedure r_card_block_procesing(p_file_data in clob,
                                     p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_clob     clob;
      l_id       pfu_epp_line.id%type;
      l_kf       pfu_epp_line.bank_mfo%type;
      l_nls      pfu_epp_line.ACCOUNT_NUMBER%type;
      l_comm     pfu_epp_line.comm%type;
      l_date     date;
      l_isepp    integer;
    begin
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      select tu.kf into l_kf
        from pfu.transport_unit tu
       where tu.id = p_file_id;

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row     := dbms_xmldom.item(l_rows, i);
        l_isepp   := to_number(dbms_xslprocessor.valueof(l_row, 'isepp/text()'));
        if l_isepp = 0 then
          l_nls  := dbms_xslprocessor.valueof(l_row, 'nls/text()');
          l_date := to_date(dbms_xslprocessor.valueof(l_row, 'date_blk/text()'), 'dd.mm.yyyy');
          l_comm := to_number(dbms_xslprocessor.valueof(l_row, 'comm/text()'));
          update pfu.pfu_pensacc c
             set c.comm =l_comm,
                 c.date_blk = l_date
           where c.nls = l_nls
             and c.kf = l_kf;
        elsif l_isepp = 1 then
          l_id   := to_number(dbms_xslprocessor.valueof(l_row, 'id/text()'));
          l_date := to_date(dbms_xslprocessor.valueof(l_row, 'date_blk/text()'), 'dd.mm.yyyy');
          l_comm := to_number(dbms_xslprocessor.valueof(l_row, 'comm/text()'));
          update pfu.pfu_epp_line t
             set t.comm = l_comm,
                 t.block_date = l_date
           where t.id = l_id;
        end if;
      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => sqlerrm || chr(10) ||dbms_utility.format_error_backtrace());

    end;

    procedure r_card_unblock_procesing(p_file_data in clob,
                                       p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_clob     clob;
      l_id       pfu_epp_line.id%type;
      l_kf       pfu_epp_line.bank_mfo%type;
      l_nls      pfu_epp_line.ACCOUNT_NUMBER%type;
      l_comm     pfu_epp_line.comm%type;
      l_date     date;
      l_isepp    integer;
    begin
      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      select tu.kf into l_kf
        from pfu.transport_unit tu
       where tu.id = p_file_id;

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row     := dbms_xmldom.item(l_rows, i);
        l_isepp   := to_number(dbms_xslprocessor.valueof(l_row, 'isepp/text()'));
        if l_isepp = 0 then
          l_nls  := dbms_xslprocessor.valueof(l_row, 'nls/text()');
          l_date := to_date(dbms_xslprocessor.valueof(l_row, 'date_blk/text()'), 'dd.mm.yyyy');
          l_comm := to_number(dbms_xslprocessor.valueof(l_row, 'comm/text()'));
          update pfu.pfu_pensacc c
             set c.comm =l_comm,
                 c.date_blk = l_date
           where c.nls = l_nls
             and c.kf = l_kf;
        elsif l_isepp = 1 then
          l_id   := to_number(dbms_xslprocessor.valueof(l_row, 'id/text()'));
          l_date := to_date(dbms_xslprocessor.valueof(l_row, 'date_blk/text()'), 'dd.mm.yyyy');
          l_comm := to_number(dbms_xslprocessor.valueof(l_row, 'comm/text()'));
          update pfu.pfu_epp_line t
             set t.comm = l_comm,
                 t.block_date = l_date
           where t.id = l_id;
        end if;
      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.trans_state_done,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => sqlerrm || chr(10) ||dbms_utility.format_error_backtrace());

    end;

    procedure r_checkissuecard_procesing(p_file_data in clob,
                                         p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_clob     clob;
      l_id       number;
      l_state_id number;
      l_message  varchar2(4000);
      l_expdate  date;
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row      := dbms_xmldom.item(l_rows, i);
        l_id       := to_number(dbms_xslprocessor.valueof(l_row,
                                                          'id/text()'));
        l_state_id := to_number(dbms_xslprocessor.valueof(l_row,
                                                          'state_id/text()'));
        l_message  := dbms_xslprocessor.valueof(l_row,
                                                          'message/text()');
        l_expdate  := to_date(dbms_xslprocessor.valueof(l_row, 'epp_expired/text()'), 'dd.mm.yyyy');
        /*set_line_state(p_line_id          => l_id,
                       p_state_id         => case l_state_id
                                               when 30 then
                                                LINE_STATE_PERSONALIZED
                                               when 21 then
                                                LINE_STATE_PROCESSED_BY_CBS
                                               when 22 then
                                                LINE_STATE_DECLINED_BY_CBS
                                             end,
                       p_tracking_comment => l_message,
                       p_stack_trace      => null);*/
        update pfu_epp_line_bnk_state2 s
           set s.state_id = case l_state_id
                              when 101 then 20 -- відправляєм повторно запит якщо ще не оброблено
                              when 30 then LINE_STATE_PERSONALIZED     -- 11
                              when 21 then LINE_STATE_PROCESSED_BY_CBS -- 10
                              when 22 then LINE_STATE_DECLINED_BY_CBS  -- 9
                            end,
               s.comm = l_message,
               s.epp_expiry_date  = l_expdate,
               s.stage_ticket = 1 -- очікує формування pfu_result для квитанції 2
        where s.epp_line_id = l_id;
      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_DONE,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());
    end;

    procedure r_activateacc_procesing(p_file_data in clob,
                                      p_file_id   in number) is
      l_parser   dbms_xmlparser.parser;
      l_doc      dbms_xmldom.domdocument;
      l_rows     dbms_xmldom.domnodelist;
      l_row      dbms_xmldom.domnode;
      l_clob     clob;
      l_id       number;
      l_state_id number;
      l_message  varchar2(4000);
    begin

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_file_data);
      l_doc := dbms_xmlparser.getdocument(l_parser);

      l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
      for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
      loop

        l_row      := dbms_xmldom.item(l_rows, i);
        l_id       := to_number(dbms_xslprocessor.valueof(l_row,
                                                          'id/text()'));
        l_state_id := to_number(dbms_xslprocessor.valueof(l_row,
                                                          'state_id/text()'));
        l_message  := dbms_xslprocessor.valueof(l_row, 'message/text()');

        if l_state_id = 30 then
          set_epp_activate(l_id, l_message, sysdate, 1);
        else
          set_line_state(p_line_id          => l_id,
                       p_state_id         => LINE_STATE_ACTIVATION_FAILED,
                       p_tracking_comment => l_message,
                       p_stack_trace      => null);
        end if;
      end loop;
      transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_DONE,
                                        p_tracking_comment => 'Файл оброблено',
                                        p_stack_trace      => null);
      dbms_xmlparser.freeparser(l_parser);
      dbms_xmldom.freedocument(l_doc);
      exception
        when others then
            transport_utl.set_transport_state(p_id               => p_file_id,
                                        p_state_id         => transport_utl.TRANS_STATE_FAILED,
                                        p_tracking_comment => 'Ошибка обработки',
                                        p_stack_trace      => dbms_utility.format_error_backtrace());

    end;


/*
    procedure create_batch_lines(
        p_epp_lines in pfu_epp_utl.t_epp_lines)
    is
    begin
        if (p_epp_lines is null or p_epp_lines is empty) then
            return;
        end if;

        forall i in indices of p_epp_lines
               insert into pfu_epp_line
               values p_epp_lines(i);
    end;
*/
end;
/
 show err;
 
PROMPT *** Create  grants  PFU_EPP_UTL ***
grant EXECUTE                                                                on PFU_EPP_UTL     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/PFU/package/pfu_epp_utl.sql =========*** End *** 
 PROMPT ===================================================================================== 
 
