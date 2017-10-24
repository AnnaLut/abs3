begin
    execute immediate 'grant select,insert,update on cc_lim_copy_header to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select,insert,update on cc_lim_copy_body to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on v_cc_lim_copy_body to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on v_cc_lim_copy_header to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on V_CCK_GLK to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on cc_lim_copy_header to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on cc_lim_copy_body to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on v_cc_lim_copy_body to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on v_cc_lim_copy_header to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on V_CCK_GLK to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on V_CCK_ND_ACCOUNT to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on V_CCK_ND_ACCOUNT to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on V_ESCR_REF_FOR_COMPENSATION to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on V_ESCR_REF_FOR_COMPENSATION to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on vw_escr_list_for_sync to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on vw_escr_list_for_sync to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on V_CCK_INTEREST_MODE to BARSREADER_ROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on V_CCK_INTEREST_MODE to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant execute on escr to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 