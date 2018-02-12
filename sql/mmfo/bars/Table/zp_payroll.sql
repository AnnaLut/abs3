exec bars.bpa.alter_policy_info( 'ZP_PAYROLL', 'WHOLE' , null, null, null, null ); 
/
exec bars.bpa.alter_policy_info( 'ZP_PAYROLL', 'FILIAL', 'M', 'M', 'M', 'M' );
/
begin execute immediate'create table bars.zp_payroll  (
   id            number                  constraint cc_zp_payroll_id not null,
   rnk           number                                              not null, 
   zp_id         number                                              not null,              
   zp_deal_id    varchar2(60)                                        not null,
   sos           number,
   source        number,   
   crt_date      date                                         default sysdate , 
   pr_date       date,
   payroll_num   varchar2(64),
   comm_reject   varchar2(500),
   branch        varchar2(30)            default sys_context(''bars_context'',''user_branch''),
   kf            varchar2(6)             default sys_context(''bars_context'',''user_mfo''),
   user_id       number, 
   upd_date      date,
   nazn          varchar2(160),
   ref_cms       number,
   key_id        varchar2(256), 
   sign          raw(2000) , 
   signed        varchar2(1),
   constraint pk_zp_payroll_id       primary key (id),
   constraint fk_zp_payroll_rnk      foreign key (rnk)    references bars.customer(rnk),
   constraint fk_zp_payroll_zp_id    foreign key (zp_id)  references bars.zp_deals(id),
   constraint fk_zp_payroll_sos      foreign key (sos)    references bars.zp_payroll_sos(sos),
   constraint cc_zp_payroll_source   check (source in (1,2,3,4,5)),
   constraint fk_zp_payroll_user_id  foreign key (user_id)   references bars.staff$base (id)
  )';
exception when others then  
  if sqlcode = -00955 then null;   else raise; end if;   
end;
/
exec  bars.bpa.alter_policies('ZP_PAYROLL'); 
/
begin
    execute immediate 'alter table zp_payroll add (key_id varchar2(256), sign raw(2000) , signed varchar2(1))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll add ( signed_user number)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll add ( reject_user number)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll add ( nazn varchar2(160))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll add ( corp2_id number)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll drop constraint cc_zp_payroll_source';
 exception when others then 
    if sqlcode = -2443 then null; else raise; 
    end if; 
end;
/
begin
    execute immediate 'alter table zp_payroll add constraint cc_zp_payroll_source   check (source in (1,2,3,4,5))';
 exception when others then 
    if sqlcode = -2264 then null; else raise; 
    end if; 
end;
/


comment on table  bars.ZP_PAYROLL is '�� �������';
comment on column bars.ZP_PAYROLL.id is 'id �������';
comment on column bars.ZP_PAYROLL.source is '������� ������� (1-����� ��������/2-������ �����/3-���������� ������ �������/4-������� ��� )';
comment on column bars.ZP_PAYROLL.payroll_num is '����� �������';
/
grant select,delete,update,insert on bars.ZP_PAYROLL to bars_access_defrole;
/

