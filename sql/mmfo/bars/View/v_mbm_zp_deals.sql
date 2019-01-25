PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/view/v_mbm_zp_deals.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view bars.v_mbm_zp_deals as
select z.id             as ProjectId, 
       z.deal_id        as BankProjectId,
       z.kf             as BankId,
       z.rnk            as CustomerId,
       b.name           as BankName, 
       z.acc_2909       as Account2909,
       z.comm_reject    as Description, 
       z.sos            as StatusId, 
       z.kod_tarif      as Tariff,
       z.start_date     as PDRegisterDate, 
       z.tar            as PDBankCommission,
       z.max_tarif      as PDPaymentCommissionPercent,
       z.fio            as BMName,
       null             as BMPhoneNumber,
       a.nls            as Nls2909,
       a.kf             as BankId2909,
       a.nms            as Name2909,
       a.kv             as Kv2909,
       c.okpo           as CustomerOkpo
from bars.v_zp_deals z
     inner join branch b on b.branch = z.branch
     inner join accounts a on a.acc = z.acc_2909
     inner join customer c on c.rnk = z.rnk;

PROMPT *** Create comments on bars.v_mbm_zp_deals ***

comment on table bars.v_mbm_zp_deals                             is 'ЗП договора';
comment on column bars.v_mbm_zp_deals.ProjectId                  is 'id договору';
comment on column bars.v_mbm_zp_deals.BankProjectId              is 'Номер договору';
comment on column bars.v_mbm_zp_deals.BankId                     is 'МФО';
comment on column bars.v_mbm_zp_deals.CustomerId                 is 'РНК';
comment on column bars.v_mbm_zp_deals.BankName                   is 'Відділення';
comment on column bars.v_mbm_zp_deals.Account2909                is 'Рахунок 2909';
comment on column bars.v_mbm_zp_deals.Description                is 'Коментар';
comment on column bars.v_mbm_zp_deals.StatusId                   is 'id стану договору';
comment on column bars.v_mbm_zp_deals.Tariff                     is 'Код тарифу';
comment on column bars.v_mbm_zp_deals.PDRegisterDate             is 'Дата відкриття';
comment on column bars.v_mbm_zp_deals.PDBankCommission           is 'Тариф, грн';
comment on column bars.v_mbm_zp_deals.PDPaymentCommissionPercent is 'Тариф %';
comment on column bars.v_mbm_zp_deals.BMName                     is 'Менеджер';
comment on column bars.v_mbm_zp_deals.Nls2909                    is 'Номер рахунка 2909';
comment on column bars.v_mbm_zp_deals.BankId2909                 is 'МФО банка, якому належить рахунок 2909';
comment on column bars.v_mbm_zp_deals.Name2909                   is 'Найменування рахунка 2909';
comment on column bars.v_mbm_zp_deals.Kv2909                     is 'Код (цифровий) валюти';
comment on column bars.v_mbm_zp_deals.CustomerOkpo               is 'ОКПО клієнта';

PROMPT *** Create  grants  v_mbm_zp_deals ***

grant select on bars.v_mbm_zp_deals to upld;
grant select on bars.v_mbm_zp_deals to barsreader_role;
grant select on bars.v_mbm_zp_deals to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/view/v_mbm_zp_deals.sql =========*** End *** =
PROMPT ===================================================================================== 
