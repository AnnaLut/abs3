exec bars.bpa.alter_policy_info( 'ZP_DEALS_SOS', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_DEALS_SOS', 'FILIAL', null, null, null, null );
/
begin execute immediate'
   create table bars.zp_deals_sos  (
   sos            number   not null,
   name           varchar2(200),
   constraint pk_zp_sos      primary key (sos) 
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_DEALS_SOS'); 
/
comment on table  bars.zp_deals_sos is 'Состояние зарплатного проекта';
comment on column bars.zp_deals_sos.sos is 'Код';
comment on column bars.zp_deals_sos.name is 'Наименование';
/
grant select,delete,update,insert on bars.ZP_DEALS_SOS to bars_access_defrole;
/