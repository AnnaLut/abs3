prompt view v_w4_acc_to_close_report_dazs
create or replace view v_w4_acc_to_close_report_dazs
as
with me as (select max(exp_id) eid from w4_imp_acc_to_close_export)
select
w.exp_id,
w.kf,
w.branch,
w.rnk,
w.nmkk,
c.okpo,
w.nls,
w.dazs
from w4_imp_acc_to_close w
join me on w.exp_id = me.eid
join customer c on w.rnk = c.rnk and w.kf = c.kf
where w.dazs is not null;

comment on column v_w4_acc_to_close_report_dazs.exp_id is '№ вивант.';
comment on column v_w4_acc_to_close_report_dazs.kf is 'МФО';
comment on column v_w4_acc_to_close_report_dazs.branch is 'Відділення';
comment on column v_w4_acc_to_close_report_dazs.rnk is 'РНК';
comment on column v_w4_acc_to_close_report_dazs.nmkk is 'Скор. назва';
comment on column v_w4_acc_to_close_report_dazs.okpo is 'ОКПО';
comment on column v_w4_acc_to_close_report_dazs.nls is 'Номер рахунку';
comment on column v_w4_acc_to_close_report_dazs.dazs is 'Дата закриття';

grant select on v_w4_acc_to_close_report_dazs to bars_access_defrole;
