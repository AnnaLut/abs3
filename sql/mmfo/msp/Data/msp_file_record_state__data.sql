PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_file_record_state__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_file_record_state (id, name)
  values (-1, 'Новий файл');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (0, 'Запис опрацьовано');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (1, 'Рахунок не відповідає реквізитам Отримувача по ID-коду або серія та номер паспорту');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (2, 'Рахунок не відповідає реквізитам пенсіонера по ПІБ');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (3, 'Рахунок закритий за заявою власника');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (4, 'Рахунок не знайдено');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (5, 'Не знайдено пенсіонера по Ідкоду або серія та номер паспорту');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (6, 'Не знайдено особу по спискам ВПО');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (10, 'Сплачений');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (14, 'Заблоковано згідно письмової вимоги органу Пенсійного фонду або органу УПСЗН');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (17, 'Помилка створення платіжного документу');
exception 
  when dup_val_on_index then 
    null;
end;
/


begin
  insert into msp_file_record_state (id, name)
  values (19, 'Очікує оплати');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (20, 'Створений платіж');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_file_record_state (id, name)
  values (99, 'Помилка при оплаті');
exception 
  when dup_val_on_index then 
    null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_file_record_state__data.sql ==========*** End ***
PROMPT ===================================================================================== 
