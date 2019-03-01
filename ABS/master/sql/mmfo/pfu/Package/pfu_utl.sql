
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/PFU/package/pfu_utl.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE PFU.PFU_UTL is

    REQ_STATE_NEW                  constant varchar2(30) := 'NEW';
    REQ_STATE_READY_FOR_SENDING    constant varchar2(30) := 'READY_FOR_SENDING';
    REQ_STATE_SENT                 constant varchar2(30) := 'SENT';
    REQ_STATE_FAILED               constant varchar2(30) := 'FAILED';
    REQ_STATE_ACCEPTED             constant varchar2(30) := 'ACCEPTED';
    REQ_STATE_CANCELED_BY_PFU      constant varchar2(30) := 'CANCELED_BY_PFU';
    REQ_STATE_DATA_IS_READY        constant varchar2(30) := 'DATA_IS_READY';
    REQ_STATE_DATA_IS_RECEIVED     constant varchar2(30) := 'DATA_IS_RECEIVED';
    REQ_STATE_DATA_PROCESSED       constant varchar2(30) := 'DATA_PROCESSED';
    REQ_STATE_MATCHING_PROCESSED   constant varchar2(30) := 'MATCHING_PROCESSED';
    REQ_STATE_DATA_PROCESSING_FAIL constant varchar2(30) := 'DATA_PROCESSING_FAIL';
    REQ_STATE_WAIT_FOR_ENVELOPES   constant varchar2(30) := 'WAIT_FOR_ENVELOPES';
    REQ_STATE_IGNORE               constant varchar2(30) := 'IGNORE';

    REQ_TYPE_ENVELOPE_LIST         constant varchar2(30) := 'GET_CONVERT_LISTS';
    REQ_TYPE_ENVELOPE              constant varchar2(30) := 'GET_CONVERT';
    REQ_TYPE_EPP_BATCH_LIST        constant varchar2(30) := 'GET_EPP_BATCH_LISTS';
    REQ_TYPE_EPP_BATCH             constant varchar2(30) := 'GET_EPP_BATCH';
    REQ_TYPE_MATCHING1             constant varchar2(30) := 'GET_POST_CONVERT_ANSWER';
    REQ_TYPE_MATCHING2             constant varchar2(30) := 'GET_POST_PAYMENT_REPLY';
    REQ_TYPE_DEATH_MATCHING        constant varchar2(30) := 'POST_WORKING_NOTICE_DEATH_BANK';
    REQ_TYPE_NO_TURNOVER           constant varchar2(30) := 'POST_NOTICE_DRAWING_BANK_ANSW';
    REQ_TYPE_EPP_MATCHING          constant varchar2(30) := 'PUT_EPP_PACKET_BNK_STATE';
    REQ_TYPE_EPP_MATCHING2         constant varchar2(30) := 'PUT_EPP_PACKET_BNK_STATE_2';
    REQ_TYPE_EPP_ACTIVATION        constant varchar2(30) := 'PUT_EPP_BNK_INFO_ASK';
    REQ_TYPE_DEATH_LIST            constant varchar2(30) := 'GET_DEATH_LIST';
    REQ_TYPE_DEATH                 constant varchar2(30) := 'GET_DEATH';
    REQ_TYPE_VERIFY_LIST           constant varchar2(30) := 'GET_VERIFICATION_LIST';
    REQ_TYPE_VERIFY                constant varchar2(30) := 'GET_VERIFICATION';
    REQ_TYPE_CHANGE_ATTR           constant varchar2(30) := 'POST_REPLACEMENT_ACCOUNT';


    ENV_STATE_LIST_RECEIVED        constant varchar2(30) := 'ENVLIST_RECEIVED';
    ENV_STATE_ENVELOPE_RECEIVED    constant varchar2(30) := 'ENVELOPE_RECEIVED';
    ENV_STATE_PARSED               constant varchar2(30) := 'PARSED';
    ENV_STATE_ERROR_SIGN           constant varchar2(30) := 'ERROR_SIGN';
    ENV_STATE_ERROR_PARSE          constant varchar2(30) := 'ERROR_PARSE';

    DEA_STATE_LIST_RECEIVED        constant varchar2(30) := 'DEALIST_RECEIVED';
    DEA_STATE_DEATH_RECEIVED       constant varchar2(30) := 'DEATH_RECEIVED';

    type tblFileForKvit is table of pfu_file%rowtype;

    function read_request(
        p_request_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return pfu_request%rowtype;

    function read_request_type(
        p_request_type_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_request_type%rowtype;

    function read_envelope_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_envelope_list_request%rowtype;

    function read_envelope_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_envelope_request%rowtype;

    function read_death_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_death_request%rowtype;

    function read_death_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_death_list_request%rowtype;

    function read_verify_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_verification_list_request%rowtype;

    function get_request_type_name(
        p_request_type_id in integer)
    return varchar2;

    procedure track_request(
        p_request_id in integer,
        p_state      in varchar2,
        p_tracking_comment in varchar2,
        p_stack_trace in clob default null);

    function create_request(
        p_request_type in varchar2,
        p_parent_request_id in integer default null)
    return integer;

    function create_envelope_list_request(
        p_date_from in date,
        p_date_to   in date,
        p_opfu_code in varchar2 default null)
    return integer;

    function create_death_list_request(
        p_date_from in date,
        p_date_to   in date,
        p_opfu_code in varchar2 default null)
    return integer;

    function create_verify_list_request(
        p_date_from in date,
        p_date_to   in date)
    return integer;

    function create_envelope(
        p_pfu_envelope_id in integer,
        p_pfu_branch_code in varchar2,
        p_pfu_branch_name in varchar2,
        p_register_date in date,
        p_receiver_mfo in varchar2,
        p_receiver_branch in varchar2,
        p_receiver_name in varchar2,
        p_envelope_check_sum in integer,
        p_envelope_check_lines_count in integer,
        p_parent_request_id in integer)
    return integer;

    function create_death(
        p_pfu_death_id in integer,
        p_pfu_branch_code in varchar2,
        p_pfu_branch_name in varchar2,
        p_register_date in date,
        p_receiver_mfo in varchar2,
        p_receiver_branch in varchar2,
        p_receiver_name in varchar2,
        p_check_sum in integer,
        p_check_lines_count in integer,
        p_parent_request_id in integer)
    return integer;

    function create_verification(
        p_pfu_death_id in integer,
        p_pfu_branch_code in varchar2,
        p_pfu_branch_name in varchar2,
        p_register_date in date,
        p_check_lines_count in integer,
        p_parent_request_id in integer)
    return integer;

    function create_death_file(
        p_death_request_id in integer,
        p_fileid in varchar2,
        p_payment_date in date,
        p_file_lines_count in integer)
    return integer;

    procedure create_matching(p_xml in clob,
                              p_parent_request_id in integer,
                              p_match_type in number);

    procedure create_no_turnover(p_xml in clob,
                                p_parent_request_id in integer,
                                p_request_id out integer);

    procedure create_epp_matching(p_xml in clob,
                                  p_parent_request_id in integer);

    procedure create_epp_matching2(p_xml in clob);
    
    procedure create_epp_activation(
        p_xml in clob);

    procedure create_replacement(p_xml in clob);

    function get_rec_to_kvit1 return tblFileForKvit pipelined;

    function create_file(
        p_envelope_request_id in integer,
        p_file_name in varchar2,
        p_payment_date in date,
        p_file_number in integer,
        p_file_check_sum in integer,
        p_file_lines_count in integer,
        p_file_data in blob)
    return integer;

    procedure set_request_state(
        p_request_id in integer,
        p_state in varchar2,
        p_tracking_comment in varchar2,
        p_stack_trace in clob default null);

    procedure set_request_parts(
        p_request_id in integer,
        p_parts in integer);

    procedure set_pfu_request_id(
        p_request_id in integer,
        p_pfu_request_id in integer);

    procedure set_death(p_recid in pfu_death_record.id%type);

    procedure create_part(
       p_session_id  in integer,
       p_request_id  in integer,
       p_part_num    in integer,
       p_part_data   blob,
       p_part_data_clob clob default null);

    function get_parameter(
        p_key in varchar2)
    return varchar2;

    function encodeclobtobase64(
        p_clob clob)
    return clob;

    function decodeclobfrombase64(
        p_clob clob)
    return clob;

    function base64decode_to_blob(
        p_clob clob)
    return blob;

    function blob_to_base64encode(
        p_blob in blob)
    return clob;

    function blob_to_clob(
        p_blob in blob)
    return clob;

    function clob_to_blob(
        p_clob in clob)
    return blob;

    function blob_to_hex (
        p_blob in blob)
    return clob;

    function string_list_to_clob(
        p_string_list in string_list,
        p_delimiter in varchar2 default ';')
    return clob;

    function get_salt
    return raw;

    function pfu_encode_base64(
         p_blob_in in blob)
    return clob;

    function pfu_decode_base64(
        p_clob_in in clob)
    return blob;

    function pfu_convertb2c (p_src blob) return clob;

    function utf8todeflang(p_clob in    clob) return clob;
end;
/
CREATE OR REPLACE PACKAGE BODY PFU.PFU_UTL as

    function read_request_type(
        p_request_type_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_request_type%rowtype
    is
        l_request_type_row pfu_request_type%rowtype;
    begin
        select *
        into   l_request_type_row
        from   pfu_request_type t
        where  t.id = p_request_type_id;

        return l_request_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Тип запитів з ідентифікатором {' || p_request_type_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_request(
        p_request_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return pfu_request%rowtype
    is
        l_request_row pfu_request%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_request_row
            from   pfu_request t
            where  t.id = p_request_id
            for update;
        else
            select *
            into   l_request_row
            from   pfu_request t
            where  t.id = p_request_id;
        end if;

        return l_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит з ідентифікатором {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_envelope_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_envelope_list_request%rowtype
    is
        l_envelope_list_request_row pfu_envelope_list_request%rowtype;
    begin
        select *
        into   l_envelope_list_request_row
        from   pfu_envelope_list_request t
        where  t.id = p_request_id;

        return l_envelope_list_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит на отримання списку конвертів з ідентифікатором {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_death_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_death_list_request%rowtype
    is
        l_death_list_request_row pfu_death_list_request%rowtype;
    begin
        select *
        into   l_death_list_request_row
        from   pfu_death_list_request t
        where  t.id = p_request_id;

        return l_death_list_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит на отримання списку пенсіонерів {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_verify_list_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_verification_list_request%rowtype
    is
        l_verify_list_request_row pfu_verification_list_request%rowtype;
    begin
        select *
        into   l_verify_list_request_row
        from   pfu_verification_list_request t
        where  t.id = p_request_id;

        return l_verify_list_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит на отримання списку пенсіонерів {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_envelope_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_envelope_request%rowtype
    is
        l_envelope_request_row pfu_envelope_request%rowtype;
    begin
        select *
        into   l_envelope_request_row
        from   pfu_envelope_request t
        where  t.id = p_request_id;

        return l_envelope_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит на отримання конверту з ідентифікатором {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

     function read_death_request(
        p_request_id in integer,
        p_raise_ndf in boolean default true)
    return pfu_death_request%rowtype
    is
        l_death_request_row pfu_death_request%rowtype;
    begin
        select *
        into   l_death_request_row
        from   pfu_death_request t
        where  t.id = p_request_id;

        return l_death_request_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Запит на отримання конверту з ідентифікатором {' || p_request_id || '} не знайдений');
             else return null;
             end if;
    end;

    function get_request_type_name(
        p_request_type_id in integer)
    return varchar2
    is
    begin
        return read_request_type(p_request_type_id, p_raise_ndf => false).request_type_name;
    end;

    procedure track_request(
        p_request_id in integer,
        p_state      in varchar2,
        p_tracking_comment in varchar2,
        p_stack_trace in clob default null)
    is
    begin
        insert into pfu_request_tracking
        values (pfu_request_tracking_seq.nextval,
                p_request_id,
                p_state,
                sysdate,
                p_tracking_comment,
                p_stack_trace);
    end;

    function create_request(
        p_request_type in varchar2,
        p_parent_request_id in integer default null)
    return integer
    is
        l_request_id integer;
    begin
        insert into pfu_request
        values (pfu_request_seq.nextval, p_request_type, pfu_utl.REQ_STATE_NEW, null, p_parent_request_id, sysdate, null)
        returning id
        into l_request_id;

        return l_request_id;
    end;

    function create_envelope_list_request(
        p_date_from in date,
        p_date_to   in date,
        p_opfu_code in varchar2 default null)
    return integer
    is
        l_request_id integer;
    begin
        -- todo
        l_request_id := create_request(pfu_utl.REQ_TYPE_ENVELOPE_LIST);

        insert into pfu_envelope_list_request
        values (l_request_id, p_date_from, p_date_to, p_opfu_code, sysdate);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на отримання списку конвертів за період {' ||
                          to_char(p_date_from, 'dd.mm.yyyy') || ' - ' ||
                          to_char(p_date_to, 'dd.mm.yyyy') ||
                          '} зареєстрований');

        return l_request_id;
    end;

    function create_death_list_request(
        p_date_from in date,
        p_date_to   in date,
        p_opfu_code in varchar2 default null)
    return integer
    is
        l_request_id integer;
    begin

        l_request_id := create_request(pfu_utl.REQ_TYPE_DEATH_LIST);

        insert into pfu_death_list_request
        values (l_request_id, p_date_from, p_date_to, p_opfu_code, sysdate);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на отримання списку пенсіонерів, що померли за період {' ||
                          to_char(p_date_from, 'dd.mm.yyyy') || ' - ' ||
                          to_char(p_date_to, 'dd.mm.yyyy') ||
                          '} зареєстрований');

        return l_request_id;
    end;

    function create_verify_list_request(
        p_date_from in date,
        p_date_to   in date)
    return integer
    is
        l_request_id integer;
    begin

        l_request_id := create_request(pfu_utl.REQ_TYPE_VERIFY_LIST);

        insert into pfu_verification_list_request
        values (l_request_id, p_date_from, p_date_to, sysdate);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на отримання списку пенсіонерів, що померли за період {' ||
                          to_char(p_date_from, 'dd.mm.yyyy') || ' - ' ||
                          to_char(p_date_to, 'dd.mm.yyyy') ||
                          '} зареєстрований');

        return l_request_id;
    end;

    function create_envelope(
        p_pfu_envelope_id in integer,
        p_pfu_branch_code in varchar2,
        p_pfu_branch_name in varchar2,
        p_register_date in date,
        p_receiver_mfo in varchar2,
        p_receiver_branch in varchar2,
        p_receiver_name in varchar2,
        p_envelope_check_sum in integer,
        p_envelope_check_lines_count in integer,
        p_parent_request_id in integer)
    return integer
    is
        l_request_id integer;
    begin
        l_request_id := create_request(pfu_utl.REQ_TYPE_ENVELOPE, p_parent_request_id);

        insert into pfu_envelope_request
        values (l_request_id,
                p_pfu_envelope_id,
                p_pfu_branch_code,
                p_pfu_branch_name,
                p_register_date,
                p_receiver_mfo,
                p_receiver_branch,
                p_receiver_name,
                p_envelope_check_sum,
                p_envelope_check_lines_count,
                sysdate,
                null,
                null,
                null,
                ENV_STATE_LIST_RECEIVED,
                null,
                null);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на отримання конверту для філії {' ||
                          p_pfu_branch_name || ' на дату ' ||
                          to_char(p_register_date, 'dd.mm.yyyy') ||
                          '} зареєстрований');

        return l_request_id;
    end;

    function create_death(
        p_pfu_death_id in integer,
        p_pfu_branch_code in varchar2,
        p_pfu_branch_name in varchar2,
        p_register_date in date,
        p_receiver_mfo in varchar2,
        p_receiver_branch in varchar2,
        p_receiver_name in varchar2,
        p_check_sum in integer,
        p_check_lines_count in integer,
        p_parent_request_id in integer)
    return integer
    is
        l_request_id integer;
    begin
        l_request_id := create_request(pfu_utl.REQ_TYPE_DEATH, p_parent_request_id);

        insert into pfu_death_request
        values (l_request_id,
                p_pfu_death_id,
                p_pfu_branch_code,
                p_pfu_branch_name,
                p_register_date,
                p_receiver_mfo,
                p_receiver_branch,
                p_receiver_name,
                p_check_sum,
                p_check_lines_count,
                sysdate,
                null,
                null,
                null,
                DEA_STATE_LIST_RECEIVED,
                null,
                null);

         track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на отримання конверту для філії {' ||
                          p_pfu_branch_name || ' на дату ' ||
                          to_char(p_register_date, 'dd.mm.yyyy') ||
                          '} зареєстрований');

        return l_request_id;
    end;

    function create_verification(
        p_pfu_death_id in integer,
        p_pfu_branch_code in varchar2,
        p_pfu_branch_name in varchar2,
        p_register_date in date,
        p_check_lines_count in integer,
        p_parent_request_id in integer)
    return integer
    is
        l_request_id integer;
    begin
        l_request_id := create_request(pfu_utl.REQ_TYPE_VERIFY, p_parent_request_id);

        insert into pfu_verification_request
        values (l_request_id,
                p_pfu_death_id,
                p_pfu_branch_code,
                p_pfu_branch_name,
                p_register_date,
                p_check_lines_count,
                sysdate,
                null,
                null,
                null,
                DEA_STATE_LIST_RECEIVED,
                null,
                null);

         track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на отримання конверту для філії {' ||
                          p_pfu_branch_name || ' на дату ' ||
                          to_char(p_register_date, 'dd.mm.yyyy') ||
                          '} зареєстрований');

        return l_request_id;
    end;

    procedure create_matching(p_xml in clob,
                              p_parent_request_id in integer,
                              p_match_type in number)

    is
        l_request_id integer;
    begin
        l_request_id := create_request(case p_match_type when 1
                                                         then pfu_utl.REQ_TYPE_MATCHING1
                                                         when 2
                                                         then pfu_utl.REQ_TYPE_MATCHING2
                                                         when 3
                                                         then pfu_utl.REQ_TYPE_DEATH_MATCHING end,
                                       p_parent_request_id);

        insert into pfu_matching_request
        values (l_request_id,
                p_xml);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на формування квитанції зареєстрований');

    end;

    procedure create_no_turnover(p_xml in clob,
                                p_parent_request_id in integer,
                                p_request_id out integer)

    is
    begin
        p_request_id := create_request(pfu_utl.REQ_TYPE_NO_TURNOVER,
                                       p_parent_request_id);

        insert into pfu_no_turnover_request
        values (p_request_id,
                p_xml);

        track_request(p_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на формування повідомлення зареєстрований');

    end;

    procedure create_replacement(p_xml in clob)
    is
        l_request_id integer;
    begin
        l_request_id := create_request(pfu_utl.REQ_TYPE_CHANGE_ATTR);

        insert into pfu_replacement_request
        values (l_request_id,
                p_xml);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на формування квитанції зареєстрований');

    end;

    procedure create_epp_matching(p_xml in clob,
                                  p_parent_request_id in integer)

    is
        l_request_id integer;
    begin
        l_request_id := create_request(pfu_utl.REQ_TYPE_EPP_MATCHING, p_parent_request_id);

        insert into pfu_matching_request
        values (l_request_id,
                p_xml);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на формування квитанції зареєстрований');

    end;
    
    procedure create_epp_matching2(p_xml in clob)

    is
        l_request_id integer;
    begin
        l_request_id := create_request(pfu_utl.REQ_TYPE_EPP_MATCHING2, null);

        insert into pfu_matching_request
        values (l_request_id,
                p_xml);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на формування квитанції 2 зареєстрований');

    end;

    procedure create_epp_activation(
        p_xml in clob)
    is
        l_request_id integer;
    begin
        l_request_id := create_request(pfu_utl.REQ_TYPE_EPP_ACTIVATION, null);

        insert into pfu_matching_request
        values (l_request_id, p_xml);

        track_request(l_request_id,
                      pfu_utl.REQ_STATE_NEW,
                      'Запит на передачу відомостей про активацію ЕПП зареєстрований');

    end;

    procedure set_request_state(
        p_request_id in integer,
        p_state in varchar2,
        p_tracking_comment in varchar2,
        p_stack_trace in clob default null)
    is
    begin
        update pfu_request t
        set    t.state = p_state
        where  t.id = p_request_id;

        track_request(p_request_id, p_state, p_tracking_comment, p_stack_trace);
    end;

    procedure set_request_parts(
        p_request_id in integer,
        p_parts in integer)
    is
    begin
        update pfu_request t
        set    t.parts_cnt = p_parts
        where  t.id = p_request_id;
    end;

    procedure set_pfu_request_id(
        p_request_id in integer,
        p_pfu_request_id in integer)
    is
    begin
        update pfu_request t
        set    t.pfu_request_id = p_pfu_request_id
        where  t.id = p_request_id;
    end;

    function create_file(
        p_envelope_request_id in integer,
        p_file_name in varchar2,
        p_payment_date in date,
        p_file_number in integer,
        p_file_check_sum in integer,
        p_file_lines_count in integer,
        p_file_data in blob)
    return integer
    is
        l_file_id integer;
        l_cnt integer;
    begin
      select count(*) into l_cnt
       from pfu_file f
      where f.envelope_request_id = p_envelope_request_id
        and f.payment_date = p_payment_date
        and f.file_name = p_file_name
        and f.file_number = p_file_number
        and f.check_sum = p_file_check_sum;

      if (l_cnt > 0) then
        delete
          from pfu_file_records fr
         where fr.file_id in (select f.id
                                from pfu_file f
                               where f.envelope_request_id = p_envelope_request_id);

        delete
          from pfu_file f
         where f.envelope_request_id = p_envelope_request_id;
      end if;

        insert into pfu_file
        values (pfu_file_seq.nextval,
                p_envelope_request_id,
                p_file_check_sum,
                p_file_lines_count,
                p_payment_date,
                p_file_number,
                p_file_name,
                p_file_data,
                'NEW',
                sysdate,
                null,
                null,
                null,
                null,
                '01') -- cobummfо-10812 - добавление типа выплат в связи с монетизацией
        returning id
        into l_file_id;
        commit;
        return l_file_id;
    end;

    function create_death_file(
        p_death_request_id in integer,
        p_fileid in varchar2,
        p_payment_date in date,
        p_file_lines_count in integer)
    return integer
    is
        l_file_id integer;
        l_cnt integer;
    begin
     select count(*) into l_cnt
       from pfu_death f
      where f.request_id = p_death_request_id;

      if (l_cnt > 0) then
        delete
          from pfu_death_record fr
         where fr.list_id in (select f.id
                                from pfu_death f
                               where f.request_id = p_death_request_id);

        delete
          from pfu_death f
         where f.request_id = p_death_request_id;
      end if;

        insert into pfu_death
        values (pfu_death_seq.nextval,
                p_death_request_id,
                p_file_lines_count,
                p_payment_date,
                sysdate,
                'NEW',
                null,
                p_fileid)
        returning id
        into l_file_id;

        return l_file_id;
    end;

    -- отбор операций для квитовки
    function get_rec_to_kvit1 return tblFileForKvit pipelined
      as
--      l_rec_file pfu_file%rowtype;
      l_cnt integer;
    begin
      for rec_file in (select pf.envelope_request_id
                         from pfu_file pf
                        where pf.state = 'CHECKED'
                     group by pf.envelope_request_id) loop
         select count(1) into l_cnt
           from (select state
                   from pfu_file pf
                  where pf.envelope_request_id = rec_file.envelope_request_id
               group by pf.envelope_request_id,pf.state) a;
         if (l_cnt = 1) then
            for rec_file_ok in (select *
                                 from pfu_file pf
                                where pf.envelope_request_id = rec_file.envelope_request_id) loop
               pipe row(rec_file_ok);
            end loop;
         end if;
      end loop;
    end;

    procedure create_part(
       p_session_id  in integer,
       p_request_id  in integer,
       p_part_num    in integer,
       p_part_data   blob,
       p_part_data_clob clob)
    is
    begin
        insert into pfu_request_parts
        values (p_session_id,
                p_request_id,
                p_part_num,
                sysdate,
                p_part_data,
                p_part_data_clob,
                'NEW');
    end;

    function get_parameter(
        p_key in varchar2)
    return varchar2
    is
        l_value varchar2(4000 byte);
    begin
        select t.value
        into   l_value
        from   pfu_parameter t
        where  t.key = p_key;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function encodeclobtobase64(p_clob clob) return clob is
      l_clob   clob;
      l_len    number;
      l_pos    number := 1;
      l_buf    varchar2(32767);
      l_amount number := 32767;
    begin
      l_len := dbms_lob.getlength(p_clob);
      dbms_lob.createtemporary(l_clob, true);

      while l_pos <= l_len
      loop
        dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
        l_buf := utl_encode.text_encode(l_buf, encoding => utl_encode.base64);
        l_pos := l_pos + l_amount;
        dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
      end loop;

      return l_clob;
    end;

    function decodeclobfrombase64(p_clob clob) return clob is
      l_clob   clob;
      l_len    number;
      l_pos    number := 1;
      l_buf    varchar2(32767);
      l_amount number := 16000;
    begin
      l_len := dbms_lob.getlength(p_clob);
      dbms_lob.createtemporary(l_clob, true);

      while l_pos <= l_len
      loop
        dbms_lob.read(p_clob, l_amount, l_pos, l_buf);
        l_buf := utl_encode.text_decode(l_buf, encoding => utl_encode.base64);
        l_pos := l_pos + l_amount;
        dbms_lob.writeappend(l_clob, length(l_buf), l_buf);
      end loop;

      return l_clob;
    end;

    function base64decode_to_blob(p_clob clob)
      return blob
    is
      l_blob    blob;
      l_raw     raw(32767);
      l_amt     number := 7700;
      l_offset  number := 1;
      l_temp    varchar2(32767);
    begin
      begin
        dbms_lob.createtemporary (l_blob, false, dbms_lob.call);
        loop
          dbms_lob.read(p_clob, l_amt, l_offset, l_temp);
          l_offset := l_offset + l_amt;
          l_raw    := utl_encode.base64_decode(utl_raw.cast_to_raw(l_temp));
          dbms_lob.append (l_blob, to_blob(l_raw));
        end loop;
      exception
        when no_data_found then
          null;
      end;
      return l_blob;
    end;

   function blob_to_base64encode(p_blob in blob) return clob
    is
      l_clob clob;
      l_step pls_integer := 12000; -- make sure you set a multiple of 3 not higher than 24573
    begin
      for i in 0 .. trunc((dbms_lob.getlength(p_blob) - 1 )/l_step) loop
        l_clob := l_clob || utl_raw.cast_to_varchar2(utl_encode.base64_encode(dbms_lob.substr(p_blob, l_step, i * l_step + 1)));
      end loop;
      return l_clob;
    end;

    function blob_to_clob (p_blob in blob) return clob
    is
        v_clob    clob;
        v_varchar varchar2(32767);
        v_start   pls_integer := 1;
        v_buffer  pls_integer := 32767;
    begin
      dbms_lob.createtemporary(v_clob, true);

      for i in 1..ceil(dbms_lob.getlength(p_blob) / v_buffer)
      loop
         v_varchar := utl_raw.cast_to_varchar2(dbms_lob.substr(p_blob, v_buffer, v_start));
         dbms_lob.writeappend(v_clob, length(v_varchar), v_varchar);
         v_start := v_start + v_buffer;
      end loop;

      return v_clob;

    end blob_to_clob;

    function blob_to_hex (p_blob in blob) return clob
    is
        v_clob    clob;
        v_raw raw(4000);
        v_start   pls_integer := 1;
        v_buffer  pls_integer := 2000;
    begin
      dbms_lob.createtemporary(v_clob, true);
      for i in 1..ceil(dbms_lob.getlength(p_blob) / v_buffer)
      loop
         v_raw := utl_raw.cast_to_raw(dbms_lob.substr(p_blob, v_buffer, v_start));
         dbms_lob.writeappend(v_clob, length(v_raw), v_raw);
         v_start := v_start + v_buffer;
      end loop;
      return v_clob;
    end blob_to_hex;

    function clob_to_blob(p_clob in clob) return blob
    -- typecasts CLOB to BLOB (binary conversion)
    is
      pos     number := 1;
      buffer  raw(32767);
      res     blob;
      lob_len pls_integer := dbms_lob.getlength(p_clob);
      l_amount number := 16000;
    begin
      dbms_lob.createtemporary(res, true);
      dbms_lob.open(res, dbms_lob.lob_readwrite);

      loop
        buffer := utl_raw.cast_to_raw(dbms_lob.substr(p_clob, l_amount, pos));
        if utl_raw.length(buffer) > 0 then
           dbms_lob.writeappend(res, utl_raw.length(buffer), buffer);
        end if;

        pos := pos + l_amount;
        exit when pos > lob_len;
      end loop;

      return res; -- res is OPEN here
    end clob_to_blob;

    function string_list_to_clob(
        p_string_list in string_list,
        p_delimiter in varchar2 default ';')
    return clob
    is
        l_clob clob;
        l integer;
        l_next_id integer;
    begin
        if (p_string_list is null) then
            return null;
        end if;

        dbms_lob.createtemporary(l_clob, false);
        l := p_string_list.first;
        while (l is not null) loop
            l_next_id := p_string_list.next(l);
            dbms_lob.append(l_clob, p_string_list(l) || case when l_next_id is null then null else p_delimiter end);
            l := l_next_id;
        end loop;
        return l_clob;
    end;

    function get_salt
    return raw
    is
        l_key varchar2(4000 byte);
    begin
        l_key := bars.crypto_utl.get_key_value(trunc(sysdate), 'WAY_DOC');
        if (l_key is null) then
            l_key := bars.crypto_utl.get_key_value(trunc(sysdate), 'WAY_DOC', p_previous => true);
        end if;

        return l_key;
    end;

    procedure set_death(p_recid in pfu_death_record.id%type)
      is
      l_rec pfu_death_record%rowtype;
    begin
       select * into l_rec
         from pfu_death_record dr
        where dr.id = p_recid;

       if l_rec.bank_mfo != '0000000000' then
         update pfu_pensioner p
            set p.block_type = 4,
                p.block_date = sysdate
          where p.okpo = l_rec.okpo
            and p.kf = l_rec.bank_mfo;
       else
         update pfu_pensioner p
            set p.block_type = 4,
                p.block_date = sysdate
          where p.ser||' '||p.numdoc = l_rec.okpo
            and p.kf = l_rec.bank_mfo;
       end if;

       update pfu_death_record dr
          set dr.state = case when nvl(dr.sum_over,0) > 0 then 'READY_FOR_PAY' ELSE 'PROCESSED' END
        where dr.id = p_recid;

        if (nvl(l_rec.sum_over,0) > 0) then
          pfu_service_utl.prepare_paym_back(l_rec.id);
        end if;

    end;

    -- функції, отримані від ПФУ - todo
    function pfu_encode_base64(
         p_blob_in in blob)
    return clob
    is
        v_clob clob;
        v_result clob;
        v_offset integer;
        v_chunk_size binary_integer := (48 / 4) * 3;
        v_buffer_varchar varchar2(48);
        v_buffer_raw raw(48);
    begin
        if p_blob_in is null then
            return null;
        end if;
        dbms_lob.createtemporary(v_clob, true);
        v_offset := 1;
        for i in 1 .. ceil(dbms_lob.getlength(p_blob_in) / v_chunk_size) loop
            dbms_lob.read(p_blob_in, v_chunk_size, v_offset, v_buffer_raw);
            v_buffer_raw := utl_encode.base64_encode(v_buffer_raw);
            v_buffer_varchar := utl_raw.cast_to_varchar2(v_buffer_raw);
            dbms_lob.writeappend(v_clob, length(v_buffer_varchar), v_buffer_varchar);
            v_offset := v_offset + v_chunk_size;
        end loop;

        v_result := v_clob;
        dbms_lob.freetemporary(v_clob);
        return v_result;
    end;


    function pfu_decode_base64(
        p_clob_in in clob)
    return blob
    is
        v_blob blob;
        v_result blob;
        v_offset integer;
        v_buffer_size binary_integer := 48;
        v_buffer_varchar varchar2(48);
        v_buffer_raw raw(48);
    begin
        if p_clob_in is null then
            return null;
        end if;

        dbms_lob.createtemporary(v_blob, true);
        v_offset := 1;

        for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size) loop
            dbms_lob.read(p_clob_in, v_buffer_size, v_offset, v_buffer_varchar);
            v_buffer_raw := utl_raw.cast_to_raw(v_buffer_varchar);
            v_buffer_raw := utl_encode.base64_decode(v_buffer_raw);
            dbms_lob.writeappend(v_blob, utl_raw.length(v_buffer_raw), v_buffer_raw);
            v_offset := v_offset + v_buffer_size;
        end loop;

        v_result := v_blob;
        dbms_lob.freetemporary(v_blob);

        return v_result;
    end;

    function pfu_convertb2c (p_src blob) return clob
    is
      l_clob         clob;
      l_dest_offsset integer := 1;
      l_src_offsset  integer := 1;
      l_lang_context integer := dbms_lob.default_lang_ctx;
      l_warning      integer;
    begin
      if p_src is null then
         return null;
      end if;

      dbms_lob.createtemporary(lob_loc => l_clob, cache => false);

      dbms_lob.converttoclob(dest_lob     => l_clob
                            ,src_blob     => p_src
                            ,amount       => dbms_lob.lobmaxsize
                            ,dest_offset  => l_dest_offsset
                            ,src_offset   => l_src_offsset
                            ,blob_csid    => dbms_lob.default_csid
                            ,lang_context => l_lang_context
                            ,warning      => l_warning);

      return l_clob;
    end;

    function utf8todeflang(p_clob in    clob) return clob is
      l_blob blob;
      l_clob clob;
      l_dest_offset   integer := 1;
      l_source_offset integer := 1;
      l_lang_context  integer := DBMS_LOB.DEFAULT_LANG_CTX;
      l_warning       integer := DBMS_LOB.WARN_INCONVERTIBLE_CHAR;
    BEGIN
      DBMS_LOB.CREATETEMPORARY(l_blob, FALSE);
      DBMS_LOB.CONVERTTOBLOB
      (
       dest_lob    =>l_blob,
       src_clob    =>p_clob,
       amount      =>DBMS_LOB.LOBMAXSIZE,
       dest_offset =>l_dest_offset,
       src_offset  =>l_source_offset,
       blob_csid   =>0,
       lang_context=>l_lang_context,
       warning     =>l_warning
      );
      l_dest_offset   := 1;
      l_source_offset := 1;
      l_lang_context  := DBMS_LOB.DEFAULT_LANG_CTX;
      DBMS_LOB.CREATETEMPORARY(l_clob, FALSE);
      DBMS_LOB.CONVERTTOCLOB
      (
       dest_lob    =>l_clob,
       src_blob    =>l_blob,
       amount      =>DBMS_LOB.LOBMAXSIZE,
       dest_offset =>l_dest_offset,
       src_offset  =>l_source_offset,
       blob_csid   =>NLS_CHARSET_ID ('UTF8'),
       lang_context=>l_lang_context,
       warning     =>l_warning
      );
      return l_clob;
    end;

end;
/
 show err;
 
PROMPT *** Create  grants  PFU_UTL ***
grant EXECUTE                                                                on PFU_UTL         to BARS;
grant EXECUTE                                                                on PFU_UTL         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/PFU/package/pfu_utl.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 
