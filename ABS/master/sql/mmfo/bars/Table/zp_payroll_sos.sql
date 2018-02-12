exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_SOS', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_PAYROLL_SOS', 'FILIAL', null, null, null, null );
/
begin execute immediate'
   create table bars.zp_payroll_sos  (
   sos            number   not null,
   name           varchar2(200),
   constraint pk_zp_payroll_sos      primary key (sos) 
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_PAYROLL_SOS'); 
/
comment on table  bars.ZP_PAYROLL_SOS is 'Стан ЗП відомості';
comment on column bars.ZP_PAYROLL_SOS.sos is 'Код';
comment on column bars.ZP_PAYROLL_SOS.name is 'Назва';
/
grant select,delete,update,insert on bars.ZP_PAYROLL_SOS to bars_access_defrole;
/