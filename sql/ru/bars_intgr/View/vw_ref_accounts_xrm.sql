prompt create view bars_intgr.vw_ref_accounts_xrm

create or replace force view vw_ref_accounts_xrm as
select  v.KF, 
		acc,
		v.rnk,
        c.nmk,
        c.okpo,
        nls,
		kv,
        v.branch,
        nms,
        ob22 
from bars.V_ACCOUNTS_XRM v
join bars.customer c on v.rnk = c.rnk;

comment on table vw_ref_accounts_xrm is 'Відкриті рахунки (accounts_xrm)';