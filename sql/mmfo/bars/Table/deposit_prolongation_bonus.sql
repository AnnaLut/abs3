PROMPT ===================================================================================== 
PROMPT *** Run *** = Scripts /Sql/BARS/Table/DEPOSIT_PROLONGATION_BONUS.sql == *** Run *** =
PROMPT ===================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_PROLONGATION_BONUS ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_PROLONGATION_BONUS', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_PROLONGATION_BONUS', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_PROLONGATION_BONUS', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_PROLONGATION_BONUS ***

begin 
  execute immediate '
    create table deposit_prolongation_bonus  (
       id                   number not null,
       interest_option_id   number not null,
       currency_id          number not null,
       is_prolongation      number default 1 not null check( is_prolongation in (0, 1)) ,
       interest_rate        number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  deposit_prolongation_bonus                    is '% ставки при пролангації депозиту';
comment on column deposit_prolongation_bonus.id                 is 'ідентифікатор';
comment on column deposit_prolongation_bonus.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_prolongation_bonus.currency_id        is 'ідентифікатор валюти';
comment on column deposit_prolongation_bonus.is_prolongation    is 'пролонгація 1 - так, 0 - ні';
comment on column deposit_prolongation_bonus.interest_rate      is '% ставка';


PROMPT *** ALTER_POLICIES to DEPOSIT_PROLONGATION_BONUS ***

exec bpa.alter_policies('DEPOSIT_PROLONGATION_BONUS');

PROMPT *** Create  constraint PK_DEPOSIT_PROLONGATION_BONUS ***
begin   
 execute immediate '
    alter table deposit_prolongation_bonus add constraint pk_deposit_prolongation_bonus
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_DPT_PRL_BONUS_OPTION ***
begin   
 execute immediate '
    create index idx_dpt_prl_bonus_option on deposit_prolongation_bonus(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_DPT_PRL_BONUS_CURRENCY ***
begin   
 execute immediate '
    create index idx_dpt_prl_bonus_currency on deposit_prolongation_bonus(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_DEPOSIT_PROLONGATION_BONUS ***
begin   
 execute immediate '
    create unique index ui_deposit_prolongation_bonus on deposit_prolongation_bonus(interest_option_id, currency_id, is_prolongation) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  grants  DEPOSIT_PROLONGATION_BONUS ***
grant SELECT  on DEPOSIT_PROLONGATION_BONUS  to BARSREADER_ROLE;
grant select  on DEPOSIT_PROLONGATION_BONUS  to BARS_ACCESS_DEFROLE;

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off

PROMPT ===================================================================================== 
PROMPT *** End *** = Scripts /Sql/BARS/Table/DEPOSIT_PROLONGATION_BONUS.sql == *** End *** =
PROMPT ===================================================================================== 