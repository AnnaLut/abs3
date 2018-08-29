
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/PFU/package/pfu_service_utl.sql =========*** Run 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE PFU.PFU_SERVICE_UTL is

    SESS_STATE_NEW                 constant integer := 1;
    SESS_STATE_SIGNED              constant integer := 7;
    SESS_STATE_SENT                constant integer := 2;
    SESS_STATE_RESPONDED           constant integer := 3;
    SESS_STATE_MALFORMED_RESPONSE  constant integer := 11;
    SESS_STATE_SIGN_VERIFIED       constant integer := 8;
    SESS_STATE_SIGN_FAILED         constant integer := 9;
    SESS_STATE_PROCESSED           constant integer := 4;
    SESS_STATE_PROCESSING_FAILED   constant integer := 10;
    SESS_STATE_FAILED              constant integer := 5;
    SESS_STATE_CANCELED            constant integer := 12;
    SESS_STATE_DATA_PART_RECEIVED  constant integer := 13;
  SESS_TYPE_REQ_ENVELOPE_LIST constant integer := 1;
  SESS_TYPE_REQ_ENVELOPE      constant integer := 2;
  SESS_TYPE_REQUEST_STATE     constant integer := 3;
  SESS_TYPE_GET_ENVELOPE_LIST constant integer := 4;
  SESS_TYPE_GET_ENVELOPE      constant integer := 5;
  -- SESS_TYPE_GET_ENVELOPE_PART    constant integer := 6;
  SESS_TYPE_REQ_EPP_BATCH_LIST constant integer := 7;
  SESS_TYPE_REQ_EPP_BATCH      constant integer := 8;
  SESS_TYPE_GET_EPP_BATCH_LIST constant integer := 9;
  SESS_TYPE_GET_EPP_BATCH      constant integer := 10;
  SESS_TYPE_REQ_MATCHING1      constant integer := 11;
  SESS_TYPE_REQ_EPP_MATCHING   constant integer := 12;
  SESS_TYPE_REQ_EPP_MATCHING2  constant integer := 28;
  SESS_TYPE_REQ_EPP_ACTIVATION constant integer := 13;
  SESS_TYPE_GET_EPP_MATCHING   constant integer := 14;
  SESS_TYPE_REQ_MATCHING2      constant integer := 15;
  SESS_TYPE_REQ_DEATH_LIST     constant integer := 16;
  SESS_TYPE_GET_DEATH_LIST     constant integer := 17;
  SESS_TYPE_REQ_DEATH          constant integer := 18;
  SESS_TYPE_GET_DEATH          constant integer := 19;
  SESS_TYPE_REQ_DEATH_MATCHING constant integer := 20;
  SESS_TYPE_REQ_NO_TURNOVER    constant integer := 27;
  SESS_TYPE_REQ_VERIFY_LIST    constant integer := 21;
  SESS_TYPE_GET_VERIFY_LIST    constant integer := 23;
  SESS_TYPE_REQ_CHANGE_ATTR    constant integer := 25;
  SESS_TYPE_GET_CHANGE_ATTR    constant integer := 26;


    REQ_STATE_ACCEPTED             constant char(1 byte) := 'R';
    REQ_STATE_PREPARED             constant char(1 byte) := 'S';
    REQ_STATE_CANCELED             constant char(1 byte) := 'D';

    type cm_error_rec is record
    (
        id                 integer,
        datemod            date,
        oper_type          integer,
        oper_status        integer,
        resp_txt           varchar2(1000),
        branch             varchar2(30),
        opendate           date,
        clienttype         integer,
        taxpayeridentifier varchar2(10),
        firstname          varchar2(105),
        lastname           varchar2(105),
        middlename         varchar2(105),
        engfirstname       varchar2(64),
        englastname        varchar2(64),
        country            varchar2(3),
        work               varchar2(254),
        office             varchar2(32),
        birthdate          date,
        birthplace         varchar2(1024),
        gender             varchar2(1),
        typedoc            integer,
        paspnum            varchar2(16),
        paspseries         varchar2(16),
        paspdate           date,
        paspissuer         varchar2(128),
        contractnumber     varchar2(19),
        productcode        varchar2(32),
        card_type          varchar2(36),
        regnumberclient    varchar2(32),
        regnumberowner     varchar2(32),
        card_br_iss        varchar2(30)
    );

    type job_rec is record
    (
     JOB_NAME           all_scheduler_jobs.job_name%type,
     COMMENTS           all_scheduler_jobs.comments%type,
     STATE              all_scheduler_jobs.STATE%type,
     LAST_START_DATE    all_scheduler_jobs.last_start_date%type,
     LAST_RUN_DURATION  all_scheduler_jobs.LAST_RUN_DURATION%type,
     NEXT_RUN_DATE      all_scheduler_jobs.next_run_date%type,
     RUN_STATUS         all_scheduler_job_run_details.STATUS%type,
     ADD_INFO           all_scheduler_job_run_details.ADDITIONAL_INFO%type
    );
  type T_CM_ERROR is table of CM_ERROR_REC;
  type T_JOB_INFO is table of job_rec;
  type T_EPP_LINE_TAB is table of pfu_epp_line%rowtype index by binary_integer;

  type epp_num_t is table of integer index by binary_integer;

  function read_session(p_session_id in integer,
                        p_lock       in boolean default false,
                        p_raise_ndf  in boolean default true)
    return pfu_session%rowtype;

  function read_session_type(p_session_type_id in integer,
                             p_raise_ndf       in boolean default true)
    return pfu_session_type%rowtype;

  function add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2)
     return dbms_xmldom.DOMNode;

  procedure add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                              p_host_node in out nocopy dbms_xmldom.DOMNode,
                              p_node_name in varchar2,
                              p_node_text in varchar2);

  function get_session_type_name(p_session_type_id in integer)
    return varchar2;

  function get_session_ws_action(p_session_type_id in integer)
    return varchar2;

  procedure gather_death_parts(p_request_id in integer);

  procedure gen_matching1(p_env_id in integer, p_ecp varchar2);

  procedure regen_matching1(p_env_id in integer);

  procedure gen_matching2(p_file_id in integer, p_ecp in varchar2);

  procedure gen_epp_kvt2;

  procedure gen_no_turnover(p_nt_id in integer,
                            p_mfo   in varchar2,
                            p_ecp   in varchar2);

  procedure gen_death_matching(p_death_id in integer, p_ecp in varchar2);

  procedure gen_epp_matching1(p_batch_id in integer);

  procedure process_w4_statuses;

  procedure prepare_new_claims;

  procedure prepare_pensioner_claim(p_kf in pfu_syncru_params.kf%type);

  procedure prepare_pensioner_claim;

  procedure prepare_acc_rest(p_acc    in pfu_acc_trans_2909.acc_num%type,
                             p_fileid in pfu_file.id%type,
                             p_kf     in pfu_acc_trans_2909.kf%type);

  procedure prepare_cardkill_claim;

  procedure prepare_set_destruct(p_epp_number pfu_epp_line.epp_number%type,
                                       p_mfo        pfu_epp_line.bank_mfo%type);

  procedure prepare_cm_error_claim(p_kf in pfu_syncru_params.kf%type);

  procedure prepare_paym_back(p_death_id in pfu_death_record.id%type);

  procedure prepare_restart_epp;

  procedure prepare_report_claim(p_kf   in pfu_syncru_params.kf%type,
                                 p_date in date);

  procedure prepare_branch_claim(p_kf in pfu_syncru_params.kf%type);

  function get_xml_cm_epp(p_id in transport_unit.id%type) return T_CM_ERROR
    pipelined;

  procedure send_request(p_id_sess pfu_session.id%type);

  procedure send_requests;

  procedure parse_fio(p_fio       in varchar2,
                      p_lastname  out varchar2,
                      p_firstname out varchar2,
                      p_surname   out varchar2);

  procedure set_session_request(p_session_id   in integer,
                                p_request_data in clob);

  procedure set_session_response(p_session_id    in integer,
                                 p_response_data in clob);

  procedure set_session_response_xml_data(p_session_id        in integer,
                                          p_response_xml_data in clob);

  procedure set_session_failure(p_session_id    in integer,
                                p_error_message in varchar2,
                                p_error_stack   in clob);

  procedure set_session_sign_failure(p_session_id    in integer,
                                     p_error_message in varchar2,
                                     p_stack_trace   in clob);

  procedure set_pfu_request_id(p_session_id     in integer,
                               p_pfu_request_id in integer);

  procedure set_request_status_answer(p_session_id     in integer,
                                      p_request_status in varchar2,
                                      p_request_parts  in integer);

  procedure create_envelope(p_session_id           in integer,
                            p_pfu_envelope_id      in integer,
                            p_pfu_branch_code      in varchar2,
                            p_pfu_branch_name      in varchar2,
                            p_register_date        in varchar2,
                            p_receiver_mfo         in varchar2,
                            p_receiver_branch      in varchar2,
                            p_receiver_name        in varchar2,
                            p_envelope_full_sum    in number,
                            p_envelope_lines_count in integer);

  procedure create_file(p_request_id        in integer,
                        p_branch_number     in varchar2,
                        p_file_branch_sum   in number,
                        p_file_lines_count  in integer,
                        p_file_payment_date in varchar2,
                        p_file_number       in integer,
                        p_file_name         in varchar2,
                        p_file_data         in blob);
  /*
   procedure create_file(p_request_id        in integer,
                         p_branch_number     in varchar2,
                         p_file_branch_sum   in number,
                         p_file_lines_count  in integer,
                         p_file_payment_date in varchar2,
                         p_file_number       in integer,
                         p_file_name         in varchar2,
                         p_file_data         in blob,
                         p_file_id           out integer);
  */
  function create_file(p_request_id        in integer,
                       p_branch_number     in varchar2,
                       p_file_branch_sum   in number,
                       p_file_lines_count  in integer,
                       p_file_payment_date in varchar2,
                       p_file_number       in integer,
                       p_file_name         in varchar2,
                       p_file_data         in blob) return integer;

  procedure set_paybach_attr(p_id_rec      in pfu_file_records.id%type,
                             p_dateback    in date,
                             p_numpay_back in pfu_file_records.num_paym%type);

  procedure send_data_to_bank_units;

  function prepare_matching1(p_env_id   in integer,
                             p_enc_type in number default 0) return clob;

  function prepare_matching2(p_file_id  in integer,
                             p_enc_type in number default 0) return clob;

  -----------------------------------------------------------------------------------------
  --  prepare_epp_kvt2
  --
  --    Створення файлу квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2) - insert pfu_matching_request2, state = 'NEW'
  --
  procedure prepare_epp_kvt2;
  -----------------------------------------------------------------------------------------
  --  prepare_epp_kvt2_result
  --
  --    Оновлення результатів опрацювання кожного запису файлу для квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2) - update pfu_epp_line_bnk_state2 pfu_result, res_teg
  --
  procedure prepare_epp_kvt2_result;


  function prepare_no_turnover(p_nt_id    in integer,
                               p_mfo      in varchar2,
                               p_enc_type in number default 0) return clob;

  function prepare_death_matching(p_death_id in integer,
                                  p_enc_type in number default 0) return clob;

  procedure validate_epp_lines(p_request_id in integer);

  procedure gen_epp_matching2;

  procedure prepare_check_state;
  -- підготовка запиту на перевірку станів оплати референсів по ЕБП

  -- обробка декриптованих сесій
  procedure process_response;

  procedure gather_epp_batch_list_parts(p_request_id in integer);

  procedure gather_epp_batch_parts(p_request_id in integer);

  procedure process_receipt;

  function get_job_info return t_job_info
    pipelined;
  procedure start_job(p_job_name in varchar2);
  procedure stop_job(p_job_name in varchar2);
  procedure disable_job(p_job_name in varchar2);
	procedure enable_job(p_job_name in varchar2);

	procedure process_pfu_stage;
	procedure process_claim_stage;
	procedure process_transport_stage;
	procedure process_transport_ebp_stage;
  procedure process_transport_lock_stage;

	procedure process_all_stages;
  procedure prepare_checkissuecard;
