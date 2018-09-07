delete from bars.corp2_user_limit;

delete from bars.corp2_user_modules;

delete from bars.corp2_user_functions;

delete from bars.corp2_module_functions;

delete from bars.corp2_modules;

delete from bars.corp2_functions;

delete from bars.corp2_acc_users;

delete from bars.CORP2_CUST_REL_USERS_MAP;

delete from bars.CORP2_REL_CUSTOMERS_ADDRESS;

delete from bars.CORP2_USER_VISA_STAMPS;

delete from bars.CORP2_ACSK_REGISTRATION;

delete from bars.corp2_rel_customers;

begin
    execute immediate 'insert into bars.corp2_rel_customers (id,tax_code,first_name,last_name,second_name,doc_type,doc_series,doc_number,doc_organization,doc_date,birth_date,
                                 created_date,cell_phone,address,email,no_inn,login,activate_date,key_id,acsk_actual,fio_card)
select bars.corp2_rel_cust_seq.nextval, cu.okpo, regexp_substr(cu.fio,''\S+ ''), trim(regexp_substr(cu.fio,'' \S+'')), trim(regexp_substr(cu.fio,'' \S+'',1, 2)), 1, 
       cu.DOCSERIES, cu.DOCNUMBER, cu.DOCORGANIZATION, cu.DOCDATE, cu.BIRTHDATE, null, cu.phonenumber,CU.USER_ID, 
       (select oam.email from core.ora_aspnet_membership@ibank.ua oam where oam.userid =cu.aspnet_userid), null, 
       (select substr(oau.loweredusername,1,60) from core.ora_aspnet_users@ibank.ua oau where oau.userid =cu.aspnet_userid), null, cu.key_sn, null, cu.fio_card
  from core.core_users@ibank.ua cu 
 where exists(select 1 from core.cust_users@ibank.ua cu2 where cu2.user_id = cu.user_id and cust_id in (select c.cust_id from  core.customers@ibank.ua c where c.bank_id in (select kf from bars.mv_kf)))';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into bars.corp2_cust_rel_users_map (cust_id, rel_cust_id, sign_number, user_id, is_approved, approved_type, sequential_visa)
select (select cust.rnk||bars.bars_sqnc.get_ru(cust.bank_id) 
          from core.customers@ibank.ua cust where cust.cust_id = cu.cust_id), 
       (select crc.id from bars.corp2_rel_customers crc where to_number(crc.address) = cu.user_id),
       nvl(cu.visa_id,0), cu.user_id, -1,''NEED_APPROVE'', cu.sequential_visa
  from core.cust_users@ibank.ua cu
 where exists (select 1 from core.customers@ibank.ua c where cu.cust_id = c.cust_id and c.bank_id in (select kf from bars.mv_kf) and c.rnk||bars.bars_sqnc.get_ru(c.bank_id) in (select cc.rnk from bars.customer cc) 
                                                 and cu.user_id in (select to_number(address) from bars.corp2_rel_customers) )';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into bars.corp2_limits (limit_id, description, doc_sum, doc_created_count, doc_sent_count)
select limit_id, description, doc_sum, doc_created_count, doc_sent_count from core.user_limits@ibank.ua';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into bars.corp2_user_limit (limit_id,user_id,login_type,doc_sum,doc_created_count,doc_sent_count,doc_date_lim)
  select clt.limit_id, (select crc.id from bars.corp2_rel_customers crc where to_number(crc.address) = clt.user_id), clt.login_type, clt.doc_sum, 
         clt.doc_created_count, clt.doc_sent_count, (select cu.doc_date_lim from core.core_users@ibank.ua cu where cu.user_id = clt.user_id)
    from core.user_limit_templates@ibank.ua clt
   where exists(select 1 from core.cust_users@ibank.ua cu2 where cu2.user_id = clt.user_id and cu2.cust_id in (select c.cust_id from  core.customers@ibank.ua c where c.bank_id in (select kf from bars.mv_kf)))';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'insert into bars.corp2_modules (module_id,name,user_type,sort_order,icon_url)
select module_id,name,user_type,sort_order,icon_url from core.core_modules@ibank.ua';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'insert into bars.corp2_functions (func_id,func_name,start_page,description,func_type,user_type)
select func_id,func_name,start_page,description,func_type,user_type from core.core_functions@ibank.ua';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'insert into bars.corp2_module_functions(module_id,func_id,sort_order)
select module_id,func_id,sort_order from core.core_module_functions@ibank.ua';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'insert into bars.corp2_user_modules (user_id, module_id)
  select (select crc.id from bars.corp2_rel_customers crc where to_number(crc.address) = um.user_id), um.module_id
    from core.core_user_modules@ibank.ua um
   where exists(select 1 from core.cust_users@ibank.ua cu2 where cu2.user_id = um.user_id and cu2.cust_id in (select c.cust_id from core.customers@ibank.ua c where c.bank_id in (select kf from bars.mv_kf)))';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.corp2_user_functions (user_id, func_id)
  select (select crc.id from bars.corp2_rel_customers crc where to_number(crc.address) = uf.user_id), uf.func_id
    from core.core_user_functions@ibank.ua uf
   where exists(select 1 from core.cust_users@ibank.ua cu2 where cu2.user_id = uf.user_id and cu2.cust_id in (select c.cust_id from  core.customers@ibank.ua c where c.bank_id in (select kf from bars.mv_kf)))';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'insert into bars.corp2_acc_users (nls, kv, kf, user_id, cust_id, can_view, can_debit, can_visa, visa_id, active, sequential_visa)
   select (select a.acc_num
             from core.accounts@ibank.ua a 
            where a.acc_id = au.acc_id),
          (select a.cur_id
             from core.accounts@ibank.ua a 
            where a.acc_id = au.acc_id), 
          (select a.bank_id 
             from core.accounts@ibank.ua a 
            where a.acc_id = au.acc_id),
          (select crc.id
             from bars.corp2_rel_customers crc
            where to_number(crc.address) = au.user_id),
          (select (select cust.rnk||bars.bars_sqnc.get_ru(a.bank_id) 
                     from core.customers@ibank.ua cust
                    where cust.cust_id = a.cust_id)
             from core.accounts@ibank.ua a 
            where a.acc_id = au.acc_id), 
          au.can_view, au.can_debit, au.can_visa, au.visa_id, au.active, au.sequential_visa 
      from core.acc_users@ibank.ua au
     where exists(select 1 from core.accounts@ibank.ua au2 where au2.acc_id = au.acc_id and au2.cust_id in (select c.cust_id from  core.customers@ibank.ua c where c.bank_id in (select kf from bars.mv_kf)))
       and au.user_id in (select to_number(c2.address) from bars.corp2_rel_customers c2)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

commit;

begin
  for c0 in (select * 
               from barsaq.ibank_acc ia 
              where ia.acc_corp2 is null) loop
      update ibank_acc iba
         set iba.acc_corp2 = (select ka.acc_id
                                from ibank.v_accounts ka
                               where ka.bank_id = c0.kf
                                 and (ka.acc_num, ka.cur_id)  = (select a.nls,
                                                                        a.kv
                                                                   from bars.accounts a
                                                                  where a.acc = c0.acc
                                                                    and a.kf = c0.kf))
       where iba.acc = c0.acc
         and iba.kf = c0.kf;
  end loop;
  
  
  commit;
end;
/