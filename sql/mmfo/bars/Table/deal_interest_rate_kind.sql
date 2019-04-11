

PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/DEAL_INTEREST_RATE_KIND.sql == *** Run *** ===
PROMPT ===================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to DEAL_INTEREST_RATE_KIND ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEAL_INTEREST_RATE_KIND', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEAL_INTEREST_RATE_KIND', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEAL_INTEREST_RATE_KIND', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEAL_INTEREST_RATE_KIND ***

begin 
  execute immediate '
create table deal_interest_rate_kind  (
   id                   number(38),
   type_id              number,
   kind_code            varchar2(50),
   kind_name            varchar2(500),
   applying_condition   varchar2(100),
   is_active            number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table deal_interest_rate_kind                     is 'види %% ставок';
comment on column deal_interest_rate_kind.id                 is 'ідентифікатор';
comment on column deal_interest_rate_kind.type_id            is 'ідентифікатор типу %% ставок (ref deal_interest_rate_type)';
comment on column deal_interest_rate_kind.kind_code          is 'код виду';
comment on column deal_interest_rate_kind.kind_name          is 'найменування';
comment on column deal_interest_rate_kind.applying_condition is 'зарезервовано - на данний момент не використовується';
comment on column deal_interest_rate_kind.is_active          is '1 - активна, 0 - не активна';


PROMPT *** ALTER_POLICIES to DEAL_INTEREST_RATE_KIND ***

exec bpa.alter_policies('DEAL_INTEREST_RATE_KIND');

PROMPT *** Create  constraint PK_DEAL_INTEREST_RATE_KIND ***
begin   
 execute immediate '
    alter table deal_interest_rate_kind add constraint pk_deal_interest_rate_kind
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create index IDX_DEAL_INTR_RATE_KIND_TYPE ***
begin   
 execute immediate '
    create index idx_deal_intr_rate_kind_type on deal_interest_rate_kind(type_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create unique index UI_DEAL_INTR_RATE_KIND_CODE ***
begin   
 execute immediate '
    create unique index ui_deal_intr_rate_kind_code on deal_interest_rate_kind(kind_code) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INT_RATE_KIND_ID_NN ***
begin   
 execute immediate '            
    alter table deal_interest_rate_kind modify (id constraint cc_deal_int_rate_kind_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  constraint CC_DEAL_INT_RATE_KIND_TYPE_NN ***
begin   
 execute immediate '            
    alter table deal_interest_rate_kind modify (type_id constraint cc_deal_int_rate_kind_type_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  constraint CC_DEAL_INT_RATE_KIND_CODE_NN ***
begin   
 execute immediate '            
    alter table deal_interest_rate_kind modify (kind_code constraint cc_deal_int_rate_kind_code_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INT_RATE_KIND_NAME_NN ***
begin   
 execute immediate '            
    alter table deal_interest_rate_kind modify (kind_name constraint cc_deal_int_rate_kind_name_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INT_RATE_KIND_ACT_NN ***
begin   
 execute immediate '            
    alter table deal_interest_rate_kind modify (is_active constraint cc_deal_int_rate_kind_act_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INT_RATE_KIND_ACTIVE ***

begin   
 execute immediate '
    alter table deal_interest_rate_kind add constraint cc_deal_int_rate_kind_active
                check(is_active in (0, 1))';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  grants  DEAL_INTEREST_RATE_KIND ***
grant SELECT  on DEAL_INTEREST_RATE_KIND  to BARSREADER_ROLE;
grant select  on DEAL_INTEREST_RATE_KIND  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Table/DEAL_INTEREST_RATE_KIND.sql == *** Run *** ===
PROMPT ===================================================================================== 

set define off