end;
/
CREATE OR REPLACE PACKAGE BODY PFU.PFU_SERVICE_UTL as

  function extract_clob(p_xml     in xmltype,
                        p_xpath   in varchar2,
                        p_default in varchar2) return clob is
  begin
    return p_xml.extract(p_xpath).getClobVal();
  exception
    when others then
      if sqlcode = -30625 then
        return p_default;
      else
        raise;
      end if;
  end extract_clob;

  function extract_str(p_xml     in xmltype,
                       p_xpath   in varchar2,
                       p_default in varchar2) return varchar2 is
  begin
    return p_xml.extract(p_xpath).getStringVal();
  exception
    when others then
      if sqlcode = -30625 then
        return p_default;
      else
        raise;
      end if;
  end extract_str;

  function read_session(p_session_id in integer,
                        p_lock       in boolean default false,
                        p_raise_ndf  in boolean default true)
    return pfu_session%rowtype is
    l_session_row pfu_session%rowtype;
  begin
    if (p_lock) then
      select *
        into l_session_row
        from pfu_session t
       where t.id = p_session_id
         for update;
    else
      select *
        into l_session_row
        from pfu_session t
       where t.id = p_session_id;
    end if;

    return l_session_row;
  exception
    when no_data_found then
      if (p_raise_ndf) then
        raise_application_error(-20000,
                                'Сесія з ідентифікатором {' || p_session_id ||
                                '} не знайдена');
      else
        return null;
      end if;
  end;

  function read_session_type(p_session_type_id in integer,
                             p_raise_ndf       in boolean default true)
    return pfu_session_type%rowtype is
    l_session_type_row pfu_session_type%rowtype;
  begin
    select *
      into l_session_type_row
      from pfu_session_type t
     where t.id = p_session_type_id;

    return l_session_type_row;
  exception
    when no_data_found then
      if (p_raise_ndf) then
        raise_application_error(-20000,
                                'Тип сесії з ідентифікатором {' ||
                                p_session_type_id || '} не знайдений');
      else
        return null;
      end if;
  end;

  function read_session_state(p_session_state_id in integer,
                              p_raise_ndf        in boolean default true)
    return pfu_session_state%rowtype is
    l_session_state_row pfu_session_state%rowtype;
  begin
    select *
      into l_session_state_row
      from pfu_session_state t
     where t.id = p_session_state_id;

    return l_session_state_row;
  exception
    when no_data_found then
      if (p_raise_ndf) then
        raise_application_error(-20000,
                                'Стан сесії з ідентифікатором {' ||
                                p_session_state_id || '} не знайдений');
      else
        return null;
      end if;
  end;

  function read_session_state(p_session_state_code in varchar2,
                              p_raise_ndf          in boolean default true)
    return pfu_session_state%rowtype is
    l_session_state_row pfu_session_state%rowtype;
  begin
    select *
      into l_session_state_row
      from pfu_session_state t
     where t.state_code = p_session_state_code;

    return l_session_state_row;
  exception
    when no_data_found then
      if (p_raise_ndf) then
        raise_application_error(-20000,
                                'Стан сесії з ідентифікатором {' ||
                                p_session_state_code || '} не знайдений');
      else
        return null;
      end if;
  end;

  function get_session_type_code(p_session_type_id in integer)
    return varchar2 is
  begin
    return read_session_type(p_session_type_id, p_raise_ndf => false).session_type_code;
  end;

  function get_session_type_name(p_session_type_id in integer)
    return varchar2 is
  begin
    return read_session_type(p_session_type_id, p_raise_ndf => false).session_type_name;
  end;

  function get_session_ws_action(p_session_type_id in integer)
    return varchar2 is
  begin
    return read_session_type(p_session_type_id, p_raise_ndf => false).ws_action_code;
  end;

  function get_session_state_id(p_session_type_code in varchar2)
    return integer is
  begin
    return read_session_state(p_session_type_code, p_raise_ndf => false).id;
  end;

  function get_session_state_code(p_session_type_id in integer)
    return varchar2 is
  begin
    return read_session_state(p_session_type_id, p_raise_ndf => false).state_code;
  end;

  function get_session_state_name(p_session_type_id in integer)
    return varchar2 is
  begin
    return read_session_state(p_session_type_id, p_raise_ndf => false).state_name;
  end;

  procedure track_session(p_session_id       in integer,
                          p_state            in varchar2,
                          p_tracking_comment in varchar2,
                          p_stack_trace      in clob default null) is
  begin
    insert into pfu_session_tracking
    values
      (pfu_session_tracking_seq.nextval,
       p_session_id,
       p_state,
       sysdate,
       substrb(p_tracking_comment, 1, 4000),
       p_stack_trace);
  end;

  function prepare_request_xml(p_session_type in varchar2,
                               p_request_id   in integer,
                               p_part_num     in integer default null)
    return clob is
    l_request_row               pfu_request%rowtype;
    l_envelope_list_request_row pfu_envelope_list_request%rowtype;
    l_envelope_request_row      pfu_envelope_request%rowtype;

    l_xml     clob;
    l_xml_row clob;
  begin
    -- l_xml := '<?xml version="1.0" encoding="utf-8"?>';
    l_xml := '';

    l_request_row := pfu_utl.read_request(p_request_id);

    case
      when p_session_type = pfu_service_utl.SESS_TYPE_REQ_ENVELOPE_LIST then
        -- запит на список конвертів
        l_envelope_list_request_row := pfu_utl.read_envelope_list_request(p_request_id);

        select XMLELEMENT("filter", XMLELEMENT("start_date", to_char(l_envelope_list_request_row.date_from, 'ddmmyyyy')), XMLELEMENT("end_date", to_char(l_envelope_list_request_row.date_to, 'ddmmyyyy')), XMLELEMENT("opfu_code", l_envelope_list_request_row.opfu_code))
               .getclobval()
          into l_xml_row
          from dual;

      when p_session_type = pfu_service_utl.SESS_TYPE_REQ_EPP_BATCH_LIST then
        -- запит на список конвертів

        select XMLELEMENT("filter", XMLELEMENT("start_date", to_char(date_from, 'ddmmyyyy')), XMLELEMENT("end_date", to_char(date_to, 'ddmmyyyy')))
               .getclobval()
          into l_xml_row
          from pfu_epp_batch_list_request t
         where t.id = l_request_row.id;

      when p_session_type = pfu_service_utl.SESS_TYPE_REQ_ENVELOPE then
        -- запит на отримання конверту
        l_envelope_request_row := pfu_utl.read_envelope_request(p_request_id);

        select XMLELEMENT("filter", XMLELEMENT("id", l_envelope_request_row.pfu_envelope_id))
               .getclobval()
          into l_xml_row
          from dual;

      when p_session_type = pfu_service_utl.SESS_TYPE_REQUEST_STATE then
        -- запит на отримання статусу запиту

        select XMLELEMENT("filter", XMLELEMENT("id", l_request_row.pfu_request_id))
               .getclobval()
          into l_xml_row
          from dual;

      when p_session_type = pfu_service_utl.SESS_TYPE_GET_ENVELOPE_LIST then
        -- запит на отримання списку конвертів
        -- складається тільки з однієї частини (? а якщо більше 1)

        select XMLELEMENT("filter", XMLELEMENT("id", l_request_row.pfu_request_id), XMLELEMENT("part", 1))
               .getclobval()
          into l_xml_row
          from dual;

      when p_session_type in (pfu_service_utl.SESS_TYPE_GET_ENVELOPE) then
        -- запит на отримання конвертів або їх частин

        select XMLELEMENT("filter", XMLELEMENT("id", l_request_row.pfu_request_id), XMLELEMENT("part", p_part_num))
               .getclobval()
          into l_xml_row
          from dual;
      else
        null;
    end case;

    l_xml := l_xml || l_xml_row;

    return l_xml;
  end prepare_request_xml;

  -- отбор операций для квитовки
  function get_xml_cm_epp(p_id in transport_unit.id%type) return T_CM_ERROR
    pipelined as
    l_clob         clob;
    l_blob         blob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_parser       dbms_xmlparser.parser;
    l_doc          dbms_xmldom.domdocument;
    l_rows         dbms_xmldom.domnodelist;
    l_row          dbms_xmldom.domnode;
    l_rec_cm_err   CM_ERROR_REC;
  begin
    select tu.response_data
      into l_blob
      from transport_unit tu
     where tu.id = p_id;

    l_blob := utl_compress.lz_uncompress(l_blob);

    l_clob := pfu_utl.blob_to_clob(l_blob);

    /*       dbms_lob.converttoclob(dest_lob     => l_clob,
    src_blob     => l_blob,
    amount       => dbms_lob.lobmaxsize,
    dest_offset  => l_dest_offset,
    src_offset   => l_src_offset,
    blob_csid    => l_blob_csid,
    lang_context => l_lang_context,
    warning      => l_warning);*/

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop

      l_row                           := dbms_xmldom.item(l_rows, i);
      l_rec_cm_err.id                 := to_number(dbms_xslprocessor.valueof(l_row,
                                                                             'id/text()'));
      l_rec_cm_err.DATEMOD            := to_date(dbms_xslprocessor.valueof(l_row,
                                                                           'datemod/text()'),
                                                 'dd.mm.yyyy');
      l_rec_cm_err.OPER_TYPE          := to_number(dbms_xslprocessor.valueof(l_row,
                                                                             'oper_type/text()'));
      l_rec_cm_err.OPER_STATUS        := to_number(dbms_xslprocessor.valueof(l_row,
                                                                             'oper_status/text()'));
      l_rec_cm_err.RESP_TXT           := dbms_xslprocessor.valueof(l_row,
                                                                   'resp_txt/text()');
      l_rec_cm_err.BRANCH             := dbms_xslprocessor.valueof(l_row,
                                                                   'branch/text()');
      l_rec_cm_err.OPENDATE           := to_date(dbms_xslprocessor.valueof(l_row,
                                                                           'opendate/text()'),
                                                 'dd.mm.yyyy');
      l_rec_cm_err.CLIENTTYPE         := to_number(dbms_xslprocessor.valueof(l_row,
                                                                             'clienttype/text()'));
      l_rec_cm_err.TAXPAYERIDENTIFIER := dbms_xslprocessor.valueof(l_row,
                                                                   'taxpayeridentifier/text()');
      l_rec_cm_err.FIRSTNAME          := dbms_xslprocessor.valueof(l_row,
                                                                   'firstname/text()');
      l_rec_cm_err.LASTNAME           := dbms_xslprocessor.valueof(l_row,
                                                                   'lastname/text()');
      l_rec_cm_err.MIDDLENAME         := dbms_xslprocessor.valueof(l_row,
                                                                   'middlename/text()');
      l_rec_cm_err.ENGFIRSTNAME       := dbms_xslprocessor.valueof(l_row,
                                                                   'engfirstname/text()');
      l_rec_cm_err.ENGLASTNAME        := dbms_xslprocessor.valueof(l_row,
                                                                   'englastname/text()');
      l_rec_cm_err.COUNTRY            := dbms_xslprocessor.valueof(l_row,
                                                                   'country/text()');
      l_rec_cm_err.WORK               := dbms_xslprocessor.valueof(l_row,
                                                                   'work/text()');
      l_rec_cm_err.OFFICE             := dbms_xslprocessor.valueof(l_row,
                                                                   'office/text()');
      l_rec_cm_err.BIRTHDATE          := to_date(dbms_xslprocessor.valueof(l_row,
                                                                           'birthdate/text()'),
                                                 'dd.mm.yyyy');
      l_rec_cm_err.BIRTHPLACE         := dbms_xslprocessor.valueof(l_row,
                                                                   'birthplace/text()');
      l_rec_cm_err.GENDER             := dbms_xslprocessor.valueof(l_row,
                                                                   'gender/text()');
      l_rec_cm_err.TYPEDOC            := to_number(dbms_xslprocessor.valueof(l_row,
                                                                             'typedoc/text()'));
      l_rec_cm_err.PASPNUM            := dbms_xslprocessor.valueof(l_row,
                                                                   'paspnum/text()');
      l_rec_cm_err.PASPSERIES         := dbms_xslprocessor.valueof(l_row,
                                                                   'paspseries/text()');
      l_rec_cm_err.PASPDATE           := to_date(dbms_xslprocessor.valueof(l_row,
                                                                           'paspdate/text()'),
                                                 'dd.mm.yyyy');
      l_rec_cm_err.PASPISSUER         := dbms_xslprocessor.valueof(l_row,
                                                                   'paspissuer/text()');
      l_rec_cm_err.CONTRACTNUMBER     := dbms_xslprocessor.valueof(l_row,
                                                                   'contractnumber/text()');
      l_rec_cm_err.PRODUCTCODE        := dbms_xslprocessor.valueof(l_row,
                                                                   'productcode/text()');
      l_rec_cm_err.CARD_TYPE          := dbms_xslprocessor.valueof(l_row,
                                                                   'card_type/text()');
      l_rec_cm_err.REGNUMBERCLIENT    := dbms_xslprocessor.valueof(l_row,
                                                                   'regnumberclient/text()');
      l_rec_cm_err.REGNUMBEROWNER     := dbms_xslprocessor.valueof(l_row,
                                                                   'regnumberowner/text()');
      l_rec_cm_err.CARD_BR_ISS        := dbms_xslprocessor.valueof(l_row,
                                                                   'card_br_iss/text()');
      pipe row(l_rec_cm_err);
    end loop;

  end;

  function add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node in out nocopy dbms_xmldom.DOMNode,
                             p_node_name in varchar2,
                             p_node_text in varchar2)
    return dbms_xmldom.DOMNode is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := dbms_xmldom.appendChild(p_host_node,
                                      dbms_xmldom.makeNode(dbms_xmldom.createElement(p_document,
                                                                                     p_node_name)));
    l_node := dbms_xmldom.appendChild(l_node,
                                      dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_document,
                                                                                      p_node_text)));

    return l_node;
  end;

  function add_clob_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                             p_host_node      in out nocopy dbms_xmldom.DOMNode,
                             p_node_name      in varchar2,
                             p_node_text_clob in clob)
    return dbms_xmldom.DOMNode is
    l_node      dbms_xmldom.DOMNode;
    l_textclob  clob := p_node_text_clob;
    l_node_text clob := '';
    l_domnode   xmldom.DOMNode;
    l_count     integer;
  begin
    l_node    := dbms_xmldom.appendChild(p_host_node,
                                         dbms_xmldom.makeNode(dbms_xmldom.createElement(p_document,
                                                                                        p_node_name)));
    l_domnode := dbms_xmldom.makeNode(dbms_xmldom.createTextNode(p_document,
                                                                 l_node_text));
    l_node    := dbms_xmldom.appendChild(l_node, l_domnode);
    loop
      l_count     := dbms_lob.getlength(l_textclob);
      l_node_text := substr(l_textclob, 1, 32767);
      l_textclob  := substr(l_textclob, 32768, l_count - 32767);
      xmldom.appendData(xmldom.makeCharacterData(l_domnode), l_node_text);
      EXIT WHEN l_count < 32767 or l_count is null;
    end loop;
    return l_node;
  end;

  procedure add_text_node_utl(p_document  in out nocopy dbms_xmldom.DOMDocument,
                              p_host_node in out nocopy dbms_xmldom.DOMNode,
                              p_node_name in varchar2,
                              p_node_text in varchar2) is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := add_text_node_utl(p_document,
                                p_host_node,
                                p_node_name,
                                p_node_text);
  end;

  procedure add_clob_node_utl(p_document       in out nocopy dbms_xmldom.DOMDocument,
                              p_host_node      in out nocopy dbms_xmldom.DOMNode,
                              p_node_name      in varchar2,
                              p_node_text_clob in clob) is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := add_clob_node_utl(p_document,
                                p_host_node,
                                p_node_name,
                                p_node_text_clob);
  end;

  function get_node_value(p_document in out nocopy dbms_xmldom.DOMDocument,
                          p_xpath    in varchar2) return varchar2 is
    l_node dbms_xmldom.DOMNode;
  begin
    l_node := dbms_xmldom.makenode(p_document);

    return dbms_xslprocessor.valueof(l_node, p_xpath);
  end;

  function create_session(p_session_type_id  in integer,
                          p_request_id       in integer,
                          p_request_xml_data in clob) return integer is
    l_session_id integer;
  begin
    insert into pfu_session
    values
      (pfu_session_seq.nextval,
       p_session_type_id,
       p_request_id,
       null,
       null,
       p_request_xml_data,
       null,
       pfu_service_utl.SESS_STATE_NEW,
       0)
    returning id into l_session_id;

    track_session(l_session_id,
                  pfu_service_utl.SESS_STATE_NEW,
                  'Звернення до сервісу ПФУ з типом (' ||
                  get_session_type_code(p_session_type_id) ||
                  ') зареєстроване');

    return l_session_id;
  end;

  function gen_session_req_envelope_list(p_request_id in integer)
    return integer is
    l_request_row               pfu_request%rowtype;
    l_envelope_list_request_row pfu_envelope_list_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row               := pfu_utl.read_request(p_request_id,
                                                        p_lock => true);
    l_envelope_list_request_row := pfu_utl.read_envelope_list_request(l_request_row.id);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'start_date',
                      to_char(l_envelope_list_request_row.date_from,
                              'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_filter_node,
                      'end_date',
                      to_char(l_envelope_list_request_row.date_to,
                              'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_filter_node,
                      'opfu_code',
                      l_envelope_list_request_row.opfu_code);

    return create_session(pfu_service_utl.SESS_TYPE_REQ_ENVELOPE_LIST,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_req_death_list(p_request_id in integer) return integer is
    l_request_row            pfu_request%rowtype;
    l_death_list_request_row pfu_death_list_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row            := pfu_utl.read_request(p_request_id,
                                                     p_lock => true);
    l_death_list_request_row := pfu_utl.read_death_list_request(l_request_row.id);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'start_date',
                      to_char(l_death_list_request_row.date_from,
                              'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_filter_node,
                      'end_date',
                      to_char(l_death_list_request_row.date_to, 'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_filter_node,
                      'opfu_code',
                      l_death_list_request_row.opfu_code);

    return create_session(pfu_service_utl.SESS_TYPE_REQ_DEATH_LIST,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_req_verify_list(p_request_id in integer)
    return integer is
    l_request_row            pfu_request%rowtype;
    l_death_list_request_row pfu_verification_list_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row            := pfu_utl.read_request(p_request_id,
                                                     p_lock => true);
    l_death_list_request_row := pfu_utl.read_verify_list_request(l_request_row.id);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'start_date',
                      to_char(l_death_list_request_row.date_from,
                              'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_filter_node,
                      'end_date',
                      to_char(l_death_list_request_row.date_to, 'ddmmyyyy'));

    return create_session(pfu_service_utl.SESS_TYPE_REQ_VERIFY_LIST,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_req_epp_batch_list(p_request_id in integer)
    return integer is
    l_request_row                pfu_request%rowtype;
    l_epp_batch_list_request_row pfu_epp_batch_list_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row                := pfu_utl.read_request(p_request_id,
                                                         p_lock => true);
    l_epp_batch_list_request_row := pfu_epp_utl.read_epp_batch_list_request(l_request_row.id);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'start_date',
                      to_char(l_epp_batch_list_request_row.date_from,
                              'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_filter_node,
                      'end_date',
                      to_char(l_epp_batch_list_request_row.date_to,
                              'ddmmyyyy'));

    return create_session(pfu_service_utl.SESS_TYPE_REQ_EPP_BATCH_LIST,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_req_envelope(p_request_id in integer) return integer is
    l_request_row          pfu_request%rowtype;
    l_envelope_request_row pfu_envelope_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row          := pfu_utl.read_request(p_request_id,
                                                   p_lock => true);
    l_envelope_request_row := pfu_utl.read_envelope_request(l_request_row.id);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_envelope_request_row.pfu_envelope_id);

    return create_session(pfu_service_utl.SESS_TYPE_REQ_ENVELOPE,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_req_death(p_request_id in integer) return integer is
    l_request_row       pfu_request%rowtype;
    l_death_request_row pfu_death_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row       := pfu_utl.read_request(p_request_id,
                                                p_lock => true);
    l_death_request_row := pfu_utl.read_death_request(l_request_row.id);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_death_request_row.pfu_death_id);

    return create_session(pfu_service_utl.SESS_TYPE_REQ_DEATH,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_req_matching1(p_request_id in integer) return integer is
    l_xml_clob clob;
  begin
    select pmr.pfu_matching_xml
      into l_xml_clob
      from pfu_matching_request pmr
     where pmr.id = p_request_id;
    return create_session(pfu_service_utl.SESS_TYPE_REQ_MATCHING1,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_matching2(p_request_id in integer) return integer is
    l_xml_clob clob;
  begin
    select pmr.pfu_matching_xml
      into l_xml_clob
      from pfu_matching_request pmr
     where pmr.id = p_request_id;
    return create_session(pfu_service_utl.SESS_TYPE_REQ_MATCHING2,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_death_matching(p_request_id in integer)
    return integer is
    l_xml_clob clob;
  begin
    select pmr.pfu_matching_xml
      into l_xml_clob
      from pfu_matching_request pmr
     where pmr.id = p_request_id;
    return create_session(pfu_service_utl.SESS_TYPE_REQ_DEATH_MATCHING,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_no_turnover(p_request_id in integer)
    return integer is
    l_xml_clob clob;
  begin
    select pmr.pfu_xml
      into l_xml_clob
      from pfu_no_turnover_request pmr
     where pmr.id = p_request_id;
    return create_session(pfu_service_utl.SESS_TYPE_REQ_NO_TURNOVER,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_replacement(p_request_id in integer)
    return integer is
    l_xml_clob clob;
  begin
    select prr.pfu_replacement_xml
      into l_xml_clob
      from pfu_replacement_request prr
     where prr.id = p_request_id;
    return create_session(pfu_service_utl.SESS_TYPE_REQ_CHANGE_ATTR,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_epp_matching(p_request_id in integer)
    return integer is
    l_xml_clob clob;
  begin
    select pmr.pfu_matching_xml
      into l_xml_clob
      from pfu_matching_request pmr
     where pmr.id = p_request_id;
    return create_session(pfu_service_utl.SESS_TYPE_REQ_EPP_MATCHING,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_epp_matching2(p_request_id in integer)
    return integer is
    l_xml_clob clob;
  begin
    select pmr.pfu_matching_xml
      into l_xml_clob
      from pfu_matching_request pmr
     where pmr.id = p_request_id;
    return create_session(pfu_service_utl.SESS_TYPE_REQ_EPP_MATCHING2,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_epp_activation(p_request_id in integer)
    return integer is
    l_xml_clob clob;
  begin
    select pmr.pfu_matching_xml
      into l_xml_clob
      from pfu_matching_request pmr
     where pmr.id = p_request_id;

    return create_session(pfu_service_utl.SESS_TYPE_REQ_EPP_ACTIVATION,
                          p_request_id,
                          l_xml_clob);
  end;

  function gen_session_req_epp_batch(p_request_id in integer) return integer is
    l_request_row           pfu_request%rowtype;
    l_epp_batch_request_row pfu_epp_batch_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row           := pfu_utl.read_request(p_request_id,
                                                    p_lock => true);
    l_epp_batch_request_row := pfu_epp_utl.read_epp_batch_request(l_request_row.id);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_epp_batch_request_row.pfu_batch_id);

    return create_session(pfu_service_utl.SESS_TYPE_REQ_EPP_BATCH,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_ask_request_state(p_request_id in integer)
    return integer is
    l_request_row pfu_request%rowtype;
    l_request_xml clob;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);

    l_request_xml := dbms_xmldom.getXmlType(l_doc).getClobVal();

    return create_session(pfu_service_utl.SESS_TYPE_REQUEST_STATE,
                          p_request_id,
                          l_request_xml);
  end;

  function gen_session_get_envelope_list(p_request_id  in integer,
                                         p_part_number in integer)
    return integer is
    l_request_row pfu_request%rowtype;
    l_request_xml clob;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    -- список конвертів очікується тільки з однієї частини
    -- (todo : переробити на універсальний механізм отримання+збору даних по частинах)
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    l_request_xml := dbms_xmldom.getXmlType(l_doc).getClobVal();

    return create_session(pfu_service_utl.SESS_TYPE_GET_ENVELOPE_LIST,
                          p_request_id,
                          l_request_xml);
  end;

  function gen_session_get_death_list(p_request_id  in integer,
                                      p_part_number in integer)
    return integer is
    l_request_row pfu_request%rowtype;
    l_request_xml clob;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    -- список конвертів очікується тільки з однієї частини
    -- (todo : переробити на універсальний механізм отримання+збору даних по частинах)
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    l_request_xml := dbms_xmldom.getXmlType(l_doc).getClobVal();

    return create_session(pfu_service_utl.SESS_TYPE_GET_DEATH_LIST,
                          p_request_id,
                          l_request_xml);
  end;

  function gen_session_get_verify_list(p_request_id  in integer,
                                       p_part_number in integer)
    return integer is
    l_request_row pfu_request%rowtype;
    l_request_xml clob;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    -- список конвертів очікується тільки з однієї частини
    -- (todo : переробити на універсальний механізм отримання+збору даних по частинах)
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    l_request_xml := dbms_xmldom.getXmlType(l_doc).getClobVal();

    return create_session(pfu_service_utl.SESS_TYPE_GET_VERIFY_LIST,
                          p_request_id,
                          l_request_xml);
  end;

  function gen_session_get_replacement(p_request_id  in integer,
                                       p_part_number in integer)
    return integer is
    l_request_row pfu_request%rowtype;
    l_request_xml clob;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    -- список конвертів очікується тільки з однієї частини
    -- (todo : переробити на універсальний механізм отримання+збору даних по частинах)
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    l_request_xml := dbms_xmldom.getXmlType(l_doc).getClobVal();

    return create_session(pfu_service_utl.SESS_TYPE_GET_CHANGE_ATTR,
                          p_request_id,
                          l_request_xml);
  end;

  function gen_session_get_envelope(p_request_id  in integer,
                                    p_part_number in integer) return integer is
    l_request_row pfu_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    return create_session(pfu_service_utl.SESS_TYPE_GET_ENVELOPE,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_get_death(p_request_id  in integer,
                                 p_part_number in integer) return integer is
    l_request_row pfu_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    return create_session(pfu_service_utl.SESS_TYPE_GET_DEATH,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_get_epp_batch_list(p_request_id  in integer,
                                          p_part_number in integer)
    return integer is
    l_request_row pfu_request%rowtype;
    l_request_xml clob;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    l_request_xml := dbms_xmldom.getXmlType(l_doc).getClobVal();

    return create_session(pfu_service_utl.SESS_TYPE_GET_EPP_BATCH_LIST,
                          p_request_id,
                          l_request_xml);
  end;

  function gen_session_get_epp_batch(p_request_id  in integer,
                                     p_part_number in integer) return integer is
    l_request_row pfu_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    return create_session(pfu_service_utl.SESS_TYPE_GET_EPP_BATCH,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  function gen_session_get_epp_match_resp(p_request_id  in integer,
                                          p_part_number in integer)
    return integer is
    l_request_row pfu_request%rowtype;

    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_filter_node dbms_xmldom.DOMNode;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_doc         := dbms_xmldom.newDomDocument;
    l_root_node   := dbms_xmldom.makeNode(l_doc);
    l_filter_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'filter')));

    add_text_node_utl(l_doc,
                      l_filter_node,
                      'id',
                      l_request_row.pfu_request_id);
    add_text_node_utl(l_doc, l_filter_node, 'part', p_part_number);

    return create_session(pfu_service_utl.SESS_TYPE_GET_EPP_MATCHING,
                          p_request_id,
                          dbms_xmldom.getXmlType(l_doc).getClobVal());
  end;

  procedure gen_session_req_envelope_list(p_request_id in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_req_envelope_list(p_request_id);
  end;

  procedure gen_session_req_epp_batch_list(p_request_id in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_req_epp_batch_list(p_request_id);
  end;

  procedure gen_session_req_envelope(p_request_id in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_req_envelope(p_request_id);
  end;

  procedure gen_session_req_death(p_request_id in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_req_death(p_request_id);
  end;

  procedure gen_session_req_epp_batch(p_request_id in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_req_epp_batch(p_request_id);
  end;

  procedure gen_session_ask_request_state(p_request_id in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_ask_request_state(p_request_id);
  end;

  procedure gen_session_get_death_list(p_request_id  in integer,
                                       p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_death_list(p_request_id, p_part_number);
  end;

  procedure gen_session_get_verify_list(p_request_id  in integer,
                                        p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_verify_list(p_request_id, p_part_number);
  end;

  procedure gen_session_get_replacement(p_request_id  in integer,
                                        p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_replacement(p_request_id, p_part_number);
  end;

  procedure gen_session_get_envelope_list(p_request_id  in integer,
                                          p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_envelope_list(p_request_id,
                                                  p_part_number);
  end;

  procedure gen_session_get_envelope(p_request_id  in integer,
                                     p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_envelope(p_request_id, p_part_number);
  end;

  procedure gen_session_get_death(p_request_id  in integer,
                                  p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_death(p_request_id, p_part_number);
  end;

  procedure gen_session_get_epp_batch_list(p_request_id  in integer,
                                           p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_epp_batch_list(p_request_id,
                                                   p_part_number);
  end;

  procedure gen_session_get_epp_batch(p_request_id  in integer,
                                      p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_epp_batch(p_request_id, p_part_number);
  end;

  procedure gen_session_get_epp_match_resp(p_request_id  in integer,
                                           p_part_number in integer) is
    l_session_id integer;
  begin
    l_session_id := gen_session_get_epp_match_resp(p_request_id,
                                                   p_part_number);
  end;

  procedure set_session_state(p_session_id       in integer,
                              p_state_id         in integer,
                              p_tracking_comment in varchar2,
                              p_stack_trace      in clob default null) is
  begin
    update pfu_session t
       set t.state_id = p_state_id
     where t.id = p_session_id;

    track_session(p_session_id,
                  p_state_id,
                  p_tracking_comment,
                  p_stack_trace);
  end;

  procedure set_session_request(p_session_id   in integer,
                                p_request_data in clob) is
    l_session_row pfu_session%rowtype;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);

    update pfu_session t
       set t.request_data = p_request_data
     where t.id = l_session_row.id;

    set_session_state(l_session_row.id,
                      pfu_service_utl.SESS_STATE_SIGNED,
                      'Запит до сервісу ПФУ підписаний і підготовлений для відправки');
  end;

  procedure cancel_further_sess_processing(p_session_id in integer,
                                           p_request_id in integer) is
  begin
    for i in (select *
                from pfu_session s
               where s.request_id = p_request_id
                 and s.state_id in
                     (pfu_service_utl.SESS_STATE_NEW,
                      pfu_service_utl.SESS_STATE_SIGNED,
                      pfu_service_utl.SESS_STATE_RESPONDED,
                      pfu_service_utl.SESS_STATE_SIGN_VERIFIED)
                 for update) loop
      set_session_state(i.id,
                        pfu_service_utl.SESS_STATE_CANCELED,
                        'Обробка сесії припинена через неможливість обробки пов''язаної сесії {' ||
                        p_session_id || '}');
    end loop;
  end;

  procedure set_session_response(p_session_id    in integer,
                                 p_response_data in clob) is
    l_session_row   pfu_session%rowtype;
    l_error_code    varchar2(4000 byte);
    l_error_message varchar2(4000 byte);

    l_xml xmltype;
    xml_parsing_failed exception;
    pragma exception_init(xml_parsing_failed, -31011);
  begin
    l_session_row := read_session(p_session_id, p_lock => true);

    update pfu_session t
       set t.response_data = p_response_data
     where t.id = l_session_row.id;

    begin
      l_xml := xmltype(p_response_data);
    exception
      when xml_parsing_failed then
        set_session_state(l_session_row.id,
                          pfu_service_utl.SESS_STATE_MALFORMED_RESPONSE,
                          'Дані відповіді від ПФУ не є валідним xml-документом');
        cancel_further_sess_processing(l_session_row.id,
                                       l_session_row.request_id);
    end;

    l_error_code    := l_xml.extract('request/ecode/text()').getstringval();
    l_error_message := l_xml.extract('request/emessage/text()')
                       .getstringval();

    if (l_error_code = '0') then
      set_session_state(l_session_row.id,
                        pfu_service_utl.SESS_STATE_RESPONDED,
                        'Отримана відповідь від сервісу ПФУ - дані очікують на перевірку ЕЦП');
    else
      set_session_state(l_session_row.id,
                        pfu_service_utl.SESS_STATE_MALFORMED_RESPONSE,
                        'ПФУ повернув код помилки: ' || l_error_code || case when
                        l_error_message is null then null else
                        ' - ' || l_error_message end);
      cancel_further_sess_processing(l_session_row.id,
                                     l_session_row.request_id);
    end if;
  end;

  procedure set_session_response_xml_data(p_session_id        in integer,
                                          p_response_xml_data in clob) is
    l_session_row pfu_session%rowtype;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);

    update pfu_session t
       set t.response_xml_data = p_response_xml_data
     where t.id = l_session_row.id;

    set_session_state(l_session_row.id,
                      pfu_service_utl.SESS_STATE_SIGN_VERIFIED,
                      'TOSS: знято підпис ЕЦП');
  end;

  procedure set_session_sign_failure(p_session_id    in integer,
                                     p_error_message in varchar2,
                                     p_stack_trace   in clob) is
    l_session_row pfu_session%rowtype;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    set_session_state(l_session_row.id,
                      pfu_service_utl.SESS_STATE_SIGN_FAILED,
                      p_error_message,
                      p_stack_trace);
    cancel_further_sess_processing(l_session_row.id,
                                   l_session_row.request_id);
  end;

  procedure set_session_failure(p_session_id    in integer,
                                p_error_message in varchar2,
                                p_error_stack   in clob) is
    l_session_row pfu_session%rowtype;
    l_request_row pfu_request%rowtype;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    l_request_row := pfu_utl.read_request(l_session_row.request_id,
                                          p_lock => true);

    l_session_row.number_of_failures := nvl(l_session_row.number_of_failures,
                                            0) + 1;

    update pfu_session s
       set s.number_of_failures = l_session_row.number_of_failures
     where s.id = l_session_row.id;

    if (l_session_row.number_of_failures >= 15) then
      set_session_state(p_session_id,
                        pfu_service_utl.SESS_STATE_FAILED,
                        p_error_message,
                        p_error_stack);

      cancel_further_sess_processing(p_session_id, l_request_row.id);

      pfu_utl.set_request_state(l_request_row.id,
                                pfu_utl.REQ_STATE_FAILED,
                                p_error_message,
                                p_error_stack);
    else
      track_session(p_session_id,
                    pfu_service_utl.SESS_STATE_FAILED,
                    p_error_message,
                    p_error_stack);
    end if;
  end;

  procedure set_pfu_request_id(p_session_id     in integer,
                               p_pfu_request_id in integer) is
    l_session_row pfu_session%rowtype;
    l_request_row pfu_request%rowtype;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    l_request_row := pfu_utl.read_request(l_session_row.request_id,
                                          p_lock => true);

    pfu_utl.set_pfu_request_id(l_request_row.id, p_pfu_request_id);

    pfu_utl.set_request_state(l_request_row.id,
                              pfu_utl.REQ_STATE_SENT,
                              'Запит на підготовку даних зареєстрований в системі ПФУ з ідентифікатором: ' ||
                              p_pfu_request_id);

    set_session_state(p_session_id,
                      pfu_service_utl.SESS_STATE_PROCESSED,
                      'Запит на підготовку даних зареєстрований в системі ПФУ з ідентифікатором: ' ||
                      p_pfu_request_id);

    gen_session_ask_request_state(l_request_row.id);
  end;

  procedure set_request_status_answer(p_session_id     in integer,
                                      p_request_status in varchar2,
                                      p_request_parts  in integer) is
    l_session_row pfu_session%rowtype;
    l_request_row pfu_request%rowtype;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    l_request_row := pfu_utl.read_request(l_session_row.request_id,
                                          p_lock => true);

    set_session_state(p_session_id,
                      pfu_service_utl.SESS_STATE_PROCESSED,
                      'Від ПФУ отриманий статус обробки запиту: ' ||
                      p_request_status);

    case
      when (p_request_status = pfu_service_utl.REQ_STATE_ACCEPTED) then

        if (l_request_row.state <> pfu_utl.REQ_STATE_ACCEPTED) then
          pfu_utl.set_request_state(l_request_row.id,
                                    pfu_utl.REQ_STATE_ACCEPTED,
                                    'Запит прийнятий в обробку в ПФУ');
        end if;

        gen_session_ask_request_state(l_request_row.id);

      when (p_request_status = pfu_service_utl.REQ_STATE_PREPARED) then

        if l_request_row.request_type in
           (pfu_utl.REQ_TYPE_MATCHING1,
            pfu_utl.REQ_TYPE_MATCHING2,
            pfu_utl.REQ_TYPE_DEATH_MATCHING,
            pfu_utl.REQ_TYPE_NO_TURNOVER) then
          pfu_utl.set_request_state(l_request_row.id,
                                    pfu_utl.REQ_STATE_DATA_PROCESSED,
                                    'Квитанція в ПФУ оброблена');
        else
          pfu_utl.set_request_state(l_request_row.id,
                                    pfu_utl.REQ_STATE_DATA_IS_READY,
                                    'Дані запиту в ПФУ підготовлені');

          if p_request_parts is not null then
            pfu_utl.set_request_parts(l_request_row.id, p_request_parts);
          end if;

          if (p_request_parts is not null and p_request_parts > 0) then
            for part_num in 1 .. p_request_parts loop
              if (l_request_row.request_type =
                 pfu_utl.REQ_TYPE_ENVELOPE_LIST) then
                gen_session_get_envelope_list(l_request_row.id, part_num);
              elsif (l_request_row.request_type = pfu_utl.REQ_TYPE_ENVELOPE) then
                gen_session_get_envelope(l_request_row.id, part_num);
              elsif (l_request_row.request_type =
                    pfu_utl.REQ_TYPE_EPP_BATCH_LIST) then
                gen_session_get_epp_batch_list(l_request_row.id, part_num);
              elsif (l_request_row.request_type =
                    pfu_utl.REQ_TYPE_EPP_BATCH) then
                gen_session_get_epp_batch(l_request_row.id, part_num);
              elsif (l_request_row.request_type =
                    pfu_utl.REQ_TYPE_EPP_MATCHING) then
                gen_session_get_epp_match_resp(l_request_row.id, part_num);
              elsif (l_request_row.request_type =
                    pfu_utl.REQ_TYPE_DEATH_LIST) then
                gen_session_get_death_list(l_request_row.id, part_num);
              elsif (l_request_row.request_type = pfu_utl.REQ_TYPE_DEATH) then
                gen_session_get_death(l_request_row.id, part_num);
              elsif (l_request_row.request_type =
                    pfu_utl.REQ_TYPE_VERIFY_LIST) then
                gen_session_get_verify_list(l_request_row.id, part_num);
              elsif (l_request_row.request_type =
                    pfu_utl.REQ_TYPE_CHANGE_ATTR) then
                gen_session_get_replacement(l_request_row.id, part_num);
              end if;
            end loop;
          end if;
        end if;
      when (p_request_status = pfu_service_utl.REQ_STATE_CANCELED) then
        pfu_utl.set_request_state(l_request_row.id,
                                  pfu_utl.REQ_STATE_CANCELED_BY_PFU,
                                  'ПФУ відхилив обробку запиту');
    end case;

    if (l_request_row.request_type = pfu_utl.REQ_TYPE_ENVELOPE_LIST) then
      -- todo: update parent request state
      null;
    end if;
  end;

  procedure create_envelope(p_session_id           in integer,
                            p_pfu_envelope_id      in integer,
                            p_pfu_branch_code      in varchar2,
                            p_pfu_branch_name      in varchar2,
                            p_register_date        in varchar2,
                            p_receiver_mfo         in varchar2,
                            p_receiver_branch      in varchar2,
                            p_receiver_name        in varchar2,
                            p_envelope_full_sum    in number,
                            p_envelope_lines_count in integer) is
    l_session_row         pfu_session%rowtype;
    l_request_row         pfu_request%rowtype;
    l_envelope_request_id integer;
    l_cnt                 integer;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    l_request_row := pfu_utl.read_request(l_session_row.request_id,
                                          p_lock => true);

    select count(*)
      into l_cnt
      from pfu_request pr, pfu_envelope_request per
     where per.id = pr.id
       and per.pfu_envelope_id = p_pfu_envelope_id
       and pr.state not in (pfu_utl.REQ_STATE_FAILED,
                            pfu_utl.REQ_STATE_CANCELED_BY_PFU,
                            pfu_utl.REQ_STATE_IGNORE);

    l_envelope_request_id := pfu_utl.create_envelope(p_pfu_envelope_id,
                                                     p_pfu_branch_code,
                                                     p_pfu_branch_name,
                                                     to_date(p_register_date,
                                                             'ddmmyyyy'),
                                                     p_receiver_mfo,
                                                     p_receiver_branch,
                                                     p_receiver_name,
                                                     p_envelope_full_sum,
                                                     p_envelope_lines_count,
                                                     l_request_row.id);

    if (l_cnt > 0) then
      pfu_utl.set_request_state(l_envelope_request_id,
                                pfu_utl.REQ_STATE_IGNORE,
                                'Запрос с таким ИД уже есть в работе');
    end if;

  end;

  procedure create_death(p_session_id      in integer,
                         p_pfu_death_id    in integer,
                         p_pfu_branch_code in varchar2,
                         p_pfu_branch_name in varchar2,
                         p_register_date   in varchar2,
                         p_receiver_mfo    in varchar2,
                         p_receiver_branch in varchar2,
                         p_receiver_name   in varchar2,
                         p_full_sum        in number,
                         p_lines_count     in integer) is
    l_session_row      pfu_session%rowtype;
    l_request_row      pfu_request%rowtype;
    l_death_request_id integer;
    l_cnt              integer;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    l_request_row := pfu_utl.read_request(l_session_row.request_id,
                                          p_lock => true);

    select count(*)
      into l_cnt
      from pfu_request pr, pfu_death_request per
     where per.id = pr.id
       and per.pfu_death_id = p_pfu_death_id
       and pr.state not in (pfu_utl.REQ_STATE_FAILED,
                            pfu_utl.REQ_STATE_CANCELED_BY_PFU,
                            pfu_utl.REQ_STATE_IGNORE);

    l_death_request_id := pfu_utl.create_death(p_pfu_death_id,
                                               p_pfu_branch_code,
                                               p_pfu_branch_name,
                                               to_date(p_register_date,
                                                       'ddmmyyyy'),
                                               p_receiver_mfo,
                                               p_receiver_branch,
                                               p_receiver_name,
                                               p_full_sum,
                                               p_lines_count,
                                               l_request_row.id);

    if (l_cnt > 0) then
      pfu_utl.set_request_state(l_death_request_id,
                                pfu_utl.REQ_STATE_IGNORE,
                                'Запрос с таким ИД уже есть в работе');
    end if;
    null;

  end;

  procedure create_verification(p_session_id      in integer,
                                p_pfu_verify_id   in integer,
                                p_pfu_branch_code in varchar2,
                                p_pfu_branch_name in varchar2,
                                p_register_date   in varchar2,
                                p_lines_count     in integer) is
    l_session_row       pfu_session%rowtype;
    l_request_row       pfu_request%rowtype;
    l_verify_request_id integer;
    l_cnt               integer;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    l_request_row := pfu_utl.read_request(l_session_row.request_id,
                                          p_lock => true);

    select count(*)
      into l_cnt
      from pfu_request pr, pfu_verification_request per
     where per.id = pr.id
       and per.pfu_verification_id = p_pfu_verify_id
       and pr.state not in (pfu_utl.REQ_STATE_FAILED,
                            pfu_utl.REQ_STATE_CANCELED_BY_PFU,
                            pfu_utl.REQ_STATE_IGNORE);

    l_verify_request_id := pfu_utl.create_verification(p_pfu_verify_id,
                                                       p_pfu_branch_code,
                                                       p_pfu_branch_name,
                                                       to_date(p_register_date,
                                                               'ddmmyyyy'),
                                                       p_lines_count,
                                                       l_request_row.id);

    if (l_cnt > 0) then
      pfu_utl.set_request_state(l_verify_request_id,
                                pfu_utl.REQ_STATE_IGNORE,
                                'Запрос с таким ИД уже есть в работе');
    end if;
    null;

  end;

  procedure create_death_list(p_request_id in integer, p_rec_data in clob) is
  begin
    for r in (select extractvalue(value(p), '/row/id/text()') as envelope_id,
                     extractvalue(value(p), '/row/opfu_code/text()') as opfu_code,
                     extractvalue(value(p), '/row/opfu_name/text()') as opfu_name,
                     extractvalue(value(p), '/row/date_cr/text()') as date_cr,
                     extractvalue(value(p), '/row/MFO_filia/text()') as mfo_filia,
                     extractvalue(value(p), '/row/filia_num/text()') as filia_num,
                     extractvalue(value(p), '/row/filia_name/text()') as filia_name,
                     extractvalue(value(p), '/row/full_sum/text()') as full_sum,
                     extractvalue(value(p), '/row/full_lines/text()') as full_lines
                from table(xmlsequence(extract(xmltype(p_rec_data),
                                               '/paymentlists/row'))) p) loop
      NULL;
    end loop;
  end;

  procedure create_file(p_request_id        in integer,
                        p_branch_number     in varchar2,
                        p_file_branch_sum   in number,
                        p_file_lines_count  in integer,
                        p_file_payment_date in varchar2,
                        p_file_number       in integer,
                        p_file_name         in varchar2,
                        p_file_data         in blob) is
    l_request_row pfu_request%rowtype;
    l_file_id     integer;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_file_id := pfu_utl.create_file(l_request_row.id,
                                     p_file_name,
                                     to_date(p_file_payment_date, 'ddmmyyyy'),
                                     p_file_number,
                                     p_file_branch_sum,
                                     p_file_lines_count,
                                     p_file_data);
  end;
  /*
  procedure create_file(p_request_id        in integer,
                        p_branch_number     in varchar2,
                        p_file_branch_sum   in number,
                        p_file_lines_count  in integer,
                        p_file_payment_date in varchar2,
                        p_file_number       in integer,
                        p_file_name         in varchar2,
                        p_file_data         in blob,
                        p_file_id           out integer) is
    l_request_row pfu_request%rowtype;
    l_file_id     integer;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_file_id := pfu_utl.create_file(l_request_row.id,
                                     p_file_name,
                                     to_date(p_file_payment_date,
                                             'ddmmyyyy'),
                                     p_file_number,
                                     p_file_branch_sum,
                                     p_file_lines_count,
                                     p_file_data);
    p_file_id := l_file_id;
  end;
  */
  function create_file(p_request_id        in integer,
                       p_branch_number     in varchar2,
                       p_file_branch_sum   in number,
                       p_file_lines_count  in integer,
                       p_file_payment_date in varchar2,
                       p_file_number       in integer,
                       p_file_name         in varchar2,
                       p_file_data         in blob) return integer is
    l_request_row pfu_request%rowtype;
    l_file_id     integer;
  begin
    l_request_row := pfu_utl.read_request(p_request_id, p_lock => true);

    l_file_id := pfu_utl.create_file(l_request_row.id,
                                     p_file_name,
                                     to_date(p_file_payment_date, 'ddmmyyyy'),
                                     p_file_number,
                                     p_file_branch_sum,
                                     p_file_lines_count,
                                     p_file_data);
    return l_file_id;
  end;
  /*
      procedure send_request_old(
          p_action in varchar2,
          p_session_id in integer,
          p_parameters in string_list,
          p_values in string_list)
      is
          l_url varchar2(4000 byte);
          l_walett_path varchar2(4000 byte);
          l_walett_pass varchar2(4000 byte);
          l_bars_login varchar2(50 char);
          l_authorization_val varchar2(4000 byte);
          l_response bars.wsm_mgr.t_response;
          l integer;
      begin
          l_url := pfu_utl.get_parameter('BARS_WS_URL');
          l_walett_path := pfu_utl.get_parameter('BARS_WS_WALLET_PATH');
          l_walett_pass := pfu_utl.get_parameter('BARS_WS_WALLET_PASS');
          l_bars_login := pfu_utl.get_parameter('BARS_WS_LOGIN');

          if (l_bars_login is not null) then
              l_authorization_val := 'Basic ' || utl_raw.cast_to_varchar2(
                                          utl_encode.base64_encode(
                                              utl_raw.cast_to_raw(
                                                  l_bars_login || ':' || pfu_utl.get_parameter('BARS_WS_PASS'))));
          end if;

          if (substr(l_url, length(l_url)) <> '/') then
              l_url := l_url || '/';
          end if;

          bars.wsm_mgr.prepare_request(p_url          => l_url,
                                       p_action       => p_action || '?sessionid=' || p_session_id,
                                       p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                       p_content_type => bars.wsm_mgr.G_CT_JSON,
                                       p_wallet_path  => l_walett_path,
                                       p_wallet_pwd   => l_walett_pass);

          if (l_authorization_val is not null) then
              bars.wsm_mgr.add_header(p_name  => 'Authorization',
                                      p_value => l_authorization_val);
          end if;

          if (p_parameters is not null and p_parameters is not empty) then
              l := p_parameters.first;
              while (l is not null) loop
                  bars.wsm_mgr.add_parameter(p_name  => p_parameters(l), p_value => p_values(l));

                  l := p_parameters.next(l);
              end loop;
          end if;

          bars.wsm_mgr.execute_request(l_response);
      end;
  */
  procedure send_request(p_id_sess pfu_session.id%type) is
    l_url         varchar2(4000 byte);
    l_walett_path varchar2(4000 byte);
    l_walett_pass varchar2(4000 byte);
    l_response    bars.wsm_mgr.t_response;
  begin
    l_url         := pfu_utl.get_parameter('BARS_WS_URL'); --'http://192.168.238.231:7080/ic0001';
    l_walett_path := pfu_utl.get_parameter('BARS_WS_WALLET_PATH');
    l_walett_pass := pfu_utl.get_parameter('BARS_WS_WALLET_PASS');

    for c0 in (select id, request_data
                 from PFU_SESSION
                where id = p_id_sess
                  and state_id = SESS_STATE_SIGNED) loop
      bars.wsm_mgr.prepare_request(p_url          => l_url ||
                                                     '/pfuredirect/sendrequest',
                                   p_action       => null,
                                   p_http_method  => bars.wsm_mgr.G_HTTP_POST,
                                   p_content_type => bars.wsm_mgr.G_CT_XML,
                                   p_wallet_path  => l_walett_path,
                                   p_wallet_pwd   => l_walett_pass,
                                   p_body         => c0.request_data);

      bars.wsm_mgr.execute_api(l_response);

      set_session_response(c0.id, l_response.cdoc);
    end loop;
  end;

  function check_if_all_parts_received(p_request_id      in integer,
                                       p_session_type_id in integer)
    return boolean is
    l_waiting_sessions_number integer;
  begin
    select count(*)
      into l_waiting_sessions_number
      from pfu_session s
     where s.request_id = p_request_id
       and s.session_type_id = p_session_type_id
       and s.state_id not in
           (pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED,
            pfu_service_utl.SESS_STATE_PROCESSED);

    return l_waiting_sessions_number = 0;
  end;

  procedure finish_data_part_sessions(p_sessions in number_list) is
    l integer;
  begin
    l := p_sessions.first;
    while (l is not null) loop
      set_session_state(p_sessions(l),
                        pfu_service_utl.SESS_STATE_PROCESSED,
                        'Всі частини пакету відповіді зібрані разом');
      l := p_sessions.next(l);
    end loop;
  end;

  procedure gather_envelope_parts(p_request_id in integer) is
    l_response_data clob;

    l_files_data clob;
    l_fd_zip     blob;
    l_fd_unzip   blob;
    l_ecp_list   clob;

    l_desc_file clob;

    l_frow PFU_FILE%rowtype;

    c_data varchar2(53) := '/description_files/branches/';
    c_doc  varchar2(254);
    l_xml  xmltype;

    l_filebody   xmltype;
    i            pls_integer;
    l_file_data3 clob;

    l_sessions     number_list := number_list();
    l_payment_date varchar2(30);
  begin
    dbms_lob.createtemporary(l_response_data, false);

    -- <requestdata><rd_id>22371</rd_id><rd_rq>46100</rd_rq><part>1</part><rd_data>PHBheW1lbnRsaXN0cz48cm9...VudGxpc3RzPg==</rd_data></requestdata>
    for i in (select s.id,
                     extract(xmltype(s.response_xml_data), 'requestdata/rd_data/text()')
                     .getclobval() response_data_part
                from pfu_session s
               where s.request_id = p_request_id
                 and s.session_type_id =
                     pfu_service_utl.SESS_TYPE_GET_ENVELOPE
                 and s.state_id in
                     (pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED,
                      pfu_service_utl.SESS_STATE_PROCESSED)
               order by to_char(extract(xmltype(s.response_xml_data), 'requestdata/part/text()')
                                .getclobval())) loop
      dbms_lob.append(l_response_data, i.response_data_part);
      l_sessions.extend(1);
      l_sessions(l_sessions.last) := i.id;
    end loop;

    l_response_data := pfu_utl.decodeclobfrombase64(l_response_data);
    -- convert from utf8  !Twice !
    l_response_data := pfu_utl.utf8todeflang(l_response_data);
    l_response_data := pfu_utl.utf8todeflang(l_response_data);

    select extract(d.response_xml, 'paymentlists/files_data/text()')
           .getClobVal(),
           extract(d.response_xml, 'paymentlists/ecp_list').getClobVal()
      into l_files_data, l_ecp_list
      from (select xmltype(l_response_data) response_xml from dual) d;

    -- прибираємо перенос рядка
    l_files_data := replace(replace(l_files_data, chr(10), ''), chr(13), '');

    -- decode base64 to blob (zip)
    l_fd_zip := pfu_utl.base64decode_to_blob(l_files_data);
    -- unzip  - отримали description_files

    update pfu_envelope_request
       set paymentlists = l_response_data,
           files_data   = l_files_data,
           ecp_list     = l_ecp_list,
           zip_data     = l_fd_zip,
           state        = pfu_utl.ENV_STATE_ENVELOPE_RECEIVED
     where id = p_request_id;

    l_fd_unzip := utl_compress.lz_uncompress(l_fd_zip);

    -- обробка description_files
    -- конвертуємо з blob в clob
    l_desc_file := pfu_utl.blob_to_clob(l_fd_unzip);

    -- кодування
    l_desc_file := pfu_utl.utf8todeflang(l_desc_file);

    i          := 0;
    l_filebody := xmltype(l_desc_file);
    loop
      -- счетчик row
      i := i + 1;

      c_doc := c_data || 'row[' || i || ']';

      -- выход при отсутствии транзакций
      if l_filebody.existsnode(c_doc) = 0 then
        exit;
      end if;

      l_xml := xmltype(extract_clob(l_filebody, c_doc, null));

      l_frow.check_sum         := extract_str(l_xml,
                                              '/row/branch_sum/text()',
                                              null);
      l_frow.check_lines_count := extract_str(l_xml,
                                              '/row/branch_lines/text()',
                                              null);
      l_payment_date           := extract_str(l_xml,
                                              '/row/date_pay/text()',
                                              null);
      l_frow.file_name         := extract_str(l_xml,
                                              '/row/file_name/text()',
                                              null);
      l_frow.file_number       := extract_str(l_xml,
                                              '/row/num_list/text()',
                                              null);
      l_file_data3             := extract_clob(l_xml,
                                               '/row/file_data/text()',
                                               null);

      -- прибираємо перенос рядка
      l_file_data3 := replace(replace(l_file_data3, chr(10), ''),
                              chr(13),
                              '');

      -- decode base64 to blob (zip)
      l_fd_zip := pfu_utl.base64decode_to_blob(l_file_data3);
      -- unzip  - отримали description_files
      l_fd_unzip := utl_compress.lz_uncompress(l_fd_zip);

      /*create_file(p_request_id => p_request_id,
      p_branch_number => null,
      p_file_branch_sum => l_frow.check_sum ,
      p_file_lines_count =>l_frow.check_lines_count,
      p_file_payment_date => l_payment_date,
      p_file_number => l_frow.file_number,
      p_file_name =>l_frow.file_name,
      p_file_data => l_fd_unzip);*/
    end loop;

    finish_data_part_sessions(l_sessions);
  end;

  procedure gather_death_parts(p_request_id in integer) is
    l_response_data clob;

    l_files_data clob;
    l_fd_zip     blob;
    l_fd_unzip   blob;
    l_ecp_list   clob;

    l_desc_file clob;

    l_frow  PFU_DEATH%rowtype;
    l_frow2 pfu_death_record%rowtype;

    c_data varchar2(53) := '/declar/declarbody/';
    c_doc  varchar2(254);
    l_xml  xmltype;

    l_filebody   xmltype;
    i            pls_integer;
    l_file_data3 clob;

    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;

    l_file_id number;

    l_sessions     number_list := number_list();
    l_payment_date varchar2(30);

    l_recid         pfu_death_record.id%type;
    l_c_pens        number;
    l_err_code      varchar2(30);
    l_err_message   varchar2(3000);
    l_pensacc_row   pfu_pensacc%rowtype;
    l_pensioner_row pfu_pensioner%rowtype;

    err_record exception;
  begin
    dbms_lob.createtemporary(l_response_data, false);

    -- <requestdata><rd_id>22371</rd_id><rd_rq>46100</rd_rq><part>1</part><rd_data>PHBheW1lbnRsaXN0cz48cm9...VudGxpc3RzPg==</rd_data></requestdata>
    for i in (select s.id,
                     extract(xmltype(s.response_xml_data), 'requestdata/rd_data/text()')
                     .getclobval() response_data_part
                from pfu_session s
               where s.request_id = p_request_id
                 and s.session_type_id = pfu_service_utl.SESS_TYPE_GET_DEATH
                 and s.state_id in
                     (pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED,
                      pfu_service_utl.SESS_STATE_PROCESSED)
               order by to_char(extract(xmltype(s.response_xml_data), 'requestdata/part/text()')
                                .getclobval())) loop
      dbms_lob.append(l_response_data, i.response_data_part);
      l_sessions.extend(1);
      l_sessions(l_sessions.last) := i.id;
    end loop;

    l_response_data := pfu_utl.decodeclobfrombase64(l_response_data);
    -- convert from utf8  !Twice !
    l_response_data := pfu_utl.utf8todeflang(l_response_data);
    l_response_data := pfu_utl.utf8todeflang(l_response_data);

    select extract(d.response_xml, 'deadlists/files_data/text()')
           .getClobVal(),
           extract(d.response_xml, 'deadlists/ecp_list').getClobVal()
      into l_files_data, l_ecp_list
      from (select xmltype(l_response_data) response_xml from dual) d;

    -- прибираємо перенос рядка
    l_files_data := replace(replace(l_files_data, chr(10), ''), chr(13), '');

    -- decode base64 to blob (zip)
    l_fd_zip := pfu_utl.base64decode_to_blob(l_files_data);
    -- unzip  - отримали description_files

    update pfu_death_request
       set deathlists = l_response_data,
           files_data = l_files_data,
           ecp_list   = l_ecp_list,
           zip_data   = l_fd_zip,
           state      = pfu_utl.DEA_STATE_DEATH_RECEIVED
     where id = p_request_id;

    l_fd_unzip := utl_compress.lz_uncompress(l_fd_zip);

    -- обробка description_files
    -- конвертуємо з blob в clob
    l_desc_file := pfu_utl.blob_to_clob(l_fd_unzip);

    -- кодування
    l_desc_file := pfu_utl.utf8todeflang(l_desc_file);

    i          := 0;
    l_filebody := xmltype(l_desc_file);

    l_frow.count_res   := extract_str(l_filebody,
                                      '/declar/declarhead/full_lines/text()',
                                      null);
    l_frow.date_pfu    := to_date(extract_str(l_filebody,
                                              'declar/declarhead/date_time/text()',
                                              null),
                                  'dd.mm.yyyy hh24.mi.ss');
    l_frow.pfu_file_id := extract_str(l_filebody,
                                      'declar/declarhead/file_id/text()',
                                      null);

    l_file_id := pfu_utl.create_death_file(p_request_id,
                                           l_frow.pfu_file_id,
                                           l_frow.date_pfu,
                                           l_frow.count_res);

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_desc_file);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'ROW');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop

      l_row := dbms_xmldom.item(l_rows, i);

      l_frow2.rec_num     := dbms_xslprocessor.valueof(l_row,
                                                       'rownum/text()');
      l_frow2.pfu_num     := dbms_xslprocessor.valueof(l_row,
                                                       'pnf_num/text()');
      l_frow2.last_name   := dbms_xslprocessor.valueof(l_row, 'ln/text()');
      l_frow2.first_name  := dbms_xslprocessor.valueof(l_row, 'nm/text()');
      l_frow2.father_name := dbms_xslprocessor.valueof(l_row, 'ftn/text()');
      l_frow2.okpo        := dbms_xslprocessor.valueof(l_row,
                                                       'numident/text()');
      l_frow2.doc_num     := dbms_xslprocessor.valueof(l_row,
                                                       'ser_num/text()');
      l_frow2.num_acc     := dbms_xslprocessor.valueof(l_row,
                                                       'num_acc/text()');
      l_frow2.bank_mfo    := dbms_xslprocessor.valueof(l_row,
                                                       'bank_mfo/text()');
      l_frow2.bank_num    := dbms_xslprocessor.valueof(l_row,
                                                       'bank_num/text()');
      l_frow2.date_dead   := to_date(dbms_xslprocessor.valueof(l_row,
                                                               'date_dead/text()'),
                                     'ddmmyyyy');
      l_frow2.death_akt   := dbms_xslprocessor.valueof(l_row,
                                                       'death_akt/text()');
      l_frow2.date_akt    := to_date(dbms_xslprocessor.valueof(l_row,
                                                               'date_akt/text()'),
                                     'ddmmyyyy');
      l_frow2.sum_over    := dbms_xslprocessor.valueof(l_row,
                                                       'sum_over/text()');
      l_frow2.period      := dbms_xslprocessor.valueof(l_row,
                                                       'period/text()');
      l_frow2.date_pay    := to_date(dbms_xslprocessor.valueof(l_row,
                                                               'ate_pay/text()'),
                                     'ddmmyyyy');
      l_frow2.sum_pay     := dbms_xslprocessor.valueof(l_row,
                                                       'sum_pay/text()');
      l_frow2.type_block  := dbms_xslprocessor.valueof(l_row,
                                                       'oznaka/text()');

      if l_frow2.okpo is null then
        l_frow2.okpo := '0000000000';
      end if;

      l_recid := pfu_death_record_seq.nextval;

      insert into pfu_death_record
        (id,
         list_id,
         rec_num,
         last_name,
         first_name,
         father_name,
         okpo,
         doc_num,
         num_acc,
         bank_mfo,
         bank_num,
         date_dead,
         death_akt,
         date_akt,
         sum_over,
         period,
         date_pay,
         sum_pay,
         type_block,
         pfu_num,
         state)
      values
        (l_recid,
         l_file_id,
         l_frow2.rec_num,
         l_frow2.last_name,
         l_frow2.first_name,
         l_frow2.father_name,
         l_frow2.okpo,
         l_frow2.doc_num,
         l_frow2.num_acc,
         l_frow2.bank_mfo,
         l_frow2.bank_num,
         l_frow2.date_dead,
         l_frow2.death_akt,
         l_frow2.date_akt,
         l_frow2.sum_over,
         l_frow2.period,
         l_frow2.date_pay,
         l_frow2.sum_pay,
         l_frow2.type_block,
         l_frow2.pfu_num,
         'NEW');
      begin
        -- наявність пенсіонера
        select count(1)
          into l_c_pens
          from pfu_pensioner p
         where p.okpo = l_frow2.okpo
           and p.kf = l_frow2.bank_mfo
           and p.date_off is null;
        if (l_frow2.okpo is not null) then
          if (l_c_pens = 0) then
            l_err_code    := 'ERR_OKPO';
            l_err_message := 'Пенсіонера не знайдено по ОКПО';
            raise err_record;
          end if;
        end if;

        -- наявність рахунку
        begin
          select *
            into l_pensacc_row
            from pfu_pensacc pa
           where pa.nls = l_frow2.num_acc
             and pa.kf = l_frow2.bank_mfo;
        exception
          when no_data_found then
            l_err_code    := 'ERR_ACC';
            l_err_message := 'Рахунок не знайдено';
            raise err_record;
        end;

        -- рахунок закритий
        if l_pensacc_row.dazs is not null then
          l_err_code    := 'ERR_ACC_CLOSE';
          l_err_message := 'Рахунок закритий';
          raise err_record;
        end if;

        -- наявність пенсіонера (по рахунку)
        begin
          select *
            into l_pensioner_row
            from pfu_pensioner p
           where p.rnk = l_pensacc_row.rnk
             and p.kf = l_pensacc_row.kf;
        exception
          when no_data_found then
            l_err_code    := 'ERR_ACC_PENS';
            l_err_message := 'Пенсіонера не знайдено (по рахунку)';
            raise err_record;
        end;

        -- невідповідність ОКПО
        if l_pensioner_row.okpo != l_frow2.okpo then
          l_err_code    := 'ERR_ACC_OKPO';
          l_err_message := 'Рахунок не відповідає по ОКПО';
          raise err_record;
        end if;

        if l_pensioner_row.state in (4, 14) then
          l_err_code    := 'ERR_BLOCKED';
          l_err_message := 'Пенсіонер закблокований по причині смерті';
          raise err_record;
        end if;

        -- невідповідність ПІБ
        -- або utl_match.jaro_winkler_similarity
        if utl_match.edit_distance_similarity(UPPER(l_pensioner_row.nmk),
                                              UPPER(trim(l_frow2.last_name) || ' ' ||
                                                    trim(l_frow2.first_name) || ' ' ||
                                                    trim(l_frow2.father_name))) < 80 then
          l_err_code    := 'ERR_NAME';
          l_err_message := 'Рахунок не відповідає по ПІБ';
          raise err_record;
        end if;

        update pfu_death_record dr
           set dr.state = 'CHECKED', dr.comm = ''
         where dr.id = l_recid;

      exception
        when err_record then
          update pfu_death_record dr
             set dr.state = l_err_code, dr.comm = l_err_message
           where dr.id = l_recid;
        when others then
          l_err_message := sqlerrm;
          update pfu_death_record dr
             set dr.state = 'ERR_SYS', dr.comm = l_err_message
           where dr.id = l_recid;

      end;
    end loop;

    finish_data_part_sessions(l_sessions);
  end;

  procedure gather_epp_batch_list_parts(p_request_id in integer) is
    l_response_data clob;

    l_sessions number_list := number_list();

    l_pfu_batch_id      integer;
    l_batch_date        date;
    l_batch_lines_count integer;
    l_batch_request_id  integer;
    l_cnt               integer;

    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.DOMDocument;
    l_rows   dbms_xmldom.DOMNodeList;
    l_row    dbms_xmldom.DOMNode;
  begin
    dbms_lob.createtemporary(l_response_data, false);

    for i in (select s.id,
                     extract(xmltype(s.response_xml_data), 'requestdata/rd_data/text()')
                     .getclobval() response_data_part
                from pfu_session s
               where s.request_id = p_request_id
                 and s.session_type_id =
                     pfu_service_utl.SESS_TYPE_GET_EPP_BATCH_LIST
                 and s.state_id =
                     pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED) loop
      dbms_lob.append(l_response_data, i.response_data_part);
      l_sessions.extend(1);
      l_sessions(l_sessions.last) := i.id;
    end loop;

    l_response_data := pfu_utl.decodeclobfrombase64(l_response_data);
    -- convert from utf8  !Twice !
    l_response_data := pfu_utl.utf8todeflang(l_response_data);
    l_response_data := pfu_utl.utf8todeflang(l_response_data);

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_response_data);

    l_doc  := dbms_xmlparser.getdocument(l_parser);
    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');

    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop

      l_row := dbms_xmldom.item(l_rows, i);

      l_pfu_batch_id      := to_number(dbms_xslprocessor.valueof(l_row,
                                                                 'id/text()'));
      l_batch_date        := to_date(dbms_xslprocessor.valueof(l_row,
                                                               'date_cr/text()'),
                                     'ddmmyyyy');
      l_batch_lines_count := to_number(dbms_xslprocessor.valueof(l_row,
                                                                 'full_lines/text()'));

      select count(*)
        into l_cnt
        from pfu_request pr
       where pr.pfu_request_id = l_pfu_batch_id
         and state not in (pfu_utl.REQ_STATE_FAILED,
                           pfu_utl.REQ_STATE_CANCELED_BY_PFU,
                           pfu_utl.REQ_STATE_IGNORE);

      l_batch_request_id := pfu_epp_utl.create_epp_batch_request(p_request_id,
                                                                 l_pfu_batch_id,
                                                                 l_batch_date,
                                                                 l_batch_lines_count);

      if (l_cnt > 0) then
        pfu_utl.set_request_state(l_batch_request_id,
                                  pfu_utl.REQ_STATE_IGNORE,
                                  'Запрос с таким ИД уже есть в работе');
      end if;

    end loop;

    finish_data_part_sessions(l_sessions);
  end;

  procedure validate_epp_line(p_wrong_tag_list  in out nocopy string_list,
                              p_source_tag_name in varchar2,
                              p_value           in varchar,
                              p_regex_template  in varchar2,
                              p_is_mandatory    in boolean default true) is
  begin
    if (p_is_mandatory and p_value is null) then
      p_wrong_tag_list.extend(1);
      p_wrong_tag_list(p_wrong_tag_list.last) := p_source_tag_name;
    else
      if (not regexp_like(p_value, p_regex_template, 'i')) then
        p_wrong_tag_list.extend(1);
        p_wrong_tag_list(p_wrong_tag_list.last) := p_source_tag_name;
      end if;
    end if;
  end;

  -----------------------------------------------------------------------------------------
  --  validate_epp_lines
  --
  --    Валідація даних пенсіонерів на отримання ЕПП
  --
  --      p_request_id - id запиту
  --
  procedure validate_epp_lines(p_request_id in integer) is
    l_wrong_tag_list string_list;
  begin
    for i in (select l.*
                from pfu_epp_line l
               where l.batch_request_id = p_request_id
                 and l.state_id <> pfu_epp_utl.LINE_STATE_ACCEPTED) loop

      l_wrong_tag_list := string_list();

      validate_epp_line(l_wrong_tag_list,
                        'id_epp',
                        i.epp_number,
                        '^[0-9,A-Z]{1,12}$');
      validate_epp_line(l_wrong_tag_list,
                        'date_andpp',
                        i.epp_expiry_date,
                        '^[0-3][0-9][0-1][0-9][0-2][0-9][0-9][0-9]$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'num_zo',
                        i.person_record_number,
                        '^(\w|\d|-){1,10}$');
      validate_epp_line(l_wrong_tag_list, 'ln', i.last_name, '^.{2,70}$');
      validate_epp_line(l_wrong_tag_list, 'nm', i.first_name, '^.{2,50}$');
      validate_epp_line(l_wrong_tag_list,
                        'ftn',
                        i.middle_name,
                        '^.{1,50}$',
                        false);
      validate_epp_line(l_wrong_tag_list, 'st', i.gender, '^(0|1)$');
      validate_epp_line(l_wrong_tag_list,
                        'date_birth',
                        i.date_of_birth,
                        '^[0-3][0-9][0-1][0-9][0-2][0-9][0-9][0-9]$');
      validate_epp_line(l_wrong_tag_list,
                        'num_tel',
                        i.phone_numbers,
                        '^(\d|-|\(|\)|\+|\s|,){1,30}$');
      validate_epp_line(l_wrong_tag_list,
                        'lnf_lat',
                        i.embossing_name,
                        '^([A-Z]|\s){1,172}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'numident',
                        i.tax_registration_number,
                        '^\d{8,10}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'type_doc',
                        i.document_type,
                        '^(1|2)$');
      -- COBUMMFO-8918
      -- якщо паспорт старого зразка
      if i.document_type in ('1') then
        validate_epp_line(l_wrong_tag_list,
                          'ser_num',
                          i.document_id,
                          '^([АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЮЯ]{2}\s{1}\d{6}|\d{9})$');
      -- якщо паспорт нового зразка
      elsif i.document_type in ('2') then
        validate_epp_line(l_wrong_tag_list,
                          'ser_num',
                          i.document_id,
                          '^\d{9}$');
      -- залишаємо валідацію старого зразка на випадок якщо передають хз що
      else
        validate_epp_line(l_wrong_tag_list,
                          'ser_num',
                          i.document_id,
                          '^([АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЮЯ]{2}\s{1}\d{6}|\d{9})$');
      end if;
      --
      validate_epp_line(l_wrong_tag_list,
                        'date_doc',
                        i.document_issue_date,
                        '^[0-3][0-9][0-1][0-9][0-2][0-9][0-9][0-9]$');
      validate_epp_line(l_wrong_tag_list,
                        'issued_doc',
                        i.document_issuer,
                        '^.{1,100}$');
      validate_epp_line(l_wrong_tag_list,
                        'type_osob',
                        i.displaced_person_flag,
                        '^(0|1)$');
      validate_epp_line(l_wrong_tag_list,
                        'country_reg',
                        i.legal_country,
                        '^.{1,50}$');
      validate_epp_line(l_wrong_tag_list,
                        'post_reg',
                        i.legal_zip_code,
                        '^\d{5,6}$');
      validate_epp_line(l_wrong_tag_list,
                        'region_reg',
                        i.legal_region,
                        '^.{1,50}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'area_reg',
                        i.legal_district,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'settl_reg',
                        i.legal_settlement,
                        '^.{1,100}$');
      validate_epp_line(l_wrong_tag_list,
                        'street_reg',
                        i.legal_street,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'house_reg',
                        i.legal_house,
                        '^.{1,7}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'corps_reg',
                        i.legal_house_part,
                        '^.{1,2}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'apart_reg',
                        i.legal_apartment,
                        '^.{1,7}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'country_act',
                        i.actual_country,
                        '^.{1,50}$');
      validate_epp_line(l_wrong_tag_list,
                        'post_act',
                        i.actual_zip_code,
                        '^\d{5,6}$');
      validate_epp_line(l_wrong_tag_list,
                        'region_act',
                        i.actual_region,
                        '^.{1,50}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'area_act',
                        i.actual_district,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'settl_act',
                        i.actual_settlement,
                        '^.{1,100}$');
      validate_epp_line(l_wrong_tag_list,
                        'street_act',
                        i.actual_street,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'house_act',
                        i.actual_house,
                        '^.{1,7}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'corps_act',
                        i.actual_house_part,
                        '^.{1,2}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'apart_act',
                        i.actual_apartment,
                        '^.{1,5}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'bank_mfo',
                        i.bank_mfo,
                        '^\d{6}$');
      validate_epp_line(l_wrong_tag_list,
                        'bank_num',
                        i.bank_num,
                        '^(/|\d){1,30}$');
      validate_epp_line(l_wrong_tag_list,
                        'bank_name',
                        i.bank_name,
                        '.{1,100}$');
      validate_epp_line(l_wrong_tag_list,
                        'pens_type',
                        i.pens_type,
                        '^(1|2)$');
      validate_epp_line(l_wrong_tag_list,
                        'guardianship',
                        i.guardianship,
                        '^(0|1)$');

      if (l_wrong_tag_list is empty) then
        pfu_epp_utl.set_line_state(i.id,
                                   pfu_epp_utl.LINE_STATE_ACCEPTED,
                                   '',
                                   null);
      else
        pfu_epp_utl.set_line_state(i.id,
                                   pfu_epp_utl.LINE_STATE_INCORRECT_DATA,
                                   'Невідповідність формату даних, отриманих від ПФУ, або не заповнено обов’язкові поля',
                                   pfu_utl.string_list_to_clob(l_wrong_tag_list,
                                                               ', '));
      end if;

    end loop;
    gen_epp_matching1(p_request_id);
    pfu_utl.set_request_state(p_request_id,
                              'MATCH_SEND',
                              'Квітанція сформована');
  end validate_epp_lines;

  -----------------------------------------------------------------------------------------
  --  validate_epp_guardians
  --
  --    Валідація даних опікунів пенсіонерів на отримання ЕПП
  --
  --      p_request_id - id запиту
  --
  procedure validate_epp_guardians(p_request_id in integer) is
    l_wrong_tag_list string_list;
  begin
    for i in (select l.*
                from pfu_epp_line_guardian l
               where l.batch_request_id = p_request_id
                 and l.state_id <> pfu_epp_utl.LINE_STATE_ACCEPTED) loop

      l_wrong_tag_list := string_list();

      validate_epp_line(l_wrong_tag_list,
                        'num_zo_g',
                        i.person_record_number,
                        '^(\w|\d|-){1,10}$');
      validate_epp_line(l_wrong_tag_list, 'ln', i.last_name, '^.{2,70}$');
      validate_epp_line(l_wrong_tag_list, 'nm', i.first_name, '^.{2,50}$');
      validate_epp_line(l_wrong_tag_list,
                        'ftn_g',
                        i.middle_name,
                        '^.{1,50}$',
                        false);
      validate_epp_line(l_wrong_tag_list, 'st', i.gender, '^(0|1)$');
      validate_epp_line(l_wrong_tag_list,
                        'date_birth_g',
                        i.date_of_birth,
                        '^[0-3][0-9][0-1][0-9][0-2][0-9][0-9][0-9]$');
      validate_epp_line(l_wrong_tag_list,
                        'num_tel_g',
                        i.phone_numbers,
                        '^(\d|-|\(|\)|\+|\s|,){1,30}$');
      validate_epp_line(l_wrong_tag_list,
                        'lnf_lat_g',
                        i.embossing_name,
                        '^([A-Z]|\s){1,172}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'numident_g',
                        i.tax_registration_number,
                        '^\d{8,10}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'type_doc_g',
                        i.document_type,
                        '^(1|2)$');
      -- COBUMMFO-8918
      -- якщо паспорт старого зразка
      if i.document_type in ('1') then
        validate_epp_line(l_wrong_tag_list,
                          'ser_num_g',
                          i.document_id,
                          '^([АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЮЯ]{2}\s{1}\d{6}|\d{9})$');
      -- якщо паспорт нового зразка
      elsif i.document_type in ('2') then
        validate_epp_line(l_wrong_tag_list,
                          'ser_num_g',
                          i.document_id,
                          '^\d{9}$');
      -- залишаємо валідацію старого зразка на випадок якщо передають хз що
      else
        validate_epp_line(l_wrong_tag_list,
                          'ser_num_g',
                          i.document_id,
                          '^([АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЮЯ]{2}\s{1}\d{6}|\d{9})$');
      end if;
      --
      validate_epp_line(l_wrong_tag_list,
                        'date_doc_g',
                        i.document_issue_date,
                        '^[0-3][0-9][0-1][0-9][0-2][0-9][0-9][0-9]$');
      validate_epp_line(l_wrong_tag_list,
                        'issued_doc_g',
                        i.document_issuer,
                        '^.{1,100}$');
      validate_epp_line(l_wrong_tag_list,
                        'type_osob_g',
                        i.displaced_person_flag,
                        '^(0|1)$');
      validate_epp_line(l_wrong_tag_list,
                        'country_reg_g',
                        i.legal_country,
                        '^.{1,50}$');
      validate_epp_line(l_wrong_tag_list,
                        'post_reg_g',
                        i.legal_zip_code,
                        '^\d{5,6}$');
      validate_epp_line(l_wrong_tag_list,
                        'region_reg_g',
                        i.legal_region,
                        '^.{1,50}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'area_reg_g',
                        i.legal_district,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'settl_reg_g',
                        i.legal_settlement,
                        '^.{1,100}$');
      validate_epp_line(l_wrong_tag_list,
                        'street_reg_g',
                        i.legal_street,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'house_reg_g',
                        i.legal_house,
                        '^.{1,7}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'corps_reg_g',
                        i.legal_house_part,
                        '^.{1,2}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'apart_reg_g',
                        i.legal_apartment,
                        '^.{1,7}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'country_act_g',
                        i.actual_country,
                        '^.{1,50}$');
      validate_epp_line(l_wrong_tag_list,
                        'post_act_g',
                        i.actual_zip_code,
                        '^\d{5,6}$');
      validate_epp_line(l_wrong_tag_list,
                        'region_act_g',
                        i.actual_region,
                        '^.{1,50}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'area_act_g',
                        i.actual_district,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'settl_act_g',
                        i.actual_settlement,
                        '^.{1,100}$');
      validate_epp_line(l_wrong_tag_list,
                        'street_act_g',
                        i.actual_street,
                        '^.{1,100}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'house_act_g',
                        i.actual_house,
                        '^.{1,7}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'corps_act_g',
                        i.actual_house_part,
                        '^.{1,2}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'apart_act_g',
                        i.actual_apartment,
                        '^.{1,5}$',
                        false);
      validate_epp_line(l_wrong_tag_list,
                        'pens_type_g',
                        i.pens_type,
                        '^(1|2)$');

      if (l_wrong_tag_list is empty) then
        pfu_epp_utl.set_line_state(i.id,
                                   pfu_epp_utl.LINE_STATE_ACCEPTED,
                                   '',
                                   null);
      else
        pfu_epp_utl.set_line_state(i.id,
                                   pfu_epp_utl.LINE_STATE_INCORRECT_DATA,
                                   'Невідповідність формату даних, отриманих від ПФУ, або не заповнено обов’язкові поля',
                                   pfu_utl.string_list_to_clob(l_wrong_tag_list,
                                                               ', '));
      end if;

    end loop;
  end validate_epp_guardians;

  procedure validate_epp_lines is --валідація даних після прийому (запису) в PFU_EPP_LINE
  begin
    for i in (select t.*
                from pfu_epp_batch_request t
                join pfu_request r
                  on r.id = t.id
               where r.state = pfu_utl.REQ_STATE_DATA_IS_RECEIVED
                 for update skip locked) loop

      savepoint before_request;
      begin
        validate_epp_lines(i.id);
      exception
        when others then
          rollback to before_request;
          pfu_utl.set_request_state(i.id,
                                    pfu_utl.REQ_STATE_DATA_PROCESSING_FAIL,
                                    sqlerrm || chr(10) ||
                                    dbms_utility.format_error_backtrace());
      end;
    end loop;
  end;

  -----------------------------------------------------------------------------------------
  --  gather_epp_batch_parts
  --
  --    Парсинг файлу ЕПП
  --
  --      p_request_id - id запиту
  --
  procedure gather_epp_batch_parts(p_request_id in integer) is
    l_response_data clob;

    i            pls_integer;
    l_batch_sign raw(128);

    l_sessions number_list := number_list();

    l_epp_lines         pfu_epp_utl.t_epp_lines;         -- колекція для пенсіонерів
    l_epp_line_guardian pfu_epp_utl.t_epp_line_guardian; -- колекція для опікунів

    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.DOMDocument;
    l_rows   dbms_xmldom.DOMNodeList;
    l_row    dbms_xmldom.DOMNode;

    -- l_xml xmltype;

    l_fd_zip   blob;
    l_fd_unzip blob;
    l_g        simple_integer := 0;
  begin
    dbms_lob.createtemporary(l_response_data, false);

    -- <requestdata><rd_id>22371</rd_id><rd_rq>46100</rd_rq><part>1</part><rd_data>PHBheW1lbnRsaXN0cz48cm9...VudGxpc3RzPg==</rd_data></requestdata>
    for i in (select s.id,
                     extract(xmltype(s.response_xml_data), 'requestdata/rd_data/text()')
                     .getclobval() response_data_part
                from pfu_session s
               where s.request_id = p_request_id
                 and s.session_type_id =
                     pfu_service_utl.SESS_TYPE_GET_EPP_BATCH
                 and s.state_id =
                     pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED) loop
      dbms_lob.append(l_response_data, i.response_data_part);
      l_sessions.extend(1);
      l_sessions(l_sessions.last) := i.id;
    end loop;

    l_response_data := pfu_utl.decodeclobfrombase64(l_response_data);
    l_response_data := xmltype(l_response_data).extract('epp_packet_bnk_data/data/text()')
                       .getclobval();

    l_fd_zip   := pfu_utl.base64decode_to_blob(l_response_data);
    l_fd_unzip := utl_compress.lz_uncompress(l_fd_zip);

    l_response_data := pfu_utl.blob_to_clob(l_fd_unzip);
    l_response_data := pfu_utl.utf8todeflang(l_response_data);

    l_batch_sign := dbms_crypto.mac(l_response_data,
                                    dbms_crypto.HMAC_SH1,
                                    pfu_utl.get_salt());

    pfu_epp_utl.set_batch_response_data(p_request_id,
                                        l_response_data,
                                        l_batch_sign);

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_response_data);

    l_doc  := dbms_xmlparser.getdocument(l_parser);
    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');

    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1 loop

      l_row := dbms_xmldom.item(l_rows, i);
      -- дані пенсіонера
      l_epp_lines(i).id := s_pfu_epp_line.nextval;
      l_epp_lines(i).batch_request_id := p_request_id;
      l_epp_lines(i).line_id := dbms_xslprocessor.valueof(l_row,
                                                          'rownum/text()');
      l_epp_lines(i).epp_number := dbms_xslprocessor.valueof(l_row,
                                                             'id_epp/text()');
      l_epp_lines(i).epp_expiry_date := dbms_xslprocessor.valueof(l_row,
                                                                  'date_andpp/text()');
      l_epp_lines(i).person_record_number := dbms_xslprocessor.valueof(l_row,
                                                                       'num_zo/text()');
      l_epp_lines(i).last_name := dbms_xslprocessor.valueof(l_row,
                                                            'ln/text()');
      l_epp_lines(i).first_name := dbms_xslprocessor.valueof(l_row,
                                                             'nm/text()');
      l_epp_lines(i).middle_name := dbms_xslprocessor.valueof(l_row,
                                                              'ftn/text()');
      l_epp_lines(i).gender := dbms_xslprocessor.valueof(l_row, 'st/text()');
      l_epp_lines(i).date_of_birth := dbms_xslprocessor.valueof(l_row,
                                                                'date_birth/text()');
      l_epp_lines(i).phone_numbers := dbms_xslprocessor.valueof(l_row,
                                                                'num_tel/text()');
      l_epp_lines(i).embossing_name := dbms_xslprocessor.valueof(l_row,
                                                                 'lnf_lat/text()');
      l_epp_lines(i).tax_registration_number := dbms_xslprocessor.valueof(l_row,
                                                                          'numident/text()');
      l_epp_lines(i).document_type := dbms_xslprocessor.valueof(l_row,
                                                                'type_doc/text()');
      l_epp_lines(i).document_id := dbms_xslprocessor.valueof(l_row,
                                                              'ser_num/text()');
      l_epp_lines(i).document_issue_date := dbms_xslprocessor.valueof(l_row,
                                                                      'date_doc/text()');
      l_epp_lines(i).document_issuer := dbms_xslprocessor.valueof(l_row,
                                                                  'issued_doc/text()');
      l_epp_lines(i).displaced_person_flag := dbms_xslprocessor.valueof(l_row,
                                                                        'type_osob/text()');
      l_epp_lines(i).legal_country := dbms_xslprocessor.valueof(l_row,
                                                                'country_reg/text()');
      l_epp_lines(i).legal_zip_code := dbms_xslprocessor.valueof(l_row,
                                                                 'post_reg/text()');
      l_epp_lines(i).legal_region := dbms_xslprocessor.valueof(l_row,
                                                               'region_reg/text()');
      l_epp_lines(i).legal_district := dbms_xslprocessor.valueof(l_row,
                                                                 'area_reg/text()');
      l_epp_lines(i).legal_settlement := dbms_xslprocessor.valueof(l_row,
                                                                   'settl_reg/text()');
      l_epp_lines(i).legal_street := dbms_xslprocessor.valueof(l_row,
                                                               'street_reg/text()');
      l_epp_lines(i).legal_house := dbms_xslprocessor.valueof(l_row,
                                                              'house_reg/text()');
      l_epp_lines(i).legal_house_part := dbms_xslprocessor.valueof(l_row,
                                                                   'corps_reg/text()');
      l_epp_lines(i).legal_apartment := dbms_xslprocessor.valueof(l_row,
                                                                  'apart_reg/text()');
      l_epp_lines(i).actual_country := dbms_xslprocessor.valueof(l_row,
                                                                 'country_act/text()');
      l_epp_lines(i).actual_zip_code := dbms_xslprocessor.valueof(l_row,
                                                                  'post_act/text()');
      l_epp_lines(i).actual_region := dbms_xslprocessor.valueof(l_row,
                                                                'region_act/text()');
      l_epp_lines(i).actual_district := dbms_xslprocessor.valueof(l_row,
                                                                  'area_act/text()');
      l_epp_lines(i).actual_settlement := dbms_xslprocessor.valueof(l_row,
                                                                    'settl_act/text()');
      l_epp_lines(i).actual_street := dbms_xslprocessor.valueof(l_row,
                                                                'street_act/text()');
      l_epp_lines(i).actual_house := dbms_xslprocessor.valueof(l_row,
                                                               'house_act/text()');
      l_epp_lines(i).actual_house_part := dbms_xslprocessor.valueof(l_row,
                                                                    'corps_act/text()');
      l_epp_lines(i).actual_apartment := dbms_xslprocessor.valueof(l_row,
                                                                   'apart_act/text()');
      l_epp_lines(i).bank_mfo := dbms_xslprocessor.valueof(l_row,
                                                           'bank_mfo/text()');
      l_epp_lines(i).bank_num := dbms_xslprocessor.valueof(l_row,
                                                           'bank_num/text()');
      l_epp_lines(i).bank_name := dbms_xslprocessor.valueof(l_row,
                                                            'bank_name/text()');
      l_epp_lines(i).branch := dbms_xslprocessor.valueof(l_row,
                                                         'branch/text()');
      l_epp_lines(i).pens_type := dbms_xslprocessor.valueof(l_row,
                                                            'pens_type/text()');
      l_epp_lines(i).guardianship := dbms_xslprocessor.valueof(l_row,
                                                            'guardianship/text()');

      l_epp_lines(i).line_sign := pfu_epp_utl.calc_line_sign(l_epp_lines(i));
      l_epp_lines(i).state_id := pfu_epp_utl.LINE_STATE_NEW;

      -- дані опікуна, якщо є
      if l_epp_lines(i).guardianship = '1' then
        l_g := l_epp_line_guardian.count;
        -- отримую новий id опікуна
        l_epp_line_guardian(l_g).id := s_pfu_epp_line_guardian.nextval;
        l_epp_line_guardian(l_g).batch_request_id := p_request_id;
        -- прописую ссилку на опікуна в pfu_epp_lines
        l_epp_lines(i).guardian_id := l_epp_line_guardian(l_g).id;
        -- інші дані опікуна
        l_epp_line_guardian(l_g).person_record_number := dbms_xslprocessor.valueof(l_row,    'num_zo_g/text()');
        l_epp_line_guardian(l_g).last_name := dbms_xslprocessor.valueof(l_row,               'ln_g/text()');
        l_epp_line_guardian(l_g).first_name := dbms_xslprocessor.valueof(l_row,              'nm_g/text()');
        l_epp_line_guardian(l_g).middle_name := dbms_xslprocessor.valueof(l_row,             'ftn_g/text()');
        l_epp_line_guardian(l_g).gender := dbms_xslprocessor.valueof(l_row,                  'st_g/text()');
        l_epp_line_guardian(l_g).date_of_birth := dbms_xslprocessor.valueof(l_row,           'date_birth_g/text()');
        l_epp_line_guardian(l_g).phone_numbers := dbms_xslprocessor.valueof(l_row,           'num_tel_g/text()');
        l_epp_line_guardian(l_g).embossing_name := dbms_xslprocessor.valueof(l_row,          'lnf_lat_g/text()');
        l_epp_line_guardian(l_g).tax_registration_number := dbms_xslprocessor.valueof(l_row, 'numident_g/text()');
        l_epp_line_guardian(l_g).document_type := dbms_xslprocessor.valueof(l_row,           'type_doc_g/text()');
        l_epp_line_guardian(l_g).document_id := dbms_xslprocessor.valueof(l_row,             'ser_num_g/text()');
        l_epp_line_guardian(l_g).document_issue_date := dbms_xslprocessor.valueof(l_row,     'date_doc_g/text()');
        l_epp_line_guardian(l_g).document_issuer := dbms_xslprocessor.valueof(l_row,         'issued_doc_g/text()');
        l_epp_line_guardian(l_g).displaced_person_flag := dbms_xslprocessor.valueof(l_row,   'type_osob_g/text()');
        l_epp_line_guardian(l_g).pens_type := dbms_xslprocessor.valueof(l_row,               'pens_type_g/text()');
        l_epp_line_guardian(l_g).legal_country := dbms_xslprocessor.valueof(l_row,           'country_reg_g/text()');
        l_epp_line_guardian(l_g).legal_zip_code := dbms_xslprocessor.valueof(l_row,          'post_reg_g/text()');
        l_epp_line_guardian(l_g).legal_region := dbms_xslprocessor.valueof(l_row,            'region_reg_g/text()');
        l_epp_line_guardian(l_g).legal_district := dbms_xslprocessor.valueof(l_row,          'area_reg_g/text()');
        l_epp_line_guardian(l_g).legal_settlement := dbms_xslprocessor.valueof(l_row,        'settl_reg_g/text()');
        l_epp_line_guardian(l_g).legal_street := dbms_xslprocessor.valueof(l_row,            'street_reg_g/text()');
        l_epp_line_guardian(l_g).legal_house := dbms_xslprocessor.valueof(l_row,             'house_reg_g/text()');
        l_epp_line_guardian(l_g).legal_house_part := dbms_xslprocessor.valueof(l_row,        'corps_reg_g/text()');
        l_epp_line_guardian(l_g).legal_apartment := dbms_xslprocessor.valueof(l_row,         'apart_reg_g/text()');
        l_epp_line_guardian(l_g).actual_country := dbms_xslprocessor.valueof(l_row,          'country_act_g/text()');
        l_epp_line_guardian(l_g).actual_zip_code := dbms_xslprocessor.valueof(l_row,         'post_act_g/text()');
        l_epp_line_guardian(l_g).actual_region := dbms_xslprocessor.valueof(l_row,           'region_act_g/text()');
        l_epp_line_guardian(l_g).actual_district := dbms_xslprocessor.valueof(l_row,         'area_act_g/text()');
        l_epp_line_guardian(l_g).actual_settlement := dbms_xslprocessor.valueof(l_row,       'settl_act_g/text()');
        l_epp_line_guardian(l_g).actual_street := dbms_xslprocessor.valueof(l_row,           'street_act_g/text()');
        l_epp_line_guardian(l_g).actual_house := dbms_xslprocessor.valueof(l_row,            'house_act_g/text()');
        l_epp_line_guardian(l_g).actual_house_part := dbms_xslprocessor.valueof(l_row,       'corps_act_g/text()');
        l_epp_line_guardian(l_g).actual_apartment := dbms_xslprocessor.valueof(l_row,        'apart_act_g/text()');
        --l_epp_line_guardian(i).line_sign := pfu_epp_utl.calc_line_sign(l_epp_line_guardian(i));
        l_epp_line_guardian(l_g).state_id := pfu_epp_utl.LINE_STATE_NEW;
      end if;
    end loop;

    dbms_xmlparser.freeParser(l_parser);
    dbms_xmldom.freeNodeList(l_rows);
    dbms_xmldom.freeNode(l_row);
    dbms_xmldom.freeDocument(l_doc);

    if (l_epp_lines is null or l_epp_lines.count() = 0) then
      return;
    end if;

    forall i in indices of l_epp_lines
      insert into pfu_epp_line values l_epp_lines (i);

    forall i in indices of l_epp_lines
      insert into pfu_epp_line_tracking
      values
        (pfu_epp_line_tracking_seq.nextval,
         l_epp_lines(i).id,
         pfu_epp_utl.LINE_STATE_NEW,
         sysdate,
         null,
         null);

    -- якщо є опікуни, то парсимо спочатку опікунів (бо в validate_epp_lines вкінці формується квитанція1)
    -- в поточній реалізації помилки валідації пенса і опікуна об'єднані (тобто якщо пао одному з них помилка то вважаємо що помилка валідації по пенсу)
    -- TODO: in process
    if not (l_epp_line_guardian is null or l_epp_line_guardian.count() = 0) then
      forall i in indices of l_epp_line_guardian
        insert into pfu_epp_line_guardian values l_epp_line_guardian (i);

      validate_epp_guardians(p_request_id);
    end if;
    --

    validate_epp_lines(p_request_id);

    finish_data_part_sessions(l_sessions);
  end;

  procedure process_w4_statuses is
    --обробка записів в w4_epp_statuses
  begin
    for c0 in (select w.*, p.id as lid
                 from w4_epp_statuses w
                 join pfu_epp_line p
                   on w.id_epp = p.epp_number
                where w.work_state = 0 --не оброблені записи в w4_epp_statuses
                  for update skip locked) loop
      --oper_type - тип операції над карткою
      if c0.oper_type = 0 then
        --активация
        -- для лайна проставляється статус 12 (LINE_STATE_W4_ACTIVATED)
        pfu_epp_utl.set_epp_activate(p_line_id               => c0.lid,
                                     p_tracking_comment      => nvl(c0.comments,
                                                                    'Активація карти у W4'),
                                     p_date                  => c0.datein,
                                     p_sign_pass_change_flag => c0.ch_pass);
      elsif c0.oper_type = 20 then
        --розблокування
        --для лайна проставляється статус 18(LINE_STATE_CARD_UNBLOCKED)
        pfu_epp_utl.set_epp_unblock(p_line_id          => c0.lid,
                                    p_tracking_comment => nvl(c0.comments,
                                                              'Розблокування картки у W4'),
                                    p_date             => c0.datein);
      elsif c0.oper_type = 21 then
        --блокування
        --для лайна проставляється статус 17(LINE_STATE_CARD_BLOCKED)
        pfu_epp_utl.set_epp_block(p_line_id          => c0.lid,
                                  p_tracking_comment => nvl(c0.comments,
                                                            'Блокування картки у W4'),
                                  p_date             => c0.datein);
      elsif c0.oper_type = 22 then
        --блокування
        --для лайна проставляється статус 17(LINE_STATE_CARD_BLOCKED)
        pfu_epp_utl.set_epp_block_dblk(p_line_id          => c0.lid,
                                  p_tracking_comment => nvl(c0.comments,
                                                            'Блокування картки у W4'),
                                  p_date             => c0.datein);
      elsif c0.oper_type = 23 then
        --блокування
        --для лайна проставляється статус 17(LINE_STATE_CARD_BLOCKED)
        pfu_epp_utl.set_epp_unblock_dblk(p_line_id          => c0.lid,
                                  p_tracking_comment => nvl(c0.comments,
                                                            'Розблокування картки у W4'),
                                  p_date             => c0.datein);
      end if;
      --проставляємо для work_state =1 типу оброблений
      update w4_epp_statuses w set w.work_state = 1 where w.id = c0.id;
    end loop;

    for c0 in (select w.*
                 from w4_epp_statuses w
                where w.work_state = 0
                  and w.id_epp is null
                  for update skip locked) loop
        --блокування
        --для лайна проставляється статус 17(LINE_STATE_CARD_BLOCKED)
        if c0.oper_type = 22  then
            pfu_epp_utl.set_acc_block_dblk(p_nls          => c0.nls,
                                           p_kf           => c0.kf,
                                           p_tracking_comment => nvl(c0.comments,
                                                                'Блокування рахунку у W4'),
                                           p_date             => c0.datein);
        elsif c0.oper_type = 23  then
            pfu_epp_utl.set_acc_unblock_dblk(p_nls          => c0.nls,
                                           p_kf           => c0.kf,
                                           p_tracking_comment => nvl(c0.comments,
                                                                'Розблокування рахунку у W4'),
                                           p_date             => c0.datein);
        end  if;
      --проставляємо для work_state =1 типу оброблений
      update w4_epp_statuses w set w.work_state = 1 where w.id = c0.id;
    end loop;

    --   delete from w4_epp_statuses;
  end;

  procedure parse_fio(p_fio       in varchar2,
                      p_lastname  out varchar2,
                      p_firstname out varchar2,
                      p_surname   out varchar2) is
    l_fio varchar2(3000) := p_fio;
  begin
    p_lastname  := substr(l_fio, 1, instr(l_fio, ' ') - 1);
    l_fio       := substr(l_fio, instr(l_fio, ' ') + 1);
    p_firstname := substr(l_fio, 1, instr(l_fio, ' ') - 1);
    l_fio       := substr(l_fio, instr(l_fio, ' ') + 1);
    p_surname   := l_fio; --substr(l_fio, 1, instr(l_fio, ' ') - 1);
  end;

  function get_sernum(p_identcode in varchar2) return varchar2 is
    l_sernum varchar2(30);
  begin
    select pp.ser || ' ' || pp.numdoc
      into l_sernum
      from pfu_pensioner pp
     where pp.okpo = p_identcode;
    return l_sernum;
  exception
    when others then
      return l_sernum;

  end;

  function get_count_wrong_row(p_env_id      in integer,
                               p_right_state in integer) return integer is
    l_cnt integer := 0;
  begin
    select count(1)
      into l_cnt
      from pfu_file_records pfr
     where pfr.pfu_envelope_id = p_env_id
       and pfr.state != p_right_state;
    return l_cnt;
  end;

  function get_sum_wrong_row(p_env_id in integer, p_right_state in integer)
    return number is
    l_sum integer := 0;
  begin
    select sum(pfr.sum_pay)
      into l_sum
      from pfu_file_records pfr
     where pfr.pfu_envelope_id = p_env_id
       and pfr.state != p_right_state;
    return l_sum;
  end;

  function get_count_wrong_row_file(p_file_id     in integer,
                                    p_right_state in integer) return integer is
    l_cnt integer := 0;
  begin
    select count(1)
      into l_cnt
      from pfu_file_records pfr
     where pfr.file_id = p_file_id
       and pfr.state != p_right_state;
    return l_cnt;
  end;

  function get_sum_wrong_row_file(p_file_id     in integer,
                                  p_right_state in integer) return number is
    l_sum integer := 0;
  begin
    select sum(pfr.sum_pay)
      into l_sum
      from pfu_file_records pfr
     where pfr.file_id = p_file_id
       and pfr.state != p_right_state;
    return l_sum;
  end;

  function prepare_matching1(p_env_id   in integer,
                             p_enc_type in number default 0) return clob is
    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_header_node dbms_xmldom.DOMNode;
    l_body_node   dbms_xmldom.DOMNode;
    l_row_node    dbms_xmldom.DOMNode;
    l_file_rec    pfu_file%rowtype;
    l_firstname   varchar2(3000);
    l_lastname    varchar2(3000);
    l_surname     varchar2(3000);
    l_pfu_env_id  pfu_envelope_request.pfu_envelope_id%type;
    l_count_lines pfu_envelope_request.check_lines_count%type;
    l_blob_xml    blob;
    l_blob_zip    blob;
    l_clob_base64 clob;
  begin
    l_doc := dbms_xmldom.newDomDocument;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declar')));

    select per.pfu_envelope_id, per.check_lines_count
      into l_pfu_env_id, l_count_lines
      from pfu_envelope_request per
     where per.id = p_env_id;

    l_header_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'declarhead')));
    add_text_node_utl(l_doc,
                      l_header_node,
                      'date_time',
                      to_char(sysdate, 'dd.mm.yyyy hh24.mi.ss'));
    add_text_node_utl(l_doc, l_header_node, 'full_lines', l_count_lines);
    add_text_node_utl(l_doc, l_header_node, 'res_file', 0);
    l_body_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declarbody')));
    for rec_frec in (select rownum, pfr.*

                       from pfu_file_records pfr
                      where pfr.pfu_envelope_id = l_pfu_env_id) loop
      l_row_node := dbms_xmldom.appendChild(l_body_node,
                                            dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                           'row')));
      parse_fio(rec_frec.full_name, l_lastname, l_firstname, l_surname);
      add_text_node_utl(l_doc, l_row_node, 'rownum', rec_frec.rownum);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'num_list',
                        rec_frec.file_number);
      add_text_node_utl(l_doc, l_row_node, 'ln', l_lastname);
      add_text_node_utl(l_doc, l_row_node, 'nm', l_firstname);
      add_text_node_utl(l_doc, l_row_node, 'ftn', l_surname);
      add_text_node_utl(l_doc, l_row_node, 'numident', rec_frec.numident);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'ser_num',
                        get_sernum(rec_frec.numident));
      add_text_node_utl(l_doc, l_row_node, 'num_acc', rec_frec.num_acc);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'result',
                        case rec_frec.state when 13 then 3 when 14 then 4 when 15 then 5 when 16 then 6 else
                        rec_frec.state end);
    end loop;

    l_blob_xml := pfu_utl.clob_to_blob(dbms_xmldom.getXmlType(l_doc)
                                       .getClobVal());
    l_blob_zip := utl_compress.lz_compress(l_blob_xml);
    if p_enc_type = 1 then
      return pfu_utl.blob_to_hex(l_blob_zip);
    end if;
    l_clob_base64 := pfu_utl.pfu_encode_base64(l_blob_zip);

    return l_clob_base64;
  end;

  function prepare_matching2(p_file_id  in integer,
                             p_enc_type in number default 0) return clob is
    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_header_node dbms_xmldom.DOMNode;
    l_body_node   dbms_xmldom.DOMNode;
    l_row_node    dbms_xmldom.DOMNode;
    l_file_rec    pfu_file%rowtype;
    l_firstname   varchar2(3000);
    l_lastname    varchar2(3000);
    l_surname     varchar2(3000);
    l_blob_xml    blob;
    l_blob_zip    blob;
    l_clob_base64 clob;
  begin
    l_doc := dbms_xmldom.newDomDocument;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declar')));

    select * into l_file_rec from pfu_file pf where pf.id = p_file_id;

    l_header_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'declarhead')));
    add_text_node_utl(l_doc,
                      l_header_node,
                      'date_time',
                      to_char(sysdate, 'dd.mm.yyyy hh24.mi.ss'));
    add_text_node_utl(l_doc,
                      l_header_node,
                      'full_lines',
                      l_file_rec.check_lines_count);
    l_body_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declarbody')));

    for rec_frec in (select rownum, pfr.*
                       from pfu_file_records pfr
                      where pfr.file_id = p_file_id) loop
      l_row_node := dbms_xmldom.appendChild(l_body_node,
                                            dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                           'row')));
      parse_fio(rec_frec.full_name, l_lastname, l_firstname, l_surname);
      add_text_node_utl(l_doc, l_row_node, 'rownum', rec_frec.rownum);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'id_convert',
                        rec_frec.pfu_envelope_id);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'num_list',
                        rec_frec.file_number);
      add_text_node_utl(l_doc, l_row_node, 'ln', l_lastname);
      add_text_node_utl(l_doc, l_row_node, 'nm', l_firstname);
      add_text_node_utl(l_doc, l_row_node, 'ftn', l_surname);
      add_text_node_utl(l_doc, l_row_node, 'numident', rec_frec.numident);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'ser_num',
                        get_sernum(rec_frec.numident));
      add_text_node_utl(l_doc, l_row_node, 'num_acc', rec_frec.num_acc);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'date_enr',
                        to_char(rec_frec.date_pay, 'ddmmyyyy'));
      add_text_node_utl(l_doc, l_row_node, 'sum_pay', rec_frec.sum_pay);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'result',
                        case rec_frec.state when 10 then 0 when 13 then 3 when 14 then 4 when 15 then 5 when 16 then 6 else 7 end);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'date_return',
                        rec_frec.DATE_PAYBACK);
      add_text_node_utl(l_doc, l_row_node, 'num_return', rec_frec.NUM_PAYM);
    end loop;
    l_blob_xml := pfu_utl.clob_to_blob(dbms_xmldom.getXmlType(l_doc)
                                       .getClobVal());
    l_blob_zip := utl_compress.lz_compress(l_blob_xml);
    if p_enc_type = 1 then
      return pfu_utl.blob_to_hex(l_blob_zip);
    end if;
    l_clob_base64 := pfu_utl.pfu_encode_base64(l_blob_zip);
  return l_clob_base64;
  end;

  -----------------------------------------------------------------------------------------
  --  prepare_kvt2
  --
  --    Створення файлу квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2) - insert pfu_matching_request2, state = 'NEW'
  --
  procedure prepare_epp_kvt2
  is
    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_header_node dbms_xmldom.DOMNode;
    l_body_node   dbms_xmldom.DOMNode;
    l_row_node    dbms_xmldom.DOMNode;
    l_res_file    varchar2(1 char);
    l_firstname   varchar2(3000);
    l_lastname    varchar2(3000);
    l_surname     varchar2(3000);
    l_clob        clob;
    l_create_date date := sysdate;
    l_match_req2_rec pfu_matching_request2%rowtype;
    l_errm        varchar2(4000);
    --l_blob_xml    blob;
    --l_blob_zip    blob;
    --l_clob_base64 clob;
  begin
    for file in (select distinct batch_request_id from pfu_epp_line_bnk_state2 where stage_ticket = 2)
    loop
      l_doc := dbms_xmldom.newDomDocument;

      l_root_node := dbms_xmldom.makeNode(l_doc);
      l_root_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc, 'declar')));

      select to_char(max(case when s.pfu_result in (0) then 0 else 1 end)) res_file
        into l_res_file
        from pfu_epp_line_bnk_state2 s
       where batch_request_id = file.batch_request_id;

      -- заголовок файлу
      l_header_node := dbms_xmldom.appendChild(l_root_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc, 'declarhead')));
      -- рядки файлу
      add_text_node_utl(l_doc,
                        l_header_node,
                        'date_time',
                        to_char(l_create_date, 'dd.mm.yyyy hh24.mi.ss'));
      add_text_node_utl(l_doc,
                        l_header_node,
                        'res_file',
                        l_res_file);

      l_body_node := dbms_xmldom.appendChild(l_root_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc, 'declarbody')));

      for rec in (select to_char(s.rn)         as rn, -- pfu_epp_line.line_id
                         s.epp_number          as id_epp,
                         to_char(s.pfu_result) as pfu_result,
                         s.res_tag             as res_tag,
                         s.ps_type             as ps_type,
                         case s.pfu_result when 0 then coalesce(to_char(s.epp_expiry_date, 'dd.mm.yyyy'),'') else '' end as date_end
                  from pfu_epp_line_bnk_state2 s
                  where s.batch_request_id = file.batch_request_id)
      loop
        l_row_node := dbms_xmldom.appendChild(l_body_node, dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc, 'row')));
        add_text_node_utl(l_doc, l_row_node, 'rownum',   rec.rn);
        add_text_node_utl(l_doc, l_row_node, 'id_epp',   rec.id_epp);
        add_text_node_utl(l_doc, l_row_node, 'result',   rec.pfu_result);
        add_text_node_utl(l_doc, l_row_node, 'res_teg',  rec.res_tag);
        add_text_node_utl(l_doc, l_row_node, 'Ps_type',  rec.ps_type);
        add_text_node_utl(l_doc, l_row_node, 'Date_end', rec.date_end);
      end loop;

      l_clob := dbms_xmldom.getXmlType(l_doc).getClobVal();

      begin
        select * into l_match_req2_rec from pfu_matching_request2 m where m.batch_request_id = file.batch_request_id;
        -- if l_match_req2_rec.state in ('NEW') then
        -- згідно уточнення по ТЗ: квитанцію можна переформувати в любому стані
        update pfu_matching_request2
           set create_date = l_create_date,
               xml_data = l_clob,
               state = 'NEW'
         where batch_request_id = file.batch_request_id;
        --else
        --  raise_application_error(-20001, 'Квитанція вже була відправлена. Переформувати не можливо');
        --end if;
      exception
        when no_data_found then
          insert into pfu_matching_request2 (batch_request_id, state, create_date, xml_data)
          values (file.batch_request_id, 'NEW', l_create_date, l_clob);
        when others then
          l_errm := sqlerrm || ' ' ||dbms_utility.format_error_backtrace();
          update pfu_matching_request2 s
             set create_date = l_create_date,
                 s.state = 'ERROR',
                 s.comm  = l_errm
           where batch_request_id = file.batch_request_id;
      end;
      update pfu_epp_line_bnk_state2 s set s.stage_ticket = null where batch_request_id = file.batch_request_id;
      commit;
    end loop;
  exception
    when others then
      --bars.bars_audit.info('pfu_service_utl.prepare_epp_kvt2 error '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
      raise_application_error(-20000, 'pfu_service_utl.prepare_epp_kvt2 error '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end prepare_epp_kvt2;

  -----------------------------------------------------------------------------------------
  --  prepare_kvt2result
  --
  --    Оновлення результатів опрацювання кожного запису файлу для квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2) - update pfu_epp_line_bnk_state2 pfu_result, res_teg
  --
  procedure prepare_epp_kvt2_result
  is
  begin
    -- оновлення результатів опрацювання кожного запису файлу
    merge into (select * from pfu_epp_line_bnk_state2 where stage_ticket = 1) e
    using (select s.epp_line_id,
                  case s.state_id
                    when 11 then 0 -- ok
                    when 20 then 4 -- нова заявка
                    when 10 then 4 -- операція в обробці
                    else coalesce(m.pfu_result,2) end pfu_result, -- не визначений рахуємо помилкою (2)
                  case when m.id in (3) then to_char(s.error_stack) else m.pfu_tag end pfu_tag -- згідно ТЗ по коду 3 мапінга треба брати тег із поля error_stack
           from pfu_epp_line_bnk_state2 s
                left join pfu_bnk_state2_mapping m on  lower(s.comm) like '%'||lower(m.msg)||'%'
           where s.stage_ticket in (1) -- 1 - очікує формування pfu_result для квитанції 2
           ) t on (e.epp_line_id = t.epp_line_id)
    when matched then
      update set e.pfu_result   = t.pfu_result,
                 e.res_tag      = t.pfu_tag;

    -- проставляю статус для формування кв 2
    update pfu_epp_line_bnk_state2 e
       set stage_ticket = 2
     where e.batch_request_id in
           (select distinct batch_request_id from pfu_epp_line_bnk_state2 where stage_ticket = 1);

    /*
    -- оновлення результатів опрацювання кожного запису файлу
    update pfu_epp_line_bnk_state2 s
       set stage_ticket = 2, -- проставляю зразу статус для формування файла кв2
           pfu_result   = case state_id
                            when 11 then 0 -- ok
                            when 20 then 4 --
                            when 10 then 4 --
                            when  9 then 2 --
                            when  7 then 2 --
                          else 2 end / * не визначений рахуємо помилкою * /,
           res_tag      = null
     where stage_ticket = 1;
     */

    commit;

    -- статус для формування файла кв2
    -- update pfu_epp_line_bnk_state2 set stage_ticket = 2 where stage_ticket = 1;
  exception
    when others then
      --bars.bars_audit.info('pfu_service_utl.prepare_epp_kvt2_result error '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
      raise_application_error(-20000, 'pfu_service_utl.prepare_epp_kvt2_result error '||dbms_utility.format_error_backtrace || ' ' || sqlerrm);
  end prepare_epp_kvt2_result;

  function prepare_death_matching(p_death_id in integer,
                                  p_enc_type in number default 0) return clob is
    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_header_node dbms_xmldom.DOMNode;
    l_body_node   dbms_xmldom.DOMNode;
    l_row_node    dbms_xmldom.DOMNode;
    l_file_rec    pfu_death%rowtype;
    l_blob_xml    blob;
    l_blob_zip    blob;
    l_clob_base64 clob;
  begin
    l_doc := dbms_xmldom.newDomDocument;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declar')));

    select * into l_file_rec from pfu_death pf where pf.id = p_death_id;

    l_header_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'declarhead')));
    add_text_node_utl(l_doc,
                      l_header_node,
                      'date_time',
                      to_char(sysdate, 'dd.mm.yyyy hh24.mi.ss'));
    add_text_node_utl(l_doc,
                      l_header_node,
                      'full_lines',
                      l_file_rec.count_res);
    add_text_node_utl(l_doc, l_header_node, 'res_file', 0); -- &&&&&&&&);
    l_body_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declarbody')));

    for rec_frec in (select rownum, pd.*
                       from pfu_death_record pd
                      where pd.list_id = p_death_id) loop
      l_row_node := dbms_xmldom.appendChild(l_body_node,
                                            dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                           'row')));
      add_text_node_utl(l_doc, l_row_node, 'rownum', rec_frec.rownum);
      add_text_node_utl(l_doc, l_row_node, 'ln', rec_frec.last_name);
      add_text_node_utl(l_doc, l_row_node, 'nm', rec_frec.first_name);
      add_text_node_utl(l_doc, l_row_node, 'ftn', rec_frec.father_name);
      add_text_node_utl(l_doc, l_row_node, 'numident', rec_frec.okpo);
      add_text_node_utl(l_doc, l_row_node, 'ser_num', rec_frec.doc_num);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'result',
                        case when rec_frec.state in ('PROCESSED', 'PAYED') then 0 when
                        rec_frec.state = 'ERR_ACC_OKPO' then 1 when
                        rec_frec.state = 'ERR_NAME' then 2 when
                        rec_frec.state = 'ERR_ACC_CLOSE' then 3 when
                        rec_frec.state = 'ERR_OKPO' then 5 when
                        rec_frec.state = 'ERR_BLOCKED' then 6 end);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'date_return',
                        rec_frec.DATE_PAYBACK);
      add_text_node_utl(l_doc, l_row_node, 'num_return', rec_frec.NUM_PAYM);
