PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/data/table/msp_envelope_state__data.sql ==========*** Run ***
PROMPT ===================================================================================== 

begin
  insert into msp_envelope_state (id, name, state)
  values (-1, 'Новий конверт', 'ENVLIST_RECEIVED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (0, 'Конверт розібраний', 'PARSED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (1, 'Помилка ЕЦП для файлу', 'ERROR_ECP_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (2, 'Помилка розшифрування даних конверту', 'ERROR_DECRYPT_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (3, 'Помилка в структурі xml', 'ERROR_XML_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (4, 'Помилка при розархівуванні файлу', 'ERROR_UNPACK_ENVELOPE');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (9, 'Квитанція 1 в процесі формування', 'MATCH1_PROCESSING');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (10, 'Квитанція 2 в процесі формування', 'MATCH2_PROCESSING');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (11, 'Квитанція 1 зформована', 'MATCH1_CREATED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (12, 'Конверт квитанції 1 готовий до підписання', 'MATCH1_SIGN_WAIT');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (13, 'Помилка формування квитанції 1', 'MATCH1_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (14, 'Квитанція 1 відправлена', 'MATCH1_SEND');
exception 
  when dup_val_on_index then 
    null;
end;
/


begin
  insert into msp_envelope_state (id, name, state)
  values (15, 'Помилка формування конверту квитанції 1', 'MATCH1_ENV_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (16, 'Квитанція 2 зформована', 'MATCH2_CREATED');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (17, 'Конверт квитанції 2 готовий до підписання', 'MATCH2_SIGN_WAIT');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (18, 'Помилка формування квитанції 2', 'MATCH2_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (19, 'Квитанція 2 відправлена', 'MATCH2_SEND');
exception 
  when dup_val_on_index then 
    null;
end;
/

begin
  insert into msp_envelope_state (id, name, state)
  values (20, 'Помилка формування конверту квитанції 2', 'MATCH2_ENV_CREATE_ERROR');
exception 
  when dup_val_on_index then 
    null;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/data/table/msp_envelope_state__data.sql ==========*** End ***
PROMPT ===================================================================================== 
