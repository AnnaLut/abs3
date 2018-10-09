begin
  
  for c in (select kf from mv_kf )
  loop
     bc.go(c.kf);
     begin
	    insert into ow_params(par, val, comm, kf)
        values('W4_IICNLSP', 0, '���������� ������ ������� � ������ IIC ��� ���. ���: 0 - �� ���������������, 1 - �� ���������', c.kf);
     exception
        when dup_val_on_index then null;
     end;

     begin
        insert into ow_params(par, val, comm, kf)
        values('W4_IICNLSU', 0, '���������� ������ ������� � ������ IIC ��� ��. ���: 0 - �� ���������������, 1 - �� ���������', c.kf);
     exception
        when dup_val_on_index then null;
     end;
     bc.home;
  end loop;
  
  commit;

end;
/
