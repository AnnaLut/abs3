

PROMPT ====================================================================================== 
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/DEAL_INTEREST_RATE_KIND.sql = *** Run *** =
PROMPT ======================================================================================

PROMPT *** Create  constraint FK_DEAL_INTR_RATE_KIND_TYPE ***
begin   
 execute immediate '
    alter table deal_interest_rate_kind
       add constraint fk_deal_intr_rate_kind_type foreign key (type_id)
          references deal_interest_rate_type (id)';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT ======================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/DEAL_INTEREST_RATE_KIND.sql = *** End *** =
PROMPT ====================================================================================== 
