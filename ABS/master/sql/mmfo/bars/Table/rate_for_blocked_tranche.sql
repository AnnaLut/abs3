PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/RATE_FOR_BLOCKED_TRANCHE.sql == *** Run *** ==
PROMPT ===================================================================================== 

set define on

PROMPT *** ALTER_POLICY_INFO to RATE_FOR_BLOCKED_TRANCHE ***

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('RATE_FOR_BLOCKED_TRANCHE', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('RATE_FOR_BLOCKED_TRANCHE', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('RATE_FOR_BLOCKED_TRANCHE', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

PROMPT *** Create  table RATE_FOR_BLOCKED_TRANCHE ***

begin 
  execute immediate '
      create table rate_for_blocked_tranche  (
         id                   number not null,
         interest_option_id   number not null,
         currency_id          number not null,
         interest_rate        number
      )tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  rate_for_blocked_tranche                    is 'Процентні ставки для заблокованих траншів срок дії яких закінчився';
comment on column rate_for_blocked_tranche.id                 is 'ідентифікатор';
comment on column rate_for_blocked_tranche.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column rate_for_blocked_tranche.currency_id        is 'ідентифікатор валюти';
comment on column rate_for_blocked_tranche.interest_rate      is '% ставка';

PROMPT *** ALTER_POLICIES to RATE_FOR_BLOCKED_TRANCHE ***
exec bpa.alter_policies('RATE_FOR_BLOCKED_TRANCHE');

PROMPT *** Create  constraint PK_RATE_FOR_BLOCKED_TRANCHE ***
begin   
 execute immediate '
    alter table rate_for_blocked_tranche add constraint pk_rate_for_blocked_tranche
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_RATE_BLOCKED_TRN_OPTION_ID ***
begin   
 execute immediate '
    create index idx_rate_blocked_trn_option_id on rate_for_blocked_tranche(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_RATE_BLOCKED_TRN_CURRENCY ***
begin   
 execute immediate '
    create index idx_rate_blocked_trn_currency on rate_for_blocked_tranche(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_RATE_FOR_BLOCKED_TRANCHE ***
begin   
 execute immediate '
    create unique index ui_rate_for_blocked_tranche on rate_for_blocked_tranche(interest_option_id, currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/


PROMPT *** Create  grants  RATE_FOR_BLOCKED_TRANCHE ***
grant SELECT  on RATE_FOR_BLOCKED_TRANCHE  to BARSREADER_ROLE;
grant select  on RATE_FOR_BLOCKED_TRANCHE  to BARS_ACCESS_DEFROLE;

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/RATE_FOR_BLOCKED_TRANCHE.sql == *** End *** ==
PROMPT ===================================================================================== 