exec bars.bpa.alter_policy_info( 'ZP_ACC', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_ACC', 'FILIAL', 'M', 'M', 'M', 'M' );
/
begin execute immediate'
   create table bars.zp_acc  (
   id            number ,
   acc           number ,
   kf            varchar2(6)  default sys_context(''bars_context'',''user_mfo''),
   
   constraint xpk_zp_acc        primary key (id,acc)   
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_ACC'); 
/
comment on table  bars.ZP_ACC is 'Счета привязанные к ЗП проекту';
comment on column bars.ZP_ACC.id is 'id зп проекта';
/
grant select,delete,update,insert on bars.ZP_ACC to bars_access_defrole;
/