PROMPT ===============================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/REGISTER_HISTORY.sql = *** Run *** =
PROMPT ===============================================================================

PROMPT *** Create  constraint FK_REGISTER_HISTORY_REG_VALUE ***
begin   
 execute immediate '
 alter table register_history
   add constraint fk_register_history_reg_value foreign key (register_value_id)
      references register_value (id) enable novalidate';
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