begin 
    excute immediate 'create table tmp_all_enabled_triggers(owner varcjar2(20), trigger_name varchar2(200) )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table tmp_all_enabled_jobs is 'список включенных тригеров';


