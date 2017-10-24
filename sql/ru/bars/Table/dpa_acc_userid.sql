exec bpa.alter_policy_info('dpa_acc_userid', 'filial',  null, null, null, null);
exec bpa.alter_policy_info('dpa_acc_userid', 'whole',  null,  null, null, null);

begin
    execute immediate 'drop table dpa_acc_userid';
 exception when others then 
    if sqlcode = -942 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create table dpa_acc_userid
(
  mfo      varchar2(12 byte),
  okpo     varchar2(14 byte),
  rt       varchar2(1 byte),
  ot       varchar2(1 byte),
  odat     date,
  nls      varchar2(40 byte),
  kv       number(6),
  c_ag     varchar2(1 byte),
  nmk      varchar2(70 byte),
  adr      varchar2(80 byte),
  c_reg    number(2),
  c_dst    number(2),
  bic      varchar2(40 byte),
  country  number(3),
  ref      number,
  userid   number   
) tablespace brsmdld';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table dpa_acc_userid add ref number';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

                                 
comment on table dpa_acc_userid is 'Временная таблица для формирования @F';
grant insert on dpa_acc_userid to bars_access_defrole;

grant insert on dpa_acc_userid to rpbn002;
