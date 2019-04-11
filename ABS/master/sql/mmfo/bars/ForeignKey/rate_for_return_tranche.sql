
PROMPT ====================================================================================== 
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/RATE_FOR_RETURN_TRANCHE.sql = *** Run *** =
PROMPT ======================================================================================

PROMPT *** Create  constraint FK_RATE_FOR_RET_TRANCHE_IO_ID ***
begin   
 execute immediate '
    alter table rate_for_return_tranche add constraint fk_rate_for_ret_tranche_io_id 
            foreign key (interest_option_id) references deal_interest_option( id ) enable novalidate';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_RATE_FOR_RET_TRANCHE_CURR ***
begin   
 execute immediate '
    alter table rate_for_return_tranche add constraint fk_rate_for_ret_tranche_curr
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT ======================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/RATE_FOR_RETURN_TRANCHE.sql = *** End *** =
PROMPT ====================================================================================== 
