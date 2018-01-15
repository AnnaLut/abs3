PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_file_state__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_file_state (id, name, state)
  values (-1, 'Новий файл', 'NEW');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (1, 'Виконується парсинг', 'IN_PARSE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (2, 'Помилка парсингу', 'PARSE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (3, 'Файл розібраний', 'PARSED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (4, 'Виконується валідація', 'IN_CHECK');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (5, 'Системна помилка валідації', 'CHECK_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (0, 'Перевірено', 'CHECKED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (6, 'Очікує оплати', 'CHECKING_PAY');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (7, 'Перевірено', 'CHECKED2');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (8, 'В процесі оплати', 'IN_PAY');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (9, 'Оплачено', 'PAYED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_state (id, name, state)
  values (10, 'Помилка', 'ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/


commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_file_state__data.sql ==========*** End ***
PROMPT ===================================================================================== 
