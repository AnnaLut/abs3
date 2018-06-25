PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/migr_zp_job.sql =========*** Run *** ===
PROMPT ===================================================================================== 

PROMPT *** drop_job ***

begin
  /*drop old job is exists*/
  dbms_scheduler.drop_job(job_name => 'bars.zp_migr');
exception when others then
  if sqlcode = -27475 then 
    null;
  elsif sqlcode = -27478 then -- is running
    dbms_scheduler.stop_job(job_name => 'bars.zp_migr', force => true);
    dbms_scheduler.drop_job(job_name => 'bars.zp_migr');
  else 
    raise; 
  end if;
end;
/

PROMPT *** create_job ***

declare
  l_job_action varchar2(4000) := '
declare
l_id number;
begin
  bars_audit.info(''zp_migr script start'');
  /* Користувачі додають в таблицю bars.tarif тариф 435 для того МФО яке потрібно мігрувати */
  /* По цим даним додаємо в bars.zp_tarif                                                   */
  begin
    bars_audit.info(''zp_migr insert_tarif start'');
    for i in (select kf from bars.tarif where kod = 435 and kv = 980)
    loop
        
      begin
        bars_audit.info(''zp_migr insert_tarif for kf ''||i.kf);
        insert into bars.zp_tarif (kod, kv, kf) values (435,980,i.kf);
      exception when others then  
        if sqlcode = -00001 then 
          null;   
        else 
          raise; 
        end if;   
      end;

    end loop;

    commit;
    bars_audit.info(''zp_migr insert_tarif commited'');
  end;
  bars_audit.info(''zp_migr migr start'');
  /* Міграція */
  for i in (select kf.*
            from mv_kf kf
                 inner join bars.tarif t on t.kod = 435 and t.kv = 980 and t.kf = kf.kf)
  loop
    bars_audit.info(''zp_migr migr kf ''||i.kf);
    bc.go(i.kf);
    for c in (
            /* вибірка на доміграцію */
            select a.rnk,c.nmkv,a.acc,a.daos,a.branch from accounts a,customer c
            where a.nbs=''2909''
            and a.ob22=''11''
            and a.kv=980
            and c.rnk=a.rnk
            and a.dazs is null
            and (a.rnk,a.acc) not in (select rnk,acc_2909 from zp_deals where sos>=0)
            )
        loop
           begin 
             bars_audit.info(''zp_migr migr branch ''||c.branch||'', rnk ''||c.rnk);
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

            bars_audit.info(''zp_migr migr deal_created ''||to_char(l_id));
                              
            update zp_deals set kod_tarif= null
            where id=l_id;
                
            zp.zp_acc_migr(l_id);

            bars_audit.info(''zp_migr migr deal_migrated ''||to_char(l_id));
           exception  
             when others then
               if sqlcode in (-20000,-20001) then 
                 bars_audit.info(''zp_migr migr err ''||sqlerrm);
                 null; 
               else 
                 bars_audit.info(''zp_migr migr err ''||dbms_utility.format_error_backtrace || '' '' || sqlerrm);
                 raise;
               end if;
           end;
        end loop;
  end loop;
  bc.home;
  commit;
  bars_audit.info(''zp_migr migr commited'');
exception
  when others then
    bc.home;
    bars_audit.info(''zp_migr migr error''||dbms_utility.format_error_backtrace || '' '' || sqlerrm);
end;
  ';
begin
  dbms_scheduler.create_job(job_name        => 'bars.zp_migr',
                            job_type            => 'PLSQL_BLOCK',
                            job_action          => l_job_action,
                            number_of_arguments => 0,
                            start_date          => sysdate,
                            repeat_interval     => NULL,
                            end_date            => null,
                            job_class           => 'DEFAULT_JOB_CLASS',
                            enabled             => TRUE,
                            comments            => 'Міграція зарплатних рахунків',
                            auto_drop           => TRUE);
exception when others then
      if (sqlcode = -27477) then null;
        else raise; 
      end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/migr_zp_job.sql =========*** End *** ===
PROMPT ===================================================================================== 
