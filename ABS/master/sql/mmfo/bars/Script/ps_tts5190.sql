-- 2). ������. ���������� ���������� � �������� 101,D66


begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('3739', '101', 1, null);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3739'', ''101'', 1, null) - ��������� ���� �� ������!');
    else raise;
    end if;
end;
/


begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('2902', 'D66', 0, null);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2902'', ''D66'', 0, null) - ��������� ���� �� ������!');
    else raise;
    end if;
end;
/


commit;



