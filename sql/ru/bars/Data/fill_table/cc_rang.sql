prompt
prompt Обновление данных справочника "CC_RANG"
prompt

begin
    delete from cc_rang t
    where t.rang = 10;
	
   begin 
   	insert into cc_rang (TIP, ORD, COMM, RANG, TYPE_PRIOR)
      values ('SPN', 1, 'Прострочені відсотки', 10, 1);
	exception when dup_val_on_index then  
	   update cc_rang t
		set t.ord           = 1
		    , t.comm        = 'Прострочені відсотки'
			 , t.type_prior  = 1
		where t.tip         = 'SPN'
		      and t.rang    = 10;
	end;	

   begin 
      insert into cc_rang (TIP, ORD, COMM, RANG, TYPE_PRIOR)
      values ('SK9', 2, 'Прострочена комісія', 10, 1);
	exception when dup_val_on_index then
	   update cc_rang t
		set t.ord           = 2
		    , t.comm        = 'Прострочена комісія'
			 , t.type_prior  = 1
		where t.tip         = 'SK9'
		      and t.rang    = 10;
	end;	

   begin 
      insert into cc_rang (TIP, ORD, COMM, RANG, TYPE_PRIOR)
      values ('SP', 3, 'Прострочений основний борг', 10, 1);
	exception when dup_val_on_index then
	   update cc_rang t
		set t.ord           = 3
		    , t.comm        = 'Прострочений основний борг'
			 , t.type_prior  = 1
		where t.tip         = 'SP'
		      and t.rang    = 10;
	end;	

   begin 
      insert into cc_rang (TIP, ORD, COMM, RANG, TYPE_PRIOR)
      values ('SN', 4, 'Відсотки', 10, null);
	exception when dup_val_on_index then
	   update cc_rang t
		set t.ord           = 4
		    , t.comm        = 'Відсотки'
			 , t.type_prior  = null
		where t.tip         = 'SN'
		      and t.rang    = 10;
	end;	

   begin 
      insert into cc_rang (TIP, ORD, COMM, RANG, TYPE_PRIOR)
      values ('SK0', 5, 'Комісія', 10, null);
	exception when dup_val_on_index then
	   update cc_rang t
		set t.ord           = 5
		    , t.comm        = 'Комісія'
			 , t.type_prior  = null
		where t.tip         = 'SK0'
		      and t.rang    = 10;
	end;	

   begin 
      insert into cc_rang (TIP, ORD, COMM, RANG, TYPE_PRIOR)
      values ('SS', 6, 'Основний борг', 10, null);
	exception when dup_val_on_index then
	   update cc_rang t
		set t.ord           = 6
		    , t.comm        = 'Основний борг'
			 , t.type_prior  = null
		where t.tip         = 'SS'
		      and t.rang    = 10;
	end;	

   begin 
      insert into cc_rang (TIP, ORD, COMM, RANG, TYPE_PRIOR)
      values ('SN8', 7, 'Пеня', 10, null);
	exception when dup_val_on_index then
	   update cc_rang t
		set t.ord           = 7
		    , t.comm        = 'Пеня'
			 , t.type_prior  = null
		where t.tip         = 'SN8'
		      and t.rang    = 10;
	end;	

   commit;
exception
	when others then
		rollback;
end;
/
