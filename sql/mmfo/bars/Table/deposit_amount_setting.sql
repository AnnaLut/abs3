
PROMPT ===================================================================================== 
PROMPT *** Run *** === Scripts /Sql/BARS/Table/DEPOSIT_AMOUNT_SETTING.sql == *** Run *** ===
PROMPT ===================================================================================== 

set define on

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_AMOUNT_SETTING ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_AMOUNT_SETTING', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_AMOUNT_SETTING', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_AMOUNT_SETTING', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_AMOUNT_SETTING ***
begin 
  execute immediate '
    create table deposit_amount_setting  (
       id                       number,
       interest_option_id       number,
       currency_id              number,
       min_sum_tranche          number,
       max_sum_tranche          number,
       min_replenishment_amount number,
       max_replenishment_amount number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  deposit_amount_setting                          is 'суми траншів';
comment on column deposit_amount_setting.id                       is 'ідентифікатор';
comment on column deposit_amount_setting.interest_option_id       is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_amount_setting.currency_id              is 'ідентифікатор валюти';
comment on column deposit_amount_setting.min_sum_tranche          is 'мінімальна сума траншу';
comment on column deposit_amount_setting.max_sum_tranche          is 'максимальна сума траншу';
comment on column deposit_amount_setting.min_replenishment_amount is 'мінімальна сума поповнення траншу';
comment on column deposit_amount_setting.max_replenishment_amount is 'максимальна сума поповнення траншу';


PROMPT *** ALTER_POLICIES to DEPOSIT_AMOUNT_SETTING ***

exec bpa.alter_policies('DEPOSIT_AMOUNT_SETTING');

PROMPT *** Create  constraint PK_DEPOSIT_AMOUNT_SETTING ***
begin   
 execute immediate '
    alter table deposit_amount_setting add constraint pk_deposit_amount_setting
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_DEPOSIT_AMOUNT_SET_CURR ***
begin   
 execute immediate '
    create index idx_deposit_amount_set_curr on deposit_amount_setting(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_DEPOSIT_AMOUNT_SETTING ***
begin   
 execute immediate '
    create unique index ui_deposit_amount_setting on deposit_amount_setting(interest_option_id, currency_id, min_sum_tranche, max_sum_tranche) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_DPT_AMOUNT_SETTING_IO ***
begin   
 execute immediate '
    create index idx_dpt_amount_setting_io on deposit_amount_setting(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SET_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_amount_setting modify (id constraint cc_deposit_amount_set_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SET_IO_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_amount_setting modify (interest_option_id constraint cc_deposit_amount_set_io_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442, -904, -2296) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SET_CURR_NN ***
begin   
 execute immediate '
    alter table deposit_amount_setting modify (currency_id constraint cc_deposit_amount_set_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SET_MISTR_NN ***
begin   
 execute immediate '
    alter table deposit_amount_setting modify (min_sum_tranche constraint cc_deposit_amount_set_mistr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SET_MIRA_NN ***
begin   
 execute immediate '
    alter table deposit_amount_setting modify (min_replenishment_amount constraint cc_deposit_amount_set_mira_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SET_MARA_NN ***
begin   
 execute immediate '
    alter table deposit_amount_setting modify (max_replenishment_amount constraint cc_deposit_amount_set_mara_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SETTING_SUM ***
begin   
 execute immediate '
    alter table deposit_amount_setting modify(
                 constraint cc_deposit_amount_setting_sum 
                check(case when max_sum_tranche is null then 1
                           when min_sum_tranche <= max_sum_tranche then 1
                           else 0
                      end = 1)) ';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_AMOUNT_SET_REPL ***
begin   
 execute immediate '
    alter table deposit_amount_setting add constraint cc_deposit_amount_set_repl
                check(min_replenishment_amount <= max_replenishment_amount)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  grants  DEPOSIT_AMOUNT_SETTING ***
grant SELECT  on DEPOSIT_AMOUNT_SETTING  to BARSREADER_ROLE;
grant select  on DEPOSIT_AMOUNT_SETTING  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** === Scripts /Sql/BARS/Table/DEPOSIT_AMOUNT_SETTING.sql == *** End *** ===
PROMPT ===================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off