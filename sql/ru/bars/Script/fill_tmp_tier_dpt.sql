declare
  l_ir       bars.int_ratn.ir%type;
  l_baserate bars.br_tier_edit.rate%type;
  l_rate bars.int_ratn%rowtype;
  l_dep  bars.dpt_deposit%rowtype;
  error_cnt  number;
  l_err varchar2(200);
  p_dat date := trunc(sysdate);
  xx number := 0;
begin
  bc.go('/'); -- возвращаемся на слэш
  
  delete from bars.tmp_tier_dpt;
  commit;
  
  for rec in (select kf from mv_kf
  -- where kf = '351823'  
   ) loop
   bc.go(rec.kf);

    for q in (select distinct bte.br_id, bte.kv -- выбираем уникальные ступенчатые ставки с валютой
                from bars.br_tier_edit bte, bars.brates br
               where br.br_id = bte.br_id
                 and br.br_type not in (1, 4)
                 --and br.br_id = 3313
                 ) loop
                           
                           for x in (select * from bars.int_ratn ir
                                    where br = q.br_id
                                    and bdat = (select max(bdat) from bars.int_ratn where acc = ir.acc and id = 1 and bdat <= p_Dat)
                                    --and acc= 492226721
                                    ) loop
                                    
                                    begin                     
                                     SELECT dd.*  -- выбираем все депозиты, открытые до 28.02.17 и еще не закрытые
                                     into l_dep
                                     FROM bars.dpt_deposit dd,
                                     bars.accounts a
                                     WHERE dd.acc = x.acc 
                                     and a.acc = dd.acc
                                     and a.nbs = 2630 
                                     and (dd.dat_end >= p_Dat or dd.dat_end is null);
                                    exception when others
                                      then l_dep := null;
                                    end;  
                                          
                                     if not l_dep.deposit_id is null then 
                                       if (l_dep.dat_begin < to_date('28.02.2017', 'DD.MM.YYYY')) and (l_dep.kv = q.kv) then
                                         insert into bars.Tmp_Tier_Dpt(deposit_id, acc, kv, kf, branch, br, old_ir, note)
                                         values (l_dep.deposit_id, x.acc, q.kv, rec.kf, l_dep.branch, x.br, x.ir, '-');
                                         xx := xx + 1;
                                       end if;
                                     end if;  
                       
                            end loop;  -- закончили обрабатывать депозиты по конкретной ставке и валюте
                            commit;
     end loop; -- закончили обрабатывать ступенчатые ставки с валютой
  end loop;
  bc.home;
  dbms_output.put_line (xx);
end;
/


      
