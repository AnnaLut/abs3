begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''ОБ'', ''Нещасний випадок (Оберіг)'', 12)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''ВЗР'', ''Туризм'', 24)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''РІР'', ''Страхування власників карт'', 23)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''ЖТ'', ''Страхування життя (cash) ФО'', 25)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''policy'', ''осаго'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''vcl'', ''дго (добровольная гражданская ответственность)'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''greencard'', ''зелёная карта'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''custom'', ''настраиваемый тип договора: кроме ОСАГО, ЗК и стандартного ДГО, может применяться также в нестандартном ДГО'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''ГО'', ''ОСЦВ (Автоцивілка)'', 14)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''ДГО'', ''ДЦВ (Автоцивілка+)'', 16)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''МЕД'', ''ДМС (Лікар у дорозі)'', 18)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''МФ'', ''Майно (Захисти домівку)'', 2)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''БП'', ''Моє здоров''''я'', 26)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''000000000000000000000000000000'', ''Default'', null)');
exception when dup_val_on_index then null;
end;
/
begin
execute immediate('Insert into INS_EWA_TYPES(ID, NAME, EXT_ID) Values (''МБГ'', ''Медицина без границ'', 18)');
exception when dup_val_on_index then null;
end;
/
COMMIT;
/
