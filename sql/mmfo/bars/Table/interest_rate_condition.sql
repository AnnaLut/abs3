
PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/INTEREST_RATE_CONDITION.sql == *** Run *** ===
PROMPT ===================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to INTEREST_RATE_CONDITION ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('INTEREST_RATE_CONDITION', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('INTEREST_RATE_CONDITION', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('INTEREST_RATE_CONDITION', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table INTEREST_RATE_CONDITION ***

begin 
  execute immediate '
    create table interest_rate_condition(
        id                          number,
        interest_option_id          number,
        currency_id                 number,
        term_unit                   number,
        term_from                   number,
        amount_from                 number,
        interest_rate               number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  interest_rate_condition                    is 'Процентні ставки для строкових траншів Базові / Акційні';
comment on column interest_rate_condition.id                 is 'ідентифікатор';
comment on column interest_rate_condition.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column interest_rate_condition.currency_id        is 'ідентифікатор валюти';
comment on column interest_rate_condition.term_unit          is 'одиниця виміру терміну дії, на данний момент - день (1)';
comment on column interest_rate_condition.term_from          is 'термін дії від - в днях';
comment on column interest_rate_condition.amount_from        is 'сумма від';
comment on column interest_rate_condition.interest_rate      is '% ставка';

PROMPT *** ALTER_POLICIES to interest_rate_condition ***

exec bpa.alter_policies('INTEREST_RATE_CONDITION');

PROMPT *** Create  constraint PK_INTEREST_RATE_CONDITION ***
begin   
 execute immediate '
    alter table interest_rate_condition add constraint pk_interest_rate_condition
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_INTEREST_RATE_COND_IO_ID ***
begin   
 execute immediate '
    create index idx_interest_rate_cond_io_id on interest_rate_condition(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_INTEREST_RATE_COND_CURR ***
begin   
 execute immediate '
    create index idx_interest_rate_cond_curr on interest_rate_condition(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_INTEREST_RATE_CONDITION ***
begin   
 execute immediate '
    create unique index ui_interest_rate_condition on interest_rate_condition(interest_option_id, currency_id, term_unit, term_from, amount_from) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_INTEREST_RATE_COND_ID_NN ***
begin   
 execute immediate '            
    alter table interest_rate_condition modify (id constraint cc_interest_rate_cond_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_INTEREST_RATE_COND_IO_ID_NN ***
begin   
 execute immediate '
    alter table interest_rate_condition modify (interest_option_id constraint cc_interest_rate_cond_do_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_INTEREST_RATE_COND_CURR_NN ***
begin   
 execute immediate ' 
    alter table interest_rate_condition modify (currency_id constraint cc_interest_rate_cond_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_INTEREST_RATE_COND_IRATE_NN ***
begin   
 execute immediate ' 
    alter table interest_rate_condition modify (interest_rate constraint cc_interest_rate_cond_irate_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_INTEREST_RATE_COND_TUNIT_NN ***
begin   
 execute immediate ' 
    alter table interest_rate_condition modify (term_unit constraint cc_interest_rate_cond_tunit_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_INTEREST_RATE_COND_TFROM_NN ***
begin   
 execute immediate ' 
    alter table interest_rate_condition modify (term_from constraint cc_interest_rate_cond_tfrom_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_INTEREST_RATE_COND_AFROM_NN ***
begin   
 execute immediate ' 
    alter table interest_rate_condition modify (amount_from constraint cc_interest_rate_cond_afrom_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/



PROMPT *** Create  grants  INTEREST_RATE_CONDITION ***
grant SELECT  on INTEREST_RATE_CONDITION  to BARSREADER_ROLE;
grant select  on INTEREST_RATE_CONDITION  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/INTEREST_RATE_CONDITION.sql == *** End *** ===
PROMPT ===================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off