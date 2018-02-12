begin   
branch_attribute_utl.create_attribute    ('ZPCENTRAL', '����� ��� �������� ������ ��������������� ��������', 'C');
branch_attribute_utl.set_attribute_value ('/','ZPCENTRAL','/barsroot/webservices/SalaryBagServices/ZPServiceMain.asmx');   
end;
/
begin   
branch_attribute_utl.create_attribute    ('ZPCORP2URL', 'URL ��������� corp2 ��� �������� ��������', 'C');
end;
/
commit;
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'ZP.ABS_login' as key,
  null as csharptype,
  '' as val,
  'ZP: ���� ��������� �����������' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
commit;
/

