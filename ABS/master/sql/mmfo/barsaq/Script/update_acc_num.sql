declare
 l_cnt0 number := 0; 
 l_cnt1 number := 0;
 l_cnt2 number := 0;
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
       
    l_cnt0 := lcnt0 + sql%rowcount;

    update ibank.v_accounts ia
       set ia.acc_num = c0.nls
      where ia.bank_id = c0.kf
       and ia.acc_num = c0.nlsalt
       and ia.cur_id = c0.kv;
       
    l_cnt1 := lcnt1 + sql%rowcount;
       
    update ibank.v_accounts2 ia
       set ia.acc_num = c0.nls
      where ia.bank_id = c0.kf
       and ia.acc_num = c0.nlsalt
       and ia.cur_id = c0.kv;
    l_cnt2 := lcnt2 + sql%rowcount;

  end loop;
  dbms_output.put_line('barsaq.accounts:'||l_cnt0);
  dbms_output.put_line('ibank.v_accounts:'||l_cnt1);
  dbms_output.put_line('ibank.v_accounts2:'||l_cnt2);
  commit;
end;
/