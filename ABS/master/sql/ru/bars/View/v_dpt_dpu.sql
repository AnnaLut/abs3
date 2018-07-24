create or replace view v_dpt_dpu as
select a.rnk,
           c.nmk,
           a.nms,
           d.Deposit_id id,
           d.dat_begin,
           d.dat_end,
           a.kv,
           d.limit  sum
    from DPT_DEPOSIT d,
         accounts a,
         customer c
    where d.acc=a.acc
      and a.dazs is null
      and a.rnk=c.rnk
union all
    select a.rnk,
           c.nmk,
           a.nms,
           d.Dpu_id     id,
           d.dat_begin,
           d.dat_end,
           a.kv,
           d.sum
    from DPU_DEAL    d,
         accounts a,
         customer c
    where d.acc=a.acc
      and a.dazs is null
      and a.rnk=c.rnk;
comment on table V_DPT_DPU is 'Активні депозити ФО/ЮО';
comment on column V_DPT_DPU.RNK is 'РНК заставодавця';
comment on column V_DPT_DPU.NMK is 'Найменування клієнта';
comment on column V_DPT_DPU.NMS is 'Найменування рахунку';
comment on column V_DPT_DPU.ID is 'Номер депозитного договору';
comment on column V_DPT_DPU.DAT_BEGIN is 'Дата укладення депозитного договору';
comment on column V_DPT_DPU.DAT_END is 'Дата закінчення депозитного договору';
comment on column V_DPT_DPU.KV is 'Код валюти за депозитом';
comment on column V_DPT_DPU.SUM is 'Сума депозиту';


GRANT SELECT, FLASHBACK ON BARS.v_dpt_dpu TO bars_access_defrole;               
