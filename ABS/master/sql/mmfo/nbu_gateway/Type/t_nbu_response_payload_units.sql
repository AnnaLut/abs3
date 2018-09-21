create or replace type t_nbu_response_payload_unit force as object
(
    orderNum varchar2(32767 byte),
    err_code varchar2(32767 byte),
    reestr_id varchar2(32767 byte),
    err_comment varchar2(32767 byte),

    constructor function t_nbu_response_payload_unit(
        p_json in varchar2)
    return self as result
);
/
create or replace type body t_nbu_response_payload_unit is

    constructor function t_nbu_response_payload_unit(
        p_json in varchar2)
    return self as result
    is
        l_start_position integer := 1;
        l_end_position integer := 1;
        l_string varchar2(32767 byte);
    begin
        l_start_position := instr(p_json, '"', l_end_position);
        while (l_start_position > 0) loop
            l_end_position := instr(p_json, '"', l_start_position + 1);
            l_string := substr(p_json, l_start_position + 1, l_end_position - l_start_position - 1);

            case (l_string)
            when 'orderNum' then
           -- bars_audit.info('t_nbu_response_payload_unit.orderNum: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                l_start_position := instr(p_json, ':', l_end_position + 1);
                l_end_position := instr(p_json, ',', l_start_position + 1);
                orderNum := substr(p_json, l_start_position + 1, l_end_position - l_start_position - 1);
                dbms_output.put_line('l_orderNum : ' || orderNum);
            when 'err_code' then
           -- bars_audit.info('t_nbu_response_payload_unit.err_code: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                l_start_position := instr(p_json, ':', l_end_position + 1);
                l_end_position := instr(p_json, ',', l_start_position + 1);
                err_code := substr(p_json, l_start_position + 1, l_end_position - l_start_position - 1);
                dbms_output.put_line('l_err_code : ' || err_code);
            when 'reestr_id' then
           -- bars_audit.info('t_nbu_response_payload_unit.reestr_id: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                l_start_position := instr(p_json, ':', l_end_position + 1);
                l_end_position := instr(p_json, ',', l_start_position + 1);
                reestr_id := substr(p_json, l_start_position + 1, l_end_position - l_start_position - 1);
                dbms_output.put_line('l_reestr_id : ' || reestr_id);
            when 'err_comment' then
           -- bars_audit.info('t_nbu_response_payload_unit.err_comment: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                l_start_position := instr(p_json, '"', l_end_position + 1);
                l_end_position := instr(p_json, '"', l_start_position + 1);
                err_comment := substr(p_json, l_start_position + 1, l_end_position - l_start_position - 1);
                dbms_output.put_line('l_err_comment : ' || err_comment);
            else
                null;
            end case;

            l_start_position := instr(p_json, '"', l_end_position + 1);
        end loop;

        return;
    end;
end;
/
create or replace type t_nbu_response_payload_units force as table of t_nbu_response_payload_unit;
/
