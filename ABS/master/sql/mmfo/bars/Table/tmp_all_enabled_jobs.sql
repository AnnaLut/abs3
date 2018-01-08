begin 
    execute immediate 'create table tmp_all_enabled_jobs(owner varchar2(20), job_type varchar2(1), job_name varchar2(200) )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table tmp_all_enabled_jobs is 'список включенных джобов';


