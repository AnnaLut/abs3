begin
  bc.go (304665);
  bars.bars_login.login_user(sys_guid,1006813,null,null);
for pay_sms in (select acc from v_sms_acc_send  where kf=304665) --луганск
  loop
     bars.bars_sms_clearance.pay_for_sms_by_acc(pay_sms.acc);                     
     end loop;
	 commit;
     end;
     /
	 
begin
  bc.go (304665);
  bars.bars_login.login_user(sys_guid,1006813,null,null);
for pay_sms in (select acc from v_sms_acc_send  where kf=304665) --луганск
  loop
     bars.bars_sms_clearance.pay_clearance (pay_sms.acc);                     
     end loop;
	 commit;
     end;
     /
	 
	 
begin
  bc.go (304665);
  bars.bars_login.login_user(sys_guid,1006813,null,null);
for pay_sms in (select acc from v_sms_acc_send  where kf=304665) --луганск
  loop
     bars.bars_sms_clearance.transfer_clearance(pay_sms.acc);                       
     end loop;
	 commit;
     end;
     /