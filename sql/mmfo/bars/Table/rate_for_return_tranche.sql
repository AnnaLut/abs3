
PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/RATE_FOR_RETURN_TRANCHE.sql == *** Run *** ===
PROMPT ===================================================================================== 

set define on

PROMPT *** ALTER_POLICY_INFO to RATE_FOR_RETURN_TRANCHE ***

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('RATE_FOR_RETURN_TRANCHE', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('RATE_FOR_RETURN_TRANCHE', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('RATE_FOR_RETURN_TRANCHE', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

PROMPT *** Create  table RATE_FOR_RETURN_TRANCHE ***

begin 
  execute immediate '
      create table rate_for_return_tranche  (
         id                   number,
         interest_option_id   number,
         currency_id          number,
         rate_from            number,
         penalty_rate         number
      )tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table rate_for_return_tranche                     is 'Процентні ставки при достроковому поверненні траншу';
comment on column rate_for_return_tranche.id                 is 'ідентифікатор';
comment on column rate_for_return_tranche.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column rate_for_return_tranche.currency_id        is 'ідентифікатор валюти';
comment on column rate_for_return_tranche.rate_from          is 'відсоток строку траншу від дати розміщення траншу';
comment on column rate_for_return_tranche.penalty_rate       is 'штрафна % ставка';

PROMPT *** ALTER_POLICIES to RATE_FOR_RETURN_TRANCHE ***

exec bpa.alter_policies('RATE_FOR_RETURN_TRANCHE');

PROMPT *** Create  constraint PK_RATE_FOR_RETURN_TRANCHE ***
begin   
 execute immediate '
    alter table rate_for_return_tranche add constraint pk_rate_for_return_tranche
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_RATE_FOR_RET_TRANCHE_IO_ID ***
begin   
 execute immediate '
    create index idx_rate_for_ret_tranche_io_id on rate_for_return_tranche(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_RATE_FOR_RET_TRANCHE_CURR ***
begin   
 execute immediate '
    create index idx_rate_for_ret_tranche_curr on rate_for_return_tranche(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index UI_RATE_FOR_RETURN_TRANCHE ***
begin   
 execute immediate '
    create unique index ui_rate_for_return_tranche on rate_for_return_tranche(interest_option_id, currency_id, rate_from) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_RATE_FOR_RET_TRANCHE_ID_NN ***
begin   
 execute immediate '            
    alter table rate_for_return_tranche modify (id constraint cc_rate_for_ret_tranche_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_RATE_FOR_RET_TRNCH_IO_ID_NN ***
begin   
 execute immediate '            
    alter table rate_for_return_tranche modify (interest_option_id constraint cc_rate_for_ret_trnch_io_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_RATE_FOR_RET_TRNCH_CURR_NN ***
begin   
 execute immediate '            
    alter table rate_for_return_tranche modify (currency_id constraint cc_rate_for_ret_trnch_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  constraint CC_RATE_FOR_RET_TRNCH_RATE_NN ***
begin   
 execute immediate '            
    alter table rate_for_return_tranche modify (rate_from constraint cc_rate_for_ret_trnch_rate_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_RATE_FOR_RET_TRNCH_PRATE_NN ***
begin   
 execute immediate '            
    alter table rate_for_return_tranche modify (penalty_rate constraint cc_rate_for_ret_trnch_prate_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/



PROMPT *** Create  grants  RATE_FOR_RETURN_TRANCHE ***
grant SELECT  on RATE_FOR_RETURN_TRANCHE  to BARSREADER_ROLE;
grant select  on RATE_FOR_RETURN_TRANCHE  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/RATE_FOR_RETURN_TRANCHE.sql == *** End *** ===
PROMPT ===================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off