begin
    execute immediate 'grant execute on bars_audit to spiu';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on bars.adr_streets to spiu';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'grant select on bars.S_ADR_CA_FILES to spiu';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on bars.S_AREAS to spiu';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on bars.S_DISTRICTS to spiu';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant execute on bars.pkg_adr_synch to spiu';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant execute on bars.bars_login to spiu';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_REGIONS to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_AREAS to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_SETTLEMENT_TYPES to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_SETTLEMENTS to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_CITY_DISTRICTS to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_STREET_TYPES to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_STREETS to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_HOUSES to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant select on ADR_PHONE_CODES to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant create job to SPIU';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 
begin
    execute immediate 'grant execute on bars.pkg_adr_synch to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'grant execute on PKG_ADR_COMPARE to BARS_ACCESS_DEFROLE';
 exception when others then 
    if sqlcode = -1917 then null; else raise; 
    end if; 
end;
/ 

