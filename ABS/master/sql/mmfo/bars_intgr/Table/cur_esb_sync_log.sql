
prompt create table bars_intgr.cur_esb_sync_log

begin
    execute immediate q'{

create table cur_esb_sync_log
(
msgid number,
cur_type varchar (20),
request clob,
response clob,
responsestatus number (3),
errortext varchar2 (4000),
msgsysdate date default sysdate
)
    }' ;
    
    
exception
    when others then
        if sqlcode = -955 then null;
         else raise; end if;
end;

/


grant select , insert , delete  on cur_esb_sync_log to bars ;


/


-- Comments for cur_esb_sync_log
 COMMENT ON TABLE cur_esb_sync_log IS 'Логирование вызова сервиса синхронизации курсов COBUMMFO-9345'

/