--                        rec_frec.date_pay);
      add_text_node_utl(l_doc, l_row_node, 'num_return', rec_frec.ref);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'sum_return',
                        rec_frec.sum_payed);
    end loop;
    l_blob_xml := pfu_utl.clob_to_blob(dbms_xmldom.getXmlType(l_doc)
                                       .getClobVal());
    l_blob_zip := utl_compress.lz_compress(l_blob_xml);
    if p_enc_type = 1 then
      return pfu_utl.blob_to_hex(l_blob_zip);
    end if;
    l_clob_base64 := pfu_utl.pfu_encode_base64(l_blob_zip);

    return l_clob_base64;
  end;

  function prepare_no_turnover(p_nt_id    in integer,
                               p_mfo      in varchar2,
                               p_enc_type in number default 0) return clob is
    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_header_node dbms_xmldom.DOMNode;
    l_body_node   dbms_xmldom.DOMNode;
    l_row_node    dbms_xmldom.DOMNode;
    l_file_rec    pfu_no_turnover_list%rowtype;
    l_blob_xml    blob;
    l_blob_zip    blob;
    l_clob_base64 clob;
    l_cnt         number;
  begin
    l_doc := dbms_xmldom.newDomDocument;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declar')));

    select *
      into l_file_rec
      from pfu_no_turnover_list pt
     where pt.id = p_nt_id
       and pt.kf = p_mfo;

    select count(*)
      into l_cnt
      from pfu_no_turnover t
     where t.id_file = p_nt_id
       and t.kf = p_mfo;

    l_header_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'declarhead')));
    add_text_node_utl(l_doc,
                      l_header_node,
                      'date_time',
                      to_char(sysdate, 'dd.mm.yyyy hh24.mi.ss'));
    add_text_node_utl(l_doc, l_header_node, 'full_lines', l_cnt);
    add_text_node_utl(l_doc, l_header_node, 'res_file', 0); -- &&&&&&&&);

    for rec_frec in (select rownum, pd.*
                       from pfu_no_turnover pd
                      where pd.id_file = p_nt_id) loop
      l_row_node := dbms_xmldom.appendChild(l_body_node,
                                            dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                           'row')));
      add_text_node_utl(l_doc, l_row_node, 'rownum', rec_frec.rownum);
      add_text_node_utl(l_doc, l_row_node, 'ln', rec_frec.last_name);
      add_text_node_utl(l_doc, l_row_node, 'nm', rec_frec.name);
      add_text_node_utl(l_doc, l_row_node, 'ftn', rec_frec.father_name);
      add_text_node_utl(l_doc, l_row_node, 'numident', rec_frec.okpo);
      add_text_node_utl(l_doc, l_row_node, 'ser_num', rec_frec.ser_num);
      add_text_node_utl(l_doc, l_row_node, 'num_acc', rec_frec.num_acc);
      add_text_node_utl(l_doc, l_row_node, 'date_last', rec_frec.date_last);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'ndays',
                        trunc(sysdate) - rec_frec.date_last);
    end loop;
    l_blob_xml := pfu_utl.clob_to_blob(dbms_xmldom.getXmlType(l_doc)
                                       .getClobVal());
    l_blob_zip := utl_compress.lz_compress(l_blob_xml);
    if p_enc_type = 1 then
      return pfu_utl.blob_to_hex(l_blob_zip);
    end if;
    l_clob_base64 := pfu_utl.pfu_encode_base64(l_blob_zip);

    return l_clob_base64;
  end;

  procedure gen_epp_matching1(p_batch_id in integer) is
    --генерація першої квитанції
    l_doc          dbms_xmldom.DOMDocument;
    l_doc1         dbms_xmldom.DOMDocument;
    l_root_node    dbms_xmldom.DOMNode;
    l_header_node  dbms_xmldom.DOMNode;
    l_body_node    dbms_xmldom.DOMNode;
    l_row_node     dbms_xmldom.DOMNode;
    l_date_cr      date;
    l_err_str      clob;
    l_clob_xml     clob;
    l_blob_xml     blob;
    l_blob_zip     blob;
    l_clob_res     clob;
    l_clob_base64  clob;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_pfu_batch    integer;
    l_warning      integer;
  begin
    l_doc := dbms_xmldom.newDomDocument;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declar')));

    l_header_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'declarhead')));
    add_text_node_utl(l_doc,
                      l_header_node,
                      'date_time',
                      to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
    add_text_node_utl(l_doc, l_header_node, 'res_file', 0);
    l_body_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'declarbody')));

    for rec_line in (select pel.*
                       from pfu_epp_line pel
                      where pel.batch_request_id = p_batch_id) loop
      l_row_node := dbms_xmldom.appendChild(l_body_node,
                                            dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                           'row')));
      add_text_node_utl(l_doc, l_row_node, 'rownum', rec_line.line_id);
      add_text_node_utl(l_doc, l_row_node, 'id_epp', rec_line.epp_number);
      add_text_node_utl(l_doc,
                        l_row_node,
                        'result',
                        case rec_line.state_id when 2 then 0 else 1 end);
      if rec_line.state_id != 2 then
        begin
          select pelt.error_stack
            into l_err_str
            from pfu_epp_line_tracking pelt
           where pelt.rowid = (select min(track.rowid) keep(dense_rank last order by pelt.id desc)
                                 from pfu_epp_line_tracking track
                                where track.line_id = rec_line.id
                                  and track.state_id = 3);
        exception
          when no_data_found then
            l_err_str := '';
        end;
        add_text_node_utl(l_doc, l_row_node, 'res_teg', l_err_str);
      end if;
    end loop;

    l_doc1 := dbms_xmldom.newDomDocument;

    l_root_node := dbms_xmldom.makeNode(l_doc1);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc1,
                                                                                          'epp_packet_bnk_state')));

    select pebr.pfu_batch_id
      into l_pfu_batch
      from pfu_epp_batch_request pebr
     where pebr.id = p_batch_id;

    l_blob_xml    := pfu_utl.clob_to_blob(dbms_xmldom.getXmlType(l_doc)
                                          .getClobVal());
    l_blob_zip    := utl_compress.lz_compress(l_blob_xml);
    l_clob_base64 := pfu_utl.pfu_encode_base64(l_blob_zip);

    add_text_node_utl(l_doc1, l_root_node, 'id', l_pfu_batch);
    add_text_node_utl(l_doc1, l_root_node, 'data', l_clob_base64);

    pfu_utl.create_epp_matching(dbms_xmldom.getXmlType(l_doc1).getClobVal(),
                                p_batch_id);

  end;

  procedure gen_epp_matching2 is
    l_doc         dbms_xmldom.DOMDocument;
    l_doc1        dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_root_node1  dbms_xmldom.DOMNode;
    l_header_node dbms_xmldom.DOMNode;
    l_body_node   dbms_xmldom.DOMNode;
    l_row_node    dbms_xmldom.DOMNode;

    l_blob_xml    blob;
    l_blob_zip    blob;
    l_clob_res    clob;
    l_clob_base64 clob;

    l_record_update T_EPP_LINE_TAB;

    l_lines_count integer := 0;
    l_state       integer;
    l_date        varchar2(20);
    l_change_pass integer;
  begin
    select *
      bulk collect
      into l_record_update
      from pfu_epp_line t
     where t.state_id in (pfu_epp_utl.LINE_STATE_ACTIVATED,
                          pfu_epp_utl.LINE_STATE_DESTRUCTED)
       for update;

    select count(*)
      into l_lines_count
      from pfu_epp_line t
     where t.state_id = pfu_epp_utl.LINE_STATE_ACTIVATED
        or (t.state_id = pfu_epp_utl.LINE_STATE_DESTRUCTED and
           t.epp_number in
           (select p.epp_number from pfu_epp_killed p where p.state = 0));

    if l_lines_count > 0 then
      l_doc := dbms_xmldom.newDomDocument;

      l_root_node := dbms_xmldom.makeNode(l_doc);
      l_root_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'declar')));

      l_header_node := dbms_xmldom.appendChild(l_root_node,
                                               dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                              'declarhead')));
      add_text_node_utl(l_doc,
                        l_header_node,
                        'date_time',
                        to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'));
      add_text_node_utl(l_doc, l_header_node, 'full_lines', l_lines_count);

      l_body_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'declarbody')));

      for i in 1 .. l_record_update.count loop

        if (l_record_update(i).state_id = pfu_epp_utl.LINE_STATE_ACTIVATED) then
          l_state       := 0;
          l_date        := to_char(l_record_update(i).activation_date,
                                   'ddmmyyyy');
          l_change_pass := l_record_update(i).sign_pass_change_flag;
        elsif (l_record_update(i)
              .state_id = pfu_epp_utl.LINE_STATE_DESTRUCTED) then
          select ep.kill_type, to_char(ep.kill_date, 'ddmmyyyy')
            into l_state, l_date
            from pfu_epp_killed ep
           where ep.epp_number = l_record_update(i).epp_number;
          l_change_pass := 0;
        end if;

        l_lines_count := l_lines_count + 1;

        l_row_node := dbms_xmldom.appendChild(l_body_node,
                                              dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                             'row')));

        add_text_node_utl(l_doc, l_row_node, 'rownum', l_lines_count);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'id_epp',
                          l_record_update(i).epp_number);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'num_zo',
                          l_record_update(i).person_record_number);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'ln',
                          l_record_update(i).last_name);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'nm',
                          l_record_update(i).first_name);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'ftn',
                          l_record_update(i).middle_name);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'numident',
                          l_record_update(i).tax_registration_number);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'ser_num',
                          l_record_update(i).document_id);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'acc_person',
                          l_record_update(i).account_number);
        add_text_node_utl(l_doc, l_row_node, 'oznaka', l_state);
        add_text_node_utl(l_doc,
                          l_row_node,
                          'bank_num',
                          substr(l_record_update(i).bank_name, 1, 10));
        add_text_node_utl(l_doc,
                          l_row_node,
                          'bank_name',
                          substr(l_record_update(i).bank_name, 14));
        add_text_node_utl(l_doc,
                          l_row_node,
                          'branch',
                          l_record_update(i).bank_num);
        add_text_node_utl(l_doc, l_row_node, 'date_isspp', l_date);
        add_text_node_utl(l_doc, l_row_node, 'ch_pass', l_change_pass);

        if (l_record_update(i).state_id = pfu_epp_utl.LINE_STATE_DESTRUCTED) then
          update pfu_epp_killed p
             set p.state = 1
           where p.epp_number = l_record_update(i).epp_number;
        end if;
        update pfu_epp_line p
           set p.state_id = pfu_epp_utl.LINE_STATE_SENT_TO_PFU
         where p.epp_number = l_record_update(i).epp_number;
      end loop;

      l_doc1 := dbms_xmldom.newDomDocument;

      l_root_node := dbms_xmldom.makeNode(l_doc1);
      l_root_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc1,
                                                                                            'epp_bnk_info')));

      l_blob_xml    := pfu_utl.clob_to_blob(dbms_xmldom.getXmlType(l_doc)
                                            .getClobVal());
      l_blob_zip    := utl_compress.lz_compress(l_blob_xml);
      l_clob_base64 := pfu_utl.pfu_encode_base64(l_blob_zip);
      add_clob_node_utl(l_doc1, l_root_node, 'data', l_clob_base64);

      pfu_utl.create_epp_activation(dbms_xmldom.getXmlType(l_doc1)
                                    .getClobVal());
    end if;
  end;

  procedure gen_matching1(p_env_id in integer, p_ecp in varchar2) is
    l_doc         dbms_xmldom.DOMDocument;
    l_root_node   dbms_xmldom.DOMNode;
    l_header_node dbms_xmldom.DOMNode;
    l_body_node   dbms_xmldom.DOMNode;
    l_row_node    dbms_xmldom.DOMNode;
    l_env_rec     pfu_envelope_request%rowtype;
    l_date_cr     date;
    l_clob_xml    clob;

    l_clob_res clob;

    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_warning      integer;
  begin
    l_doc     := dbms_xmldom.newDomDocument;
    l_date_cr := sysdate;
    select *
      into l_env_rec
      from pfu_envelope_request pf
     where pf.id = p_env_id;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'paymentlists')));
    add_text_node_utl(l_doc, l_root_node, 'id', l_env_rec.pfu_envelope_id);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'opfu_code',
                      l_env_rec.pfu_branch_code);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'opfu_name',
                      l_env_rec.pfu_branch_name);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'date_time',
                      to_char(l_date_cr, 'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_root_node,
                      'MFO_filia',
                      l_env_rec.receiver_mfo);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'filia_num',
                      l_env_rec.receiver_branch);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'filia_name',
                      nvl(l_env_rec.receiver_name, 'Не данных'));
    add_text_node_utl(l_doc,
                      l_root_node,
                      'full_lines',
                      l_env_rec.check_lines_count);
    add_text_node_utl(l_doc, l_root_node, 'res_file', 0);

    l_clob_xml := prepare_matching1(p_env_id);

    add_clob_node_utl(l_doc, l_root_node, 'pca_data', l_clob_xml);

    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'ecp_list')));
    add_text_node_utl(l_doc, l_root_node, 'ecp', p_ecp);

    pfu_utl.create_matching(dbms_xmldom.getXmlType(l_doc).getClobVal(),
                            l_env_rec.id,
                            1);
    update pfu_envelope_request per
       set per.state = 'MATCH_SEND', per.userid = bars.user_id
     where per.id = p_env_id;

    commit;
  end;

  procedure regen_matching1(p_env_id in integer) is
    l_xml         pfu_matching_request.pfu_matching_xml%type;
    l_match_reqid pfu_matching_request.id%type;
  begin
    select req.id
      into l_match_reqid
      from pfu_request req
     where req.parent_request_id = p_env_id
       and req.request_type = pfu_utl.REQ_TYPE_MATCHING1;
    select mr.pfu_matching_xml
      into l_xml
      from pfu_matching_request mr
     where mr.id = l_match_reqid;
    pfu_utl.create_matching(l_xml, p_env_id, 1);
  end;

  procedure gen_matching2(p_file_id in integer, p_ecp in varchar2) is
    l_doc          dbms_xmldom.DOMDocument;
    l_root_node    dbms_xmldom.DOMNode;
    l_header_node  dbms_xmldom.DOMNode;
    l_body_node    dbms_xmldom.DOMNode;
    l_row_node     dbms_xmldom.DOMNode;
    l_file_rec     pfu_file%rowtype;
    l_env_rec      pfu_envelope_request%rowtype;
    l_date_cr      date;
    l_clob_xml     clob;
    l_blob_xml     blob;
    l_blob_zip     blob;
    l_clob_res     clob;
    l_clob_base64  clob;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_warning      integer;
  begin
    l_doc     := dbms_xmldom.newDomDocument;
    l_date_cr := sysdate;
    select * into l_file_rec from pfu_file pf where pf.id = p_file_id;
    select *
      into l_env_rec
      from pfu_envelope_request per
     where per.id = l_file_rec.envelope_request_id;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'paymentlists')));
    add_text_node_utl(l_doc, l_root_node, 'id', l_env_rec.pfu_envelope_id);
    add_text_node_utl(l_doc, l_root_node, 'idb', l_env_rec.id);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'opfu_code',
                      l_env_rec. pfu_branch_code);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'opfu_name',
                      l_env_rec.pfu_branch_name);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'date_cr',
                      to_char(l_date_cr, 'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_root_node,
                      'MFO_filia',
                      l_env_rec.receiver_mfo);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'filia_num',
                      l_env_rec.receiver_branch);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'filia_name',
                      nvl(l_env_rec.receiver_name, 'Не данных'));
    add_text_node_utl(l_doc,
                      l_root_node,
                      'full_sum',
                      l_file_rec.check_sum * 100);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'full_lines',
                      l_file_rec.check_lines_count);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'return_full_sum',
                      get_sum_wrong_row_file(p_file_id, 10));
    add_text_node_utl(l_doc,
                      l_root_node,
                      'return_full_lines',
                      get_count_wrong_row_file(p_file_id, 10));
    l_clob_xml := prepare_matching2(p_file_id);
    add_clob_node_utl(l_doc, l_root_node, 'report_data', l_clob_xml);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'ecp_list')));
    add_text_node_utl(l_doc, l_root_node, 'ecp', p_ecp);

    pfu_utl.create_matching(dbms_xmldom.getXmlType(l_doc).getClobVal(),
                            null,
                            2);
    update pfu_file pf
       set pf.state      = 'MATCH_SEND',
           pf.userid     = bars.user_id,
           pf.match_date = l_date_cr
     where pf.id = p_file_id;
  end;

  procedure gen_epp_kvt2
  is
    l_doc          dbms_xmldom.DOMDocument;
    l_root_node    dbms_xmldom.DOMNode;
    l_header_node  dbms_xmldom.DOMNode;
    l_body_node    dbms_xmldom.DOMNode;
    l_row_node     dbms_xmldom.DOMNode;
    l_file_rec     pfu_file%rowtype;
    l_env_rec      pfu_envelope_request%rowtype;
    l_date_cr      date;
    l_blob_xml     blob;
    l_blob_zip     blob;
    l_clob_res     clob;
    l_clob_base64  clob;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_warning      integer;
  begin
    for i in (select m.batch_request_id, r.pfu_batch_id, m.xml_data 
              from pfu_matching_request2 m
                   inner join pfu_epp_batch_request r on r.id = m.batch_request_id
              where state = 'NEW')
    loop
      l_blob_xml := pfu_utl.clob_to_blob(i.xml_data);
      l_blob_zip := utl_compress.lz_compress(l_blob_xml);
      --if p_enc_type = 1 then
      --  return pfu_utl.blob_to_hex(l_blob_zip);
      --end if;
      l_clob_base64 := pfu_utl.pfu_encode_base64(l_blob_zip);

      l_doc := dbms_xmldom.newDomDocument;

      l_root_node := dbms_xmldom.makeNode(l_doc);
      l_root_node := dbms_xmldom.appendChild(l_root_node,
                                             dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                            'epp_packet_bnk_state_2')));

      add_text_node_utl(l_doc, l_root_node, 'id', i.pfu_batch_id);
      add_text_node_utl(l_doc, l_root_node, 'data', l_clob_base64);

      pfu_utl.create_epp_matching2(dbms_xmldom.getXmlType(l_doc).getClobVal());

      update pfu_matching_request2 m
         set m.state       = 'SEND'
       where m.batch_request_id = i.batch_request_id;
      commit;
    end loop;
  end gen_epp_kvt2;

  procedure gen_death_matching(p_death_id in integer, p_ecp in varchar2) is
    l_doc          dbms_xmldom.DOMDocument;
    l_root_node    dbms_xmldom.DOMNode;
    l_header_node  dbms_xmldom.DOMNode;
    l_body_node    dbms_xmldom.DOMNode;
    l_row_node     dbms_xmldom.DOMNode;
    l_file_rec     pfu_death%rowtype;
    l_death_rec    pfu_death_request%rowtype;
    l_date_cr      date;
    l_clob_xml     clob;
    l_blob_xml     blob;
    l_blob_zip     blob;
    l_clob_res     clob;
    l_clob_base64  clob;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_warning      integer;
  begin
    l_doc     := dbms_xmldom.newDomDocument;
    l_date_cr := sysdate;
    select * into l_file_rec from pfu_death pd where pd.id = p_death_id;
    select *
      into l_death_rec
      from pfu_death_request per
     where per.id = l_file_rec.request_id;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'deadlists')));
    add_text_node_utl(l_doc, l_root_node, 'id', l_death_rec.pfu_death_id);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'opfu_code',
                      l_death_rec.pfu_branch_code);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'date_cr',
                      to_char(l_date_cr, 'ddmmyyyy'));
    add_text_node_utl(l_doc,
                      l_root_node,
                      'MFO_filia',
                      l_death_rec.receiver_mfo);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'filia_num',
                      l_death_rec.receiver_branch);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'filia_name',
                      nvl(l_death_rec.receiver_name, 'Нет данных'));
    l_clob_xml := prepare_death_matching(p_death_id);
    add_clob_node_utl(l_doc, l_root_node, 'notice_kv', l_clob_xml);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'ecp_list')));
    add_text_node_utl(l_doc, l_root_node, 'ecp', p_ecp);

    pfu_utl.create_matching(dbms_xmldom.getXmlType(l_doc).getClobVal(),
                            null,
                            3);
    update pfu_death pf
       set pf.state = 'MATCH_SEND', pf.userid = bars.user_id
     where pf.id = p_death_id;
  end;

  procedure gen_no_turnover(p_nt_id in integer,
                            p_mfo   in varchar2,
                            p_ecp   in varchar2) is
    l_doc          dbms_xmldom.DOMDocument;
    l_root_node    dbms_xmldom.DOMNode;
    l_header_node  dbms_xmldom.DOMNode;
    l_body_node    dbms_xmldom.DOMNode;
    l_row_node     dbms_xmldom.DOMNode;
    l_file_rec     pfu_no_turnover_list%rowtype;
    l_date_cr      date;
    l_clob_xml     clob;
    l_blob_xml     blob;
    l_blob_zip     blob;
    l_clob_res     clob;
    l_clob_base64  clob;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_warning      integer;
    l_fil_name     varchar2(200);
    l_reqid        integer;
    l_cnt          integer;
  begin
    l_doc     := dbms_xmldom.newDomDocument;
    l_date_cr := sysdate;

    select *
      into l_file_rec
      from pfu_no_turnover_list pd
     where pd.id = p_nt_id
       and pd.kf = p_mfo;

    select count(*)
      into l_cnt
      from pfu_no_turnover pt
     where pt.id_file = p_nt_id
       and pt.kf = p_mfo;

    select t.name
      into l_fil_name
      from pfu_syncru_params t
     where t.kf = p_mfo;

    l_root_node := dbms_xmldom.makeNode(l_doc);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'deadlists')));
    add_text_node_utl(l_doc, l_root_node, 'idb', l_file_rec.id);
    add_text_node_utl(l_doc,
                      l_root_node,
                      'date_cr',
                      l_file_rec.date_create);
    add_text_node_utl(l_doc, l_root_node, 'filia_num', l_file_rec.kf);
    add_text_node_utl(l_doc, l_root_node, 'filia_name', l_fil_name);
    add_text_node_utl(l_doc, l_root_node, 'tipe_pen', 1);
    l_clob_xml := prepare_no_turnover(p_nt_id, p_mfo);
    add_clob_node_utl(l_doc, l_root_node, 'drawing_kv', l_clob_xml);
    l_root_node := dbms_xmldom.appendChild(l_root_node,
                                           dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                          'ecp_list')));
    add_text_node_utl(l_doc, l_root_node, 'ecp', p_ecp);

    pfu_utl.create_no_turnover(dbms_xmldom.getXmlType(l_doc).getClobVal(),
                               null,
                               l_reqid);

    update pfu_no_turnover_list pt
       set pt.state      = 'MATCH_SENT',
           pt.user_id    = bars.user_id,
           pt.id_request = l_reqid,
           pt.full_lines = l_cnt,
           pt.date_sent  = sysdate
     where pt.id = p_nt_id
       and pt.kf = p_mfo;
  end;

  procedure set_paybach_attr(p_id_rec      in pfu_file_records.id%type,
                             p_dateback    in date,
                             p_numpay_back in pfu_file_records.num_paym%type) is
  begin
    update pfu_file_records pfr
       set pfr.date_payback = p_dateback, pfr.num_paym = p_numpay_back
     where pfr.id = p_id_rec;
    commit;
  end;

  procedure prepare_new_claims is
    l_epp_lines         number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_client_node       dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
  begin
    -- Блокуємо рядки перед обробкою
    select t.id
      bulk collect
      into l_epp_lines
      from pfu_epp_line t
     where t.state_id = pfu_epp_utl.LINE_STATE_ACCEPTED
       for update;

    if (l_epp_lines is not empty) then
      for i in (select cast(collect(l.id) as number_list) mfo_lines,
                       l.bank_mfo
                  from pfu_epp_line l
                 where l.id in (select column_value from table(l_epp_lines))
                 group by l.bank_mfo) loop

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

        for j in (select *
                    from pfu_epp_line l
                   where l.id in
                         (select column_value from table(i.mfo_lines))) loop
          l_client_node := dbms_xmldom.appendChild(l_body_node,
                                                   dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                  'client')));

          add_text_node_utl(l_doc, l_client_node, 'id', j.id);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'epp_number',
                            j.epp_number);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'person_record_number',
                            j.person_record_number);
          add_text_node_utl(l_doc, l_client_node, 'last_name', j.last_name);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'first_name',
                            j.first_name);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'middle_name',
                            j.middle_name);
          add_text_node_utl(l_doc, l_client_node, 'gender', j.gender);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'date_of_birth',
                            j.date_of_birth);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'phone_numbers',
                            j.phone_numbers);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'embossing_name',
                            j.embossing_name);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'tax_registration_number',
                            j.tax_registration_number);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'document_type',
                            j.document_type);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'document_id',
                            j.document_id);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'document_issue_date',
                            j.document_issue_date);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'document_issuer',
                            j.document_issuer);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'displaced_person_flag',
                            j.displaced_person_flag);
          add_text_node_utl(l_doc, l_client_node, 'bank_mfo', j.bank_mfo);
          add_text_node_utl(l_doc, l_client_node, 'bank_num', j.bank_num);
          add_text_node_utl(l_doc, l_client_node, 'bank_name', j.bank_name);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'epp_expiry_date',
                            j.epp_expiry_date);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_country',
                            j.legal_country);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_zip_code',
                            j.legal_zip_code);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_region',
                            j.legal_region);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_district',
                            j.legal_district);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_settlement',
                            j.legal_settlement);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_street',
                            j.legal_street);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_house',
                            j.legal_house);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_house_part',
                            j.legal_house_part);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'legal_apartment',
                            j.legal_apartment);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_country',
                            j.actual_country);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_zip_code',
                            j.actual_zip_code);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_region',
                            j.actual_region);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_district',
                            j.actual_district);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_settlement',
                            j.actual_settlement);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_street',
                            j.actual_street);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_house',
                            j.actual_house);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_house_part',
                            j.actual_house_part);
          add_text_node_utl(l_doc,
                            l_client_node,
                            'actual_apartment',
                            j.actual_apartment);
          add_text_node_utl(l_doc, l_client_node, 'sign', j.line_sign);
          add_text_node_utl(l_doc, l_client_node, 'branch', j.branch);
          add_text_node_utl(l_doc, l_client_node, 'pens_type', j.pens_type);
        end loop;

        begin
          -- TRANS_TYPE_REGEPP  - '1'    REGEPP          Файл на реєстрацію ЄПП
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_REGEPP,
                                                                     i.bank_mfo,
                                                                     transport_utl.get_receiver_url(i.bank_mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());

          if (i.mfo_lines is not null and i.mfo_lines is not empty) then
            forall k in indices of i.mfo_lines
              insert into pfu_epp_line_transport_unit
              values
                (l_transport_unit_id, i.mfo_lines(k));

            for k in i.mfo_lines.first .. i.mfo_lines.last loop
              pfu_epp_utl.set_line_state(i.mfo_lines(k),
                                         pfu_epp_utl.LINE_STATE_CLAIM_WAIT_FOR_SEND,
                                         null,
                                         null);
            end loop;
          end if;
        exception
          when others then
            for k in i.mfo_lines.first .. i.mfo_lines.last loop
              pfu_epp_utl.set_line_state(i.mfo_lines(k),
                                         pfu_epp_utl.LINE_STATE_ACCOUNT_CLAIM_FAIL,
                                         sqlerrm,
                                         sqlerrm || chr(10) ||
                                         dbms_utility.format_error_backtrace());
            end loop;
        end;
      end loop;
    end if;
  end;

  procedure prepare_activation_claims
  --підготовка пакетів для активації рахунків на РУ
   is
    l_epp_lines         number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l                   integer;
  begin
    -- Блокуємо рядки перед обробкою
    select t.id
      bulk collect
      into l_epp_lines
      from pfu_epp_line t
     where t.state_id = pfu_epp_utl.LINE_STATE_W4_ACTIVATED --відбираємо всі лайни з статусом 12
       for update;

    if (l_epp_lines is not empty) then
      for i in (select cast(collect(l.id) as number_list) mfo_lines,
                       l.bank_mfo
                  from pfu_epp_line l
                 where l.id in (select column_value from table(l_epp_lines))
                 group by l.bank_mfo) loop

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

        l := i.mfo_lines.first;
        while (l is not null) loop
          add_text_node_utl(l_doc, l_body_node, 'id', i.mfo_lines(l));
          pfu_epp_utl.set_line_state(i.mfo_lines(l),
                                     pfu_epp_utl.LINE_STATE_ACTIVATED,
                                     null,
                                     null);
          l := i.mfo_lines.next(l);
        end loop;

        begin
          --TRANS_TYPE_ACTIVATEACC ставимо тип - '3'    ACTIVATEACC     Активація рахунку
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_ACTIVATEACC,
                                                                     i.bank_mfo,
                                                                     transport_utl.get_receiver_url(i.bank_mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());

          /*if (i.mfo_lines is not null and i.mfo_lines is not empty) then
              forall k in indices of i.mfo_lines
                   insert into pfu_epp_line_transport_unit
                   values (l_transport_unit_id, i.mfo_lines(k));

              for k in i.mfo_lines.first..i.mfo_lines.last loop
                  pfu_epp_utl.set_line_state(i.mfo_lines(k), pfu_epp_utl.LINE_STATE_ACTIVATION_CLAIMED, null, null);
              end loop;
          end if;*/
        exception
          when others then
            for k in i.mfo_lines.first .. i.mfo_lines.last loop
              pfu_epp_utl.set_line_state(i.mfo_lines(k),
                                         pfu_epp_utl.LINE_STATE_ACTIVATION_CLAIM_ER,
                                         sqlerrm,
                                         sqlerrm || chr(10) ||
                                         dbms_utility.format_error_backtrace());
            end loop;
        end;
      end loop;
    end if;
  end;

  procedure prepare_check_epp_state is
    -- получить состояние ЕПП из РУ
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_count             integer;
  begin
    for rec_mfo in (select distinct p.kf mfo from pfu_syncru_params p) loop
      select count(*)
        into l_count
        from pfu_epp_line pel
       where pel.state_id in (8, 24);

      if (l_count > 0) then
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
        for c0 in (select *
                     from pfu_epp_line pel
                    where pel.state_id in (8, 24)) loop
          l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                               'row')));
          add_text_node_utl(l_doc, l_row_node, 'epp_num', c0.epp_number);
        end loop;
        begin
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_CHECK_EPP_STATE,
                                                                     rec_mfo.mfo,
                                                                     transport_utl.get_receiver_url(ltrim(rec_mfo.mfo,
                                                                                                          '0')),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());
        end;
      end if;
    end loop;
  end;

  procedure prepare_restart_epp is
    -- получить состояние ЕПП из РУ
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_count             integer;
  begin

    for rec_mfo in (select distinct p.kf mfo from pfu_syncru_params p) loop
      select count(*)
        into l_count
        from pfu_epp_line pel
       where pel.state_id in (30)
         and pel.bank_mfo = rec_mfo.mfo;
      if (l_count > 0) then
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
        for c0 in (select *
                     from pfu_epp_line pel
                    where pel.state_id in (30)
                      and pel.bank_mfo = rec_mfo.mfo) loop
          l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                               'row')));
          add_text_node_utl(l_doc, l_row_node, 'epp_num', c0.epp_number);
          add_text_node_utl(l_doc, l_row_node, 'rnk', c0.rnk);
        end loop;
        begin
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_RESTART_EPP,
                                                                     rec_mfo.mfo,
                                                                     transport_utl.get_receiver_url(ltrim(rec_mfo.mfo,
                                                                                                          '0')),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());
        end;
      end if;
    end loop;
  end;

  procedure prepare_paym_back(p_death_id in pfu_death_record.id%type) is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_death_rec         pfu_death_record%rowtype;
    l_pfu_acc           pfu_acc_2560_payback.acc_num%type;
    l_transport_unit_id integer;
  begin
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

    select *
      into l_death_rec
      from pfu_death_record d
     where d.id = p_death_id;

    select p.acc_num
      into l_pfu_acc
      from pfu_acc_2560_payback p
     where p.kf = l_death_rec.bank_mfo;

    add_text_node_utl(l_doc,
                      l_body_node,
                      'fio',
                      l_death_rec.last_name || ' ' ||
                      l_death_rec.first_name || ' ' ||
                      l_death_rec.father_name);
    add_text_node_utl(l_doc, l_body_node, 'okpo', l_death_rec.okpo);
    add_text_node_utl(l_doc, l_body_node, 'sum', l_death_rec.sum_over);
    add_text_node_utl(l_doc, l_body_node, 'num_acc', l_death_rec.num_acc);
    add_text_node_utl(l_doc,
                      l_body_node,
                      'date_dead',
                      l_death_rec.date_dead);
    add_text_node_utl(l_doc, l_body_node, 'acc_2560', l_pfu_acc);
    add_text_node_utl(l_doc, l_body_node, 'did', l_death_rec.id);

    begin
      l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_CREATE_PAYM,
                                                                       l_death_rec.bank_mfo,
                                                                 transport_utl.get_receiver_url(ltrim(l_death_rec.bank_mfo,
                                                                                                      '0')),
                                                                 dbms_xmldom.getXmlType(l_doc)
                                                                 .getClobVal());
    end;

  end;

  procedure prepare_acc_rest(p_acc    in pfu_acc_trans_2909.acc_num%type,
                             p_fileid in pfu_file.id %type,
                             p_kf     in pfu_acc_trans_2909.kf%type)
  -- підготовка запиту на перевірку станів оплати референсів по ЕБП
   is
    l_file_lines        number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l                   integer;
  begin
    -- Блокуємо рядки перед обробкою
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

    add_text_node_utl(l_doc, l_body_node, 'acc', p_acc);
    add_text_node_utl(l_doc, l_body_node, 'fileid', p_fileid);

    merge into pfu_acc_rest ar
    using dual
    ON (ar.fileid = p_fileid)
    when matched then
      update set ar.rest = null, ar.restdate = sysdate, ar.acc = p_acc
    when not matched then
      insert values (p_acc, null, sysdate, p_fileid);
    begin
      l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_GET_ACC_REST,
                                                                 p_kf,
                                                                 transport_utl.get_receiver_url(ltrim(p_kf,
                                                                                                      '0')),
                                                                 dbms_xmldom.getXmlType(l_doc)
                                                                 .getClobVal());
    end;
  end;

  procedure prepare_checkissuecard
  -- підготовка запиту на перевірку станів випуску/перевипуску ЕПП
   is
    l_file_lines        number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_count             integer;
  begin
    -- Блокуємо рядки перед обробкою

    --bars.bc.go('300465');
    for rec_mfo in (select p.kf mfo from pfu_syncru_params p) loop

        select s.epp_line_id
          bulk collect
          into l_file_lines
        from pfu_epp_line_bnk_state2 s
             inner join pfu_epp_line e on e.id = s.epp_line_id
        where s.state_id = 20
              and e.bank_mfo = rec_mfo.mfo
              and trunc(sysdate) - 5 >= s.create_date;

      if (l_file_lines.count > 0) then

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
        if (l_file_lines is not empty) then
          for i in (select column_value id from table(l_file_lines)) loop

              l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                   'row')));
              add_text_node_utl(l_doc,
                                l_row_node,
                                'id',
                                i.id);
          end loop;
          --TRANS_TYPE_CHECKSTATE проставляємо тип  4    CHECKPAYMSTATE  Опитування статусу платежу
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_CHECKISSUECARD,
                                                                     rec_mfo.mfo,
                                                                     transport_utl.get_receiver_url(rec_mfo.mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());
        end if;
      end if;
    end loop;
    commit;
  end prepare_checkissuecard;

  procedure prepare_check_state
  -- підготовка запиту на перевірку станів оплати референсів по ЕБП
   is
    l_file_lines        number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l                   integer;
    l_count             integer;
    l_cnt               integer;
    l_date              date;
    l_idr               number;
  begin
    -- Блокуємо рядки перед обробкою

    bars.bc.go('300465');
    for rec_mfo in (select p.kf mfo from pfu_syncru_params p) loop
      select count(*)
        into l_count
        from pfu_file_records t
       where t.state = 20
         and t.mfo = rec_mfo.mfo;
      if (l_count > 0) then
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

        select t.ref
          bulk collect
          into l_file_lines
          from pfu_file_records t
         where t.state = 20
           and t.mfo = rec_mfo.mfo;

        if (l_file_lines is not empty) then
          for i in (select column_value ref from table(l_file_lines)) loop

            select O.PDAT
              into l_date
              from bars.oper o
             where o.ref = i.ref;

            select f.id
              into l_idr
              from pfu_file_records f
             where f.ref = i.ref;

          /*  if l_cnt = 0 then
              l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                   'row')));
              add_text_node_utl(l_doc, l_row_node, 'ref', MOD(i.ref, 1000000000));
            else*/
              l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                    dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                   'row')));
              add_text_node_utl(l_doc,
                                l_row_node,
                                'ref',
                                MOD(i.ref, 1000000000));
              add_text_node_utl(l_doc, l_row_node, 'pdat', to_char(l_date,'dd.mm.yyyy'));
              add_text_node_utl(l_doc, l_row_node, 'idr', l_idr);
            /*end if;*/

          end loop;
          --TRANS_TYPE_CHECKSTATE проставляємо тип  4    CHECKPAYMSTATE  Опитування статусу платежу
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_CHECKSTATE,
                                                                     rec_mfo.mfo,
                                                                     transport_utl.get_receiver_url(rec_mfo.mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());
        end if;
      end if;
    end loop;
    commit;
  end;

  procedure prepare_check_state_back
  -- підготовка запиту на перевірку станів оплати референсів по ЕБП
   is
    l_file_lines        number_list;
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l_count             integer;
    l                   integer;
  begin
    -- Блокуємо рядки перед обробкою
    for rec_mfo in (select p.kf mfo from pfu_syncru_params p) loop
      select count(*)
        into l_count
        from pfu_death_record t
       where t.state = 'READY_FOR_PAY'
         and t.bank_mfo = rec_mfo.mfo;

      if (l_count > 0) then
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

        select t.ref
          bulk collect
          into l_file_lines
          from (select fr.ref
                  from pfu_death_record fr
                 where fr.state = 'READY_FOR_PAY'
                   and fr.bank_mfo = rec_mfo.mfo) t;

        if (l_file_lines is not empty) then
          for i in (select column_value ref from table(l_file_lines)) loop

            l_row_node := dbms_xmldom.appendChild(l_body_node,
                                                  dbms_xmldom.makeNode(dbms_xmldom.createElement(l_doc,
                                                                                                 'row')));
            add_text_node_utl(l_doc, l_row_node, 'ref', i.ref);

          end loop;
          --TRANS_TYPE_CHECKSTATE проставляємо тип  4    CHECKPAYMSTATE  Опитування статусу платежу
          l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_CHECKBACKSTATE,
                                            rec_mfo.mfo,
                                                                     transport_utl.get_receiver_url(rec_mfo.mfo),
                                                                     dbms_xmldom.getXmlType(l_doc)
                                                                     .getClobVal());
        end if;
      end if;
    end loop;
  end;

  procedure prepare_pensioner_claim(p_kf in pfu_syncru_params.kf%type) is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_updid_pens        pfu_pensioner.last_ru_idupd%type;
    l_updid_acc         pfu_pensacc.last_ru_idupd%type;
    l_transport_unit_id integer;
    l                   integer;
  begin
    l_doc := dbms_xmldom.newDomDocument;

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

    select max(t.last_ru_idupd)
      into l_updid_pens
      from pfu_pensioner t
     where t.kf = p_kf;

    select max(t.last_ru_idupd)
      into l_updid_acc
      from pfu_pensacc t
     where t.kf = p_kf;

    add_text_node_utl(l_doc, l_body_node, 'updid_pens', l_updid_pens);
    add_text_node_utl(l_doc, l_body_node, 'updid_acc', l_updid_acc);

    begin
      --TRANS_TYPE_GET_EBP  Проставляємо тип -  5    GET_EBP         Получение пенсионеров и счетов
      l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_GET_EBP,
                                                                 p_kf,
                                                                 transport_utl.get_receiver_url(p_kf),
                                                                 dbms_xmldom.getXmlType(l_doc)
                                                                 .getClobVal());
    end;
  end;

  procedure prepare_pensioner_claim is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_updid_pens        pfu_pensioner.last_ru_idupd%type;
    l_updid_acc         pfu_pensacc.last_ru_idupd%type;
    l_transport_unit_id integer;
    l                   integer;
  begin
    -- Блокуємо рядки перед обробкою
    for rec_mfo in (select distinct p.kf mfo
                      from pfu_syncru_params p
                    /*where p.kf != '300465'*/
                    ) loop

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

      select max(t.last_ru_idupd)
        into l_updid_pens
        from pfu_pensioner t
       where t.kf = rec_mfo.mfo;

      select max(t.last_ru_idupd)
        into l_updid_acc
        from pfu_pensacc t
       where t.kf = rec_mfo.mfo;

      add_text_node_utl(l_doc, l_body_node, 'updid_pens', l_updid_pens);
      add_text_node_utl(l_doc, l_body_node, 'updid_acc', l_updid_acc);

      begin
        --TRANS_TYPE_GET_EBP  Проставляємо тип -  5    GET_EBP         Получение пенсионеров и счетов
        l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_GET_EBP,
                                                                   rec_mfo.mfo,
                                                                   transport_utl.get_receiver_url(rec_mfo.mfo),
                                                                   dbms_xmldom.getXmlType(l_doc)
                                                                   .getClobVal());
      end;
    end loop;
  end;

  procedure prepare_cardkill_claim is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_updid_acc         pfu_pensacc.last_ru_idupd%type;
    l_transport_unit_id integer;
    l                   integer;
  begin
    -- Блокуємо рядки перед обробкою
    for rec_mfo in (select distinct p.kf mfo
                      from pfu_syncru_params p
                    /* where p.kf != '300465'*/
                    ) loop

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

      begin
        ---- TRANS_TYPE_GET_CARDKILL 7 GET_CARDKILL    Получение уничтоженніх карт
        l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_GET_CARDKILL,
                                                                   rec_mfo.mfo,
                                                                   transport_utl.get_receiver_url(rec_mfo.mfo),
                                                                   dbms_xmldom.getXmlType(l_doc)
                                                                   .getClobVal());
      end;
    end loop;
  end;

  procedure prepare_set_destruct(p_epp_number pfu_epp_line.epp_number%type,
                                       p_mfo        pfu_epp_line.bank_mfo%type)is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_updid_acc         pfu_pensacc.last_ru_idupd%type;
    l_transport_unit_id integer;
    l                   integer;
  begin

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

      add_text_node_utl(l_doc, l_body_node, 'epp_number', p_epp_number);
      begin
        ---- TRANS_TYPE_GET_CARDKILL 7 GET_CARDKILL    Получение уничтоженніх карт
        l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_SET_DESTRUCT,
                                                                   p_mfo,
                                                                   transport_utl.get_receiver_url(p_mfo),
                                                                   dbms_xmldom.getXmlType(l_doc)
                                                                   .getClobVal());
      end;
  end;

  procedure prepare_report_claim(p_kf   in pfu_syncru_params.kf%type,
                                 p_date in date) is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l                   integer;
  begin
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

    add_text_node_utl(l_doc, l_row_node, 'daterep', p_date);

    begin
      --???????????????
      l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_GET_REPORT,
                                                                 p_kf,
                                                                 transport_utl.get_receiver_url(p_kf),
                                                                 dbms_xmldom.getXmlType(l_doc)
                                                                 .getClobVal());
    end;
  end;

  procedure prepare_cm_error_claim(p_kf in pfu_syncru_params.kf%type) is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l                   integer;
  begin
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

    --add_text_node_utl(l_doc, l_row_node, 'date', sysdate);

    begin
      --TRANS_TYPE_GET_CM_ERROR Ставимо тип - 8    GET_CM_ERROR    Получение ошибок от кардмейка
      l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_GET_CM_ERROR,
                                                                 p_kf,
                                                                 transport_utl.get_receiver_url(p_kf),
                                                                 dbms_xmldom.getXmlType(l_doc)
                                                                 .getClobVal());
    end;

  end;

  procedure prepare_branch_claim(p_kf in pfu_syncru_params.kf%type) is
    l_doc               dbms_xmldom.DOMDocument;
    l_root_node         dbms_xmldom.DOMNode;
    l_header_node       dbms_xmldom.DOMNode;
    l_body_node         dbms_xmldom.DOMNode;
    l_row_node          dbms_xmldom.DOMNode;
    l_transport_unit_id integer;
    l                   integer;
  begin
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

    begin
      --TRANS_TYPE_GET_CM_ERROR Ставимо тип - 8    GET_CM_ERROR    Получение ошибок от кардмейка
      l_transport_unit_id := transport_utl.create_transport_unit(transport_utl.TRANS_TYPE_GET_BRANCH,
                                                                 p_kf,
                                                                 transport_utl.get_receiver_url(p_kf),
                                                                 dbms_xmldom.getXmlType(l_doc)
                                                                 .getClobVal());
    end;
  end;

  procedure process_response(p_session_id in integer,
                             p_parser     in dbms_xmlparser.parser /*,
                                     p_session_type_id in integer,
                                     p_request_id in integer,
                                     p_response_xml_data in clob*/) is
    l_session_row pfu_session%rowtype;
    l_request_row pfu_request%rowtype;

    l_pfu_request_id    integer;
    l_pfu_request_state varchar2(1);
    l_parts_cnt         integer;
    l_part              integer;

    l_request_data clob;
    l_xml          xmltype;

    l_doc dbms_xmldom.DOMDocument;
    pragma autonomous_transaction;
  begin
    l_session_row := read_session(p_session_id, p_lock => true);
    l_request_row := pfu_utl.read_request(l_session_row.request_id,
                                          p_lock => true);

    dbms_xmlparser.parseclob(p_parser, l_session_row.response_xml_data);

    l_doc := dbms_xmlparser.getdocument(p_parser);

    begin
      if (l_session_row.session_type_id in
         (pfu_service_utl.SESS_TYPE_REQ_ENVELOPE_LIST,
           pfu_service_utl.SESS_TYPE_REQ_ENVELOPE,
           pfu_service_utl.SESS_TYPE_REQ_DEATH_LIST,
           pfu_service_utl.SESS_TYPE_REQ_DEATH,
           pfu_service_utl.SESS_TYPE_REQ_VERIFY_LIST,
           pfu_service_utl.SESS_TYPE_REQ_EPP_BATCH_LIST,
           pfu_service_utl.SESS_TYPE_REQ_EPP_BATCH,
           pfu_service_utl.SESS_TYPE_REQ_MATCHING1,
           pfu_service_utl.SESS_TYPE_REQ_MATCHING2,
           pfu_service_utl.SESS_TYPE_REQ_DEATH_MATCHING,
           pfu_service_utl.SESS_TYPE_REQ_CHANGE_ATTR,
           pfu_service_utl.SESS_TYPE_REQ_NO_TURNOVER,
           pfu_service_utl.SESS_TYPE_REQ_EPP_MATCHING,
           pfu_service_utl.SESS_TYPE_REQ_EPP_MATCHING2,
           pfu_service_utl.SESS_TYPE_REQ_EPP_ACTIVATION)) then

        l_pfu_request_id    := to_number(get_node_value(l_doc,
                                                        'requeststatus/rq_id/text()'));
        l_pfu_request_state := get_node_value(l_doc,
                                              'requeststatus/rq_st/text()');

        set_pfu_request_id(p_session_id, l_pfu_request_id);

      elsif (l_session_row.session_type_id =
            pfu_service_utl.SESS_TYPE_REQUEST_STATE) then

        -- <requeststatus><rq_id>17455</rq_id><rq_st>S</rq_st><rq_st_name>Оброблено</rq_st_name><parts_cnt>1</parts_cnt></requeststatus>
        l_pfu_request_state := get_node_value(l_doc,
                                              'requeststatus/rq_st/text()');
        l_parts_cnt         := to_number(get_node_value(l_doc,
                                                        'requeststatus/parts_cnt/text()'));

        set_request_status_answer(l_session_row.id,
                                  l_pfu_request_state,
                                  l_parts_cnt);

      elsif (l_session_row.session_type_id =
            pfu_service_utl.SESS_TYPE_GET_ENVELOPE_LIST) then
        l_xml := xmltype(l_session_row.response_xml_data);

        l_request_data := l_xml.extract('requestdata/rd_data/text()')
                          .getclobval();
        -- decode from base64
        l_request_data := pfu_utl.decodeclobfrombase64(l_request_data);
        -- convert from utf8  !Twice
        l_request_data := pfu_utl.utf8todeflang(l_request_data);
        l_request_data := pfu_utl.utf8todeflang(l_request_data);

        -- <paymentlists><row><id>581</id><opfu_code>20001</opfu_code><opfu_name>Головне управління ПФУ в Харківській обл.</opfu_name>...
        for r in (select extractvalue(value(p), '/row/id/text()') as envelope_id,
                         extractvalue(value(p), '/row/opfu_code/text()') as opfu_code,
                         extractvalue(value(p), '/row/opfu_name/text()') as opfu_name,
                         extractvalue(value(p), '/row/date_cr/text()') as date_cr,
                         extractvalue(value(p), '/row/MFO_filia/text()') as mfo_filia,
                         extractvalue(value(p), '/row/filia_num/text()') as filia_num,
                         extractvalue(value(p), '/row/filia_name/text()') as filia_name,
                         extractvalue(value(p), '/row/full_sum/text()') as full_sum,
                         extractvalue(value(p), '/row/full_lines/text()') as full_lines
                    from table(xmlsequence(extract(xmltype(l_request_data),
                                                   '/paymentlists/row'))) p) loop

          create_envelope(p_session_id           => l_session_row.id,
                          p_pfu_envelope_id      => to_number(r.envelope_id),
                          p_pfu_branch_code      => r.opfu_code,
                          p_pfu_branch_name      => r.opfu_name,
                          p_register_date        => r.date_cr,
                          p_receiver_mfo         => r.mfo_filia,
                          p_receiver_branch      => r.filia_num,
                          p_receiver_name        => r.filia_name,
                          p_envelope_full_sum    => to_number(replace(r.full_sum,
                                                                      ',',
                                                                      '.')) * 100, --???? скорее всего сумма приходит не в копейках
                          p_envelope_lines_count => to_number(r.full_lines));
        end loop;

        set_session_state(l_session_row.id,
                          pfu_service_utl.SESS_STATE_PROCESSED,
                          'Обробку сесії завершено - отримано список конвертів');
      elsif (l_session_row.session_type_id in
            (pfu_service_utl.SESS_TYPE_GET_ENVELOPE)) then

        l_part := get_node_value(l_doc, 'requestdata/part/text()');
        set_session_state(l_session_row.id,
                          pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED,
                          'Отримана частина даних відповіді - номер частини: ' ||
                          l_part);

        -- перевіряємо, чи всі частини відповіді з даними отримані і запускаємо зборку пакету даних
        if (check_if_all_parts_received(l_session_row.request_id,
                                        l_session_row.session_type_id)) then
          gather_envelope_parts(l_session_row.request_id);
        end if;
      elsif (l_session_row.session_type_id in
            (pfu_service_utl.SESS_TYPE_GET_EPP_BATCH_LIST,
              pfu_service_utl.SESS_TYPE_GET_EPP_BATCH)) then

        l_part := get_node_value(l_doc, 'requestdata/part/text()');
        set_session_state(l_session_row.id,
                          pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED,
                          'Отримана частина даних відповіді - номер частини: ' ||
                          l_part);

        -- перевіряємо, чи всі частини відповіді з даними отримані і запускаємо зборку пакету даних
        if (check_if_all_parts_received(l_session_row.request_id,
                                        l_session_row.session_type_id)) then
          if (l_session_row.session_type_id =
             pfu_service_utl.SESS_TYPE_GET_EPP_BATCH_LIST) then
            gather_epp_batch_list_parts(l_session_row.request_id);
          elsif (l_session_row.session_type_id =
                pfu_service_utl.SESS_TYPE_GET_EPP_BATCH) then
            gather_epp_batch_parts(l_session_row.request_id);
          end if;
        end if;
      elsif (l_session_row.session_type_id =
            pfu_service_utl.SESS_TYPE_GET_DEATH_LIST) then
        l_xml := xmltype(l_session_row.response_xml_data);

        l_request_data := l_xml.extract('requestdata/rd_data/text()')
                          .getclobval();
        -- decode from base64
        l_request_data := pfu_utl.decodeclobfrombase64(l_request_data);
        -- convert from utf8  !Twice
        l_request_data := pfu_utl.utf8todeflang(l_request_data);
        l_request_data := pfu_utl.utf8todeflang(l_request_data);

        -- <paymentlists><row><id>581</id><opfu_code>20001</opfu_code><opfu_name>Головне управління ПФУ в Харківській обл.</opfu_name>...
        for r in (select extractvalue(value(p), '/row/id/text()') as death_id,
                         extractvalue(value(p), '/row/opfu_code/text()') as opfu_code,
                         extractvalue(value(p), '/row/opfu_name/text()') as opfu_name,
                         extractvalue(value(p), '/row/date_cr/text()') as date_cr,
                         extractvalue(value(p), '/row/MFO_filia/text()') as mfo_filia,
                         extractvalue(value(p), '/row/filia_num/text()') as filia_num,
                         extractvalue(value(p), '/row/filia_name/text()') as filia_name,
                         extractvalue(value(p), '/row/full_sum/text()') as full_sum,
                         extractvalue(value(p), '/row/full_lines/text()') as full_lines
                    from table(xmlsequence(extract(xmltype(l_request_data),
                                                   '/deadlists/row'))) p) loop

          create_death(p_session_id      => l_session_row.id,
                       p_pfu_death_id    => to_number(r.death_id),
                       p_pfu_branch_code => r.opfu_code,
                       p_pfu_branch_name => r.opfu_name,
                       p_register_date   => r.date_cr,
                       p_receiver_mfo    => r.mfo_filia,
                       p_receiver_branch => r.filia_num,
                       p_receiver_name   => r.filia_name,
                       p_full_sum        => to_number(replace(r.full_sum,
                                                              ',',
                                                              '.')) * 100, --???? скорее всего сумма приходит не в копейках
                       p_lines_count     => to_number(r.full_lines));
        end loop;

        set_session_state(l_session_row.id,
                          pfu_service_utl.SESS_STATE_PROCESSED,
                          'Обробку сесії завершено - отримано список конвертів');
      elsif (l_session_row.session_type_id in
            (pfu_service_utl.SESS_TYPE_GET_DEATH)) then

        l_part := get_node_value(l_doc, 'requestdata/part/text()');
        set_session_state(l_session_row.id,
                          pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED,
                          'Отримана частина даних відповіді - номер частини: ' ||
                          l_part);

        -- перевіряємо, чи всі частини відповіді з даними отримані і запускаємо зборку пакету даних
        if (check_if_all_parts_received(l_session_row.request_id,
                                        l_session_row.session_type_id)) then
          gather_death_parts(l_session_row.request_id);
        end if;

      elsif (l_session_row.session_type_id =
            pfu_service_utl.SESS_TYPE_GET_VERIFY_LIST) then
        l_xml := xmltype(l_session_row.response_xml_data);

        l_request_data := l_xml.extract('requestdata/rd_data/text()')
                          .getclobval();
        -- decode from base64
        l_request_data := pfu_utl.decodeclobfrombase64(l_request_data);
        -- convert from utf8  !Twice
        l_request_data := pfu_utl.utf8todeflang(l_request_data);
        l_request_data := pfu_utl.utf8todeflang(l_request_data);

        -- <paymentlists><row><id>581</id><opfu_code>20001</opfu_code><opfu_name>Головне управління ПФУ в Харківській обл.</opfu_name>...
        for r in (select extractvalue(value(p), '/row/id/text()') as verification_id,
                         extractvalue(value(p), '/row/opfu_code/text()') as opfu_code,
                         extractvalue(value(p), '/row/opfu_name/text()') as opfu_name,
                         extractvalue(value(p), '/row/date_cr/text()') as date_cr,
                         extractvalue(value(p), '/row/full_lines/text()') as full_lines
                    from table(xmlsequence(extract(xmltype(l_request_data),
                                                   '/verifylists/row'))) p) loop

          create_verification(p_session_id      => l_session_row.id,
                              p_pfu_verify_id   => to_number(r.verification_id),
                              p_pfu_branch_code => r.opfu_code,
                              p_pfu_branch_name => r.opfu_name,
                              p_register_date   => r.date_cr,
                              p_lines_count     => to_number(r.full_lines));
        end loop;

        set_session_state(l_session_row.id,
                          pfu_service_utl.SESS_STATE_PROCESSED,
                          'Обробку сесії завершено - отримано список конвертів');
        /*
                     elsif (l_session_row.session_type_id in (pfu_service_utl.SESS_TYPE_GET_EPP_MATCHING)) then

                         l_part := get_node_value(l_doc, 'requestdata/part/text()');
                         set_session_state(l_session_row.id, pfu_service_utl.SESS_STATE_DATA_PART_RECEIVED, 'Отримана частина даних відповіді - номер частини: ' || l_part);

                         -- перевіряємо, чи всі частини відповіді з даними отримані і запускаємо зборку пакету даних
                         if (check_if_all_parts_received(l_session_row.request_id, l_session_row.session_type_id)) then
                             if (l_session_row.session_type_id = pfu_service_utl.SESS_TYPE_GET_EPP_BATCH_LIST) then
                                 gather_epp_batch_list_parts(l_session_row.request_id);
                             elsif (l_session_row.session_type_id = pfu_service_utl.SESS_TYPE_GET_EPP_BATCH) then
                                 gather_epp_batch_parts(l_session_row.request_id);
                     end if;
                         end if;
        */
      end if;

      set_session_state(l_session_row.id,
                        pfu_service_utl.SESS_STATE_PROCESSED,
                        'Обробку сесії завершено');
      commit;
    exception
      when others then
        rollback /*to before_request*/
        ;
        -- костыль!
        if (l_session_row.state_id =
           pfu_service_utl.SESS_STATE_SIGN_VERIFIED) then
          set_session_state(l_session_row.id,
                            pfu_service_utl.SESS_STATE_PROCESSING_FAILED,
                            'Обробка сесії не пройшла через помилку: ' ||
                            sqlerrm,
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
        end if;
        if (l_session_row.session_type_id =
           pfu_service_utl.SESS_TYPE_GET_ENVELOPE_LIST) then
          pfu_utl.set_request_state(l_session_row.request_id,
                                    pfu_utl.REQ_STATE_FAILED,
                                    'Ошибка на этапе разбора ответа со списком файлом',
                                    sqlerrm || chr(10) ||
                                    dbms_utility.format_error_backtrace());
        end if;
        commit;
    end;
  end;

  procedure process_response is
    l_parser dbms_xmlparser.parser;
  begin
    l_parser := dbms_xmlparser.newparser;
    -- обробка (парсинг) декриптованої відповіді
    for c0 in (select s.id,
                      s.session_type_id,
                      s.request_id,
                      s.response_xml_data
                 from pfu_session s
                where s.state_id = pfu_service_utl.SESS_STATE_SIGN_VERIFIED) loop

      process_response(c0.id, l_parser);
    end loop;
  end process_response;

  procedure send_requests is
    l_session_row pfu_session%rowtype;
    l_session_id  integer;
  begin
    for c0 in (select r.id, r.request_type
                 from pfu_request r
                where r.state = pfu_utl.REQ_STATE_NEW
                  for update) loop

      if (c0.request_type = pfu_utl.REQ_TYPE_ENVELOPE_LIST) then
        l_session_id := gen_session_req_envelope_list(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_ENVELOPE) then
        l_session_id := gen_session_req_envelope(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_EPP_BATCH_LIST) then
        l_session_id := gen_session_req_epp_batch_list(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_EPP_BATCH) then
        l_session_id := gen_session_req_epp_batch(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_MATCHING1) then
        l_session_id := gen_session_req_matching1(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_MATCHING2) then
        l_session_id := gen_session_req_matching2(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_DEATH_MATCHING) then
        l_session_id := gen_session_req_death_matching(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_NO_TURNOVER) then
        l_session_id := gen_session_req_no_turnover(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_EPP_MATCHING) then
        l_session_id := gen_session_req_epp_matching(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_EPP_MATCHING2) then
        l_session_id := gen_session_req_epp_matching2(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_EPP_ACTIVATION) then
        l_session_id := gen_session_req_epp_activation(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_DEATH_LIST) then
        l_session_id := gen_session_req_death_list(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_DEATH) then
        l_session_id := gen_session_req_death(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_VERIFY_LIST) then
        l_session_id := gen_session_req_verify_list(c0.id);
      elsif (c0.request_type = pfu_utl.REQ_TYPE_CHANGE_ATTR) then
        l_session_id := gen_session_req_replacement(c0.id);
      end if;

      l_session_row := read_session(l_session_id);

      pfu_utl.set_request_state(c0.id,
                                pfu_utl.REQ_STATE_READY_FOR_SENDING,
                                'Звернення типу ' ||
                                get_session_type_name(l_session_row.session_type_id) ||
                                'до сервісу ПФУ підготовлено');
    end loop;

    commit;

    -- відправка запиту
    for c0 in (select s.id, s.session_type_id, s.request_id
                 from pfu_session s
                where s.state_id = pfu_service_utl.SESS_STATE_SIGNED
                  for update) loop

      savepoint before_request;

      begin
        send_request(c0.id);
      exception
        when others then
          rollback to before_request;
          l_session_row := read_session(c0.id);
          if (l_session_row.state_id <> pfu_service_utl.SESS_STATE_FAILED) then
            set_session_failure(c0.id,
                                sqlerrm,
                                sqlerrm || chr(10) ||
                                dbms_utility.format_error_backtrace());
          end if;
      end;
    end loop;

    commit;
  end;

  procedure send_data_to_bank_units --відправка пакетів на РУ
   is
  begin
    for i in (select t.*
                from transport_unit t
                join transport_unit_type tt
                  on t.unit_type_id = tt.id
               where t.state_id = transport_utl.TRANS_STATE_NEW
                 and tt.transport_type_code not in
                     (transport_utl.TRANS_TYPE_GET_EBP,
                      transport_utl.TRANS_TYPE_SET_CARD_BLOCK,
                      transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK) --відбираються всі пакети з статусом 1
                 for update skip locked) loop
      transport_utl.send_data(i);
    end loop;
    commit;
    for i in (select t.*
                from transport_unit t
                join transport_unit_type tt
                  on t.unit_type_id = tt.id
               where t.state_id in
                     (transport_utl.TRANS_STATE_SENT,
                      transport_utl.TRANS_STATE_DATA_NOT_READY)
                 and tt.transport_type_code not in
                     (transport_utl.TRANS_TYPE_GET_EBP,
                      transport_utl.TRANS_TYPE_SET_CARD_BLOCK,
                      transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK)
                 for update skip locked) loop
      transport_utl.check_unit_state(i);
    end loop;
  end;

  procedure send_data_to_bank_units_ebp --відправка пакетів на РУ
   is
  begin
    for i in (select t.*
                from transport_unit t
                join transport_unit_type tt
                  on t.unit_type_id = tt.id
               where t.state_id = transport_utl.TRANS_STATE_NEW
                 and tt.transport_type_code in
                     (transport_utl.TRANS_TYPE_GET_EBP) --відбираються всі пакети з статусом 1
                 for update skip locked) loop
      transport_utl.send_data(i);
    end loop;
    commit;

    for i in (select t.*
                from transport_unit t
                join transport_unit_type tt
                  on t.unit_type_id = tt.id
               where t.state_id in
                     (transport_utl.TRANS_STATE_SENT,
                      transport_utl.TRANS_STATE_DATA_NOT_READY)
                 and tt.transport_type_code in
                     (transport_utl.TRANS_TYPE_GET_EBP)
                 for update skip locked) loop
      transport_utl.check_unit_state(i);
    end loop;
  end;
  
  procedure send_data_to_bank_units_lock --відправка пакетів на РУ
   is
  begin
    for i in (select t.*
                from transport_unit t
                join transport_unit_type tt
                  on t.unit_type_id = tt.id
               where t.state_id = transport_utl.TRANS_STATE_NEW
                 and tt.transport_type_code in
                     (transport_utl.TRANS_TYPE_SET_CARD_BLOCK,
                      transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK) --відбираються всі пакети з статусом 1
                 for update skip locked) loop
      transport_utl.send_data(i);
    end loop;
    commit;

    for i in (select t.*
                from transport_unit t
                join transport_unit_type tt
                  on t.unit_type_id = tt.id
               where t.state_id in
                     (transport_utl.TRANS_STATE_SENT,
                      transport_utl.TRANS_STATE_DATA_NOT_READY)
                 and tt.transport_type_code in
                     (transport_utl.TRANS_TYPE_SET_CARD_BLOCK,
                      transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK)
                 for update skip locked) loop
      transport_utl.check_unit_state(i);
    end loop;
  end;

  procedure process_receipt is

    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

  begin
    for c0 in (select t.*, tt.transport_type_code
                 from transport_unit t
                 join transport_unit_type tt
                   on t.unit_type_id = tt.id
                  and tt.transport_type_code in
                      (transport_utl.TRANS_TYPE_REGEPP,
                       transport_utl.TRANS_TYPE_CHECKISSUECARD,
                       transport_utl.TRANS_TYPE_ACTIVATEACC,
                       transport_utl.TRANS_TYPE_CHECKSTATE,
                       transport_utl.TRANS_TYPE_CHECKBACKSTATE,
                       transport_utl.TRANS_TYPE_CREATE_PAYM,
                       transport_utl.TRANS_TYPE_GET_CARDKILL,
                       transport_utl.TRANS_TYPE_GET_ACC_REST,
                       transport_utl.TRANS_TYPE_CHECK_EPP_STATE,
                       transport_utl.TRANS_TYPE_GET_REPORT,
                       transport_utl.TRANS_TYPE_RESTART_EPP,
                       transport_utl.TRANS_TYPE_GET_BRANCH)
                  and t.state_id = transport_utl.TRANS_STATE_RESPONDED) loop
      declare
        l_clob         clob;
        l_tmpb         blob;
        l_warning      integer;
        l_dest_offset  integer := 1;
        l_src_offset   integer := 1;
        l_blob_csid    number := dbms_lob.default_csid;
        l_lang_context number := dbms_lob.default_lang_ctx;

      begin
        dbms_lob.createtemporary(l_clob, false);
        savepoint before_transaction;

        l_tmpb := utl_compress.lz_uncompress(c0.response_data);

        dbms_lob.converttoclob(dest_lob     => l_clob,
                               src_blob     => l_tmpb,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

        -- запит в РУ на реєстрацію/перевипуск карт
        if c0.transport_type_code in
           (transport_utl.TRANS_TYPE_REGEPP,
            transport_utl.TRANS_TYPE_RESTART_EPP) then
          pfu_epp_utl.r_regepp_procesing(l_clob, c0.id);
        -- запит на статуси реєстрації/перевипуск карт
        elsif c0.transport_type_code =
              transport_utl.TRANS_TYPE_CHECKISSUECARD then
          pfu_epp_utl.r_checkissuecard_procesing(l_clob, c0.id);
        elsif c0.transport_type_code = transport_utl.TRANS_TYPE_ACTIVATEACC then
          pfu_epp_utl.r_activateacc_procesing(l_clob, c0.id);
        elsif c0.transport_type_code = transport_utl.TRANS_TYPE_CHECKSTATE then
          pfu_files_utl.r_checkstate_procesing(l_clob, c0.id);
        elsif c0.transport_type_code = transport_utl.TRANS_TYPE_GET_EBP then
          pfu_files_utl.r_getebp_procesing(l_clob, c0.id);
        elsif c0.transport_type_code =
              transport_utl.TRANS_TYPE_CHECKBACKSTATE then
          pfu_files_utl.r_checkbackstate_procesing(l_clob, c0.id);
        elsif c0.transport_type_code = transport_utl.TRANS_TYPE_CREATE_PAYM then
          pfu_files_utl.r_create_paym_procesing(l_clob, c0.id);
        elsif c0.transport_type_code =
              transport_utl.TRANS_TYPE_GET_CARDKILL then
          pfu_files_utl.r_getcardkill_procesing(l_clob, c0.id);
        elsif c0.transport_type_code =
              transport_utl.TRANS_TYPE_GET_ACC_REST then
          pfu_files_utl.r_getacc_rest_procesing(l_clob, c0.id);
        elsif c0.transport_type_code = transport_utl.TRANS_TYPE_GET_REPORT then
          pfu_files_utl.r_get_report_procesing(l_clob, c0.id, c0.kf);
        elsif c0.transport_type_code =
              transport_utl.TRANS_TYPE_CHECK_EPP_STATE then
          pfu_epp_utl.r_check_epp_state_procesing(l_clob, c0.id);
        elsif c0.transport_type_code = transport_utl.TRANS_TYPE_GET_BRANCH then
          pfu_files_utl.r_branch_procesing(l_clob, c0.id);
        end if;
        dbms_lob.freetemporary(l_clob);
      exception
        when others then
          dbms_lob.freetemporary(l_clob);
          rollback to before_transaction;
      end;

    end loop;
  end;

  procedure process_receipt_ebp is

    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

  begin
    for c0 in (select t.*, tt.transport_type_code
                 from transport_unit t
                 join transport_unit_type tt
                   on t.unit_type_id = tt.id
                  and tt.transport_type_code =
                      transport_utl.TRANS_TYPE_GET_EBP
                  and t.state_id = transport_utl.TRANS_STATE_RESPONDED) loop
      declare
        l_clob         clob;
        l_tmpb         blob;
        l_warning      integer;
        l_dest_offset  integer := 1;
        l_src_offset   integer := 1;
        l_blob_csid    number := dbms_lob.default_csid;
        l_lang_context number := dbms_lob.default_lang_ctx;
      begin
        dbms_lob.createtemporary(l_clob, false);
        savepoint before_transaction;

        l_tmpb := utl_compress.lz_uncompress(c0.response_data);

        dbms_lob.converttoclob(dest_lob     => l_clob,
                               src_blob     => l_tmpb,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

        if c0.transport_type_code = transport_utl.TRANS_TYPE_GET_EBP then
          pfu_files_utl.r_getebp_procesing(l_clob, c0.id);
        end if;
        dbms_lob.freetemporary(l_clob);
      exception
        when others then
          dbms_lob.freetemporary(l_clob);
          rollback to before_transaction;
      end;

    end loop;
  end;
  
  procedure process_receipt_lock is

    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

  begin
    for c0 in (select t.*, tt.transport_type_code
                 from transport_unit t
                 join transport_unit_type tt
                   on t.unit_type_id = tt.id
                  and tt.transport_type_code in (transport_utl.TRANS_TYPE_SET_CARD_BLOCK,
                                                 transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK)
                  and t.state_id = transport_utl.TRANS_STATE_RESPONDED) loop
      declare
        l_clob         clob;
        l_tmpb         blob;
        l_warning      integer;
        l_dest_offset  integer := 1;
        l_src_offset   integer := 1;
        l_blob_csid    number := dbms_lob.default_csid;
        l_lang_context number := dbms_lob.default_lang_ctx;
      begin
        dbms_lob.createtemporary(l_clob, false);
        savepoint before_transaction;

        l_tmpb := utl_compress.lz_uncompress(c0.response_data);

        dbms_lob.converttoclob(dest_lob     => l_clob,
                               src_blob     => l_tmpb,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

        if c0.transport_type_code = transport_utl.TRANS_TYPE_SET_CARD_BLOCK then
          pfu_epp_utl.r_card_block_procesing(l_clob, c0.id);
        elsif c0.transport_type_code = transport_utl.TRANS_TYPE_SET_CARD_UNBLOCK then
          pfu_epp_utl.r_card_unblock_procesing(l_clob, c0.id);
        end if;
        dbms_lob.freetemporary(l_clob);
      exception
        when others then
          dbms_lob.freetemporary(l_clob);
          rollback to before_transaction;
      end;

    end loop;
  end;

  function get_job_info return t_job_info
    pipelined is
  begin
    for c0 in (select j.job_name,
                      j.comments,
                      j.state,
                      j.last_start_date,
                      j.LAST_RUN_DURATION,
                      j.next_run_date,
                      (SELECT jr.STATUS
                         FROM all_scheduler_job_run_details jr
                        WHERE jr.JOB_NAME = j.job_name
                          AND jr.ACTUAL_START_DATE = j.last_start_date) run_status,
                      (SELECT jr.ADDITIONAL_INFO
                         FROM all_scheduler_job_run_details jr
                        WHERE jr.JOB_NAME = j.job_name
                          AND jr.ACTUAL_START_DATE = j.last_start_date) add_info
                 FROM all_scheduler_jobs j
                where j.owner = 'PFU') loop
      pipe row(c0);
    end loop;

  end;

  procedure start_job(p_job_name in varchar2) is
  begin

    dbms_scheduler.run_job('PFU.' || p_job_name);

  end;

  procedure stop_job(p_job_name in varchar2) is
  begin

    dbms_scheduler.stop_job('PFU.' || p_job_name);

  end;

  procedure disable_job(p_job_name in varchar2) is
  begin

    dbms_scheduler.disable('PFU.' || p_job_name);

  end;

  procedure enable_job(p_job_name in varchar2) is
  begin

    dbms_scheduler.enable('PFU.' || p_job_name);

  end;

  procedure process_pfu_stage is
  begin
    -- запити в ПФУ
    send_requests;
    -- обробка відповіді
    process_response;
  end;

  procedure process_claim_stage is
  begin
    prepare_new_claims();
    prepare_activation_claims();
    --prepare_cardkill_claim();
    process_w4_statuses();
    gen_epp_matching2();
  end;

  procedure process_transport_stage is
  begin
    send_data_to_bank_units();
    process_receipt;
  end;

  procedure process_transport_ebp_stage is
  begin
    send_data_to_bank_units_ebp;
    process_receipt_ebp;
    prepare_cardkill_claim();
  end;
  
  procedure process_transport_lock_stage is
  begin
    send_data_to_bank_units_lock;
    process_receipt_lock;
  end;

  procedure process_all_stages is
  begin
    /*-- запити в ПФУ
    send_requests;
    -- обробка відповіді
    process_response;*/
    ---- 2 часть
    prepare_new_claims();
    prepare_activation_claims();

    --   prepare_cardkill_claim();

    process_w4_statuses();


    send_data_to_bank_units();
    process_receipt;
    gen_epp_matching2();
    gen_epp_kvt2;
  end;
end;
/
 show err;
 
PROMPT *** Create  grants  PFU_SERVICE_UTL ***
grant EXECUTE                                                                on PFU_SERVICE_UTL to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/PFU/package/pfu_service_utl.sql =========*** End 
 PROMPT ===================================================================================== 
 
