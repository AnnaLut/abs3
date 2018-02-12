prompt create view v_sto_sbon_closed_accounts
create or replace view bars.v_sto_sbon_closed_accounts (NLS, KV, KF)
as select nls, kv, kf
from accounts
where dazs is not null
and nbs in ('2560', '2600', '2603', '2604', '2650', '2909');

comment on table v_sto_sbon_closed_accounts is 'Закрытые счета для СБОНа';
comment on column v_sto_sbon_closed_accounts.nls is 'Лицевой номер счета';
comment on column v_sto_sbon_closed_accounts.kv is 'Код валюты';
comment on column v_sto_sbon_closed_accounts.kf is 'Код филиала';

grant select on bars.v_sto_sbon_closed_accounts to sbon;
grant select on bars.v_sto_sbon_closed_accounts to bars_access_defrole;