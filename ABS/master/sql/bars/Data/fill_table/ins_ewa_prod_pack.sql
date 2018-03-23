begin
execute immediate('Insert into INS_EWA_PROD_PACK(OKPO, EXT_CODE, EWA_TYPE_ID, MASK_ID) Values (''34538696'', 4806, ''Ð²Ð'', 1)');
exception when dup_val_on_index then null;
end;
/

begin
execute immediate('Insert into INS_EWA_PROD_PACK(OKPO, EXT_CODE, EWA_TYPE_ID, MASK_ID) Values (''34538696'', 4804, ''Ð²Ð'', 2)');
exception when dup_val_on_index then null;
end;
/

begin
execute immediate('Insert into INS_EWA_PROD_PACK(OKPO, EXT_CODE, EWA_TYPE_ID, MASK_ID) Values (''24175269'', 4802, ''ÂÇÐ'', 4)');
exception when dup_val_on_index then null;
end;
/

begin
execute immediate('Insert into INS_EWA_PROD_PACK(OKPO, EXT_CODE, EWA_TYPE_ID, MASK_ID) Values (''24175269'', 4800, ''ÂÇÐ'', 10)');
exception when dup_val_on_index then null;
end;
/
update INS_EWA_PROD_PACK
set MASK_ID = 1
where EXT_CODE = 4806;
/
update INS_EWA_PROD_PACK
set MASK_ID = 2
where EXT_CODE = 4804;
/
update INS_EWA_PROD_PACK
set MASK_ID = 4
where EXT_CODE = 4802;
/
update INS_EWA_PROD_PACK
set MASK_ID = 10
where EXT_CODE = 4800;
/
COMMIT;
/