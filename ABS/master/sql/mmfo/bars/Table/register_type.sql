
PROMPT =======================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/Table/REGISTER_TYPE.sql = *** Run *** =
PROMPT =======================================================================

PROMPT *** ALTER_POLICY_INFO to REGISTER_TYPE ***


BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('REGISTER_TYPE', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_TYPE', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_TYPE', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table REGISTER_TYPE ***
begin 
  execute immediate '
        create table register_type  (
           id                   number(38)     not null,
           object_type_id       number(38)             ,
           register_code        varchar2(30)   not null,
           register_name        varchar2(4000) not null,
           is_active            varchar2(1)    not null
        ) tablespace brsmdld';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** ALTER_POLICIES to REGISTER_TYPE ***

exec bpa.alter_policies('REGISTER_TYPE');

comment on table register_type is 'Типы регистров';
comment on column register_type.id is 'уникальный ключ';
comment on column register_type.object_type_id is 'тип объекта';
comment on column register_type.register_code is 'код регистра';
comment on column register_type.register_name is 'наименование регистра';
comment on column register_type.is_active is 'статус регистра';

PROMPT *** Create  constraint PK_REGISTER_TYPE ***
begin   
 execute immediate '
alter table register_type
   add constraint pk_register_type primary key (id)
      using index tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index UI_REGISTER_TYPE_CODE ***
begin   
 execute immediate '
create unique index ui_register_type_code on register_type (register_code) 
      tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_REGISTER_TYPE_ACTIVE ***
begin   
 execute immediate q'[
alter table register_type
   add constraint cc_register_type_active check(is_active in ('Y', 'N'))]';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  grants  REGISTER_TYPE ***
grant SELECT  on REGISTER_TYPE  to BARSREADER_ROLE;
grant select  on REGISTER_TYPE  to BARS_ACCESS_DEFROLE;

PROMPT =======================================================================
PROMPT *** End *** = Scripts /Sql/BARS/Table/REGISTER_TYPE.sql = *** End *** =
PROMPT =======================================================================
