prompt view v_w4_acc_to_close_report
create or replace force view v_w4_acc_to_close_report
as
with me as (select max(exp_id) eid from w4_imp_acc_to_close_export)
select 
rownum rnm,
       main_prot.exp_id,
       main_prot.kf,
       main_prot.branch,
       main_prot.rnk,
       main_prot.nmkk,
       main_prot.okpo,
       main_prot.counter,
       main_prot.nd,
       main_prot.kv,
       main_prot.tag,
       main_prot.val,
       e.check_date,
       e.checked_rows,
       e.blocked_rows
from
(
select w.exp_id,
       w.kf,
       w.branch,
       w.rnk,
       w.nmkk,
       c.okpo,
       w.counter,
       w4.nd,
       w.kv,
       p.tag,
       p.val
from w4_imp_acc_to_close w
join me on w.exp_id = me.eid
join customer c on w.rnk = c.rnk and w.kf = c.kf
join accounts a on (w.nls = a.nls or w.nls = a.nlsalt) and w.kv = a.kv and w.kf = a.kf
join w4_acc w4 on a.acc = w4.acc_pk and a.kf = w4.kf
left join w4_imp_acc_to_close_param p on w4.acc_pk = p.main_acc and p.exp_id = w.exp_id
where (w.blk is not null or w.dapp is not null or w.ost is not null)
group by w.exp_id, w.kf, w.branch, w.rnk, w.nmkk, c.okpo, w.counter, w4.nd, w.kv, p.tag, p.val
order by rnk, nd, tag
) main_prot
join w4_imp_acc_to_close_export e on main_prot.exp_id = e.exp_id;

comment on column v_w4_acc_to_close_report.rnm is '№ п/п';
comment on column v_w4_acc_to_close_report.exp_id is '№ вивант.';
comment on column v_w4_acc_to_close_report.kf is 'МФО';
comment on column v_w4_acc_to_close_report.branch is 'Відділення';
comment on column v_w4_acc_to_close_report.rnk is 'РНК';
comment on column v_w4_acc_to_close_report.nmkk is 'Скор. назва';
comment on column v_w4_acc_to_close_report.okpo is 'ОКПО';
comment on column v_w4_acc_to_close_report.counter is 'Лічильник';
comment on column v_w4_acc_to_close_report.nd is 'Номер договору';
comment on column v_w4_acc_to_close_report.kv is 'Валюта';
comment on column v_w4_acc_to_close_report.tag is 'Параметр';
comment on column v_w4_acc_to_close_report.val is 'Значення';
comment on column v_w4_acc_to_close_report.check_date is 'Дата звірки';
comment on column v_w4_acc_to_close_report.checked_rows is 'Перевірено';
comment on column v_w4_acc_to_close_report.blocked_rows is 'Заблоковано';

grant select on v_w4_acc_to_close_report to bars_access_defrole;
