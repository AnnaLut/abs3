begin
execute immediate 'Insert into CUSTOMER_FIELD(TAG, NAME, B, U, F, CODE, NOT_TO_EDIT, PARID, U_NREZ, F_NREZ, F_SPD)
 Values (''SDBO '', ''Відмітка підпису ДБО'', 0, 1, 0,''OTHERS'', 0, null, 0, 0,1)';
exception when dup_val_on_index then null;
end;
/ 
COMMIT;
/