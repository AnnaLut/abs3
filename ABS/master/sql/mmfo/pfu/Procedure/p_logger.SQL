create or replace procedure pfu.logger (p_sys_time timestamp, p_log varchar2)
is 
pragma autonomous_transaction;

begin
insert into pfu.tmp_sec_log (sys_time, log) values (p_sys_time,p_log );
commit;
end; 
/