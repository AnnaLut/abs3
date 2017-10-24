update bars.cim_contracts_trade t set t.deadline=180
 where t.contr_id in ( select c.contr_id from bars.cim_contracts c where c.contr_type in (0, 1) and c.status_id<>1 ) and t.deadline<180;  
commit;

-- Чистка повідомлень про заборгованість
update bars.cim_borg_message set delete_date=sysdate, delete_uid=sys_context('bars_global','user_id') 
 where approve=0 and delete_date is null and file_name is null and control_date<to_date('01/05/2017', 'dd/mm/yyyy');
commit;

declare  
begin
  bars.bc.go(322669);
  for l in
( select * from 
( select 
       case when v.p01=2 then ( select sum(zs_vp) from bars.v_cim_trade_payments x where x.vdat=to_date(v.doc_date, 'ddmmyyyy') and x.contr_id=c.contr_id )                                     
                         else ( select  sum(z_vt) from bars.v_cim_bound_vmd x where x.allow_date=to_date(v.doc_date, 'ddmmyyyy') and x.contr_id=c.contr_id ) end as x,               
      v.branch,  v.k020, v.p01, v.p16, v.p17, v.p15, v.p14, v.p21
  from bars.v_cim_f36 v
       join bars.cim_contracts c on  c.branch like v.branch||'%' and v.k020 like '%'||c.okpo and c.contr_type+1=v.p01 and c.num=v.p17 and c.open_date=v.p16
       join bars.cim_contracts_trade ct on ct.deadline=180 and ct.contr_id=c.contr_id ) x       
   where x*100=p15 ) 
 loop
   update bars.cim_f36 f set f.p21_new=to_date(f.doc_date, 'ddmmyyyy')+181
     where f.branch=l.branch and f.k020=l.k020 and f.p01=l.p01 and f.p16=l.p16 and f.p17=l.p17 and f.p15=l.p15 and f.p14=l.p14 and f.p21=l.p21;   
 end loop;  
end;
/
commit;   