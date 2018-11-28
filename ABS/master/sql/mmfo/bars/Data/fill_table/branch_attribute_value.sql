begin
  branch_attribute_utl.create_attribute('DPA_FFILE_ROW_CNT',
                                        'Кількість записів в F-файлі для ДПА',
                                        'N');
  branch_attribute_utl.set_attribute_value('/', 'DPA_FFILE_ROW_CNT', '100');

  commit;
exception when others then null; 
end;
/

begin 
insert into branch_attribute_value(attribute_code,branch_code,attribute_value)
values ('INSCC','/','1');
exception when others then null; 
end;
/
commit;
