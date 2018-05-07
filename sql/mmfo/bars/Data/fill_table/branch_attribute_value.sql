begin
  branch_attribute_utl.create_attribute('USEPAREXECSMS',
                                        'Включення парарельної обробки по SMS',
                                        'N');
  branch_attribute_utl.create_attribute('NUMPARLEVELSMS',
                                        'Кількість потоків для паралельної обробки SMS',
                                        'N');
  branch_attribute_utl.create_attribute('NUMPARGROUPSMS',
                                        'Кількість груп для паралельної обробки SMS',
                                        'N');
  branch_attribute_utl.set_attribute_value('/', 'USEPAREXECSMS', '1');

  branch_attribute_utl.set_attribute_value('/', 'NUMPARLEVELSMS', '5');

  branch_attribute_utl.set_attribute_value('/', 'NUMPARGROUPSMS', '50');
end;
/
