
begin
    Insert into BARSUPL.UPL_AUTOJOB_PARAMS (param, defval, descript)
    Values ('UPL_METHOD', 'CLOB', '��� �������� (CLOB- ����� CLOB, BUFF - ����� utl_file)');
exception when dup_val_on_index then null; 
end;
/

COMMIT;
