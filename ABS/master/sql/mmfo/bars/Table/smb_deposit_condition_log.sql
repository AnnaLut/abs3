
PROMPT ================================================================================
PROMPT *** Run ** = Scripts /Sql/BARS/Table/SMB_DEPOSIT_CONDITION_LOG.sql = *** Run * =
PROMPT ================================================================================


PROMPT *** ALTER_POLICY_INFO to SMB_DEPOSIT_CONDITION_LOG ***

set define on
define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI


BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('SMB_DEPOSIT_CONDITION_LOG', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('SMB_DEPOSIT_CONDITION_LOG', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('SMB_DEPOSIT_CONDITION_LOG', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table SMB_DEPOSIT_CONDITION_LOG ***
begin 
  execute immediate '
    create table smb_deposit_condition_log(
         id               number not null
        ,rate_kind_id     number not null
        ,option_id        number not null
        ,condition_id     number
        ,operation_type   varchar2(1)
        ,condition_data   varchar2(4000)
        ,local_bank_date  date    -- 
        ,global_bank_date date    -- glb_bankdate
        ,user_id          number
        ,sys_time         date default sysdate
  ) tablespace &tbl_Spce_';
 exception when others then
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  smb_deposit_condition_log                            is 'історія зміни умов по депозитним довідникам';
comment on column smb_deposit_condition_log.id                         is 'ідентифікатор';
comment on column smb_deposit_condition_log.rate_kind_id               is 'ідентифікатор виду ';
comment on column smb_deposit_condition_log.option_id                  is 'ідентифікатор значення (interest_option_id)';
comment on column smb_deposit_condition_log.condition_id               is 'ідентифікатор значення кожного довідника (id)';
comment on column smb_deposit_condition_log.operation_type             is 'тип опреації I - insert, U - update';
comment on column smb_deposit_condition_log.condition_data             is 'зміни в xml';
comment on column smb_deposit_condition_log.local_bank_date            is 'локальна банківська дата - coalesce(gl.bd, glb_bankdate)';
comment on column smb_deposit_condition_log.global_bank_date           is 'глобальна банківська дата - glb_bankdate);';
comment on column smb_deposit_condition_log.user_id                    is 'користувач';
comment on column smb_deposit_condition_log.sys_time                   is 'дата зміни';


PROMPT *** ALTER_POLICIES to SMB_DEPOSIT_CONDITION_LOG ***

exec bpa.alter_policies('SMB_DEPOSIT_CONDITION_LOG');

PROMPT *** Create  constraint PK_SMB_DEPOSIT_CONDITION_LOG ***
begin   
 execute immediate '
alter table smb_deposit_condition_log
   add constraint pk_smb_deposit_condition_log primary key (id)
      using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_SMB_DPT_CONDITION_LOG_KIND ***
begin   
 execute immediate '
    create index idx_smb_dpt_condition_log_kind on smb_deposit_condition_log(rate_kind_id, option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_SMB_DPT_CONDITION_LOG_COND ***
begin   
 execute immediate '
    create index idx_smb_dpt_condition_log_cond on smb_deposit_condition_log(condition_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  grants  SMB_DEPOSIT_CONDITION_LOG ***
grant SELECT  on SMB_DEPOSIT_CONDITION_LOG  to BARSREADER_ROLE;
grant select  on SMB_DEPOSIT_CONDITION_LOG  to BARS_ACCESS_DEFROLE;

PROMPT ================================================================================
PROMPT *** End ** = Scripts /Sql/BARS/Table/SMB_DEPOSIT_CONDITION_LOG.sql = *** End * =
PROMPT ================================================================================

undef tbl_Spce_
undef tbl_Spce_idx
set define off