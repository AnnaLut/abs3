begin 
insert into branch_attribute(attribute_code,attribute_desc,attribute_datatype,attribute_format,attribute_module)
values ('INSCC','����������� �������','N',null,null);
exception when others then null; 
end;
/
commit;
