PROMPT ===================================================================
PROMPT *** Run ** = Scripts /Sql/BARS/Table/REGISTER_LOG.sql = *** Run * =
PROMPT ===================================================================


PROMPT *** ALTER_POLICY_INFO to REGISTER_LOG ***

set define on
define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI


BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('REGISTER_LOG', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_LOG', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('REGISTER_LOG', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table REGISTER_LOG ***
begin 
  execute immediate '
    create table register_log(
         id                   number not null
        ,operation_type       varchar2(1)
        ,register_value_id    number not null
        ,register_type_id     number
        ,object_id            number
        ,register_history_id  number
        ,plan_value           number
        ,actual_value         number
        ,currency_id          number
        ,value_date           date
        ,amount               number
        ,is_active            varchar2(1)
        ,is_planned           varchar2(1)
        ,document_id          number
        ,local_bank_date      date    -- 
        ,global_bank_date     date    -- glb_bankdate
        ,user_id              number
        ,sys_time             date default sysdate
  ) tablespace &tbl_Spce_';
 exception when others then
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** add column document_id ***
begin 
  execute immediate 'alter table register_log add document_id number';
exception when others then       
  if sqlcode=-1430 then null; else raise; end if; 
end; 
/

comment on table  register_log                            is 'історія зміни умов по депозитним довідникам';
comment on column register_log.id                         is 'ідентифікатор';
comment on column register_log.operation_type             is 'тип опреації I - insert, U - update';
comment on column register_log.register_value_id          is 'ідентифікатор регістрових значень (register_value)';
comment on column register_log.register_type_id           is 'ідентифікатор типу регистрів';
comment on column register_log.object_id                  is 'ідентифікатор об''єкту';
comment on column register_log.register_history_id        is 'ідентифікатор історії регістрів (register_history) ';
comment on column register_log.plan_value                 is 'планове значення';
comment on column register_log.actual_value               is 'актуальне значення';
comment on column register_log.currency_id                is 'валюта';
comment on column register_log.value_date                 is 'дата з якої дїє значення';
comment on column register_log.amount                     is 'значення';
comment on column register_log.is_active                  is 'статус Y/N';
comment on column register_log.is_planned                 is 'плановое значение Y/N';
comment on column register_log.document_id                is 'референс документа';
comment on column register_log.local_bank_date            is 'локальна банківська дата - coalesce(gl.bd, glb_bankdate)';
comment on column register_log.global_bank_date           is 'глобальна банківська дата - glb_bankdate);';
comment on column register_log.user_id                    is 'користувач';
comment on column register_log.sys_time                   is 'дата зміни';


PROMPT *** ALTER_POLICIES to REGISTER_LOG ***

exec bpa.alter_policies('REGISTER_LOG');

PROMPT *** Create  constraint PK_REGISTER_LOG ***
begin   
 execute immediate '
alter table register_log
   add constraint pk_register_log primary key (id)
      using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_REGISTER_LOG_VALUE ***
begin   
 execute immediate '
    create index idx_register_log_value on register_log(register_value_id, register_history_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_REGISTER_LOG_HISTORY ***
begin   
 execute immediate '
    create index idx_register_log_history on register_log(register_history_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  grants  REGISTER_LOG ***
grant SELECT  on REGISTER_LOG  to BARSREADER_ROLE;
grant select  on REGISTER_LOG  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================
PROMPT *** End ** = Scripts /Sql/BARS/Table/REGISTER_LOG.sql = *** End * =
PROMPT ===================================================================

undef tbl_Spce_
undef tbl_Spce_idx
set define off
