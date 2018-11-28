BEGIN
   insert into ow_oic_atransfers_acc(nd, acc_pk)
   select S_ACQUIRING_DEAL.nextval, a.acc
   from accounts a
   where a.nls like '2924%' and a.ob22 = '16'
         and not exists(select 1 from ow_oic_atransfers_acc where acc_pk = a.acc);
   
   commit;
END; 
/ 
