begin
bc.go('/');
insert into OW_FILE_TYPE(FILE_TYPE, 
                         NAME, 
                         IO, 
                         PRIORITY, 
                         TYPE, 
                         OFFSET, 
                         OFFSETEXPIRE)
       values('INSTPLAN',
              '���� Way4 ����� ����������',
              'I',
              '10',
              null,
              null,
              null);
exception when dup_val_on_index then
null;
end;
/
commit;
/