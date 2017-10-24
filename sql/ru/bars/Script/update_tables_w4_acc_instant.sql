begin
  tuda;
  bpa.disable_policies('w4_acc_instant');

  
  update w4_acc_instant t
     set kf = sys_context('bars_context', 'user_mfo')
   where kf is null;
  bpa.enable_policies('w4_acc_instant');             
  suda;
end;
/
commit;