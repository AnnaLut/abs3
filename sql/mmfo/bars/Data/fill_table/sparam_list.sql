begin
	update sparam_list
	set def_flag = 'Y'
	where name in ('R011', 'R013');
	dbms_output.put_line( '��������� ����� �������������� ���������� ��� R011, R013' );
end;
/