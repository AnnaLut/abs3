create or replace type t_nbu_response_payload force as object
(
    general_err_code varchar2(32767 byte),
    general_http_status_code varchar2(32767 byte),
    general_err_comment varchar2(32767 byte),

    response_units t_nbu_response_payload_units,

    constructor function t_nbu_response_payload(p_payload in clob)
    return self as result
);
/
create or replace type body t_nbu_response_payload is

    constructor function t_nbu_response_payload(
        p_payload in clob)
    return self as result
    is
        l_start_position integer := 1;
        l_end_position integer := 1;

        l_array_start_position integer := 1;
        l_array_end_position integer := 1;

        l_string varchar2(32767 byte);

        l_result_kvi clob;
        l_payload_unit varchar2(32767 byte);
    begin
        l_start_position := dbms_lob.instr(p_payload, '"', l_end_position);
        while (l_start_position > 0) loop
            l_end_position := dbms_lob.instr(p_payload, '"', l_start_position + 1);
            l_string := dbms_lob.substr(p_payload, l_end_position - l_start_position - 1, l_start_position + 1);

            case (l_string)
            when 'general_err_code' then
            --bars_audit.info('general_err_code: '||to_char(sysdate,'ddmmhh24miss'));
                l_start_position := dbms_lob.instr(p_payload, ':', l_end_position + 1);
                l_end_position := dbms_lob.instr(p_payload, ',', l_start_position + 1);

                general_err_code := dbms_lob.substr(p_payload, l_end_position - l_start_position - 1, l_start_position + 1);
                -- dbms_output.put_line('general_err_code : ' || general_err_code);
            when 'general_http_status_code' then
              -- bars_audit.info('general_http_status_code: '||to_char(sysdate,'ddmmhh24miss'));
                l_start_position := dbms_lob.instr(p_payload, ':', l_end_position + 1);
                l_end_position := dbms_lob.instr(p_payload, ',', l_start_position + 1);

                general_http_status_code := dbms_lob.substr(p_payload, l_end_position - l_start_position - 1, l_start_position + 1);
                -- dbms_output.put_line('general_http_status_code : ' || general_http_status_code);
            when 'general_err_comment' then
              -- bars_audit.info('general_err_comment: '||to_char(sysdate,'ddmmhh24miss'));
                l_start_position := dbms_lob.instr(p_payload, '"', l_end_position + 1);
                l_end_position := dbms_lob.instr(p_payload, '"', l_start_position + 1);

                general_err_comment := dbms_lob.substr(p_payload, l_end_position - l_start_position - 1, l_start_position + 1);
                -- dbms_output.put_line('general_err_comment : ' || general_err_comment);
            when 'result_kvi' then
                -- bars_audit.info('result_kvi: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                if (dbms_lob.substr(p_payload, 10, l_end_position) not like '%null%') then
                    l_start_position := dbms_lob.instr(p_payload, '[', l_end_position + 1);
                    l_end_position := dbms_lob.instr(p_payload, ']', l_start_position + 1);

                    dbms_lob.createtemporary(l_result_kvi, false);

                    dbms_lob.copy(l_result_kvi, p_payload, l_end_position - l_start_position - 1, src_offset => l_start_position + 1);

                    if (l_result_kvi is not null) then
                    -- bars_audit.info('l_result_kvi is not null: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                        l_array_start_position := dbms_lob.instr(l_result_kvi, '{', l_array_end_position);
                        while (l_array_start_position > 0) loop
                      --  bars_audit.info('l_result_kvi enter while: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                            l_array_end_position := dbms_lob.instr(l_result_kvi, '}', l_array_start_position + 1);

                            l_payload_unit := dbms_lob.substr(l_result_kvi, l_array_end_position - l_array_start_position - 1, l_array_start_position + 1);
                            -- bars_audit.info('l_payload_unit: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                            -- dbms_output.put_line('l_payload_unit : ' || l_payload_unit);

                            if (l_payload_unit is not null and l_payload_unit <> 'null') then
                              --bars_audit.info('l_payload_unit enter is not null: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                                 if (response_units is null) then
                                     response_units := t_nbu_response_payload_units();
                                 end if;
                          -- bars_audit.info('l_payload_unit after end if: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                                 response_units.extend(1);
                           --bars_audit.info('response_units.extend: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                                 response_units(response_units.last) := t_nbu_response_payload_unit(l_payload_unit);
                           -- bars_audit.info('response_units: '||to_char(sysdate,'dd.mm.hh24:mi:ss'));
                            end if;

                            l_array_start_position := dbms_lob.instr(l_result_kvi, '{', l_array_end_position + 1);
                            --DBMS_LOB.close(l_result_kvi);
                            DBMS_LOB.FREETEMPORARY(l_result_kvi);
                        end loop;
                    end if;
                end if;
            else
                null;
            end case;

            l_start_position := dbms_lob.instr(p_payload, '"', l_end_position + 1);
        end loop;

        return;
    end;
end;
/
