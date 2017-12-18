prompt
prompt cim_contracts - Контракти
prompt

exec bpa.alter_policy_info('CIM_CONTRACTS','FILIAL',null,null,null,null);
exec bpa.alter_policy_info('CIM_CONTRACTS','WHOLE',null,null,null,null);
commit;


begin
    execute immediate 'create table cim_contracts (
    contr_id      number               constraint cc_cimcontracts_id_nn not null,
    contr_type    number               constraint cc_cimcontracts_type_nn not null,
    rnk           number               constraint cc_cimcontracts_rnk_nn not null,
	okpo          varchar2(14)		   constraint cc_contracts_okpo_nn not null,
    num           varchar2(60)         constraint cc_cimcontracts_num_nn not null,
    open_date     date                 constraint cc_cimcontracts_opendate_nn not null,
    close_date    date,
    s             number,
    kv            number               constraint cc_cimcontracts_kv_nn not null,
    benef_id      number,
	status_id     number			   constraint cc_cimcontracts_status_nn not null,
    branch        varchar(30) default  sys_context(''bars_context'',''user_branch'') constraint cc_cimcontracts_branch_nn not null,
    owner_uid     number      default  sys_context(''bars_global'',''user_id''),
    comments      varchar2(250),
    subnum varchar2(20),
    constraint pk_cimcontracts primary key(contr_id) using index tablespace brsmdli,
    constraint fk_cimcontracts_types foreign key (contr_type) references cim_contract_types (contr_type_id),
    constraint fk_cimcontracts_statuses foreign key (status_id) references cim_contract_statuses (status_id),
    constraint fk_cimcontracts_benefs foreign key (benef_id) references cim_beneficiaries (benef_id)    
)
tablespace brsmdld';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table cim_contracts add constraint fk_cimcontracts_owneruid foreign key (owner_uid) references staff$base (id) novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table cim_contracts add constraint fk_cimcontracts_customer foreign key (rnk) references customer (rnk) novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table cim_contracts add constraint fk_cimcontracts_branch foreign key (branch) references branch (branch)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table cim_contracts add constraint fk_cimcontracts_tabval foreign key (kv) references tabval$global (kv)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


comment on table  cim_contracts              is 'Довідник контрактів v1.0';
comment on column cim_contracts.contr_id     is 'Внутрішній код контракту';
comment on column cim_contracts.contr_type   is 'Тип контракту';
comment on column cim_contracts.rnk          is 'Внутрішній номер (rnk) контрагента контракту';
comment on column cim_contracts.okpo	     is	'Код ЄДРПОУ клієнта';
comment on column cim_contracts.num          is 'Символьний номер контракту';
comment on column cim_contracts.open_date    is 'Дата відкриття';
comment on column cim_contracts.close_date   is 'Дата закриття ';
comment on column cim_contracts.s            is 'Сума контракту';
comment on column cim_contracts.kv           is 'Валюта контракту';
comment on column cim_contracts.benef_id     is 'Код клієнта-неризидента';
comment on column cim_contracts.status_id    is 'Статус контракту';
comment on column cim_contracts.comments     is 'Деталі контракту';
comment on column cim_contracts.branch       is 'Номер відділеня'; 
comment on column cim_contracts.owner_uid    is 'Id користувача, за яким закріплено контракт';  
comment on column cim_contracts.subnum       is 'Субномер контракту';

begin
    execute immediate 'insert into cim_contracts (contr_id, contr_type, rnk, okpo, num, open_date, kv, benef_id, status_id, comments)
  values (0, 3, (select min(rnk) from customer), 0, '' '', sysdate, 980, null, 0,  
          ''Технічний контракт. Використовується для фіктивної прив`язки платежів, які не відносяться до жодного контракту'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table cim_contracts add bank_change varchar2(300)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column cim_contracts.bank_change is 'Інформація про перехід з іншого банку';


grant select on cim_contracts to bars_access_defrole;

grant select,update,delete,insert on cim_contracts to cim_role;


show errors;