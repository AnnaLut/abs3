
PROMPT =======================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/Table/REGISTER_VALUE.sql = *** Run *** =
PROMPT =======================================================================


PROMPT *** ALTER_POLICY_INFO to REGISTER_VALUE ***

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('REGISTER_VALUE', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_VALUE', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_VALUE', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table REGISTER_VALUE ***
begin 
  execute immediate '
    create table register_value  (
       id                   number(38)     not null,
       object_id            number(38)     not null,
       register_type_id     number(38)     not null,
       plan_value           number         not null,
       actual_value         number         not null,
       currency_id          number(3)      not null
    ) tablespace brsbigd';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** ALTER_POLICIES to REGISTER_VALUE ***

exec bpa.alter_policies('REGISTER_VALUE');

comment on table register_value is 'значения регистров';
comment on column register_value.id is 'уникальный ключ';
comment on column register_value.object_id is 'объекта';
comment on column register_value.register_type_id is 'тип регистра';
comment on column register_value.plan_value is 'плановое значение';
comment on column register_value.actual_value is 'реальное значение';
comment on column register_value.currency_id is 'валюта регистра';

PROMPT *** Create  constraint PK_REGISTER_VALUE ***
begin   
 execute immediate '
alter table register_value
   add constraint pk_register_value primary key (id)
      using index tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index UI_REGISTER_VALUE_OBJ ***
begin   
 execute immediate '
create unique index ui_register_value_obj on register_value(object_id, register_type_id)
      tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_REGISTER_VALUE_TYPE ***
begin   
 execute immediate '
create index ui_register_value_type on register_value(register_type_id)
      tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  grants  REGISTER_VALUE ***
grant SELECT  on REGISTER_VALUE  to BARSREADER_ROLE;
grant select  on REGISTER_VALUE  to BARS_ACCESS_DEFROLE;

PROMPT =======================================================================
PROMPT *** End *** = Scripts /Sql/BARS/Table/REGISTER_VALUE.sql = *** End *** =
PROMPT =======================================================================
