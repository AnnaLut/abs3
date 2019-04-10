PROMPT ============================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/REGISTER_VALUE.sql = *** Run *** =
PROMPT ============================================================================

PROMPT *** Create  constraint FK_REGISTER_VALUE_CURR ***
begin   
 execute immediate '
    alter table register_value add constraint fk_register_value_curr
            foreign key (currency_id) references tabval$global(kv) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_REGISTER_VALUE_OBJECT ***
begin   
 execute immediate '
    alter table register_value add constraint fk_register_value_object
            foreign key (object_id) references object(id) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint FK_REGISTER_VALUE_REG_TYPE ***
begin   
 execute immediate '
    alter table register_value
       add constraint fk_register_value_reg_type foreign key (register_type_id)
          references register_type (id) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT ============================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/REGISTER_VALUE.sql = *** End *** =
PROMPT ============================================================================