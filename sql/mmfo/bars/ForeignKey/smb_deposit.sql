PROMPT ==========================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/SMB_DEPOSIT.sql = *** Run *** =
PROMPT ==========================================================================

PROMPT *** Create  constraint FK_SMB_DEPOSIT_CURRENCY ***
begin
 execute immediate '
    alter table smb_deposit add constraint fk_smb_deposit_currency 
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_SMB_DEPOSIT_OBJECT ***
begin
 execute immediate '
    alter table smb_deposit add constraint fk_smb_deposit_object
            foreign key (id) references object(id) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT ==========================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/SMB_DEPOSIT.sql = *** End *** =
PROMPT ==========================================================================