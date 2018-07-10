
begin
    Insert into BARSUPL.UPL_AUTOJOB_PARAMS (param, defval, descript)
    Values ('UPL_METHOD', 'CLOB', 'Тип выгрузки (CLOB- через CLOB, BUFF - через utl_file)');
exception when dup_val_on_index then null; 
end;
/

COMMIT;
