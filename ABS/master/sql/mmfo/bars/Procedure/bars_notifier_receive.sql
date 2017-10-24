

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_NOTIFIER_RECEIVE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_NOTIFIER_RECEIVE ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_NOTIFIER_RECEIVE (
    ret_    out integer,
    bdate_  out date,
    status_ out varchar2)
is
    s              INTEGER;
    marker         VARCHAR2(30);
    sid_           INTEGER;
    pipenm         v$db_pipes.name%type;
    l_msg          varchar2(32767);
    l_sender_id    staff.id%type;
    l_enqueue_time date;
    options        varchar2(5);

begin
    options := getglobaloption('BMS');
     --- bars_audit.info('.BARS_NOTIFIER_RECEIVE: options - ' || options);

    -- Використовуємо механізм BMS
    if (options = '1') then
        begin
            bms.receive_message(p_message_type_id => bms.MSG_TYPE_BARSNOTIFY_MESSAGE,
                                p_message         => l_msg,
                                p_sender_id       => l_sender_id,
                                p_enqueue_time    => l_enqueue_time);
        exception
            when others then
                 bars_audit.error('bars_notifier_receive (error):' || chr(10) ||
                                  sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
                 ret_ := 0;
                 return;
        end;

        if (l_msg is null) then
            ret_ := 0;
            return;
        end if;

        bdate_  := to_date(substr(l_msg, 1, 10), 'dd.mm.yyyy');
        status_ := substr(l_msg, 12);
        ret_    := 1;

    -- Використовуємо DBMS_PIPE
    else
        select userenv('SESSIONID')
        into   sid_
        from   dual;

        pipenm := 'BANK_DATES$' || to_char(sid_) || '$' || user;

        s := dbms_pipe.receive_message(pipenm, 0);

        if s <> 0 then
            ret_ := 0;
            return;
        end if;

        dbms_pipe.unpack_message(marker);

        if (marker <> 'BARSNOTIFY') then
            ret_ := 0;
            return;
        end if;

        dbms_pipe.unpack_message(bdate_);
        dbms_pipe.unpack_message(status_);
        ret_ := 1;
    end if; --options='1'
end bars_notifier_receive;
/
show err;

PROMPT *** Create  grants  BARS_NOTIFIER_RECEIVE ***
grant EXECUTE                                                                on BARS_NOTIFIER_RECEIVE to ABS_ADMIN;
grant EXECUTE                                                                on BARS_NOTIFIER_RECEIVE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_NOTIFIER_RECEIVE to START1;
grant EXECUTE                                                                on BARS_NOTIFIER_RECEIVE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_NOTIFIER_RECEIVE.sql ========
PROMPT ===================================================================================== 
