declare
  type t_arr is table of deal.id%type;
  v_data t_arr;
  l_dkbo_deal     deal.id%type;
  n_do            number(1);
  l_dkbo_acc_list  number_list;
  l_acc_list_union number_list;
  lc_acc_list      CONSTANT attribute_kind.attribute_code%TYPE := 'DKBO_ACC_LIST';
begin

for cur in (
          select * from (
          select t.rnkfrom p_rnkfrom, t.rnkto p_rnkto, a.acc acc_, c.date_off, t.sdate from bars.RNK2NLS t, bars.accounts a, bars.customer c
          where t.rnkfrom <> t.rnkto
            and t.nls = a.nls
            and a.dazs is null
            and a.nbs = '2625'
            and c.rnk = t.rnkto
            and t.rnkfrom not in (234160)  --в DA_KIEV походу ошиблись с этим объединением
          order by t.sdate)
        --  where rownum<1417
           )
loop
    n_do:=1;
    declare
      n_cust  customer.rnk%type; 
      d_close customer.date_off%type; 
    begin
     loop
       EXIT WHEN cur.date_off is null or cur.p_rnkto is null;
       
       begin
         select MAX(r.rnkto) KEEP (DENSE_RANK LAST ORDER BY r.sdate) into cur.p_rnkto from rnk2nls r where r.rnkfrom = cur.p_rnkto;
         select c.date_off into cur.date_off from customer c  where c.rnk = cur.p_rnkto;
       exception when others then n_do:=0;
       end;
     end loop;
    end; 
            if n_do=1 then
                  for cur2 in -- и неважно, открыт или закрыт deal. Все равно забираем счет и присоединяем к другому, ведь счет открыт
                              (select distinct d.id, d.branch_id , d.start_date 
                                    from BARS.deal d
                                    join BARS.Attribute_History        ah  on ah.object_id = d.id and ah.attribute_id in(select ak.id from BARS.attribute_kind ak where ak.attribute_code = 'DKBO_ACC_LIST')
                                    join BARS.Attribute_Number_History anh on anh.id = ah.id
                              where d.deal_type_id in(select tt.id from BARS.object_type tt where tt.type_code = 'DKBO')
                                and d.customer_id = cur.p_rnkfrom
                                and anh.value     = cur.acc_)
                  loop             
                  savepoint DO;
                  begin
                  bars.bc.go(cur2.branch_id);

                  --Визначаємо всі рахунки клієнта ,включені в ДКБО
                  l_dkbo_acc_list  := bars.attribute_utl.get_number_values(p_object_id      => cur2.id
                                                                          ,p_attribute_code => lc_acc_list);

                  l_acc_list_union := l_dkbo_acc_list MULTISET EXCEPT DISTINCT number_list(cur.acc_);
                  
                  bars.attribute_utl.set_value(p_object_id      => cur2.id
                                              ,p_attribute_code => lc_acc_list
                                              ,p_values         => l_acc_list_union);
                  
                    --присоединяем счет к ДКБО
                    bars.pkg_dkbo_utl.p_acc_map_to_dkbo(in_customer_id => cur.p_rnkto,
                                                   in_acc_list         => number_list(cur.acc_),
                                                   in_dkbo_date_from   => cur2.start_date,
                                                   out_deal_id         => l_dkbo_deal);
                    --пишем в историю переноса                                                                
                                insert
                                into   bars.rnk2deal_acc (rnkfrom,
                                                rnkto  ,
                                                sdate  ,
                                                deal_from     ,
                                                deal_to      ,
                                                acc ,
                                                id)
                                        values (to_number(cur.p_rnkfrom),
                                                to_number(cur.p_rnkto)  ,
                                                cur.sdate             ,
                                                cur2.id           ,
                                                l_dkbo_deal         ,  
                                                cur.acc_                ,
                                                user_id); 
                  exception when others then rollback to DO;
                  end;                              
                                                   
                  end loop;                        
                      
               end if;                         
end loop;           

end;
/