PROMPT ==================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/DEPOSIT_REPLENISHMENT.sql === *** Run *** ===
PROMPT ==================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_REPLENISHMENT ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_REPLENISHMENT', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_REPLENISHMENT', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_REPLENISHMENT', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_REPLENISHMENT ***

begin 
  execute immediate '
    create table deposit_replenishment  (
       id                   number,
       interest_option_id   number,
       currency_id          number,
       interest_rate        number,
       is_replenishment     number default 1 check( is_replenishment in (0, 1))
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  deposit_replenishment                    is '% ставки при поповненні депозиту';
comment on column deposit_replenishment.id                 is 'ідентифікатор';
comment on column deposit_replenishment.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_replenishment.currency_id        is 'ідентифікатор валюти';
comment on column deposit_replenishment.interest_rate      is '% ставка';

PROMPT *** ALTER_POLICIES to DEPOSIT_REPLENISHMENT ***

exec bpa.alter_policies('DEPOSIT_REPLENISHMENT');

PROMPT *** Create  constraint PK_DEPOSIT_REPLENISHMENT ***
begin   
 execute immediate '
    alter table deposit_replenishment add constraint pk_deposit_replenishment
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_DPT_REPLENISHMENT_IO_ID ***
begin   
 execute immediate '
    create index idx_dpt_replenishment_io_id on deposit_replenishment(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_DPT_REPLENISHMENT_CURR_ID ***
begin   
 execute immediate '
    create index idx_dpt_replenishment_curr_id on deposit_replenishment(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_DPT_REPLENISHMENT ***
begin   
 execute immediate '
    create unique index ui_dpt_replenishment on deposit_replenishment(interest_option_id, currency_id, is_replenishment) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DPT_REPLENISHMENT_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_replenishment modify (id constraint cc_dpt_replenishment_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_REPLENISHMENT_IO_ID_NN ***
begin   
 execute immediate '
    alter table deposit_replenishment modify (interest_option_id constraint cc_dpt_replenishment_io_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_REPLENISHMENT_CURR_NN ***
begin   
 execute immediate '
    alter table deposit_replenishment modify (currency_id constraint cc_dpt_replenishment_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_REPLENISHMENT_IREST_NN ***
begin   
 execute immediate '
    alter table deposit_replenishment modify (interest_rate constraint cc_dpt_replenishment_irest_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  grants  DEPOSIT_REPLENISHMENT ***
grant SELECT  on DEPOSIT_REPLENISHMENT  to BARSREADER_ROLE;
grant select  on DEPOSIT_REPLENISHMENT  to BARS_ACCESS_DEFROLE;

PROMPT ==================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/DEPOSIT_REPLENISHMENT.sql === *** End *** ===
PROMPT ==================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off