begin
  insert into err_texts(errmod_code, err_code, errlng_code, err_msg, err_hlp)
  values('CIM', 105, 'UKR', '��������� ������ ���� ��� ���������� �������', null);  
  exception 
    when dup_val_on_index then null;
end;
/

commit;