begin
  bpa.alter_policy_info( 'cp_dgp_zv_type', 'CENTER', null, null, null, null );
  bpa.alter_policy_info( 'cp_dgp_zv_type', 'FILIAL', null, null, null, null );
  bpa.alter_policy_info( 'cp_dgp_zv_type', 'WHOLE' , null, null, null, null );
end;
/

-- Create table
begin 
  execute immediate '
create table cp_dgp_zv_type
(
  type_id    number(2),
  type_name  varchar2(80),
  type_view  varchar2(32)
)
tablespace brssmld';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


begin   
 execute immediate 'alter table CP_DGP_ZV_TYPE
  add constraint cp_dgp_zv_type primary key (TYPE_ID)
  using index 
  tablespace BRSSMLI
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  )';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


-- Add comments to the table 
comment on table CP_DGP_ZV_TYPE is 'Типи для форм DGP по ЦП';

grant SELECT,UPDATE,DELETE                                                          on CP_DGP_ZV_TYPE  to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE,DELETE                                                          on CP_DGP_ZV_TYPE  to CP_ROLE;
