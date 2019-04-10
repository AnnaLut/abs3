
PROMPT ====================================================================================== 
PROMPT *** Run *** === Scripts /Sql/Bars/ForeignKey/DEAL_INTEREST_OPTION.sql == *** Run *** =
PROMPT ======================================================================================

PROMPT *** Create  constraint FK_DEAL_INTEREST_OPTION_KIND ***
begin   
 execute immediate '
    alter table deal_interest_option
       add constraint fk_deal_interest_option_kind foreign key (rate_kind_id)
          references deal_interest_rate_kind (id)';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT ======================================================================================
PROMPT *** End *** === Scripts /Sql/Bars/ForeignKey/DEAL_INTEREST_OPTION.sql == *** End *** =
PROMPT ====================================================================================== 
