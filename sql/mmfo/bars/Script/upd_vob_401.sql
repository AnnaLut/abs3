begin 
	--����� ��� ���������
	begin 
	  execute immediate 
		'insert into vob (vob, name, flv, rep_prefix) values (401,''������ ������'',1 ,''ORDERCNB'')';
	exception when dup_val_on_index then 
	  null;
	end;
	--��������� ������ ���� ��� �������� CNB
    execute immediate 'update tts_vob set vob=:p_new_vob where tt = :p_tt and vob = :p_vob' using 401, 'CNB', 402;
end;  
/
commit;
