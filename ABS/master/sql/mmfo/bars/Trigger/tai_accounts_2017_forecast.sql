CREATE OR REPLACE TRIGGER tai_accounts_2017_forecast AFTER INSERT  ON ACCOUNTS  FOR EACH ROW
declare
   l_new_nls accounts.nls%type;
   l_count     number:= 0;
   l_tries     number:= 0;
   l_new_nbs   varchar2(4);
   l_old_nbs   varchar2(4);
   l_row       transfer_2017%rowtype;
   l_trace     varchar2(100) := 'T2017.tai_accounts_2017_forecast: ';
begin
   
   if :new.nbs is null then 
      l_old_nbs := substr(:new.nls,1,4);
   else    
      l_old_nbs := :new.nbs;
   end if;    
   
      
   begin
      -- счет не меняет лицевой
      select 1 into l_count 
        from transfer_2017 
       where r020_old = l_old_nbs and r020_old <> r020_new
         and rownum = 1;
   exception when no_data_found then
      return;
   end;

   
   bars_audit.info(l_trace||'старт внесения счета для прогнозирования kf='||:new.kf||', acc='||:new.acc||', nls='||:new.nls||', nbs='||:new.nbs||', ob22='||:new.ob22);
/*   
   select * into l_row 
     from transfer_2017 t 
    where t.r020_old = l_old_nbs 
      and t.ob_old = nvl(:new.ob22,t.ob_old) 
      and rownum = 1;
      
   l_new_nbs := l_row.r020_new;
  
  
   while l_tries < 100 loop
            l_new_nls := vkrzn( substr( :new.kf, 1,5), l_new_nbs||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) ));
            l_count := 0 ;
            select count(*) into l_count from 
            ( select 1  from accounts                  where nls      = l_new_nls   and kf = :new.kf
              union all 
              select 1 from TRANSFORM_2017_FORECAST    where new_nls  = l_new_nls   and kf = :new.kf
            );
            
            -- если такой счет нашли или в счете или в зарезервированных
            -- пытаемся еще раз подобрать
            if l_count > 0 then               
               l_tries := l_tries + 1;
            else
               -- выход, счет нашли
               exit;   
            end if;
        
      end loop;
      if l_tries >=100 then
           bars_audit.info(l_trace||'для счета не смогли подобрать новый счет за 100 попыток kf='||:new.kf||', acc='||:new.acc||', nls='||:new.nls);
           return;
      end if;
*/           
      insert into transform_2017_forecast(
                    kf,
                    kv,
                    acc,
                    nbs,
                    nls,
                    ob22,
                    new_nbs,
                    new_ob22,
                    new_nls,
                    insert_date          )
    --values (:new.kf, :new.kv, :new.acc, :new.nbs, :new.nls, :new.ob22, l_row.r020_new, l_row.ob_new, l_new_nls, sysdate );
    values (:new.kf, :new.kv, :new.acc, :new.nbs, :new.nls, :new.ob22, null, null, null, sysdate );
      
  
end;
/    
    
show err