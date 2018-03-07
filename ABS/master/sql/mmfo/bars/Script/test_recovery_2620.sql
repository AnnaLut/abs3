declare 
l_kf mv_kf.kf%type;
title varchar(50) := 'recovery 2620: ';
l_dptid number;
l_flag number := 0;
l_len number;
l_s varchar2(200);
begin 
  execute immediate 'truncate table test_recovery2620_220218'; 
  commit;
  
  bars_audit.info('Start recovery 2620');
  bc.go('/');
  for r in (select * from bars.mv_kf) loop --r
  bc.go(r.kf);
  bars_audit.info(title||' kf = '||r.kf);
  
  
     for i in (
         -- —чета 2620, которые открыты, но по которым 22.02.2018 были закрыты депозиты
           select a.*, d.deposit_id, 111 pr
           from bars.accounts a,
           bars.dpt_deposit_clos d
           where a.nbs = '2620' 
           and a.dazs is null 
           and D.ACC = A.ACC
           and D.ACTION_ID in (1,2) 
           and D.BDATE = to_date('22.02.2018','DD.MM.YYYY')
           and not exists (select null from 
           bars.dpt_deposit dx
           where dx.deposit_id = d.deposit_id
           and dx.acc = a.acc)
           
           union all
           --—чета 2620, котор≥е закрыты 22-02-2018 и по которым 22-02-2018 были закрыты депозиты
           select a.*, d.deposit_id, 222 pr
               from bars.accounts a,
               bars.dpt_deposit_clos d
               where a.nbs = '2620' 
               and a.dazs = to_date('22.02.2018','DD.MM.YYYY')
               and D.ACC = A.ACC
               and D.ACTION_ID in (1,2) 
               and D.BDATE = to_date('22.02.2018','DD.MM.YYYY')
               and not exists (select null from 
               bars.dpt_deposit dx
               where dx.deposit_id = d.deposit_id
               and dx.acc = a.acc)
           ) loop
           
           begin
             select count(*)
             into l_flag
             from bars.cc_deal c, bars.nd_acc n
             where n.acc = i.acc
             and c.nd = n.nd
             and c.sos < 14;
           exception when no_data_found then
             l_flag := 0;
           end;
           
           --savepoint xx;
           
           if l_flag >= 1 then  --#1 счет по кредитному договору
           begin    
           if i.pr = 222 then --#2
           -- обЌ”Ћ€ем дату закрыти€ счета
              execute immediate ('alter trigger TBU_ACCOUNTS_DAZS disable');
                update bars.accounts set dazs = null where acc = i.acc and nls = i.nls;
                bars_audit.info(title||' acc '||i.acc||' ('||i.nls||') opened!');
              execute immediate ('alter trigger TBU_ACCOUNTS_DAZS enable');
            end if; --#2
           -- восстанавливаем договор
           dpt_utils.RECOVERY_CONTRACT(i.deposit_id);
           
           bars_audit.info(title||' deposit '||i.deposit_id||' recovered!');
           -- записываем в табличку лога
           insert into test_recovery2620_220218 values 
           (i.acc, i.nls, i.kf, i.deposit_id, 
           'OK. ƒепозит ID = '||to_char(i.deposit_id)||' восстановлен! Cчет '||i.nls||' открыт');
           
           commit;
           
           exception when others then
             --rollback to xx; -- ошибка. откатываем изменени€
             -- записываем в табличку лога
             l_s := 'Error. ќшибка восстановлени€ депозита ID = '||to_char(i.deposit_id)||' и счета '||to_char(i.acc)|| '('||i.nls||') - '||to_char(sqlerrm);
             bars_audit.info(title||' '||l_s);
             l_s := substr(l_s,1,200);
             insert into test_recovery2620_220218 values 
             (i.acc, i.nls, i.kf, i.deposit_id, l_s);
             commit;
            end; 
           end if; --#1
           
        end loop;   --i
   end loop; -- r
  
  bc.home;   
  bars_audit.info('Finish recovery 2620');
end;
/