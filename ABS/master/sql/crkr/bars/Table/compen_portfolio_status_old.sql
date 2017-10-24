exec bpa.alter_policy_info('compen_portfolio_status_old', 'filial', null, null, null, null);
exec bpa.alter_policy_info('compen_portfolio_status_old', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table COMPEN_PORTFOLIO_STATUS_OLD
(
  compen_id  NUMBER,
  status_old NUMBER
)
tablespace BRSSMLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_PORTFOLIO_STATUS_OLD
  is 'Статуси вкладів з АСВО (невідомі при міграції)';
