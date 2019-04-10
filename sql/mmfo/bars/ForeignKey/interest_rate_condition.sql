

PROMPT ====================================================================================== 
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/INTEREST_RATE_CONDITION.sql = *** Run *** =
PROMPT ======================================================================================

PROMPT *** Create  constraint FK_INTEREST_RATE_COND_IO_ID ***
begin   
 execute immediate '
    alter table interest_rate_condition add constraint fk_interest_rate_cond_io_id 
            foreign key (interest_option_id) references deal_interest_option( id ) enable novalidate';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_INTEREST_RATE_COND_CURR ***
begin   
 execute immediate '
    alter table interest_rate_condition add constraint fk_interest_rate_cond_curr 
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT ======================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/INTEREST_RATE_CONDITION.sql = *** End *** =
PROMPT ====================================================================================== 
