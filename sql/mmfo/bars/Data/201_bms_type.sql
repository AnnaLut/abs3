prompt 'Добавление тип сообщения'
begin
insert into bms_message_type (id,
                              message_type_code,
                              message_type_name,
                              validity_period,
                              receiver_id_type,
                              is_persisted)
  select 10, 'IMMEDIATE_MESSAGE', 'Всплывающее сообщение', 1, 'USERID','N'
    from dual
    where not exists (select 1 from bms_message_type where id = 10);
exception
  when others then null;    
end;
/

