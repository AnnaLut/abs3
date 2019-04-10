PROMPT =========================================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/DEPOSIT_PROLONGATION_BONUS.sql = *** Run *** =
PROMPT =========================================================================================

PROMPT *** Create  constraint FK_DPT_PRL_BONUS_OPTION ***
begin   
 execute immediate '
    alter table deposit_prolongation_bonus add constraint fk_dpt_prl_bonus_option 
            foreign key (interest_option_id) references deal_interest_option( id ) enable novalidate';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_DPT_PRL_BONUS_CURRENCY ***
begin   
 execute immediate '
    alter table deposit_prolongation_bonus add constraint fk_dpt_prl_bonus_currency
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT =========================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/DEPOSIT_PROLONGATION_BONUS.sql = *** End *** =
PROMPT =========================================================================================
