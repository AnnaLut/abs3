
begin --убрать перед передачей в прод
for c in (
            select a.rnk,c.nmkv,a.acc,a.daos,a.branch from accounts a,customer c
                where a.nbs='2909'
                and a.ob22='11'
                and a.kv=980
                and c.rnk=a.rnk
                and a.dazs is null)
 loop
 
     update zp_deals
     set branch=c.branch
     where rnk=c.rnk
     and acc_2909=c.acc
     and sos>=0;  
     
 end loop;
 
 end;               
/
commit;
/         
declare
l_id number;
begin
    for i in(select * from mv_kf)
    loop
        bc.go(i.kf);
        for c in (
                select a.rnk,c.nmkv,a.acc,a.daos,a.branch from accounts a,customer c
                where a.nbs='2909'
                and a.ob22='11'
                and a.kv=980
                and c.rnk=a.rnk
                and a.dazs is null
                and a.rnk not in (select rnk from zp_deals where sos>=0 )
                )
        
            loop
               begin 
                 bc.go(c.branch);
                 zp.create_deal(c.rnk,
                               nvl(c.nmkv,'Ѕез назви'),  
                               c.daos,
                              0, 
                              0,
                              435,
                              c.acc,
                              null );

                select id into l_id from zp_deals 
                where rnk=c.rnk
                and acc_2909=c.acc
                and sos>=0;
                              
                update zp_deals set kod_tarif= null
                where id=l_id;
                
                 --zp.zp_acc_migr(l_id);
               exception  when others then
                         if sqlcode = -20000 then 
                         null; 
                         else raise;
                         end if;
               end;
            end loop;
    end loop;
    bc.go('/');      
end;                      
/
commit;
/



begin 
for c in (
            select a.rnk,c.nmkv,a.acc,a.daos,a.branch from accounts a,customer c
                where a.nbs='2909'
                and a.ob22='11'
                and a.kv=980
                and c.rnk=a.rnk
                and a.dazs is null)
 loop
 
     update zp_deals
     set branch=c.branch
     where rnk=c.rnk
     and acc_2909=c.acc
     and sos>=0;  
     
 end loop;
 
 end;               
/
commit;
/         
                        
                