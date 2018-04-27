prompt create view bars.v_accounts_xrm
create or replace view bars.v_accounts_xrm
as
   select 
		acc,
		rnk,
		kf,
		nls,
		kv,
		branch,
		nms,
		ob22
     from accounts
    where dazs is null
	and substr(nbs, 1, 1) in ('1', '2', '6', '9')
	and nbs not in ('2620', '2625', '2630');

grant select,delete,update,insert on bars.v_accounts_xrm to bars_access_defrole;