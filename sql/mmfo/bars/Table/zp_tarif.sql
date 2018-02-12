exec bars.bpa.alter_policy_info( 'ZP_TARIF', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_TARIF', 'FILIAL', 'M', 'M', 'M', 'M' );
/
begin execute immediate'
   create table bars.zp_tarif  (
   kod           number,
   kv            number,
   kf            varchar2(6)             default sys_context(''bars_context'',''user_mfo''),
   
   constraint fk_zp_tarif_tarif     foreign key (kod,kf)  references bars.tarif(kod,kf)
   
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
begin
    execute immediate 'alter table zp_tarif add constraint pk_zp_tarif_kod  primary key (kod,kf)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/
exec  bars.bpa.alter_policies('ZP_TARIF'); 
/
comment on table  bars.ZP_TARIF is 'Тарифы, доступные для ЗП проектов';
comment on column bars.ZP_TARIF.kod is 'Код тарифа';
/
grant select,delete,update,insert on bars.zp_tarif to bars_access_defrole;
/