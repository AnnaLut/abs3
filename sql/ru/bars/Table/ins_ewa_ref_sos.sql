exec bars.bpa.alter_policy_info( 'INS_EWA_REF_SOS', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'INS_EWA_REF_SOS', 'FILIAL', 'M', 'M', 'M', 'M' );
/
begin execute immediate'
   create table bars.ins_ewa_ref_sos (
   ref           number,
   id_ewa        number,
   crt_date      date,
   sos           number ,
   kf            varchar2(6)  default sys_context(''bars_context'',''user_mfo''),
   
   constraint pk_ins_ewa_ref_sos        primary key (ref)   
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('INS_EWA_REF_SOS'); 
/
comment on table  bars.INS_EWA_REF_SOS is 'Документы,для передачи состояния в ПО EWA ';
/
grant select,delete,update,insert on bars.INS_EWA_REF_SOS to bars_access_defrole;
/
                