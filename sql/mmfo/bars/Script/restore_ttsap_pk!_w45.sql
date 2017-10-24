prompt Restore PK! operation settings

begin
    --------------------------------
    ------ ��易��� ����樨 ------
    --------------------------------
    delete from ttsap where tt='PK!';
    begin
      insert into ttsap(ttap, tt, dk)
      values ('W45', 'PK!', 0);
    exception
      when dup_val_on_index then null;
      when others then 
        if ( sqlcode = -02291 ) then
          dbms_output.put_line('�� 㤠���� �������� ������ (ttsap: ''W45'', ''PK!'', 0) - ��ࢨ�� ���� �� ������!');
        else raise;
        end if;
    end;

    commit;
end;
/