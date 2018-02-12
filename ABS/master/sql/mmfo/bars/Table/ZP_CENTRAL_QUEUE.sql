exec bars.bpa.alter_policy_info( 'ZP_CENTRAL_QUEUE', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_CENTRAL_QUEUE', 'FILIAL', null, null, null, null );
/
begin execute immediate'
   create table bars.ZP_CENTRAL_QUEUE(
   mfo           varchar2(6),
   nls           varchar2(15),
   central       number,
   error         varchar2(4000) )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/

exec  bars.bpa.alter_policies('ZP_CENTRAL_QUEUE'); 
/

begin
    execute immediate 'alter table ZP_CENTRAL_QUEUE add constraint pk_ZP_CENTRAL_QUEUE       primary key (mfo,nls,central)';
 exception when others then 
    if sqlcode = -2260 then null; else raise; 
    end if; 
end;
/
comment on table  bars.ZP_CENTRAL_QUEUE is 'Черга на відправку централізованих договорів';
/
grant select,delete,update,insert on bars.ZP_CENTRAL_QUEUE to bars_access_defrole;
/
 
