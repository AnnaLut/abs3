
PROMPT ====================================================================================== 
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/DEPOSIT_AMOUNT_SETTING.sql = *** Run *** ==
PROMPT ======================================================================================

PROMPT *** Create  constraint FK_DEPOSIT_AMOUNT_SETTING_CURR ***
begin   
 execute immediate '
    alter table deposit_amount_setting add constraint fk_deposit_amount_setting_curr
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_DPT_AMOUNT_SETTING_IO_ID ***
begin   
 execute immediate '
    alter table deposit_amount_setting add constraint fk_dpt_amount_setting_io_id
            foreign key (interest_option_id) references deal_interest_option( id ) enable novalidate';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442, -904) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT ======================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/DEPOSIT_AMOUNT_SETTING.sql = *** End *** ==
PROMPT ====================================================================================== 
