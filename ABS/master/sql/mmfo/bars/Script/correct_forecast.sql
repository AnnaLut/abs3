set serveroutput on size 10000

begin
  execute immediate 'create index xuk_TRANSFORM_FORECAST on TRANSFORM_2017_FORECAST ( KF, NEW_NLS )';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/



begin
  execute immediate 'create index xuk_TRANSFORM_FORECAST on TRANSFORM_2017_FORECAST ( KF, NLS )';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/


begin
  execute immediate 'drop index xak_TRANSFORM_FORECAST_acc';
exception
  when others then
    if sqlcode=-1418 then null; else raise; end if;
end;
/


begin
  execute immediate 'create unique index xak_TRANSFORM_FORECAST_acc on TRANSFORM_2017_FORECAST ( ACC)';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/


exec dbms_stats.gather_table_stats('BARS','TRANSFORM_2017_FORECAST');


begin
   for k in (select kf from mv_kf) loop
       for c in ( 
                  select kf, nls, min(new_nls) min_new_nls
                    from transform_2017_forecast 
                   where (kf, nls)  in
                       ( select kf, nls
                           from transform_2017_forecast
                           where kf = k.kf
                          group by kf, nls
                         having count(*) > 1
                       )  
                  group by kf, nls
                ) loop
           update transform_2017_forecast set new_nls = c.min_new_nls where kf = c.kf and nls = c.nls;
       end loop;
       dbms_output.put_line('Done for '||k.kf); 
       commit;            
   end loop;    
end;
/

