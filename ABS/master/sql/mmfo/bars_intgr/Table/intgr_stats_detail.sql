prompt create table INTGR_STATS_DETAIL
begin
    execute immediate q'[
create table intgr_stats_detail
(
id number,
changenumber number,
object_name varchar2(150),
start_time date,
stop_time date,
rows_ok number,
rows_err number,
status varchar2(15),
KF varchar2(6) default sys_context('bars_context', 'user_mfo'),
constraint XPK_INTGR_STATS_DETAIL primary key (id) using index tablespace brsmdli
)
tablespace brssmld]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
grant select on intgr_stats_detail to bars_access_defrole;