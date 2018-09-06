create or replace view v_nbu_report_instance as
select t.id, t.reporting_date, bars.list_utl.get_item_name('NBU_601_REPORT_INSTANCE_STAGE', t.stage_id) stage_name
from   nbu_report_instance t;

grant select on v_nbu_report_instance  to BARS_ACCESS_DEFROLE;