PROMPT ===================================================================================== 
PROMPT *** Run *** = Scripts /Sql/BARS/Table/DEPOSIT_ON_DEMAND_CONDITION.sql = *** Run *** =
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_ON_DEMAND_CONDITION ***
set define on
define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_ON_DEMAND_CONDITION', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_ON_DEMAND_CONDITION', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_ON_DEMAND_CONDITION', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_ON_DEMAND_CONDITION ***

begin 
  execute immediate '
create table deposit_on_demand_condition(
    id                  number
   ,interest_option_id  number 
   ,currency_id         number
   ,amount_from         number
   ,interest_rate       number
   ,user_id             number
   ,sys_time            date   default sysdate
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
     null; 
  else raise; 
  end if;
end;
/

comment on table  deposit_on_demand_condition                    is 'Процентні ставки для вкладу на вимогу';
comment on column deposit_on_demand_condition.id                 is 'ідентифікатор';
comment on column deposit_on_demand_condition.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_on_demand_condition.currency_id        is 'ідентифікатор валюти';
comment on column deposit_on_demand_condition.amount_from        is 'сумма від';
comment on column deposit_on_demand_condition.interest_rate      is '% ставка';
comment on column deposit_on_demand_condition.user_id             is 'користувач';
comment on column deposit_on_demand_condition.sys_time            is 'остання дата зміни';

PROMPT *** ALTER_POLICIES to DEPOSIT_ON_DEMAND_CONDITION ***

exec bpa.alter_policies('DEPOSIT_ON_DEMAND_CONDITION');

PROMPT *** Create  constraint PK_DEPOSIT_ON_DEMAND_CONDITION ***
begin   
 execute immediate '
        alter table deposit_on_demand_condition add constraint pk_deposit_on_demand_condition 
                    primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_ON_DEMAND_COND_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_on_demand_condition modify (id constraint cc_dpt_on_demand_cond_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_ON_DEMAND_COND_AF_NN ***
begin   
 execute immediate '            
    alter table deposit_on_demand_condition modify (amount_from constraint cc_dpt_on_demand_cond_af_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_ON_DEMAND_COND_CURR_NN ***
begin   
 execute immediate '            
    alter table deposit_on_demand_condition modify (currency_id constraint cc_dpt_on_demand_cond_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_ON_DEMAND_COND_IR_NN ***
begin   
 execute immediate '            
    alter table deposit_on_demand_condition modify (interest_rate constraint cc_dpt_on_demand_cond_ir_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_ON_DEMAND_COND_IO_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_on_demand_condition modify (interest_option_id constraint cc_dpt_on_demand_cond_io_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442, -904, -2296) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create unique index UI_DEPOSIT_ON_DEMAND_CONDITION ***
begin   
 execute immediate '
    create unique index ui_deposit_on_demand_condition on 
         deposit_on_demand_condition (interest_option_id, currency_id, amount_from) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-1408, -955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_DPT_ON_DEMAND_CONDITION_IO ***
begin   
 execute immediate '
    create index idx_dpt_on_demand_condition_io on deposit_on_demand_condition(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/


PROMPT *** Create  grants  DEPOSIT_ON_DEMAND_CONDITION ***
grant SELECT    on DEPOSIT_ON_DEMAND_CONDITION  to BARSREADER_ROLE;
grant select    on DEPOSIT_ON_DEMAND_CONDITION  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** = Scripts /Sql/BARS/Table/DEPOSIT_ON_DEMAND_CONDITION.sql = *** End *** =
PROMPT ===================================================================================== 

set define off