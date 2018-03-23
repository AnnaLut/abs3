begin 
  execute immediate 'alter table CUSTOMER_IMAGES add constraint FK_CUSTOMERIMGS_RNK foreign key (RNK) references CUSTOMER (RNK) novalidate';
exception 
  when others then 
    if sqlcode = -2275
    then null;
    else raise;
    end if;
end;
/