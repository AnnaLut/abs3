exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_LOG', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_LOG', 'FILIAL', null, null, null, null );
/
begin execute immediate'create table bars.ZP_PAYROLL_LOG  (
   corp2_id      number,
   id            number,
   status        number,
   err           varchar2(4000),
   crt_date      date,
   constraint xpk_zp_payroll_log_corpid      primary key (corp2_id)
  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
begin
    execute immediate 'create index idx_zp_payroll_log_id on BARS.ZP_PAYROLL_LOG (id)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table bars.ZP_PAYROLL_LOG add (send_status number)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
exec  bars.bpa.alter_policies('ZP_PAYROLL_LOG'); 
/
comment on table  bars.ZP_PAYROLL_LOG is 'Документи  ЗП відомості(лог відповідей в корп)';
comment on column bars.ZP_PAYROLL_LOG.status is '1 - оплачена, -1 - відхилена (причина в err)';
comment on column bars.ZP_PAYROLL_LOG.send_status is '1 - відправлено, 0 - очікує';


/
grant select,delete,update,insert on bars.ZP_PAYROLL_LOG to bars_access_defrole;
/


