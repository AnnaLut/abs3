delete from cim_reports_list where report_id=14;
insert into cim_reports_list (report_id, name, proc, template, file_type, file_name, use_in_TVBV) 
  values (14, '���������� ��� ������� � ������ �����', null, 'Contracts_Coments.frx', 'excel', 'Contracts_Coments.xlsx', 0); 
commit;