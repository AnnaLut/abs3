
PROMPT =======================================================================
PROMPT *** Run ** = Scripts /Sql/BARS/Table/REGISTER_HISTORY.sql = *** Run * =
PROMPT =======================================================================


PROMPT *** ALTER_POLICY_INFO to REGISTER_HISTORY ***

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('REGISTER_HISTORY', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_HISTORY', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_HISTORY', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table REGISTER_HISTORY ***
begin 
  execute immediate '
    create table register_history  (
       id                   number(38)      not null,
       register_value_id    number(38)      not null,
       value_date           date            not null,
       amount               number          not null,
       is_active            varchar2(1)     not null,
       is_planned           varchar2(1)     not null,
       document_id          number,
       sys_time             date            default sysdate not null
    ) tablespace brsbigd';
 exception when others then
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** ALTER_POLICIES to REGISTER_HISTORY ***

exec bpa.alter_policies('REGISTER_HISTORY');


PROMPT *** add column document_id ***
begin 
  execute immediate 'alter table register_history add document_id number';
exception when others then       
  if sqlcode=-1430 then null; else raise; end if; 
end; 
/

comment on table register_history is 'история значений регистров';
comment on column register_history.id is 'уникальный ключ';
comment on column register_history.register_value_id is 'ссылка на значение регистр';
comment on column register_history.value_date is 'дата действия';
comment on column register_history.amount is 'установленная сумма';
comment on column register_history.is_active is 'статус в истории';
comment on column register_history.is_planned is 'плановое значение - если не прошла проводка со счета для списания на депозитный счет';
comment on column register_history.document_id is 'референс документа';
comment on column register_history.sys_time is 'дата и время установки значения';


PROMPT *** Create  constraint PK_REGISTER_HISTORY ***
begin   
 execute immediate '
alter table register_history
   add constraint pk_register_history primary key (id)
      using index tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_REGISTER_HISTORY_REG_ID ***
begin   
 execute immediate '
create index idx_register_history_reg_id on register_history(register_value_id)
      tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_REGISTER_HISTORY_DATE ***
begin   
 execute immediate '
create index idx_register_history_date on register_history(value_date)
      tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_REGISTER_HISTORY_ACTIVE ***
begin   
 execute immediate q'[
alter table register_history
   add constraint cc_register_history_active check(is_active in ('Y', 'N'))]';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_REGISTER_HISTORY_IS_PLANNED ***
begin   
 execute immediate q'[
alter table register_history
   add constraint cc_register_history_planned check(is_planned in ('Y', 'N'))]';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_REGISTER_HISTORY_DOC_ID ***
begin   
 execute immediate '
create index idx_register_history_doc_id on register_history(document_id)
      tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/



PROMPT *** Create  grants  REGISTER_HISTORY ***
grant SELECT  on REGISTER_HISTORY  to BARSREADER_ROLE;
grant select  on REGISTER_HISTORY  to BARS_ACCESS_DEFROLE;

PROMPT =======================================================================
PROMPT *** End ** = Scripts /Sql/BARS/Table/REGISTER_HISTORY.sql = *** End * =
PROMPT =======================================================================
