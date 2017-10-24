

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_NOTIFIER_SEND.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_NOTIFIER_SEND ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_NOTIFIER_SEND (
    bdate_ date,
    status_ varchar2)
is
    s integer;
    sid_ integer;
    username_ v$session.username%type;
    exist_ integer;
    pipenm v$db_pipes.name%type;
    options varchar2(5);

  cursor userlist is
    select v.audsid, v.username
    from v$session v, staff s
    where s.logname = v.username;

BEGIN
    -- bars_audit.info('BMS: BARS_NOTIFIER_SEND bdate="'||bdate_||'", status="'||status_||'"');

    options := getglobaloption('BMS');

    -- bars_audit.info('BMS: BARS_NOTIFIER_SEND options="'||options);

    open userlist;
    loop
        fetch userlist into sid_, username_;
        exit when userlist%notfound;

        if (options = '1') then

            bms.send_message(p_receiver_id => sid_,
                             p_message_type_id => bms.MSG_TYPE_BARSNOTIFY_MESSAGE,
                             p_message_text => to_char(bdate_, 'dd.mm.yyyy') || ' ' || status_,
                             p_delay => null,
                             p_expiration => 24 * 60 * 60);

        else
            pipenm := 'BANK_DATES$' || TO_CHAR(sid_) || '$' || username_;

            begin
                select count(*) into exist_ from v$db_pipes where name = pipenm;
            exception
                when no_data_found then
                     exist_ := 0;
            end;

            if (exist_ <> 0) then
                dbms_pipe.pack_message('BARSNOTIFY'); -- protocol version
                dbms_pipe.pack_message(bdate_);
                dbms_pipe.pack_message(status_);
                s := dbms_pipe.send_message(pipenm, 2);
                if s <> 0 then
                  -- Error: '||to_char(s)||' sending on pipe
                  bars_error.raise_error('SVC', 3, to_char(s));
                end if;
            end if;
        end if;
    end loop;

end bars_notifier_send;
/
show err;

PROMPT *** Create  grants  BARS_NOTIFIER_SEND ***
grant EXECUTE                                                                on BARS_NOTIFIER_SEND to ABS_ADMIN;
grant EXECUTE                                                                on BARS_NOTIFIER_SEND to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_NOTIFIER_SEND to START1;
grant EXECUTE                                                                on BARS_NOTIFIER_SEND to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_NOTIFIER_SEND.sql =========**
PROMPT ===================================================================================== 
