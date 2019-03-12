begin
   for kf in (
                   select distinct a.kf
                   from accounts a
                   join ow_oic_atransfers_acc owa on owa.acc_fee = a.acc 
                                                 or owa.acc_fee_overdue = a.acc 
                )
   loop
      bc.go(kf.kf);
      for c in (
                  select a.acc, owm.nms||' '||c.nmkk nms_new, a.nms
                  from accounts a
                  join customer c on c.rnk = a.rnk
                  join ow_oic_atransfers_acc owa on owa.acc_fee = a.acc 
                                                 or owa.acc_fee_overdue = a.acc 
                  join ow_oic_atransfers_mask owm on owm.nbs = a.nbs 
                                               and owm.ob22 = a.ob22
               )
      loop
         update accounts
         set nms = c.nms_new
         where acc = c.acc;
      end loop;
      commit;
   end loop;
   bc.home();
end;
/
