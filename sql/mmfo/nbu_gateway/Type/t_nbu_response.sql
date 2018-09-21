create or replace type t_nbu_response as object
(
    payload t_nbu_response_payload,
    protected t_nbu_response_protected,
    signature varchar2(32767 byte),
    constructor function t_nbu_response(p_json in clob) return self as result
);
/
create or replace type body t_nbu_response is

    constructor function t_nbu_response(p_json in clob)
    return self as result
    is
        l_payload clob;
        l_protected varchar2(32767 byte);
        l_start_position integer := 1;
        l_end_position integer := 1;
        l_string varchar2(32767 byte);
    begin
        l_start_position := dbms_lob.instr(p_json, '"', l_end_position);
        while (l_start_position > 0) loop
            l_end_position := dbms_lob.instr(p_json, '"', l_start_position + 1);
            l_string := dbms_lob.substr(p_json, l_end_position - l_start_position - 1, l_start_position + 1);

            if (l_string = 'payload') then
                dbms_lob.createtemporary(l_payload, false);
               -- bars_audit.info('payload_begin: '||to_char(sysdate,'ddmmhh24miss'));
                l_start_position := dbms_lob.instr(p_json, '"', l_end_position + 1);
                l_end_position := dbms_lob.instr(p_json, '"', l_start_position + 1);

                dbms_lob.copy(l_payload, p_json, l_end_position - l_start_position - 1, src_offset => l_start_position + 1);
                --bars_audit.info('payload_copy: '||sysdate);
                payload := t_nbu_response_payload(replace(json_utl.base64url_to_string(l_payload), '\"', ''''));
               -- bars_audit.info('payload_end: '||sysdate);
                --DBMS_LOB.close(l_payload);
                DBMS_LOB.FREETEMPORARY(l_payload);
            end if;

            if (l_string = 'protected') then
             --- bars_audit.info('protected_begin: '||to_char(sysdate,'ddmmhh24miss'));
                l_start_position := dbms_lob.instr(p_json, '"', l_end_position + 1);
                l_end_position := dbms_lob.instr(p_json, '"', l_start_position + 1);

                l_protected := dbms_lob.substr(p_json, l_end_position - l_start_position - 1, l_start_position + 1);

                protected := t_nbu_response_protected(l_protected);
                -- bars_audit.info('protected_end: '||to_char(sysdate,'ddmmhh24miss'));
            end if;

            if (l_string = 'signature') then
            -- bars_audit.info('signature_begin: '||to_char(sysdate,'ddmmhh24miss'));
                l_start_position := dbms_lob.instr(p_json, '"', l_end_position + 1);
                l_end_position := dbms_lob.instr(p_json, '"', l_start_position + 1);

                signature := dbms_lob.substr(p_json, l_end_position - l_start_position - 1, l_start_position + 1);
                -- bars_audit.info('signature_end: '||to_char(sysdate,'ddmmhh24miss'));
            end if;

            l_start_position := dbms_lob.instr(p_json, '"', l_end_position + 1);
        end loop;

        return;
    end;
end;
/
