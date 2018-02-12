exec bars.bpa.alter_policy_info( 'ZP_CENTRAL_RECIPIENTS', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_CENTRAL_RECIPIENTS', 'FILIAL', null, null, null, null );
/
begin execute immediate'
   create table bars.ZP_CENTRAL_RECIPIENTS  (
   mfo           varchar2(6),
   url           varchar2(400) 
   
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
begin
    execute immediate 'alter table bars.ZP_CENTRAL_RECIPIENTS   add constraint pk_ZP_CENTRAL_RECIPIENTS       primary key (mfo)';
 exception when others then 
    if sqlcode = -2260 then null; else raise; 
    end if; 
end;
/
exec  bars.bpa.alter_policies('ZP_CENTRAL_RECIPIENTS'); 
/
comment on table  bars.zp_central_recipients is 'Ссылки для вызова вебсервиса(передача инф.о централизованом договоре)';
/
grant select,delete,update,insert on bars.zp_central_recipients to bars_access_defrole;
/
 
