begin 
  branch_attribute_utl.add_new_attribute_with_set(p_attr_code => 'CORP2_PILOT',p_attr_desc => 'Признак пілотного відділення по CORP2',
                                                                 p_branch_code => '/322669/',p_attr_value => 1);
end;
/   

begin                                                              
  branch_attribute_utl.add_new_attribute_with_set(p_attr_code => 'CORP2_PILOT',p_attr_desc => 'Признак пілотного відділення по CORP2',
                                                                 p_branch_code => '/351823/',p_attr_value => 1);                                                                 
end;
/

begin                                                              
  branch_attribute_utl.add_new_attribute_with_set(p_attr_code => 'CORP2_PILOT',p_attr_desc => 'Признак пілотного відділення по CORP2',
                                                                 p_branch_code => '/300465/',p_attr_value => 1);                                                                 
end;
/

commit;