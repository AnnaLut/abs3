begin
  branch_attribute_utl.create_attribute('DPA_FFILE_ROW_CNT',
                                        'ʳ������ ������ � F-���� ��� ���',
                                        'N');
  branch_attribute_utl.set_attribute_value('/', 'DPA_FFILE_ROW_CNT', '100');

  commit;
end;
/
