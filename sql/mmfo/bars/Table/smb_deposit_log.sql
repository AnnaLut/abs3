PROMPT ======================================================================
PROMPT *** Run ** = Scripts /Sql/BARS/Table/SMB_DEPOSIT_LOG.sql = *** Run * =
PROMPT ======================================================================


PROMPT *** ALTER_POLICY_INFO to SMB_DEPOSIT_LOG ***

set define on
define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI


BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('SMB_DEPOSIT_LOG', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('SMB_DEPOSIT_LOG', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('SMB_DEPOSIT_LOG', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table SMB_DEPOSIT_LOG ***
begin 
  execute immediate '
    create table smb_deposit_log(
           id               number not null primary key
          ,object_id        number not null
          ,process_id       number not null
          ,operation_type   varchar2(1)
          ,process_data     clob
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

comment on table  smb_deposit_log                            is 'історія зміни по депозитнам ММСБ';
comment on column smb_deposit_log.id                         is 'ідентифікатор';
comment on column smb_deposit_log.object_id                  is 'ідентифікатор депозиту (ref object) ';
comment on column smb_deposit_log.process_id                 is 'ідентифікатор процесу (ref process)';
comment on column smb_deposit_log.operation_type             is 'тип опреації I - insert, U - update';
comment on column smb_deposit_log.process_data               is 'зміни в xml';
comment on column smb_deposit_log.local_bank_date            is 'локальна банківська дата - coalesce(gl.bd, glb_bankdate)';
comment on column smb_deposit_log.global_bank_date           is 'глобальна банківська дата - glb_bankdate);';
comment on column smb_deposit_log.user_id                    is 'користувач';
comment on column smb_deposit_log.sys_time                   is 'дата зміни';


PROMPT *** ALTER_POLICIES to SMB_DEPOSIT_LOG ***

exec bpa.alter_policies('SMB_DEPOSIT_LOG');

PROMPT *** Create  constraint PK_SMB_DEPOSIT_LOG ***
begin   
 execute immediate '
alter table smb_deposit_log
   add constraint pk_smb_deposit_log primary key (id)
      using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_SMB_DEPOSITT_LOG_OBJ_PROC ***
begin   
 execute immediate '
    create index idx_smb_depositt_log_obj_proc on smb_deposit_log(object_id, process_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_SMB_DEPOSITT_LOG_PROC ***
begin   
 execute immediate '
    create index idx_smb_depositt_log_proc on smb_deposit_log(process_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  grants  SMB_DEPOSIT_LOG ***
grant SELECT  on SMB_DEPOSIT_LOG  to BARSREADER_ROLE;
grant select  on SMB_DEPOSIT_LOG  to BARS_ACCESS_DEFROLE;

PROMPT ================================================================================
PROMPT *** End ** = Scripts /Sql/BARS/Table/SMB_DEPOSIT_LOG.sql = *** End * =
PROMPT ================================================================================

undef tbl_Spce_
undef tbl_Spce_idx
set define off