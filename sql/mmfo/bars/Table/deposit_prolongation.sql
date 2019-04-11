
PROMPT ===================================================================================== 
PROMPT *** Run *** ==== Scripts /Sql/BARS/Table/DEPOSIT_PROLONGATION.sql === *** Run *** ===
PROMPT ===================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_PROLONGATION ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_PROLONGATION', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_PROLONGATION', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_PROLONGATION', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_PROLONGATION ***

begin 
  execute immediate '
    create table deposit_prolongation  (
       id                   number,
       interest_option_id   number,
       currency_id          number,
       amount_from          number,
       interest_rate        number,
       apply_to_first       number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table deposit_prolongation                     is '% ставки при пролангації депозиту';
comment on column deposit_prolongation.id                 is 'ідентифікатор';
comment on column deposit_prolongation.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_prolongation.currency_id        is 'ідентифікатор валюти';
comment on column deposit_prolongation.amount_from        is 'сумма від';
comment on column deposit_prolongation.interest_rate      is '% ставка';
comment on column deposit_prolongation.apply_to_first     is 'до якой пролонгації застосовується % ставка 1 - до першої, 2 - до кожної';


PROMPT *** ALTER_POLICIES to DEPOSIT_PROLONGATION ***

exec bpa.alter_policies('DEPOSIT_PROLONGATION');

PROMPT *** Create  constraint PK_DEPOSIT_PROLONGATION ***
begin   
 execute immediate '
    alter table deposit_prolongation add constraint pk_deposit_prolongation
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_DEPOSIT_PROLONGATION_IO_ID ***
begin   
 execute immediate '
    create index idx_deposit_prolongation_io_id on deposit_prolongation(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_DEPOSIT_PROLONGATION_CURR ***
begin   
 execute immediate '
    create index idx_deposit_prolongation_curr on deposit_prolongation(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_DPT_PROLONGATION ***
begin   
 execute immediate '
    create unique index ui_dpt_prolongation on deposit_prolongation(interest_option_id, currency_id, amount_from) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_PROLONGATION_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_prolongation modify (id constraint cc_deposit_prolongation_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_PROLONGATION_CURR_NN ***
begin   
 execute immediate '            
    alter table deposit_prolongation modify (currency_id constraint cc_dpt_prolongation_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_PROLONGATION_IO_ID_NN ***
begin   
 execute immediate '
    alter table deposit_prolongation modify (interest_option_id constraint cc_dpt_prolongation_io_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_PROLONGATION_AFROM_NN ***
begin   
 execute immediate '
    alter table deposit_prolongation modify (amount_from constraint cc_dpt_prolongation_afrom_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_PROLONGATION_IREST_NN ***
begin   
 execute immediate '
    alter table deposit_prolongation modify (interest_rate constraint cc_dpt_prolongation_irest_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DPT_PROLONGATION_AFIRST_NN ***
begin   
 execute immediate '
    alter table deposit_prolongation modify (apply_to_first constraint cc_dpt_prolongation_afirst_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  constraint CC_DPT_PROLONGATION_AFIRST ***
begin   
 execute immediate '
    alter table deposit_prolongation add constraint cc_dpt_prolongation_afirst
                check(apply_to_first in (1, 2))';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  grants  DEPOSIT_PROLONGATION ***
grant SELECT  on DEPOSIT_PROLONGATION  to BARSREADER_ROLE;
grant select  on DEPOSIT_PROLONGATION  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ==== Scripts /Sql/BARS/Table/DEPOSIT_PROLONGATION.sql === *** End *** ===
PROMPT ===================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx
set define off