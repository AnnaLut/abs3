begin
	for c0 in (select a.*
							 from ibank.v_accounts2 ia, bars.accounts a
							where ia.acc_num = a.nlsalt
								and ia.bank_id = a.kf
								and ia.cur_id = a.kv
								and a.dazs is null
								and a.dat_alt is not null) loop
		update barsaq.accounts ba
			 set ba.acc_num = c0.nls
		 where ba.bank_id = c0.kf
			 and ba.acc_num = c0.nlsalt
			 and ba.cur_id = c0.kv;
	
		update ibank.v_accounts ia
       set ia.acc_num = c0.nls
 		 where ia.bank_id = c0.kf
			 and ia.acc_num = c0.nlsalt
			 and ia.cur_id = c0.kv;
       
		update ibank.v_accounts2 ia
       set ia.acc_num = c0.nls
 		 where ia.bank_id = c0.kf
			 and ia.acc_num = c0.nlsalt
			 and ia.cur_id = c0.kv;
	end loop;
  commit;
end;
/