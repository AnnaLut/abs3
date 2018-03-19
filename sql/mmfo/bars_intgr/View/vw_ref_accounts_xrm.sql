prompt create view bars_intgr.vw_ref_accounts_xrm

create or replace force view vw_ref_accounts_xrm as
select  KF, 
		acc,
		rnk,
        nls,
		kv,
        branch,
        nms,
        ob22 
from bars.V_ACCOUNTS_XRM;

comment on table vw_ref_accounts_xrm is 'Відкриті рахунки (accounts_xrm)';