prompt v_w4_acc_to_close_report_dpt
create or replace view v_w4_acc_to_close_report_dpt
as
with me as (select max(exp_id) eid from w4_imp_acc_to_close_export)
select
w.exp_id,
w.kf,
w.branch,
a.nls,
a.nlsalt,
w.kv,
d.deposit_id,
d.nd
from w4_imp_acc_to_close w
join me on w.exp_id = me.eid
join accounts a on a.kf = w.kf and (a.nls = w.nls or a.nlsalt = w.nls) and a.kv = w.kv
join dpt_deposit d on d.kf = a.kf and a.acc = d.acc_d
where w.dpt_binding = 1;

comment on column v_w4_acc_to_close_report_dpt.exp_id is '№ вивант.';
comment on column v_w4_acc_to_close_report_dpt.kf is 'МФО';
comment on column v_w4_acc_to_close_report_dpt.branch is 'Відділення';
comment on column v_w4_acc_to_close_report_dpt.nls is 'Номер рахунку';
comment on column v_w4_acc_to_close_report_dpt.kv is 'Валюта';
comment on column v_w4_acc_to_close_report_dpt.deposit_id is 'Внутрішній № деп. договору';
comment on column v_w4_acc_to_close_report_dpt.nd is '№ деп. договору';

grant select on v_w4_acc_to_close_report_dpt to bars_access_defrole;
