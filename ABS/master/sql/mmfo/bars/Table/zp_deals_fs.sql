exec bars.bpa.alter_policy_info( 'ZP_DEALS_FS', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_DEALS_FS ', 'FILIAL', null, null, null, null );
/
begin execute immediate'create table bars.zp_deals_fs  (
   id              number,
   name            varchar2(4000),
   ob22            varchar2(2)   not null,
   date_close      date ,
   constraint pk_zp_deals_fs_id primary key(id) 
  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_DEALS_FS'); 
/
comment on table  bars.ZP_DEALS_FS is 'Довідник типів організацій';
/
grant select,delete,update,insert on bars.ZP_DEALS_FS to bars_access_defrole;
/


