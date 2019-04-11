declare
    l_fixed_attribute_obj_id integer;
    l_dynamic_attribute_obj_id integer;
    l_calculated_attribute_obj_id integer;
begin
    l_fixed_attribute_obj_id := object_utl.get_object_type_id('FIXED_ATTRIBUTE');
    l_dynamic_attribute_obj_id := object_utl.get_object_type_id('DYNAMIC_ATTRIBUTE');
    l_calculated_attribute_obj_id := object_utl.get_object_type_id('CALCULATED_ATTRIBUTE');

    update attribute_kind t
    set    t.attribute_type_id = attribute_utl.ATTR_TYPE_FIXED
    where  t.attribute_type_id = l_fixed_attribute_obj_id;

    update attribute_kind t
    set    t.attribute_type_id = attribute_utl.ATTR_TYPE_DYNAMIC
    where  t.attribute_type_id = l_dynamic_attribute_obj_id;

    update attribute_kind t
    set    t.attribute_type_id = attribute_utl.ATTR_TYPE_CALCULATED
    where  t.attribute_type_id = l_calculated_attribute_obj_id;

    delete object_type t
    where  t.type_code in ('STAFF_USER_CBS', 'STAFF_USER_ORA', 'STAFF_USER_AD', 'FIXED_ATTRIBUTE', 'DYNAMIC_ATTRIBUTE', 'CALCULATED_ATTRIBUTE');

    commit;
end;
/