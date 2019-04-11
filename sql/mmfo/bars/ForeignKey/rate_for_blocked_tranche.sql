PROMPT ======================================================================================= 
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/RATE_FOR_BLOCKED_TRANCHE.sql = *** Run *** =
PROMPT =======================================================================================

PROMPT *** Create  constraint FK_RATE_FOR_BLOCKED_TRN_OPTION ***
begin   
 execute immediate '
    alter table rate_for_blocked_tranche add constraint fk_rate_for_blocked_trn_option 
            foreign key (interest_option_id) references deal_interest_option( id ) enable novalidate';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_RATE_FOR_BLOCKED_TRN_CURR ***
begin   
 execute immediate '
    alter table rate_for_blocked_tranche add constraint FK_RATE_FOR_BLOCKED_TRN_CURR
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT =======================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/RATE_FOR_BLOCKED_TRANCHE.sql = *** End *** =
PROMPT ======================================================================================= 
