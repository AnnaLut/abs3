begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (0,
                   '������������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/


begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (10,
                   '��������� �����');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (11,
                   '��������� ��������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/


begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (20,
                   '������� ���� ��������� �������');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert
  into   crkr_ca_transfer_state (state_id ,
                   state_name)
           values (21,
                   '������� ���� ���������� ���');
exception when dup_val_on_index then null;
          when others then raise;
end;
/
