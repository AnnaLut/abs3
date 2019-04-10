begin
    list_utl.cor_list(smb_deposit_utl.CALC_TYPE_DOD_CODE, 'Тип нарахування відсотків');
    list_utl.cor_list_item(smb_deposit_utl.CALC_TYPE_DOD_CODE, smb_deposit_utl.CALC_TYPE_DOD_END_OF_DAY_ID, 'CALC_TYPE_DOD_END_OF_DAY', 'Залишок на кінець дня');
    list_utl.cor_list_item(smb_deposit_utl.CALC_TYPE_DOD_CODE, smb_deposit_utl.CALC_TYPE_DOD_DAILY_AVERAGE_ID, 'CALC_TYPE_DOD_DAILY_AVERAGE', 'Середньоденні залишки');
    commit;
end;
/
