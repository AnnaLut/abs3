
 ----���������
begin
	begin 
	 insert into w4_kd_tts (tt,description) values ('W4X', '�������� �� ���������� ����� ���������');
	 exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-00001: unique constraint (BARS.XPK_K9) violated
	end;

	begin
	 insert into w4_kd_tts (tt,description) values ('W4I', '�������� �� ������� �������');
	 exception when others then   if SQLCODE = -00001 then null;   else raise; end if;   -- ORA-00001: unique constraint (BARS.XPK_K9) violated
	end;
 
  commit;
 end;

/
