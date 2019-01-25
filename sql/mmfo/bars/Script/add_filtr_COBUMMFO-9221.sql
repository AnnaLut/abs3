declare
l_flag number;
begin
 select count(tabid) into l_flag 
   from meta_columns mc 
  where mc.tabid='1011512' 
        and mc.colname in ('MAIN_ACCOUNT_NUMBER','PARTNER_ACCOUNT', 'PARTNER_ID');
 if(l_flag>0) then      
  update meta_columns mc 
     set mc.showin_fltr=1 
     where mc.tabid='1011512' 
           and mc.colname in ('MAIN_ACCOUNT_NUMBER','PARTNER_ACCOUNT', 'PARTNER_ID');
 end if;
 l_flag:=0;
 select count(tabid) into l_flag 
   from meta_columns mc 
  where mc.tabid='1011512'
        and mc.colname in ('PARTNER_NAME');
  if(l_flag=1) then      
  update meta_columns mc 
     set mc.coltype='A', mc.showin_fltr=1
     where mc.tabid='1011512' 
           and mc.colname in ('PARTNER_NAME');
 end if;
end;
/
commit;
/
