begin
    execute immediate 'grant select on v_stat_file_workflow to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'grant select on v_stat_files to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'grant select on v_stat_workflows to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on v_stat_extensions to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on V_STAT_FILE_STATUSES to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'grant select on V_STAT_FILE_TYPES to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on v_stat_operations to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on v_stat_wf_oper to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on V_STAT_ACCESS to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'grant execute on PKG_STAT to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant execute on PKG_STAT_DICT to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 