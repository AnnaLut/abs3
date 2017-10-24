
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/PFU/package/pfu_ui.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE PFU.PFU_UI is

    procedure create_envelope_list_request(
        p_date_from in date,
        p_date_to in date,
        p_opfu_code in varchar2 default null);

    procedure create_epp_batch_request(
        p_date_from in date,
        p_date_to in date);

    procedure create_death_list_request(
        p_date_from in date,
        p_date_to in date,
        p_opfu_code in varchar2 default null);

    function get_file_data(
        p_file_id in integer)
    return blob;

    function get_last_tracking_id
    return integer;
end;
/
CREATE OR REPLACE PACKAGE BODY PFU.PFU_UI as

    procedure create_envelope_list_request(
        p_date_from in date,
        p_date_to in date,
        p_opfu_code in varchar2 default null)
    is
        l_request_id integer;
    begin
        l_request_id := pfu_utl.create_envelope_list_request(p_date_from, p_date_to, p_opfu_code);
    end;

    procedure create_death_list_request(
        p_date_from in date,
        p_date_to in date,
        p_opfu_code in varchar2 default null)
    is
        l_request_id integer;
    begin
        l_request_id := pfu_utl.create_death_list_request(p_date_from, p_date_to, p_opfu_code);
    end;

    procedure create_epp_batch_request(
        p_date_from in date,
        p_date_to in date)
    is
    begin
        bars.tools.hide_hint(pfu_epp_utl.create_epp_batch_list_request(p_date_from, p_date_to));
    end;

    function get_file_data(
        p_file_id in integer)
    return blob
    is
        l_file_data blob;
    begin
        select f.file_data
        into   l_file_data
        from   pfu_file f
        where  f.id = p_file_id;

        return l_file_data;
    end;

    function get_last_tracking_id
    return integer
    is
        l_last_tracking_id integer;
    begin
        select max(t.id)
        into   l_last_tracking_id
        from   pfu_session_tracking t;

        return nvl(l_last_tracking_id, 0);
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  PFU_UI ***
grant EXECUTE                                                                on PFU_UI          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/PFU/package/pfu_ui.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 