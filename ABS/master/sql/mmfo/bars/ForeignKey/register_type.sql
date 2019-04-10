PROMPT ============================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/ForeignKey/REGISTER_TYPE.sql = *** Run *** =
PROMPT ============================================================================


PROMPT *** Create  constraint FK_REGISTER_TYPE_OBJ_TYPE ***
begin   
 execute immediate '
    alter table register_type add constraint fk_register_type_obj_type
            foreign key (object_type_id) references object_type(id) enable novalidate';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT ============================================================================
PROMPT *** End *** = Scripts /Sql/Bars/ForeignKey/REGISTER_TYPE.sql = *** End *** =
PROMPT ============================================================================