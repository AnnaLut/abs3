
PROMPT ====================================================================================== 
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/DEPOSIT_CAPITALIZATION.sql == *** Run *** =
PROMPT ======================================================================================

PROMPT *** Create  constraint FK_DPT_CAPITALIZATION_IO_ID ***
begin   
 execute immediate '
    alter table deposit_capitalization add constraint fk_dpt_capitalization_io_id
            foreign key (interest_option_id) references deal_interest_option( id ) enable novalidate';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_DPT_CAPITALIZATION_CURR ***
begin   
 execute immediate '
    alter table deposit_capitalization add constraint fk_dpt_capitalization_curr 
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT ======================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/DEPOSIT_CAPITALIZATION.sql == *** End *** =
PROMPT ====================================================================================== 
