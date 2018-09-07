create or replace view bars.v_corp2_accounts as
select a.acc  bank_acc,
        ia.acc_corp2  corp2_acc,
         nvl2(ia.acc, 1, 0) is_corp2_acc,
         a.nls  num_acc,
	 a.rnk rnk,
         a.nms  name,
         a.kv  code_curr,
         a.daos  open_date,
         a.dapp last_move_date,
         a.dazs close_date,
         a.ostc  rest,
         a.dos  deb_turnover,
         a.kos  kred_turnover,
         (select sb.fio
            from staff$base sb
           where sb.id = a.isp) executor_name,
         a.branch branch,
         (select b.name
            from branch b
           where b.branch = a.branch) branch_name,
         a.kf,
         ia.visa_count
    from accounts a
   left join barsaq.ibank_acc ia on (a.acc = ia.acc and a.kf = ia.kf);
/

grant select on v_corp2_accounts to bars_access_defrole;