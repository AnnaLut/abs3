prompt view bars_intgr.v_intgr_stats_detail
create or replace force view v_intgr_stats_detail
as
select
id,
changenumber,
object_name,
start_time,
stop_time,
rows_ok,
rows_err,
status,
KF,
round((nvl(stop_time, sysdate)-start_time)*24*60, 2) as elapsed_minutes
from intgr_stats_detail;

grant select on v_intgr_stats_detail to bars_access_defrole;