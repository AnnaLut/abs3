PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/migr_zp_job.sql =========*** Run *** ===
PROMPT ===================================================================================== 

PROMPT *** drop_job ***

begin
  dbms_scheduler.drop_job(job_name  => 'bars.zp_migr');
exception when others then
  if (sqlcode = -27475) then null;
  else raise; end if;
end;
/

PROMPT *** create_job ***

declare
  l_job_action varchar2(4000) := '
declare
l_id number;
begin
    for i in(select * from mv_kf)
    loop
        bc.go(i.kf);
        for c in (
                select a.rnk,c.nmkv,a.acc,a.daos,a.branch from accounts a,customer c
                where a.nbs=''2909''
                and a.ob22=''11''
                and a.kv=980
                and c.rnk=a.rnk
                and a.dazs is null
                and a.rnk not in (select rnk from zp_deals where sos>=0 )
                )
        
            loop
               begin 
                 bc.go(c.branch);
                 zp.create_deal(c.rnk,
                               nvl(c.nmkv,''Без назви''),  
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
                
                zp.zp_acc_migr(l_id);
               exception  when others then
                         if sqlcode = -20000 then 
                         null; 
                         else raise;
                         end if;
               end;
            end loop;
    end loop;
    bc.go(''/'');
    commit;

    begin 
      for c in (
                  select a.rnk,c.nmkv,a.acc,a.daos,a.branch from accounts a,customer c
                      where a.nbs=''2909''
                      and a.ob22=''11''
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
  
       commit; 
     end;
end;  
  ';
begin
  dbms_scheduler.create_job(job_name        => 'bars.zp_migr',
                            job_type            => 'PLSQL_BLOCK',
                            job_action          => l_job_action,
                            number_of_arguments => 0,
                            start_date          => TO_TIMESTAMP('2018/02/27 22:00:00.000000','yyyy/mm/dd hh24:mi:ss.ff'),
                            repeat_interval     => NULL,
                            end_date            => TO_TIMESTAMP('2018/02/27 22:01:00.000000','yyyy/mm/dd hh24:mi:ss.ff'),
                            job_class           => 'DEFAULT_JOB_CLASS',
                            enabled             => TRUE,
                            comments            => 'Міграція зарплатних рахунків');
exception when others then
      if (sqlcode = -27477) then null;
        else raise; 
      end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/migr_zp_job.sql =========*** End *** ===
PROMPT ===================================================================================== 
