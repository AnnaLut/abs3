begin
   execute immediate 'CREATE TABLE test_recovery2620_220218 AS
  (select a.acc, a.nls, a.kf, 
   ''                                                                                                                                                                                                                 '' note
   from bars.accounts a
   where 1 = 0)';

  exception
  when OTHERS then 
    
    if (sqlcode = -00955) then 
      dbms_output.put_line('Table already exists.');
    else raise;
    end if; 
end;
/

begin  
  execute immediate 'truncate table test_recovery2620_220218'; 
         
  insert into test_recovery2620_220218 
  select x.acc, x.nls, x.kf, '---' from (
  select 261487602 acc, '26208043199111' nls, '324805' kf, 35405602 rnk from dual union all
  select 261910502 acc, '26207043222711' nls, '324805' kf, 121187902 rnk from dual union all
  select 363011821 acc, '26204028765120' nls, '351823' kf, 144785021 rnk from dual) x;

commit;

end;  
/

declare 
l_kf mv_kf.kf%type;
title varchar(50) := 'recovery 2620: ';
l_dptid number;
begin 
  bars_audit.info('Start recovery 2620');
  l_kf := '/';
  bc.go(l_kf);
  
  for i in (select * from test_recovery2620_220218 order by kf) loop 
  if l_kf <> i.kf then
    l_kf := i.kf;
     bars_audit.info(title||' kf = '||l_kf);
    bc.go(l_kf);
  end if;
  
  execute immediate ('alter trigger TBU_ACCOUNTS_DAZS disable');
  --bars_audit.trace('%s acc = %s nls = %s', title, to_char(i.acc), i.nls);
  update bars.accounts set dazs = null where acc = i.acc and nls = i.nls;
  execute immediate ('alter trigger TBU_ACCOUNTS_DAZS enable');
  
  begin --#1
  select deposit_id 
  into l_dptid
  from bars.dpt_deposit
  where acc = i.acc;
  
  update test_recovery2620_220218 
  set note = 'Error. депозит '||to_char(l_dptid)||' дл€ счета '||to_char(i.acc)||' не закрыт!'
  where acc = i.acc;
  
  exception when no_data_found then --#1
   
   begin --#2
     select deposit_id 
     into l_dptid
     from bars.dpt_deposit_clos
     where acc = i.acc
     and action_id in (1,2)
     and trunc(bdate) = to_date('22.02.2018','DD.MM.YYYY'); 
     
     dpt_utils.RECOVERY_CONTRACT(l_dptid);
     
     update test_recovery2620_220218 
     set note = 'OK. ƒепозит '||to_char(l_dptid)||' и счет '||to_char(i.acc)||' восстановлены!'
     where acc = i.acc;

   exception when no_data_found then --#2
     update test_recovery2620_220218 
     set note = 'Error. Ќе найден депозит дл€ счета '||to_char(i.acc)||' закрытый 22.02.2018'
     where acc = i.acc;
   end; --#2  
 
  end; --#1
   
   commit;
   end loop;
   bc.home;   
end;
/
