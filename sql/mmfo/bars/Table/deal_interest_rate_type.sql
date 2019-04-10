
PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/DEAL_INTEREST_RATE_TYPE.sql == *** Run *** ===
PROMPT ===================================================================================== 

set define on

PROMPT *** ALTER_POLICY_INFO to DEAL_INTEREST_RATE_TYPE ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEAL_INTEREST_RATE_TYPE', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEAL_INTEREST_RATE_TYPE', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEAL_INTEREST_RATE_TYPE', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEAL_INTEREST_RATE_TYPE ***

begin 
  execute immediate '
create table deal_interest_rate_type  (
   id                   number,
   object_type_id       number,
   type_code            varchar2(50),
   type_name            varchar2(200)
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table deal_interest_rate_type is 'типи %% ставок';
comment on column deal_interest_rate_type.id is 'ідентифікатор';
comment on column deal_interest_rate_type.object_type_id is 'тип об''єкту : SMB_DEPOSIT_TRANCHE - Депозитні транші ММСБ; SMB_DEPOSIT_ON_DEMAND - Вклади на вимогу ММСБ';
comment on column deal_interest_rate_type.type_code is 'код типу';
comment on column deal_interest_rate_type.type_name is 'найменування';

PROMPT *** ALTER_POLICIES to DEAL_INTEREST_RATE_TYPE ***

exec bpa.alter_policies('DEAL_INTEREST_RATE_TYPE');

PROMPT *** Create  constraint PK_DEAL_INTEREST_RATE_TYPE ***
begin   
 execute immediate '
    alter table deal_interest_rate_type add constraint pk_deal_interest_rate_type 
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create unique index UI_DEAL_INTEREST_RATE_T_CODE ***
begin   
 execute immediate '
    create unique index ui_deal_interest_rate_t_code on deal_interest_rate_type(type_code) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTR_RATE_TYPE_CODE_NN ***
begin   
 execute immediate '            
    alter table deal_interest_rate_type modify (type_code constraint cc_deal_intr_rate_type_code_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTR_RATE_TYPE_NAME_NN ***
begin   
 execute immediate '            
    alter table deal_interest_rate_type modify (type_name constraint cc_deal_intr_rate_type_name_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  grants  DEAL_INTEREST_RATE_TYPE ***
grant SELECT  on DEAL_INTEREST_RATE_TYPE  to BARSREADER_ROLE;
grant select  on DEAL_INTEREST_RATE_TYPE  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** == Scripts /Sql/BARS/Table/DEAL_INTEREST_RATE_TYPE.sql == *** End *** ===
PROMPT ===================================================================================== 


undefine tbl_Spce_
undefine tbl_Spce_idx

set define off