PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/bars/Table/zp_acc_pk.sql =========*** Run **
PROMPT ===================================================================================== 

exec bars.bpa.alter_policy_info( 'ZP_ACC_PK', 'WHOLE' , null, null, null, null ); 

exec bars.bpa.alter_policy_info( 'ZP_ACC_PK', 'FILIAL', 'M', 'M', 'M', 'M' );

begin execute immediate'
   create table bars.zp_acc_pk  (
   id            number ,
   acc_pk         number ,
   kf            varchar2(6)  default sys_context(''bars_context'',''user_mfo''),
   status        number, 
   id_bpk_proect number,
   
   constraint pk_zp_acc_pk        primary key (acc_pk)
)';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_ACC_PK'); 

comment on table  bars.ZP_ACC_PK is 'Счета 2625/2620 зарплатного проекта';
comment on column bars.ZP_ACC_PK.id is 'id зп проекта ';
comment on column bars.ZP_ACC_PK.id_bpk_proect is 'id зп проекта бпк';

begin
    execute immediate 'create index i_zp_acc_pk_id on bars.zp_acc_pk (id)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/

grant select,delete,update,insert on bars.ZP_ACC_PK to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/bars/Table/zp_acc_pk.sql =========*** End **
PROMPT ===================================================================================== 
