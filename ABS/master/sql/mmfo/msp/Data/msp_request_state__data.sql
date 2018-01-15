PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_request_state__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_request_state (id, name, state)
  values (-1, 'Новий запит', 'NEW_REQUEST');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_request_state (id, name, state)
  values (0, 'Ok', 'PARSED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_request_state (id, name, state)
  values (1, 'Помилка ЕЦП для конверту', 'ERROR_ECP_REQUEST');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_request_state (id, name, state)
  values (2, 'Помилка розшифрування даних конверту', 'ERROR_DECRYPT_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_request_state (id, name, state)
  values (3, 'Помилка в структурі xml', 'ERROR_XML_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_request_state (id, name, state)
  values (4, 'Помилка при розархівуванні файлу', 'ERROR_UNPACK_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_request_state (id, name, state)
  values (5, 'Помилка унікальності конверту', 'ERROR_UNIQUE_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_request_state__data.sql ==========*** End ***
PROMPT ===================================================================================== 
