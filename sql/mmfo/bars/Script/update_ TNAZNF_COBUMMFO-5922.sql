begin
update TNAZNF t
set t.txt = '#(''��������� ����������� ������������� �� ������������ �������� <�볺��-����>'')'
where t.n = 5;
  commit;
end;
/
