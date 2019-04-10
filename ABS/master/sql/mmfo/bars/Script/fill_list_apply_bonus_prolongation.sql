begin
    list_utl.cor_list(smb_deposit_utl.DEPOSIT_APPLY_BONUS_PROLONG, 'Періодичність застосування бонусної ставки при пролонгації');
    list_utl.cor_list_item(smb_deposit_utl.DEPOSIT_APPLY_BONUS_PROLONG, smb_deposit_utl.APPLY_ONLY_FIRST_PROLONG_ID, 'APPLY_ONLY_FIRST_PROLONG', 'для першої');
    list_utl.cor_list_item(smb_deposit_utl.DEPOSIT_APPLY_BONUS_PROLONG, smb_deposit_utl.APPLY_FOR_EACH_PROLONG_ID, 'APPLY_FOR_EACH_PROLONG', 'для кожної');
    commit;
end;
/
