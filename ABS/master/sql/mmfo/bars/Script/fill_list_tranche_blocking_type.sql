begin
    list_utl.cor_list(smb_deposit_utl.DEPOSIT_TRANCHE_LOCK_TYPE, 'Типы блокировок траншей по депозитам ММСБ');
    list_utl.cor_list_item(smb_deposit_utl.DEPOSIT_TRANCHE_LOCK_TYPE, smb_deposit_utl.LOCK_ARREST_ID, 'SMB_LOCK_ARREST', q'[блокування в зв'язку з арештом за рішенням суду/виконавчої служби]');
    list_utl.cor_list_item(smb_deposit_utl.DEPOSIT_TRANCHE_LOCK_TYPE, smb_deposit_utl.LOCK_DPT_ON_CREDIT_ID, 'SMB_LOCK_DPT_ON_CREDIT', q'[блокування в зв'язку з забезпеченням депозиту по кредиту]');
    commit;
end;
/