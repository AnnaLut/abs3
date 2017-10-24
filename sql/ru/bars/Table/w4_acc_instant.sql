exec bpa.alter_policy_info('W4_ACC_INSTANT', 'WHOLE',  null, 'E', 'E', 'E');
exec bpa.alter_policy_info('W4_ACC_INSTANT', 'FILIAL', 'M', 'M', 'M', 'M');

begin 
  execute immediate 
    'create table w4_acc_instant
     ( acc        number(22)    constraint cc_w4accinstant_acc_nn not null,
       card_code  varchar2(30)  constraint cc_w4accinstant_cardcode_nn not null,
       BATCHID number,
       STATE integer,
       RNK number,
       REQID number,	   
       kf         varchar2(6)   constraint cc_w4accinstant_kf_nn not null,
       constraint pk_w4accinstant primary key (acc),
       constraint fk_w4accinstant_accounts foreign key (acc, kf) references accounts (acc, kf),
       constraint fk_w4accinstant_w4card foreign key (card_code, kf) references w4_card (code, kf)
     ) tablespace brssmld';
exception when others then 
  if sqlcode = -955 then null; else raise; end if;
end;
/


begin
    execute immediate 'alter table W4_ACC_INSTANT add BATCHID number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table W4_ACC_INSTANT add STATE integer';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table W4_ACC_INSTANT add RNK number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table W4_ACC_INSTANT add REQID number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table w4_acc_instant add kf varchar2(6)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


alter table w4_acc_instant modify kf varchar2(6) default sys_context('bars_context','user_mfo');

comment on table w4_acc_instant is 'OW. Рахунки Instant';
comment on column w4_acc_instant.acc       is 'ACC карт.рах. 2625';
comment on column w4_acc_instant.card_code is 'Тип картки';

exec bpa.alter_policies('W4_ACC_INSTANT');

grant select, insert, update, delete on w4_acc_instant to ow;