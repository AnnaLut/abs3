prompt bars_intgr.v_w4_imp_acc_to_close
create or replace force view v_w4_imp_acc_to_close as
with me as (select max(exp_id) eid from bars.w4_imp_acc_to_close_export)
select
w.exp_id as ID_iteration,
w.kf as MFO,
w.nls_abs as nls,
w.kv,
w.nmkk as shortname,
w.branch,
w.pdat as date_in
from bars.w4_imp_acc_to_close w
join me on w.exp_id = me.eid
where w.status = 1
and (select check_date from bars.w4_imp_acc_to_close_export where exp_id = me.eid) is not null;


grant select on v_w4_imp_acc_to_close to bars_access_defrole;
grant select on v_w4_imp_acc_to_close to IBMESB;
