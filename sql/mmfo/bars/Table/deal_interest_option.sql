PROMPT ===================================================================================== 
PROMPT *** Run *** === Scripts /Sql/BARS/Table/DEAL_INTEREST_OPTION.sql === *** Run *** ====
PROMPT ===================================================================================== 
set define on
PROMPT *** ALTER_POLICY_INFO to DEAL_INTEREST_OPTION ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEAL_INTEREST_OPTION', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEAL_INTEREST_OPTION', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEAL_INTEREST_OPTION', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEAL_INTEREST_OPTION ***

begin 
  execute immediate '
    create table deal_interest_option(
        id                  number,
        product_id          number,
        rate_kind_id        number,
        valid_from          date    default trunc(sysdate),
        valid_through       date,
        is_active           number  default 1,
        option_description  varchar2(100),  
        user_id             number,
        sys_time            date    default sysdate
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
     null; 
  else raise; 
  end if;
end;
/

comment on table  deal_interest_option                    is 'Умови терміну дії довідників (Строкових траншів та вкладів на вимогу)';
comment on column deal_interest_option.id                 is 'ідентифікатор';
comment on column deal_interest_option.product_id         is 'ідентифікатор продукту';
comment on column deal_interest_option.rate_kind_id       is 'ідентифікатор виду %% ставок (ref deal_interest_rate_kind)';
comment on column deal_interest_option.valid_from         is 'дата початку дії';
comment on column deal_interest_option.valid_through      is 'дата закінчення';
comment on column deal_interest_option.is_active          is '1 - активна, 0 - не активна';
comment on column deal_interest_option.option_description is 'найменювання ';
comment on column deal_interest_option.user_id            is 'користувач';
comment on column deal_interest_option.sys_time           is 'остання дата зміни';

PROMPT *** ALTER_POLICIES to DEAL_INTEREST_OPTION ***

exec bpa.alter_policies('DEAL_INTEREST_OPTION');

PROMPT *** Create  constraint PK_DEAL_INTEREST_OPTION ***
begin   
 execute immediate '
        alter table deal_interest_option add constraint pk_deal_interest_option 
                    primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTEREST_OPTION_ID_NN ***
begin   
 execute immediate '            
    alter table deal_interest_option modify (id constraint cc_deal_interest_option_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTEREST_OPTION_VF_NN ***

begin   
 execute immediate '
    alter table deal_interest_option modify (valid_from constraint cc_deal_interest_option_vf_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTR_OPTION_KIND_NN ***

begin   
 execute immediate '
    alter table deal_interest_option modify (rate_kind_id constraint cc_deal_intr_option_kind_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTR_OPTION_USER_NN ***

begin   
 execute immediate '
    alter table deal_interest_option modify (user_id constraint cc_deal_intr_option_user_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTR_OPTION_STIME_NN ***
begin   
 execute immediate '
    alter table deal_interest_option modify (sys_time constraint cc_deal_intr_option_stime_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTEREST_OPTION_DATE ***

begin   
 execute immediate '
    alter table deal_interest_option add constraint cc_deal_interest_option_date 
                check(valid_from <= nvl(trunc(valid_through), valid_from))';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create unique index UI_DEAL_INTEREST_OPTION ***

begin   
 execute immediate '
    create unique index ui_deal_interest_option on deal_interest_option (rate_kind_id, valid_from, case when is_active = 1 then 1 else id end) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-1408, -955) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create index IDX_DEAL_INTEREST_OPTION_KIND ***
begin   
 execute immediate '
    create index idx_deal_interest_option_kind on deal_interest_option (rate_kind_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-1408, -955) then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DEAL_INTEREST_OPTION_ACTIVE ***
begin   
 execute immediate '
    alter table deal_interest_option add constraint cc_deal_interest_option_active
                check(is_active in (0, 1))';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  grants  DEAL_INTEREST_OPTION ***
grant SELECT    on DEAL_INTEREST_OPTION  to BARSREADER_ROLE;
grant select    on DEAL_INTEREST_OPTION  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** === Scripts /Sql/BARS/Table/DEAL_INTEREST_OPTION.sql === *** End *** ====
PROMPT =====================================================================================

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off