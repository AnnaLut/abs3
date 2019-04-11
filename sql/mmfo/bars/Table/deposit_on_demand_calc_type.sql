PROMPT ===================================================================================== 
PROMPT *** Run *** = Scripts /Sql/BARS/Table/DEPOSIT_ON_DEMAND_CALC_TYPE.sql = *** Run *** =
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_ON_DEMAND_CALC_TYPE ***
set define on
define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_ON_DEMAND_CALC_TYPE', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_ON_DEMAND_CALC_TYPE', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_ON_DEMAND_CALC_TYPE', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_ON_DEMAND_CALC_TYPE ***

begin 
  execute immediate '
create table deposit_on_demand_calc_type(
    id                  number  not null
   ,interest_option_id  number not null
   ,calculation_type_id number not null
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

comment on table  deposit_on_demand_calc_type                     is 'типи нарахувань для кладу на вимогу';
comment on column deposit_on_demand_calc_type.id                  is 'ідентифікатор';
comment on column deposit_on_demand_calc_type.interest_option_id  is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_on_demand_calc_type.calculation_type_id is 'допустимий тип нарухування (0 - Довільний метод нарахування; 1 - Залишок на кінець дня, 2 - Середньоденні залишки)';
comment on column deposit_on_demand_calc_type.user_id             is 'користувач';
comment on column deposit_on_demand_calc_type.sys_time            is 'остання дата зміни';


PROMPT *** ALTER_POLICIES to DEPOSIT_ON_DEMAND_CALC_TYPE ***

exec bpa.alter_policies('DEPOSIT_ON_DEMAND_CALC_TYPE');

PROMPT *** Create  constraint PK_DOD_CALC_TYPE ***
begin   
 execute immediate '
        alter table deposit_on_demand_calc_type add constraint PK_DOD_CALC_TYPE 
                    primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create unique index UI_DOD_CONDITION ***
begin   
 execute immediate '
    create unique index ui_dod_condition on 
         deposit_on_demand_calc_type (interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-1408, -955, -904) then 
      null;
   else raise;  
   end if;
end;
/


PROMPT *** Create  constraint CC_DOD_CALC_TYPE_ID ***
begin   
 execute immediate '
    alter table deposit_on_demand_calc_type add constraint cc_dod_calc_type_id
                check(calculation_type_id in (0, 1, 2))';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  grants  DEPOSIT_ON_DEMAND_CALC_TYPE ***
grant SELECT    on DEPOSIT_ON_DEMAND_CALC_TYPE  to BARSREADER_ROLE;
grant select    on DEPOSIT_ON_DEMAND_CALC_TYPE  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** = Scripts /Sql/BARS/Table/DEPOSIT_ON_DEMAND_CALC_TYPE.sql = *** End *** =
PROMPT ===================================================================================== 

set define off