begin
  branch_attribute_utl.create_attribute('USEPAREXECSMS',
                                        '��������� ���������� ������� �� SMS',
                                        'N');
  branch_attribute_utl.create_attribute('NUMPARLEVELSMS',
                                        'ʳ������ ������ ��� ���������� ������� SMS',
                                        'N');
  branch_attribute_utl.create_attribute('NUMPARGROUPSMS',
                                        'ʳ������ ���� ��� ���������� ������� SMS',
                                        'N');
  branch_attribute_utl.set_attribute_value('/', 'USEPAREXECSMS', '1');

  branch_attribute_utl.set_attribute_value('/', 'NUMPARLEVELSMS', '5');

  branch_attribute_utl.set_attribute_value('/', 'NUMPARGROUPSMS', '50');
end;
/
