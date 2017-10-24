create or replace view bars.v_e_deal_accounts
as
   (select a.acc,
           a.branch,
           a.nls,
           a.kv,
           a.nms,
           a.dos/100 as dos,
           a.kos/100 as kos,
           a.ostc/100 as ostc,
           a.ostb/100 as ostb,
           a.ostf/100 as ostf,
           a.dapp,
           a.mdate,
           a.lim,
           a.nbs,
           a.pap,
           a.tip,
           a.vid,
           a.ob22,
           a.isp,
           a.blkd,
           a.blkk,
           a.daos,
           a.dazs,
           a.rnk 
      from accounts a, e_deal$base d
     where     (   a.acc = d.acc26
                or a.acc = d.acc36
                or a.acc = d.accd
                or a.acc = d.accp)
           and d.nd = to_number(pul.get('DEAL_ND')));

show errors;

grant select on bars.v_e_deal_accounts to bars_access_defrole;



comment on table bars.v_e_deal_accounts is 'Рахунки угод (послуги)';

comment on column bars.v_e_deal_accounts.acc is 'ACC';

comment on column bars.v_e_deal_accounts.nls is 'Номер~рахунку';

comment on column bars.v_e_deal_accounts.kv is 'Код~валюти';

comment on column bars.v_e_deal_accounts.branch is 'Код~безбалансового~відділення';

comment on column bars.v_e_deal_accounts.nbs is 'Балансовий~рахунок';

comment on column bars.v_e_deal_accounts.daos is 'Дата~відкриття~рахунку';

comment on column bars.v_e_deal_accounts.dapp is 'Дата~останього~руху';

comment on column bars.v_e_deal_accounts.isp is 'ID~виконавця';

comment on column bars.v_e_deal_accounts.nms is 'Назва~рахунку';

comment on column bars.v_e_deal_accounts.lim is 'Ліміт';

comment on column bars.v_e_deal_accounts.ostb is 'Залишок~плановий';

comment on column bars.v_e_deal_accounts.ostc is 'Залишок~фактичний';

comment on column bars.v_e_deal_accounts.ostf is 'Залишок~майбутній';

comment on column bars.v_e_deal_accounts.dos is 'Обороти~дебет';

comment on column bars.v_e_deal_accounts.kos is 'Обороти~кредит';

comment on column bars.v_e_deal_accounts.pap is 'АКТИВ~ПАСИВ';

comment on column bars.v_e_deal_accounts.tip is 'Тип~рахунку';

comment on column bars.v_e_deal_accounts.vid is 'Код~виду~рахунку';

comment on column bars.v_e_deal_accounts.mdate is 'Дата~погашения~рахунку';

comment on column bars.v_e_deal_accounts.dazs is 'Дата~закриття~рахунку';

comment on column bars.v_e_deal_accounts.blkd is 'Код~блок.~(дебет)';

comment on column bars.v_e_deal_accounts.blkk is 'Код~блок.~(кредит)';

comment on column bars.v_e_deal_accounts.rnk is 'РНК';

comment on column bars.v_e_deal_accounts.ob22 is 'ОБ22';
