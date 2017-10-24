declare
  l_attribute_id integer;
begin
  l_attribute_id := attribute_utl.read_attribute('CUSTOMER_SEGMENT_TVBV', p_raise_ndf => false).id;
  if (l_attribute_id is null) then
    l_attribute_id := attribute_utl.create_dynamic_attribute('CUSTOMER_SEGMENT_TVBV',
                                                             'Обслуговуюче відділення',
                                                             'CUSTOMER',
                                                             attribute_utl.VALUE_TYPE_STRING,
                                                             p_history_saving_mode_id => attribute_utl.HISTORY_MODE_VALUES_BY_DATE);
  end if;
  commit work;
end;
/
