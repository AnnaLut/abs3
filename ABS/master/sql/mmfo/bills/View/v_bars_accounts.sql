prompt view V_BARS_ACCOUNTS
create or replace force view v_bars_accounts
as
select kf, rnk, acc, nls, ob22, kv, nms
from bars.accounts t
where (t.nbs = '2620' and ob22 in ('05', '38') or nbs = '2600')
and dazs is null
and kv = 980;

grant select on v_bars_accounts to bars_access_defrole;

comment on table v_bars_accounts is 'Клиентские счета для получателей векселей 2620(05,38), 2600';