create or replace view v_otcn_lim_sb as
select a.acc || ';' || to_char(t.fdat, 'ddmmyyyy') uk_value, a.nls, a.kv, t.lim, t.fdat
from   otcn_lim_sb t
join   accounts a on a.acc = t.acc and
                     a.dazs is null;

grant select on v_otcn_lim_sb to bars_access_defrole;

comment on column v_otcn_lim_sb.nls is 'Номер рахунку';
comment on column v_otcn_lim_sb.kv is 'Валюта';
comment on column v_otcn_lim_sb.lim is 'Ліміт';
comment on column v_otcn_lim_sb.fdat is 'Дата';
