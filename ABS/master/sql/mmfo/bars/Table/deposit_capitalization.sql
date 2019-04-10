
PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/DEPOSIT_CAPITALIZATION.sql === *** Run *** ===
PROMPT ===================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_CAPITALIZATION ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_CAPITALIZATION', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_CAPITALIZATION', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_CAPITALIZATION', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_CAPITALIZATION ***

begin 
  execute immediate '
    create table deposit_capitalization  (
       id                   number,
       interest_option_id   number,
       payment_term_id      number,
       currency_id          number,
       interest_rate        number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  deposit_capitalization                    is '% ставки при капіталізації депозиту';
comment on column deposit_capitalization.id                 is 'ідентифікатор';
comment on column deposit_capitalization.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_capitalization.currency_id        is 'ідентифікатор валюти';
comment on column deposit_capitalization.payment_term_id    is 'період капіталізації 1 - щомісяця; 2 - щоквартально';
comment on column deposit_capitalization.interest_rate      is '% ставка';


PROMPT *** ALTER_POLICIES to DEPOSIT_CAPITALIZATION ***

exec bpa.alter_policies('DEPOSIT_CAPITALIZATION');

PROMPT *** Create  constraint PK_DEPOSIT_CAPITALIZATION ***
begin   
 execute immediate '
    alter table deposit_capitalization add constraint pk_deposit_capitalization
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_DPT_CAPITALIZATION_IO_ID ***
begin   
 execute immediate '
    create index idx_dpt_capitalization_io_id on deposit_capitalization(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_DPT_CAPITALIZATION_CURR_ID ***
begin   
 execute immediate '
    create index idx_dpt_capitalization_curr_id on deposit_capitalization(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_DPT_CAPITALIZATION ***
begin   
 execute immediate '
    create unique index ui_dpt_capitalization on deposit_capitalization(interest_option_id, currency_id, payment_term_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DPT_CAPITALIZATION_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_capitalization modify (id constraint cc_dpt_capitalization_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_CAPITALIZATION_IO_ID_NN ***
begin   
 execute immediate '
    alter table deposit_capitalization modify (interest_option_id constraint cc_dpt_capitalization_io_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_CAPITALIZATION_CURR_NN ***
begin   
 execute immediate '
    alter table deposit_capitalization modify (currency_id constraint cc_dpt_capitalization_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_CAPITALIZATION_IREST_NN ***
begin   
 execute immediate '
    alter table deposit_capitalization modify (interest_rate constraint cc_dpt_capitalization_irest_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_CAPITALIZATION_PTERM_NN ***
begin   
 execute immediate '
    alter table deposit_capitalization modify (payment_term_id constraint cc_dpt_capitalization_pterm_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_CAPITALIZATION_PTERM_ ***
begin
 execute immediate '
    alter table deposit_capitalization add constraint cc_dpt_capitalization_pterm_ check(payment_term_id in (1, 2))';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  grants  DEPOSIT_CAPITALIZATION ***
grant SELECT  on DEPOSIT_CAPITALIZATION  to BARSREADER_ROLE;
grant select  on DEPOSIT_CAPITALIZATION  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/DEPOSIT_CAPITALIZATION.sql === *** End *** ===
PROMPT ===================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off